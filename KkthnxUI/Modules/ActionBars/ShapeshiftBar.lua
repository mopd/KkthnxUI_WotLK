local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true then return end

local _G = _G
local unpack = unpack
local CreateFrame = CreateFrame
local UIParent = UIParent
local InCombatLockdown = InCombatLockdown
local GetShapeshiftFormInfo = GetShapeshiftFormInfo
local hooksecurefunc = hooksecurefunc

-- Setup Shapeshift Bar by Tukz
local ShiftHolder = CreateFrame("Frame", "ShiftHolder", UIParent)
if C["actionbar"].stancebar_horizontal == true then
	ShiftHolder:SetPoint(unpack(C["position"].stance_bar))
	ShiftHolder:SetWidth((C["actionbar"].button_size * 7) + (C["actionbar"].button_space * 6))
	ShiftHolder:SetHeight(C["actionbar"].button_size)
else
	if (PetActionBarFrame:IsShown() or PetHolder) and C["actionbar"].petbar_horizontal ~= true then
		ShiftHolder:SetPoint("RIGHT", "PetHolder", "LEFT", -C["actionbar"].button_space, (C["actionbar"].button_size / 2) + 1)
	else
		ShiftHolder:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", -C["actionbar"].button_space, (C["actionbar"].button_size / 2) + 1)
	end
	ShiftHolder:SetWidth(C["actionbar"].button_size)
	ShiftHolder:SetHeight((C["actionbar"].button_size * 7) + (C["actionbar"].button_space * 6))
end

-- Hide bar
if C["actionbar"].stancebar_hide then ShiftHolder:Hide() return end

-- Create bar
local bar = CreateFrame("Frame", "UIShapeShift", ShiftHolder, "SecureHandlerStateTemplate")
bar:ClearAllPoints()
bar:SetAllPoints(ShiftHolder)

local States = {
	["DEATHKNIGHT"] = "show",
	["DRUID"] = "show",
	["PALADIN"] = "show",
	["PRIEST"] = "show",
	["ROGUE"] = "show",
	["WARLOCK"] = "show",
	["WARRIOR"] = "show",
}

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
bar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local button = _G["ShapeshiftButton"..i]
			button:ClearAllPoints()
			button:SetParent(self)
			if i == 1 then
				if C["actionbar"].stancebar_horizontal == true then
					button:SetPoint("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			else
				local previous = _G["ShapeshiftButton"..i-1]
				if C["actionbar"].stancebar_horizontal == true then
					button:SetPoint("LEFT", previous, "RIGHT", C["actionbar"].button_space, 0)
				else
					button:SetPoint("TOP", previous, "BOTTOM", 0, -C["actionbar"].button_space)
				end
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
		end
		RegisterStateDriver(self, "visibility", States[K.Class] or "hide")
		local function movestance()
			if not InCombatLockdown() then
				if C["actionbar"].stancebar_horizontal == true then
					ShapeshiftButton1:SetPoint("BOTTOMLEFT", ShiftHolder, "BOTTOMLEFT", 0, 0)
				else
					ShapeshiftButton1:SetPoint("TOPLEFT", ShiftHolder, "TOPLEFT", 0, 0)
				end
			end
		end
		hooksecurefunc("ShapeshiftBar_Update", movestance)
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		if InCombatLockdown() then return end
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local button = _G["ShapeshiftButton"..i]
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
		end
		K.ShiftBarUpdate()
	elseif event == "PLAYER_ENTERING_WORLD" then
		K.StyleShift()
	else
		K.ShiftBarUpdate()
	end
end)