local K, C, L, _ = unpack(select(2, ...))

local _G = _G
local collectgarbage = collectgarbage
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown

local FixTooltipBags = CreateFrame("Frame")
FixTooltipBags:RegisterEvent("BAG_UPDATE_DELAYED")
FixTooltipBags:SetScript("OnEvent", function()
	if StuffingFrameBags and StuffingFrameBags:IsShown() then
		GameTooltip:Hide()
	end
end)

-- Fix RemoveTalent() taint
FCF_StartAlertFlash = K.Dummy

-- Fix DeclensionFrame strata
if K.Client == "ruRU" then
	_G["DeclensionFrame"]:SetFrameStrata("HIGH")
end

-- Collect garbage
local eventcount = 0
local Garbage = CreateFrame("Frame")
Garbage:RegisterAllEvents()
Garbage:SetScript("OnEvent", function(self, event)
	eventcount = eventcount + 1

	if (InCombatLockdown() and eventcount > 25000) or (not InCombatLockdown() and eventcount > 10000) or event == "PLAYER_ENTERING_WORLD" then
		collectgarbage("collect")
		eventcount = 0
	end
end)