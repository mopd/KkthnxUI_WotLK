local K, C, L, _ = unpack(select(2, ...))
if C["announcements"].spells ~= true then return end

local pairs = pairs
local gsub = string.gsub
local format = string.format
local UnitGUID = UnitGUID
local GetSpellLink = GetSpellLink
local GetInstanceInfo = GetInstanceInfo
local SendChatMessage = SendChatMessage
local CreateFrame = CreateFrame

-- Announce some spells
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, _, ...)
	local _, event, sourceGUID, sourceName, _, _, destName, _, spellID = ...
	local spells = K.AnnounceSpells
	local _, _, difficulty = GetInstanceInfo()
	if difficulty == 0 or event ~= "SPELL_CAST_SUCCESS" then return end

	if sourceName then sourceName = sourceName:gsub("%-[^|]+", "") end
	if destName then destName = destName:gsub("%-[^|]+", "") end
	if C["announcements"].spells_from_all == true and not (sourceGUID == UnitGUID("player") and sourceName == K.Name) then
		if not sourceName then return end

		for i, spells in pairs(spells) do
			if spellID == spells then
				if destName == nil then
					SendChatMessage(format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), K.CheckChat())
				else
					SendChatMessage(format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID).." -> "..destName), K.CheckChat())
				end
			end
		end
	else
		if not (sourceGUID == UnitGUID("player") and sourceName == K.Name) then return end

		for i, spells in pairs(spells) do
			if spellID == spells then
				if destName == nil then
					SendChatMessage(format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), K.CheckChat())
				else
					SendChatMessage(GetSpellLink(spellID).." -> "..destName, K.CheckChat())
				end
			end
		end
	end
end)