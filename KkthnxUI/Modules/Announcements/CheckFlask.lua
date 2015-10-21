local K, C, L, _ = unpack(select(2, ...))
if C.announcements.checkflask ~= true then return end

-- Check Flask(Flasked North by v6o)
local checkflask = CreateFrame("Frame")
checkflask:SetScript("OnEvent", function(self, event, ...)
	local _, CombatEvent, _, _, _, DestGUID, _, _, SpellID = ...
	if CombatEvent == "SPELL_AURA_APPLIED" and DestGUID == K.Unit then
		if SpellID == 67016 then
			RaidNotice_AddMessage(RaidWarningFrame, L_FLASK_SPD, {r = 0.41, g = 0.8, b = 0.94}, 3)
		elseif SpellID == 67017 then
			RaidNotice_AddMessage(RaidWarningFrame, L_FLASK_AP, {r = 0.41, g = 0.8, b = 0.94}, 3)
		elseif SpellID == 67018 then
			RaidNotice_AddMessage(RaidWarningFrame, L_FLASK_STR, {r = 0.41, g = 0.8, b = 0.94}, 3)
		end
	end
end)
checkflask:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")