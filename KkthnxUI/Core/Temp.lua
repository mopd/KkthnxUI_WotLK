local K, C, L = unpack(select(2, ...));

-- Remind people to delete old KkthnxUI_Filger
local Reminder_EventFrame = CreateFrame("Frame")
if IsAddOnLoaded("KkthnxUI_Filger") then
Reminder_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
Reminder_EventFrame:SetScript("OnEvent",
	function(self, event, ...)
		print("|cffff3300".."Please, delete KkthnxUI_Filger, it is now built-in.".."|r")
	end)
end

local CollectGarbage = _G.collectgarbage

local garbageCount = 0
_G.collectgarbage = function()
	garbageCount = garbageCount + 1
	return 1
end

local start = GetTime()

CollectGarbage("stop")

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
	_G.collectgarbage = CollectGarbage
	collectgarbage("collect")
	collectgarbage("restart")
	f:SetScript("OnEvent", nil)
end)

StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_BATTLEFIELD_ENTRY.button2 = nil

----------------------------------------------------------------------------------------
--	Force quit
----------------------------------------------------------------------------------------
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Auto SetFilter for AchievementUI
----------------------------------------------------------------------------------------
local AchFilter = CreateFrame("Frame")
AchFilter:RegisterEvent("ADDON_LOADED")
AchFilter:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		AchievementFrame_SetFilter(3)
	end
end)

local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("PARTY_INVITE_REQUEST")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" and StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") then
		PlaySound("ReadyCheck", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" or event == "PARTY_INVITE_REQUEST" then
		PlaySound("ReadyCheck", "Master")
	end
end)