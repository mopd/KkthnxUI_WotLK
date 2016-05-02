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
		RaidNotice_AddMessage(RaidWarningFrame, L_INFO_DUEL.."|cffE8CB3B"..name..".", {r = 0.22, g = 0.62, b = 0.91}, 3)
		print(format("|cff3AA0E9"..L_INFO_DUEL.."|cffE8CB3B"..name.."."))
		StaticPopup_Hide("DUEL_REQUESTED")
	end
end)

SlashCmdList.DISABLEDECLINE = function()
	if not Disable then
		Disable = true
		print("|cffE8CB3BDueling is now|r |cFF008000enabled|r")
	else
		Disable = false
		print("|cffE8CB3BDueling is now|r |cFFFF0000disabled|r")
	end
end

SLASH_DISABLEDECLINE1 = "/disduel"