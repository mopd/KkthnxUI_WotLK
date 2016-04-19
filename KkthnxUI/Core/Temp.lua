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
-- Fuck off CLC_DK. Quit hiding shit without peoples permission
if K.Class == "DEATHKNIGHT" then
	local Runebar = CreateFrame("Frame")
	if IsAddOnLoaded("CLC_DK") then
		Runebar:RegisterEvent("ADDON_LOADED")
		Runebar:SetScript("OnEvent",
		function(self, event, addon)
			-- print("event:"..event)
			RuneFrame:Show()
			if (addon == "CLC_DK") then 
				self:UnRegisterEvent('ADDON_LOADED')
			end
		end)
	end
end