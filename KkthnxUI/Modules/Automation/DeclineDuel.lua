local K, C, L, _ = unpack(select(2, ...))
if C.automation.declineduel ~= true then return end

-- Auto decline duel
local DeclineDuel = CreateFrame("Frame")
DeclineDuel:RegisterEvent("DUEL_REQUESTED")
DeclineDuel:SetScript("OnEvent", function(self, event, name)
	HideUIPanel(StaticPopup1)
	CancelDuel()
	RaidNotice_AddMessage(RaidWarningFrame, L_INFO_DUEL..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
	print(format("|cffffff00"..L_INFO_DUEL..name.."."))
end)