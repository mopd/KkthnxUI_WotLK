local K, C, L, _ = unpack(select(2, ...))
if C["announcements"].spells ~= true then return end

local pairs = pairs

local UnitGUID = UnitGUID
local SendChatMessage = SendChatMessage
local GetInstanceInfo = GetInstanceInfo
local CreateFrame = CreateFrame

--	Announce some spells
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID = ...
	local spells = K.AnnounceSpells
	local _, _, difficultyID = GetInstanceInfo()
	if difficultyID == 0 or event ~= "SPELL_CAST_SUCCESS" then return end

	if C.announcements.spells_from_all == true and not (sourceGUID == UnitGUID("player") and sourceName == K.Name) then
		if not sourceName then return end

		for i, spells in pairs(spells) do
			if spellID == spells then
				if destName == nil then
					SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), K.CheckChat())
				else
					SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID).." -> "..destName), K.CheckChat())
				end
			end
		end
	else
		if not (sourceGUID == UnitGUID("player") and sourceName == K.Name) then return end

		for i, spells in pairs(spells) do
			if spellID == spells then
				if destName == nil then
					SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), K.CheckChat())
				else
					SendChatMessage(GetSpellLink(spellID).." -> "..destName, K.CheckChat())
				end
			end
		end
	end
end)