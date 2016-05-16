local K, C, L, _ = select(2, ...):unpack()

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