local K, C, L, _ = unpack(select(2, ...))

local tonumber = tonumber
local lower, match = string.lower, string.match

local GetNumPartyMembers, GetNumRaidMembers = GetNumPartyMembers, GetNumRaidMembers

--	Check outdated UI version
local Check = function(self, event, prefix, message, channel, sender)
	local numParty, numRaid = GetNumPartyMembers(), GetNumRaidMembers()
	if event == "CHAT_MSG_ADDON" then
		if prefix ~= "KkthnxUIVersion" or sender == K.Name then return end
		if tonumber(message) ~= nil and tonumber(message) > tonumber(K.Version) then
			print("|cffff0000"..L_MISC_UI_OUTDATED.."|r")
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		if numRaid() > 0 then
			SendAddonMessage("KkthnxUIVersion", tonumber(K.Version), "RAID")
		elseif numParty() > 0 then
			SendAddonMessage("KkthnxUIVersion", tonumber(K.Version), "PARTY")
		elseif IsInGuild() then
			SendAddonMessage("KkthnxUIVersion", tonumber(K.Version), "GUILD")
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("RAID_ROSTER_UPDATE")
f:RegisterEvent("PARTY_MEMBERS_CHANGED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", Check)

-- Whisper UI version
local Whisper = CreateFrame("Frame")
Whisper:RegisterEvent("CHAT_MSG_WHISPER")
Whisper:SetScript("OnEvent", function(self, event, text, name, ...)
	if text:lower():match("ui_version") or text:lower():match("уи_версия") then
		if event == "CHAT_MSG_WHISPER" then
			SendChatMessage("KkthnxUI "..K.Version, "WHISPER", nil, name)
		end
	end
end)