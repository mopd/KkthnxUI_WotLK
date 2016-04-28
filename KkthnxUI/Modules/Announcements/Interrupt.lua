local K, C, L, _ = unpack(select(2, ...))
if C["announcements"].interrupt ~= true then return end

local SendChatMessage = SendChatMessage
local CreateFrame = CreateFrame
local UnitGUID = UnitGUID

--	Announce your interrupts
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID = ...
	if not (event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player")) then return end

	SendChatMessage(L_ANNOUNCE_INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), K.CheckChat())
end)