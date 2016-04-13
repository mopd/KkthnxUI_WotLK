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