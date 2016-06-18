local K, C, _ = select(2, ...):unpack()
if C["Announcements"].Say_Sapped ~= true then return end

local pairs = pairs

local SaySapped = CreateFrame("Frame")
SaySapped:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
SaySapped:SetScript("OnEvent", function(self, _, ...)
	local _, event, sourceGUID, sourceName, _, _, destName, _, spellID = ...
	local spells = K.SappedSpells
	if spellID == spells then
		for i, spells in pairs(spells) do
			if (spellID == spells) and (destName == K.Name) and (eventType == "SPELL_AURA_APPLIED") or (eventType == "SPELL_AURA_REFRESH") then
				SendChatMessage(L_ANNOUNCE_SAPPED, "SAY")
				K.Print(L_ANNOUNCE_SAPPED_BY..(sourceName or "(unknown)"))
			end
		end
	end
end)