local K, C, L = unpack(select(2, ...));

-- Force quit WoW
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

local Reminder_EventFrame = CreateFrame("Frame")
if IsAddOnLoaded("KkthnxUI_Filger") then
Reminder_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
Reminder_EventFrame:SetScript("OnEvent",
	function(self, event, ...)
		print("|cffff3300".."Please, delete KkthnxUI_Filger, it is now built-in.".."|r")
	end)
end