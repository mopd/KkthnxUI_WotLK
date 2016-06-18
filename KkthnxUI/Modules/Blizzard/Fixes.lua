local K, C, L, _ = select(2, ...):unpack()

local _G = _G
local collectgarbage = collectgarbage
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown

INTERFACE_ACTION_BLOCKED = ""

local FixTooltip = CreateFrame("Frame")
FixTooltip:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
FixTooltip:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
FixTooltip:SetScript("OnEvent", function()
	local done
	GameTooltip:HookScript("OnTooltipCleared", function(self)
		if not done and self:NumLines() == 0 then
			self:Hide()
			done = true
		end
	end)
end)

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
FCF_StartAlertFlash = K.Noop

-- Fix DeclensionFrame strata
if K.Client == "ruRU" then
	_G["DeclensionFrame"]:SetFrameStrata("HIGH")
end

-- Hunter Dismiss Pet Taint (Blizzard issue)
local PET_DISMISS = "PET_DISMISS"
if K.Class == "HUNTER" then PET_DISMISS = nil end

do
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", PET_DISMISS, "CANCEL" };
end