local K, C, L, _ = select(2, ...):unpack()
if C["Automation"].autoinvite ~= true then return end

local select = select
local CreateFrame = CreateFrame
local GetNumPartyMembers = GetNumPartyMembers
local GetNumFriends = GetNumFriends
local GetFriendInfo = GetFriendInfo
local GetNumGuildMembers = GetNumGuildMembers
local GetGuildRosterInfo = GetGuildRosterInfo
local AutoInvite = CreateFrame("Frame")
local AutoAccept = CreateFrame("Frame")

local strfind = string.find
local strlower = strlower
local strmatch = string.match
local UnitIsRaidOfficer = UnitIsRaidOfficer
local UnitIsPartyLeader = UnitIsPartyLeader
local HidePopup = false
local Keyword = "inv"

AutoAccept:RegisterEvent("PARTY_INVITE_REQUEST")
AutoAccept:RegisterEvent("PARTY_MEMBERS_CHANGED")
AutoAccept:SetScript("OnEvent", function(self, event, sender)
	local Name

	if (event == "PARTY_INVITE_REQUEST") then
		-- We're waiting on a queue
		if MiniMapLFGFrame:IsShown() or MiniMapBattlefieldFrame:IsShown() then
			return
		end

		if (GetNumPartyMembers() > 0 or GetNumPartyMembers() > 0) then
			return
		end

		-- Update Guild and Friends
		if (GetNumFriends() > 0) then
			ShowFriends()
		end

		if IsInGuild() then
			GuildRoster()
		end

		for i = 1, GetNumFriends() do
			Name = GetFriendInfo(i)

			if (Name == sender) then
				AcceptGroup()
				HidePopup = true
				return
			end
		end

		local PlayerFaction

		-- find which faction we play
		if (UnitFactionGroup("player") == "Horde") then
			PlayerFaction = 0
		else
			PlayerFaction = 1
		end

		for i = 1, select(2, BNGetNumFriends()) do
			local PresenceID, _, _, Name, _, Client = BNGetFriendInfo(i)
			local Faction = select(5, BNGetToonInfo(PresenceID))

			if (Client == "WoW" and Faction == PlayerFaction) then
				if Name == sender then
					AcceptGroup()
					HidePopup = true
					return
				end
			end
		end

		for i = 1, GetNumGuildMembers() do
			Name = (GetGuildRosterInfo(i))

			if (Name == sender) then
				AcceptGroup()
				HidePopup = true
				return
			end
		end
	elseif (event == "PARTY_MEMBERS_CHANGED" and HidePopup) then
		StaticPopup_Hide("PARTY_INVITE")
		HidePopup = false
	end
end)

AutoInvite:RegisterEvent("CHAT_MSG_WHISPER")
AutoInvite:SetScript("OnEvent", function(self, event, msg, sender)
	if (not UnitInParty()) or (UnitIsPartyLeader("player")) or (UnitIsRaidOfficer("player")) and strmatch(strlower(msg), Keyword) then
		InviteUnit(sender)
	end
end)