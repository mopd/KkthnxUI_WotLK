local K, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Accept invites from guild members or friend list(by ALZA)
----------------------------------------------------------------------------------------
if C.automation.autoinvite == true then
	local IsFriend = function(name)
		for i = 1, GetNumFriends() do if(GetFriendInfo(i) == name) then return true end end
		if(IsInGuild()) then for i = 1, GetNumGuildMembers() do if(GetGuildRosterInfo(i) == name) then return true end end end
	end
	
	local AutoInvite = CreateFrame("Frame")
	AutoInvite:RegisterEvent("PARTY_INVITE_REQUEST")
	AutoInvite:SetScript("OnEvent", function(frame, event, name)
		if(IsFriend(name)) then
			RaidNotice_AddMessage(RaidWarningFrame, L_INFO_INVITE..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
			print(format("|cffffff00"..L_INFO_INVITE..name.."."))
			AcceptGroup()
			for i = 1, 4 do
				local frame = _G["StaticPopup"..i]
				if(frame:IsVisible() and frame.which == "PARTY_INVITE") then
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