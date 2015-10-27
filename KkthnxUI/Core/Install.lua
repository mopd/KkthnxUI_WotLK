local K, C, L, _ = unpack(select(2, ...))

-- Simple Install
local function InstallUI()
	SetCVar("RotateMinimap", 0)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("autoQuestProgress", 1)
	SetCVar("autoQuestWatch", 1)
	SetCVar("buffDurations", 1)
	SetCVar("chatStyle", "im")
	SetCVar("colorblindMode", 0)
	SetCVar("consolidateBuffs", 0)
	SetCVar("enableCombatText", 1)
	SetCVar("ffxGlow", 0)
	SetCVar("gameTip", 0)
	SetCVar("removeChatDelay", 1)
	SetCVar("screenshotQuality", 10)
	SetCVar("scriptErrors", 0)
	SetCVar("showTargetOfTarget", 1)
	SetCVar("showTutorials", 0)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("threatWarning", 3)
	SetCVar('SpamFilter', 0)
	SetCVar('UnitNameEnemyGuardianName', 0)
	SetCVar('UnitNameEnemyPetName', 1)
	SetCVar('UnitNameEnemyPlayerName', 1)
	SetCVar('UnitNameEnemyTotemName', 0)
	SetCVar('UnitNameFriendlyGuardianName', 0)
	SetCVar('UnitNameFriendlyPetName', 0)
	SetCVar('UnitNameFriendlyPlayerName', 0)
	SetCVar('UnitNameFriendlyTotemName', 0)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('autoLootDefault', 0)
	SetCVar('cameraDistanceMax', 50)
	SetCVar('cameraDistanceMaxFactor', 2)
	SetCVar('cameraSmoothTrackingStyle', 0)
	SetCVar('chatMouseScroll', 1)
	SetCVar('lockActionBars', 1)
	SetCVar('lootUnderMouse', 1)
	SetCVar('lootUnderMouse', 1)
	SetCVar('nameplateShowEnemies', 1)
	SetCVar('profanityFilter', 0)
	SetCVar('taintLog', 0)
	--SetCVar('useUiScale', 1)
	--SetCVar('uiScale', 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], '%d+x(%d+)'))
	
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_OpenNewWindow(GENERAL)
	FCF_SetLocked(ChatFrame3, 1)
	FCF_DockFrame(ChatFrame3)
	
	ChatFrame3:Show()
	
	-- Setting chat frames
	if C.chat.enable == true and not (IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			local chatName = FCF_GetChatWindowInfo(chatFrameId)
			
			frame:SetSize(C.chat.width, C.chat.height)
			
			-- Default width and height of chats
			SetChatWindowSavedDimensions(chatFrameId, K.Scale(C.chat.width), K.Scale(C.chat.height))
			
			-- Move general chat to bottom left
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint(unpack(C.position.chat))
			end
			
			-- Save new default position and dimension
			FCF_SavePositionAndDimensions(frame)
			
			-- Set default font size
			FCF_SetChatWindowFontSize(nil, frame, 12)
			
			-- Rename chat tabs.
			if i == 1 then FCF_SetWindowName(frame, "G, S & W") end
			if i == 2 then FCF_SetWindowName(frame, "Log") end
			if i == 3 then FCF_SetWindowName(frame, LOOT.." / "..TRADE) end
			
			-- Lock them if unlocked
			if not frame.isLocked then FCF_SetLocked(frame, 1) end
		end
		
		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_RemoveChannel(ChatFrame1, TRADE)
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_DEFENSE)
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_RECRUITMENT)
		ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_LFG)
		ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT")
		ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_RemoveChannel(ChatFrame3, GENERAL)
		ChatFrame_AddChannel(ChatFrame3, TRADE)
		ChatFrame_AddChannel(ChatFrame3, L_CHAT_DEFENSE)
		ChatFrame_AddChannel(ChatFrame3, L_CHAT_RECRUITMENT)
		ChatFrame_AddChannel(ChatFrame3, L_CHAT_LFG)
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
		ChatFrame_AddMessageGroup(ChatFrame3, "YELL")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame3, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame3, "IGNORED")
		
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
		
		--General
		ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255)
		--Trade
		ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255)
		--Local Defense
		ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
		--Global
		ChangeChatColor("CHANNEL5", 255/255, 191/255, 191/255)
	end
	
	-- Reset saved variables on char
	SavedPositions = {}
	SavedOptionsPerChar = {}
	
	SavedOptionsPerChar.Install = true
	SavedOptionsPerChar.FogOfWar = false
	
	ReloadUI()
