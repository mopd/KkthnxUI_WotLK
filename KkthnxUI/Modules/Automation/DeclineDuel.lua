local K, C, L, _ = unpack(select(2, ...))
if C["automation"].declineduel ~= true then return end

local print = print
local format = string.format

local CreateFrame = CreateFrame
local SendChatMessage = SendChatMessage

-- Auto decline duel
local Disable = false
local DeclineDuel = CreateFrame("Frame")
DeclineDuel:RegisterEvent("DUEL_REQUESTED")
DeclineDuel:SetScript("OnEvent", function(self, event, name)
	if Disable == true then return end
	if event == "DUEL_REQUESTED" then
		CancelDuel()
		RaidNotice_AddMessage(RaidWarningFrame, L_INFO_DUEL.."|cFFFFFF00"..name..".", {r = 0.22, g = 0.62, b = 0.91}, 3)
		print(format("|cFF3AA0E9"..L_INFO_DUEL.."|cFFFFFF00"..name.."."))
		StaticPopup_Hide("DUEL_REQUESTED")
		if (K.Name == "Kkthnx" or K.Name == "Broflex" or K.Name == "Kkthnxui") and (K.Realm == "Ragnaros" or K.Realm == "Lordaeron" or K.Realm == "Blackrock [PvP only]") then
			K.Delay(4, SendChatMessage, L_INFO_DUEL_DECLINE, "WHISPER", nil, name)
		end
	end
end)

SlashCmdList.DISABLEDECLINE = function()
	if not Disable then
		Disable = true
		print("|cFFFFFF00Dueling is now|r |cFF008000enabled|r")
	else
		Disable = false
		print("|cFFFFFF00Dueling is now|r |cFFFF0000disabled|r")
	end
end

SLASH_DISABLEDECLINE1 = "/disduel"
SLASH_DISABLEDECLINE2 = "/вшывгуд"