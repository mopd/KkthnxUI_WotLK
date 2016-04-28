local K, C, L, _ = unpack(select(2, ...))
if C["automation"].declineduel ~= true then return end

local print = print
local format = string.format

local CreateFrame = CreateFrame

-- Auto decline duel
local Disable = false
local DeclineDuel = CreateFrame("Frame")
DeclineDuel:RegisterEvent("DUEL_REQUESTED")
DeclineDuel:SetScript("OnEvent", function(self, event, name)
	if Disable == true then return end
	if event == "DUEL_REQUESTED" then
		CancelDuel()
		RaidNotice_AddMessage(RaidWarningFrame, L_INFO_DUEL..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
		print(format("|cFFFFFF00"..L_INFO_DUEL..name.."."))
		StaticPopup_Hide("DUEL_REQUESTED")
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