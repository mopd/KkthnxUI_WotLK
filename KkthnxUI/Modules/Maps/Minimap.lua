local K, C, L, _ = unpack(select(2, ...))
if C.minimap.enable ~= true then return end

-- Minimap border
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)
MinimapAnchor:CreatePanel("Invisibile", C.minimap.size, C.minimap.size, unpack(C.position.minimap))

local frames = {
	'GameTimeFrame',
	'MinimapBorder',
	'MinimapZoomIn',
	'MinimapZoomOut',
	'MinimapBorderTop',
	'BattlegroundShine',
	'MiniMapWorldMapButton',
	'MinimapZoneTextButton',
	'MiniMapTrackingBackground',
	'MiniMapVoiceChatFrameBackground',
	'MiniMapVoiceChatFrameBorder',
	'MiniMapVoiceChatFrame',
	'MinimapNorthTag',
	'MiniMapBattlefieldBorder',
	'MiniMapMailBorder',
	'MiniMapTracking',
}

for i in pairs(frames) do
	_G[frames[i]]:Hide()
	_G[frames[i]].Show = K.Dummy
end

-- Kill Minimap Cluster
MinimapCluster:Kill()

-- Parent Minimap into our frame
Minimap:SetParent(MinimapAnchor)
Minimap:ClearAllPoints()
Minimap:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 0, 0)
Minimap:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", 0, 0)
Minimap:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())
-- Backdrop
MinimapBackdrop:ClearAllPoints()
MinimapBackdrop:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
MinimapBackdrop:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
MinimapBackdrop:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())

-- Mail
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 5)
MiniMapMailFrame:SetScale(1.2)
MiniMapMailIcon:SetTexture('Interface\\Addons\\KkthnxUI\\Media\\Textures\\Mail')

MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("TOP", Minimap, "TOP", 1, 1)
MiniMapBattlefieldFrame:SetScale(0.8)

MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 2)

-- Invites icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent(Minimap)
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("TOP", Minimap, "TOP", 1, 6)
	MiniMapLFGFrame:SetHighlightTexture(nil)
	MiniMapLFGFrameBorder:Kill()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

--[[ Clock ]]
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont(C.font.basic_font, C.font.basic_font_size, C.font.basic_font_style)
clockTime:SetShadowOffset(0, 0)
TimeManagerClockButton:ClearAllPoints()
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -5)
TimeManagerClockButton:SetScript('OnShow', nil)
TimeManagerClockButton:Hide()
TimeManagerClockButton:SetScript('OnClick', function(self, button)
	if(button=="RightButton") then
		if(self.alarmFiring) then
			PlaySound('igMainMenuQuit')
			TimeManager_TurnOffAlarm()
		else
			ToggleTimeManager()
		end
	else
		ToggleCalendar()
	end
end)  

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local guildText = IsInGuild() and ACHIEVEMENTS_GUILD_TAB or LOOKINGFORGUILD
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
			ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
			if InCombatLockdown() then
				print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
			end
			ToggleFrame(SpellBookFrame)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, func = function()
			if not PlayerTalentFrame then
				TalentFrame_LoadUI()
			end
			if K.Level >= SHOW_TALENT_LEVEL then
				ShowUIPanel(PlayerTalentFrame)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
			end
	end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
			ToggleAchievementFrame()
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
			ToggleQuestLog()
	end},
	{text = guildText, notCheckable = 1, func = function()
			ToggleGuildFrame()
			if IsInGuild() then
				GuildFrame_TabClicked(GuildFrameTab2)
			end
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
			ToggleFriendsFrame()
	end},
	{text = PLAYER_V_PLAYER, notCheckable = 1, func = function()
			if K.Level >= SHOW_PVP_LEVEL then
				TogglePVPFrame()
			else
				if C.error.white == false then
					UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL), 1, 0.1, 0.1)
				else
					print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL).."|r")
				end
			end
	end},
	{text = DUNGEONS_BUTTON, notCheckable = 1, func = function()
			if K.Level >= SHOW_LFD_LEVEL then
				PVEFrame_ToggleFrame("GroupFinderFrame", nil)
			else
				if C.error.white == false then
					UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL), 1, 0.1, 0.1)
				else
					print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL).."|r")
				end
			end
	end},
	{text = ADVENTURE_JOURNAL, notCheckable = 1, func = function()
			ToggleEncounterJournal()
	end},
	{text = COLLECTIONS, notCheckable = 1, func = function()
			if InCombatLockdown() then
				print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
			end
			ToggleCollectionsJournal()
	end},
	{text = HELP_BUTTON, notCheckable = 1, func = function()
			ToggleHelpFrame()
	end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
			ToggleCalendar()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = 1, func = function()
			ToggleBattlefieldMinimap()
	end},
	{text = LOOT_ROLLS, notCheckable = 1, func = function()
			ToggleFrame(LootHistoryFrame)
	end},
}

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = Minimap:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU")
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU")
		end
	elseif button == "MiddleButton" then
		if position:match("LEFT") then
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", 0, 0, "MENU", 2)
		else
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- For others mods with a minimap button, set minimap buttons position in square mode
function GetMinimapShape() return "SQUARE" end

-- Set Square Map View
Minimap:SetMaskTexture(C.media.blank)
MinimapBorder:Hide()

-- Who Pinged?
local wPing = CreateFrame('ScrollingMessageFrame', nil, Minimap)
wPing:SetHeight(10)
wPing:SetWidth(100)
wPing:SetPoint('BOTTOM', Minimap, 0, 20)

wPing:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
wPing:SetJustifyH'CENTER'
wPing:SetJustifyV'CENTER'
wPing:SetMaxLines(1)
wPing:SetFading(true)
wPing:SetFadeDuration(3)
wPing:SetTimeVisible(5)

wPing:RegisterEvent'MINIMAP_PING'
wPing:SetScript('OnEvent', function(self, event, u)
	local c = RAID_CLASS_COLORS[select(2,UnitClass(u))]
	local name = UnitName(u)
	if(name ~= K.Name) then
		wPing:AddMessage(name, c.r, c.g, c.b)
	end
end)