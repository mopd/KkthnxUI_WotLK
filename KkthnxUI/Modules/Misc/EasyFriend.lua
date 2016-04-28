local K, C, L, _ = unpack(select(2, ...))
if C["misc"].easy_friend ~= true then return end	

local EasyAddFriend = CreateFrame("Frame","EasyAddFriendFrame")
EasyAddFriend:SetScript("OnEvent", function() hooksecurefunc("UnitPopup_ShowMenu", EasyAddFriendCheck) EasyAddFriendSlash() end)
EasyAddFriend:RegisterEvent("PLAYER_LOGIN")

local PopupUnits = {"PARTY", "PLAYER", "RAID_PLAYER", "RAID", "FRIEND", "TEAM", "CHAT_ROSTER", "TARGET", "FOCUS"}

local AddFriendButtonInfo = {
	text = "Add Friend",
	value = "ADD_FRIEND",
	func = function() AddFriend(UIDROPDOWNMENU_OPEN_MENU.name) end,
	notCheckable = 1,
}

local CancelButtonInfo = {
	text = "Cancel",
	value = "CANCEL",
	notCheckable = 1
}

function EasyAddFriendSlash()
	SLASH_EASYADDFRIEND1 = "/add";
	SlashCmdList["EASYADDFRIEND"] = function(msg) if #msg == 0 then DEFAULT_CHAT_FRAME:AddMessage("EasyAddFriend: Use '/add' followed by a character's name to add them to your friends list.") else AddFriend(msg) end end
end

function EasyAddFriendCheck()		
	local PossibleButton = getglobal("DropDownList1Button"..(DropDownList1.numButtons)-1)
	if PossibleButton["value"] ~= "ADD_FRIEND" then			
		local GoodUnit = false
		for i=1, #PopupUnits do	
			if OPEN_DROPDOWNMENUS[1]["which"] == PopupUnits[i] then	
				GoodUnit = true
			end
		end
		if UIDROPDOWNMENU_OPEN_MENU["unit"] == "target" and ((not UnitIsPlayer("target")) or (not UnitIsFriend("player", "target"))) then
			GoodUnit = false
		end
		if GoodUnit then
			local IsAlreadyFriend = false
			for z=1, GetNumFriends() do
				if GetFriendInfo(z) == UIDROPDOWNMENU_OPEN_MENU["name"] or UIDROPDOWNMENU_OPEN_MENU["name"] == UnitName("player") then
					IsAlreadyFriend = true
				end
			end
			if not IsAlreadyFriend then
				CreateAddFriendButton()
			end
		end
	end		
end

function CreateAddFriendButton()
	local CancelButtonFrame = getglobal("DropDownList1Button"..DropDownList1.numButtons)
	CancelButtonFrame:Hide()
	DropDownList1.numButtons = DropDownList1.numButtons - 1
	UIDropDownMenu_AddButton(AddFriendButtonInfo)
	UIDropDownMenu_AddButton(CancelButtonInfo)
end