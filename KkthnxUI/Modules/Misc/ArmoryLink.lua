local K, C, L, _ = unpack(select(2, ...))
if C["misc"].armory_link ~= true then return end

local realmName = (GetRealmName())
local link

local function urlencode(obj)
	local currentIndex = 1
	local charArray = {}
	while currentIndex <= #obj do
		local char = string.byte(obj, currentIndex)
		charArray[currentIndex] = char
		currentIndex = currentIndex + 1
	end
	local converchar = ""
	for _, char in ipairs(charArray) do
		converchar = converchar..string.format("%%%X", char)
	end
	return converchar
end

realmName = realmName:gsub("'", "")
realmName = realmName:gsub("-", "")
realmName = realmName:gsub(" ", "-")
local myserver = realmName:gsub("-", "")

if K.Client == "ruRU" then
	link = "ru"
elseif K.Client == "frFR" then
	link = "fr"
elseif K.Client == "deDE" then
	link = "de"
elseif K.Client == "esES" or K.Client == "esMX" then
	link = "es"
elseif K.Client == "ptBR" or K.Client == "ptPT" then
	link = "pt"
elseif K.Client == "itIT" then
	link = "it"
elseif K.Client == "zhTW" then
	link = "zh"
elseif K.Client == "koKR" then
	link = "ko"
else
	link = "en"
end

-- Dropdown menu link
hooksecurefunc("UnitPopup_OnClick", function(self)
	local dropdownFrame = UIDROPDOWNMENU_INIT_MENU
	local name = dropdownFrame.name
	local server = dropdownFrame.server
	if not server then
		server = myserver
	else
		server = string.lower(server:gsub("'", ""))
		server = server:gsub(" ", "-")
	end

	if name and self.value == "ARMORYLINK" then
		if K.Realm == "Ragnaros" or K.Realm == "Lordaeron" or K.Realm == "Deathwing" or K.Realm == "Neltharion" or K.Realm == "Warsong" or K.Realm == "Frostwolf" then
			if server == myserver then
				linkurl = "http://armory.warmane.com/character/"..name.."/"..realmName.."/summary"
			end
			local editbox = ChatEdit_ChooseBoxForSend()
			ChatEdit_ActivateChat(editbox)
			editbox:Insert(linkurl)
			editbox:HighlightText()
			return
		else
			print("|cFFFFFF00This realm is not currently supported|r")
			return
		end
	end
end)

UnitPopupButtons["ARMORYLINK"] = {text = L_POPUP_ARMORY, dist = 0, func = UnitPopup_OnClick}
tinsert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"] - 1, "ARMORYLINK")
tinsert(UnitPopupMenus["PARTY"], #UnitPopupMenus["PARTY"] - 1, "ARMORYLINK")
tinsert(UnitPopupMenus["RAID"], #UnitPopupMenus["RAID"] - 1, "ARMORYLINK")
tinsert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"] - 1, "ARMORYLINK")

-- Delete some lines from unit dropdown menu (Broke some line)
for _, menu in pairs(UnitPopupMenus) do
	for index = #menu, 1, -1 do
		if menu[index] == "SET_FOCUS" or menu[index] == "CLEAR_FOCUS" or menu[index] == "LARGE_FOCUS" or menu[index] == "MOVE_FOCUS_FRAME" or (menu[index] == "PET_DISMISS" and K.Class == "HUNTER") then
			table.remove(menu, index)
		end
	end
end