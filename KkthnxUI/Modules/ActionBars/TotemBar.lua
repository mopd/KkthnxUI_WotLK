local K, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or K.Class ~= "SHAMAN" then return end

-- Totembar - Left-Alt + Left Click Move
if MultiCastActionBarFrame then
	local f = CreateFrame("Frame", "MultiCastActionBarFrameAnchor")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetSize(10, 10)
	f:ClearAllPoints()
	f:SetPoint("CENTER", UIParent)

	if InCombatLockdown() then
		f:SetMovable(false)
		f:SetUserPlaced(true)
	else
		f:SetMovable(true)
		f:SetUserPlaced(true)
	end
	f:SetScript("OnEvent", function(self, event)
		MultiCastActionBarFrame:ClearAllPoints()
		MultiCastActionBarFrame:SetPoint("CENTER", MultiCastActionBarFrameAnchor)
		MultiCastActionBarFrame.SetPoint = K.Dummy
		MultiCastActionBarFrame.SetParent = K.Dummy
	end)

	for i = 1, 12 do
		for _, button in pairs({
			_G["MultiCastSlotButton1"],
			_G["MultiCastSlotButton2"],
			_G["MultiCastSlotButton3"],
			_G["MultiCastSlotButton4"],

			_G["MultiCastActionBarFrame"],
			_G["MultiCastActionButton"..i],

			_G["MultiCastRecallSpellButton"],
			_G["MultiCastSummonSpellButton"],
		}) do
			button:RegisterForDrag("LeftButton")
			button:HookScript("OnDragStart", function()
				if (IsShiftKeyDown() and IsAltKeyDown()) then
					if InCombatLockdown() then return end
					MultiCastActionBarFrameAnchor:StartMoving()
				end
			end)

			button:HookScript("OnDragStop", function()
				if InCombatLockdown() then return end
				MultiCastActionBarFrameAnchor:StopMovingOrSizing()
			end)
		end
	end

	MultiCastActionButton1:ClearAllPoints()
	MultiCastActionButton1:SetPoint("CENTER", MultiCastSlotButton1)

	MultiCastActionButton5:ClearAllPoints()
	MultiCastActionButton5:SetPoint("CENTER", MultiCastSlotButton1)

	MultiCastActionButton9:ClearAllPoints()
	MultiCastActionButton9:SetPoint("CENTER", MultiCastSlotButton1)

	hooksecurefunc("MultiCastFlyoutFrame_LoadSlotSpells", function(self, slot, ...)
		local numSpells = select("#", ...)

		if (numSpells == 0) then
			return false
		end

		numSpells = numSpells + 1

		for i = 2, numSpells do
			_G["MultiCastFlyoutButton"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end)
end