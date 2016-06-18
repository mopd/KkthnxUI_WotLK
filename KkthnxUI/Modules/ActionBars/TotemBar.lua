local K, C, L, _ = select(2, ...):unpack()
if C["ActionBar"].Enable ~= true or K.Class ~= "SHAMAN" then return end

local unpack = unpack
local CreateFrame = CreateFrame
local UIParent = UIParent
local hooksecurefunc = hooksecurefunc
local InCombatLockdown = InCombatLockdown

-- Setup Totem Bar by Tukz
local TotemHolder = CreateFrame("Frame", "TotemHolder", UIParent)
local bar = CreateFrame("Frame", "UITotemBar", TotemHolder, "SecureHandlerStateTemplate")
bar:ClearAllPoints()
bar:SetAllPoints(TotemHolder)

TotemHolder:SetPoint(unpack(C["position"].stance_bar))
TotemHolder:SetWidth((C["ActionBar"].Button_Size * 5) + (C["ActionBar"].Button_Space * 10))
TotemHolder:SetHeight(C["ActionBar"].Button_Size)

-- Setup Totem Bar by Tukz
if MultiCastActionBarFrame then
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
			ActionButton1.SetPoint(button, "LEFT", prev, "RIGHT", C["ActionBar"].Button_Space, 0)
		end
	end

	MultiCastActionBarFrame.SetParent = K.Noop
	MultiCastActionBarFrame.SetPoint = K.Noop
	MultiCastRecallSpellButton.SetPoint = K.Noop -- This causes taint?
end