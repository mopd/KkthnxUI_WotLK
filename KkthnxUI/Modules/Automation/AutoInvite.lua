local K, C, L, _ = unpack(select(2, ...))

local _G = _G
local print = print
local format = string.format
local CreateFrame = CreateFrame
local GetNumPartyMembers = GetNumPartyMembers
local GetNumFriends = GetNumFriends
local GetFriendInfo = GetFriendInfo
local GetNumGuildMembers = GetNumGuildMembers
local GetGuildRosterInfo = GetGuildRosterInfo

-- Accept invites from guild members or friends list(by ALZA)
if C["automation"].autoinvite == true then
	local CheckFriend = function(name)
		for i = 1, GetNumFriends() do
			if GetFriendInfo(i) == name then
				return true
			end
		end
		if IsInGuild() then
			for i = 1, GetNumGuildMembers() do
				if GetGuildRosterInfo(i) == name then
					return true
				end
			end
		end
	end

	local ai = CreateFrame("Frame")
	ai:RegisterEvent("PARTY_INVITE_REQUEST")
	ai:SetScript("OnEvent", function(self, event, name)
		if MiniMapLFGFrame:IsShown() or MiniMapBattlefieldFrame:IsShown() or GetNumPartyMembers() > 0 then return end
		if CheckFriend(name) then
			RaidNotice_AddMessage(RaidWarningFrame, L_INFO_INVITE..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
			print(format("|cffffff00"..L_INFO_INVITE..name..".|r"))
			AcceptGroup()
			for i = 1, STATICPOPUP_NUMDIALOGS do
				local frame = _G["StaticPopup"..i]
				if frame:IsVisible() and frame.which == "PARTY_INVITE" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE")
					return
				end
			end
		else
			SendWho(name)
		end
	end)
end