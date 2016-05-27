local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true or K.Class ~= "SHAMAN" then return end

local unpack = unpack
local CreateFrame = CreateFrame
local UIParent = UIParent
local hooksecurefunc = hooksecurefunc
local InCombatLockdown = InCombatLockdown

-- Setup Totem Bar by Tukz
local TotemHolder = CreateFrame("Frame", "TotemHolder", K.UIParent)
local bar = CreateFrame("Frame", "UITotemBar", TotemHolder, "SecureHandlerStateTemplate")
bar:ClearAllPoints()
bar:SetAllPoints(TotemHolder)

TotemHolder:SetPoint(unpack(C["position"].stance_bar))
TotemHolder:SetWidth((C["actionbar"].button_size * 5) + (C["actionbar"].button_space * 10))
TotemHolder:SetHeight(C["actionbar"].button_size)

-- Setup Totem Bar by Tukz
if MultiCastActionBarFrame then
	if name:match("MultiCastActionButton") then return end 
	MultiCastActionBarFrame:SetScript("OnUpdate", nil)
	MultiCastActionBarFrame:SetScript("OnShow", nil)
	MultiCastActionBarFrame:SetScript("OnHide", nil)
	MultiCastActionBarFrame:SetParent("TotemHolder")
	MultiCastActionBarFrame:ClearAllPoints()
	MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", TotemHolder, "BOTTOMLEFT", 0, 0)
	
	hooksecurefunc("MultiCastActionButton_Update", function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)
	
	for i = 1, 12 do
		if i < 6 then
			local button = _G["MultiCastSlotButton"..i] or MultiCastRecallSpellButton
			local prev = _G["MultiCastSlotButton"..(i-1)] or MultiCastSummonSpellButton
			prev.idx = i - 1
			button:ClearAllPoints()
			ActionButton1.SetPoint(button, "LEFT", prev, "RIGHT", C["actionbar"].button_space, 0)
		end
	end
	
	MultiCastActionBarFrame.SetParent = K.Dummy
	MultiCastActionBarFrame.SetPoint = K.Dummy
	MultiCastRecallSpellButton.SetPoint = K.Dummy -- This causes taint?
end