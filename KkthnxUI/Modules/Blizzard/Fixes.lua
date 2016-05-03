local K, C, L, _ = unpack(select(2, ...))

local _G = _G
local collectgarbage = collectgarbage
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown

INTERFACE_ACTION_BLOCKED = ""

local FixTooltipBags = CreateFrame("Frame")
FixTooltipBags:RegisterEvent("BAG_UPDATE_DELAYED")
FixTooltipBags:SetScript("OnEvent", function()
	local done
	if StuffingFrameBags and StuffingFrameBags:IsShown() then
		GameTooltip:HookScript("OnTooltipCleared", function(self)
			if not done and self:NumLines() == 0 then
				self:Hide()
				done = true
			end
		end)
	end
end)

-- Fix RemoveTalent() taint
FCF_StartAlertFlash = K.Dummy

-- Fix DeclensionFrame strata
if K.Client == "ruRU" then
	_G["DeclensionFrame"]:SetFrameStrata("HIGH")
end

-- Collect garbage
local Count = 0
local Garbage = CreateFrame("Frame")
Garbage:RegisterAllEvents()
Garbage:SetScript("OnEvent", function(self, event, ...)
	if not UnitAffectingCombat("player") then
		Count = Count + 1
		if Count > 6000 or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_REGEN_ENABLED" then
			collectgarbage("collect")
			Count = 0
		end
	end
end)