end

local function DisableUI()
	DisableAddOn("KkthnxUI")
	ReloadUI()
end


-- Install Popups 
StaticPopupDialogs.INSTALL_UI = {
	text = L_POPUP_INSTALLUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = false end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

StaticPopupDialogs.DISABLE_UI = {
	text = L_POPUP_DISABLEUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableUI,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_UI = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = true end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_STATS = {
	text = L_POPUP_RESETSTATS,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() SavedStats = {} ReloadUI() end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("RESET_UI") end

SLASH_INSTALLUI1 = "/installui"
SlashCmdList.INSTALLUI = function() StaticPopup_Show("INSTALL_UI") end

SLASH_RESETSTATS1 = "/resetstats"
SlashCmdList.RESETSTATS = function() StaticPopup_Show("RESET_STATS") end

-- On logon function
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	-- Create empty CVar if they doesn't exist
	if SavedOptions == nil then SavedOptions = {} end
	if SavedPositions == nil then SavedPositions = {} end
	if SavedAddonProfiles == nil then SavedAddonProfiles = {} end
	if SavedOptionsPerChar == nil then SavedOptionsPerChar = {} end
	--if oUFAbuSettings == nil then oUFAbuSettings = {} end
	
	-- Show empty buttons
	if C.actionbar.enable == true then
		if C.actionbar.showgrid == true then
			ActionButton_HideGrid = K.Dummy
			for i = 1, 12 do
				local button = _G[format("ActionButton%d", i)]
				button:SetAttribute("showgrid", 1)
				ActionButton_ShowGrid(button)
				
				button = _G[format("BonusActionButton%d", i)]
				button:SetAttribute("showgrid", 1)
				ActionButton_ShowGrid(button)
				
				button = _G[format("MultiBarRightButton%d", i)]
				button:SetAttribute("showgrid", 1)
				ActionButton_ShowGrid(button)
				
				button = _G[format("MultiBarBottomRightButton%d", i)]
				button:SetAttribute("showgrid", 1)
				ActionButton_ShowGrid(button)
				
				button = _G[format("MultiBarLeftButton%d", i)]
				button:SetAttribute("showgrid", 1)
				ActionButton_ShowGrid(button)
				
				button = _G[format("MultiBarBottomLeftButton%d", i)]
				button:SetAttribute("showgrid", 1)
				ActionButton_ShowGrid(button)
			end
		end
	end
	
	if SavedOptionsPerChar.FogOfWar == nil then SavedOptionsPerChar.FogOfWar = false end
	
	if K.getscreenwidth < 1024 and GetCVar("gxMonitor") == "0" then
		SetCVar("useUiScale", 0)
		StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if C.general.uiscale > 1.28 then C.general.uiscale = 1.28 end
		if C.general.uiscale < 0.64 then C.general.uiscale = 0.64 end
		
		-- Set our uiscale
		SetCVar("uiScale", C.general.uiscale)
		
		-- Install default if we never ran KkthnxUI on this character
		if not SavedOptionsPerChar.Install then
			StaticPopup_Show("INSTALL_UI")
		end
	end
	
	-- Welcome message
	if C.general.welcome_message == true then
		print("|cffffff00"..L_WELCOME_LINE_1..K.Version.." "..K.Client..", "..K.Name..".|r")
		print("|cffffff00"..L_WELCOME_LINE_2_1.."|cffffff00"..L_WELCOME_LINE_2_2)
		print("|cffffff00"..L_WELCOME_LINE_2_3.."|cffffff00"..L_WELCOME_LINE_2_4)
	end
end)