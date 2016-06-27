-- GUI for KkthnxUI (by Fernir, Tukz and Tohveli, Shestak)
local _G = _G
local unpack = unpack
local sub = string.sub
local max = math.max
local print = print
local format = string.format
local pairs, type = pairs, type
local CreateFrame = CreateFrame

local realm = GetRealmName()
local name = UnitName("player")
Print = function(...)
	print("|cff2eb6ffKkthnxUI_Config|r:", ...)
end

if Locale == "enGB" then
	Locale = "enUS"
end

local ALLOWED_GROUPS = {
	["General"] = 1,
	["ActionBar"] = 2,
	["Announcements"] = 3,
	["Automation"] = 4,
	["Bag"] = 5,
	["Blizzard"] = 6,
	["Auras"] = 7,
	["Chat"] = 8,
	["Cooldown"] = 9,
	["Error"] = 10,
	["Filger"] = 11,
	["Loot"] = 12,
	["Minimap"] = 13,
	["Misc"] = 14,
	["Nameplate"] = 15,
	["PowerBar"] = 16,
	["PulseCD"] = 17,
	["Skins"] = 18,
	["Tooltip"] = 19,
	["Unitframe"] = 20,
}

local function Local(o)
	local K, C, L, _ = KkthnxUI:unpack()
	-- Actionbar Settings
	if o == "UIConfigActionBar" then o = ACTIONBAR_LABEL end
	if o == "UIConfigActionBarEnable" then o = L_GUI_ACTIONBAR_ENABLE end
	if o == "UIConfigActionBarOut_Of_Mana" then o = L_GUI_ACTIONBAR_OUT_OF_MANA end
	if o == "UIConfigActionBarOut_Of_Range" then o = L_GUI_ACTIONBAR_OUT_OF_RANGE end
	if o == "UIConfigActionBarSelfcast" then o = L_GUI_ACTIONBAR_SELFCAST end
	if o == "UIConfigActionBarHotkey" then o = L_GUI_ACTIONBAR_HOTKEY end
	if o == "UIConfigActionBarMacro" then o = L_GUI_ACTIONBAR_MACRO end
	if o == "UIConfigActionBarShow_Grid" then o = L_GUI_ACTIONBAR_GRID end
	if o == "UIConfigActionBarButton_Size" then o = L_GUI_ACTIONBAR_BUTTON_SIZE end
	if o == "UIConfigActionBarButton_Space" then o = L_GUI_ACTIONBAR_BUTTON_SPACE end
	if o == "UIConfigActionBarSplitBars" then o = L_GUI_ACTIONBAR_SPLIT_BARS end
	if o == "UIConfigActionBarToggle_Mode" then o = L_GUI_ACTIONBAR_TOGGLE_MODE end
	if o == "UIConfigActionBarBottomBars" then o = L_GUI_ACTIONBAR_BOTTOMBARS end
	if o == "UIConfigActionBarRightBars" then o = L_GUI_ACTIONBAR_RIGHTBARS end
	if o == "UIConfigActionBarPetBar_Hide" then o = L_GUI_ACTIONBAR_PETBAR_HIDE end
	if o == "UIConfigActionBarPetBar_Horizontal" then o = L_GUI_ACTIONBAR_PETBAR_HORIZONTAL end
	if o == "UIConfigActionBarStanceBar_Hide" then o = L_GUI_ACTIONBAR_STANCEBAR_HIDE end
	if o == "UIConfigActionBarStanceBar_Horizontal" then o = L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL end
	-- Announcement Settings
	if o == "UIConfigAnnouncements" then o = L_GUI_ANNOUNCEMENTS end
	if o == "UIConfigAnnouncementsInterrupt" then o = L_GUI_ANNOUNCEMENTS_INTERRUPT end
	if o == "UIConfigAnnouncementsPull_Countdown" then o = L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN end
	if o == "UIConfigAnnouncementsSay_Sapped" then o = L_GUI_ANNOUNCEMENTS_SAY_SAPPED end
	if o == "UIConfigAnnouncementsSpells" then o = L_GUI_ANNOUNCEMENTS_SPELLS end
	if o == "UIConfigAnnouncementsSpells_From_All" then o = L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL end
	-- Automation Settings
	if o == "UIConfigAutomation" then o = L_GUI_AUTOMATION end
	if o == "UIConfigAutomationautocollapse" then o = L_GUI_AUTOMATION_AUTOCOLLAPSE end
	if o == "UIConfigAutomationautoinvite" then o = L_GUI_AUTOMATION_ACCEPTINVITE end
	if o == "UIConfigAutomationdeclineduel" then o = L_GUI_AUTOMATION_DECLINEDUEL end
	if o == "UIConfigAutomationlogging_combat" then o = L_GUI_AUTOMATION_LOGGING_COMBAT end
	if o == "UIConfigAutomationresurrection" then o = L_GUI_AUTOMATION_RESURRECTION end
	if o == "UIConfigAutomationscreenshot" then o = L_GUI_AUTOMATION_SCREENSHOT end
	if o == "UIConfigAutomationsellgrey_n_repair" then o = L_GUI_AUTOMATION_SELLGREY_N_REPAIR end
	if o == "UIConfigAutomationtab_binder" then o = L_GUI_AUTOMATION_TAB_BINDER end
	-- Bag Settings
	if o == "UIConfigBag" then o = L_GUI_BAGS end
	if o == "UIConfigBagbag_columns" then o = L_GUI_BAGS_BAG end
	if o == "UIConfigBagbank_columns" then o = L_GUI_BAGS_BANK end
	if o == "UIConfigBagbutton_size" then o = L_GUI_BAGS_BUTTON_SIZE end
	if o == "UIConfigBagbutton_space" then o = L_GUI_BAGS_BUTTON_SPACE end
	if o == "UIConfigBagenable" then o = L_GUI_BAGS_ENABLE end
	-- Blizzard Settings
	if o == "UIConfigBlizzard" then o = L_GUI_BLIZZARD end
	if o == "UIConfigBlizzardcapturebar" then o = L_GUI_BLIZZARD_CAPTUREBAR end
	if o == "UIConfigBlizzardclass_color" then o = L_GUI_BLIZZARD_CLASS_COLOR end
	if o == "UIConfigBlizzarddark_textures" then o = L_GUI_BLIZZARD_DARK_TEXTURES end
	if o == "UIConfigBlizzarddark_textures_color" then o = L_GUI_BLIZZARD_DARK_TEXTURES_COLOR end
	if o == "UIConfigBlizzarddurability" then o = L_GUI_BLIZZARD_DURABILITY end
	if o == "UIConfigBlizzardmoveachievements" then o = L_GUI_BLIZZARD_ACHIEVEMENTS end
	if o == "UIConfigBlizzardquestbuttonsize" then o = L_GUI_BLIZZARD_QUESTBUTTON_SIZE end
	if o == "UIConfigBlizzardreputations" then o = L_GUI_BLIZZARD_REPUTATIONS end
	-- Auras Settings
	if o == "UIConfigAuras" then o = L_GUI_BUFFS end
	if o == "UIConfigAurasaurasperrow" then o = L_GUI_BUFFS_BUFFPERROW end
	if o == "UIConfigAurasbuffsize" then o = L_GUI_BUFFS_BUFFSIZE end
	if o == "UIConfigAurascast_by" then o = L_GUI_BUFFS_CAST_BY end
	if o == "UIConfigAurasclass_color" then o = L_GUI_BUFFS_CLASS_COLOR end
	if o == "UIConfigAurasdebuffsize" then o = L_GUI_BUFFS_DEBUFFSIZE end
	if o == "UIConfigAurasenable" then o = L_GUI_BUFFS_ENABLE end
	if o == "UIConfigAuraspaddingx" then o = L_GUI_BUFFS_PADDINGX end
	if o == "UIConfigAuraspaddingy" then o = L_GUI_BUFFS_PADDINGY end
	-- Chat Settings
	if o == "UIConfigChat" then o = CHAT end
	if o == "UIConfigChatcombatlog" then o = L_GUI_CHAT_CL_TAB end
	if o == "UIConfigChatdamage_meter_spam" then o = L_GUI_CHAT_DAMAGE_METER_SPAM end
	if o == "UIConfigChatenable" then o = L_GUI_CHAT_ENABLE end
	if o == "UIConfigChatfilter" then o = L_GUI_CHAT_SPAM end
	if o == "UIConfigChatheight" then o = L_GUI_CHAT_HEIGHT end
	if o == "UIConfigChatoutline" then o = L_GUI_CHAT_OUTLINE end
	if o == "UIConfigChatspam" then o = L_GUI_CHAT_GOLD end
	if o == "UIConfigChatsticky" then o = L_GUI_CHAT_STICKY end
	if o == "UIConfigChattabs_mouseover" then o = L_GUI_CHAT_TABS_MOUSEOVER end
	if o == "UIConfigChattabsoutline" then o = L_GUI_CHAT_TABS_OUTLINE end
	if o == "UIConfigChatwhisp_sound" then o = L_GUI_CHAT_WHISP end
	if o == "UIConfigChatwidth" then o = L_GUI_CHAT_WIDTH end
	-- Cooldown Settings
	if o == "UIConfigCooldown" then o = L_GUI_COOLDOWN end
	if o == "UIConfigCooldownenable" then o = L_GUI_COOLDOWN_ENABLE end
	if o == "UIConfigCooldownfont_size" then o = L_GUI_COOLDOWN_FONT_SIZE end
	if o == "UIConfigCooldownthreshold" then o = L_GUI_COOLDOWN_THRESHOLD end
	-- Error Settings
	if o == "UIConfigError" then o = L_GUI_ERROR end
	if o == "UIConfigErrorenable" then o = L_GUI_ERROR_ENABLE end
	-- Filger
	if o == "UIConfigFilger" then o = L_GUI_FILGER end
	if o == "UIConfigFilgerbuffs_size" then o = L_GUI_FILGER_BUFFS_SIZE end
	if o == "UIConfigFilgercooldown_size" then o = L_GUI_FILGER_COOLDOWN_SIZE end
	if o == "UIConfigFilgerenable" then o = L_GUI_FILGER_ENABLE end
	if o == "UIConfigFilgermax_test_icon" then o = L_GUI_FILGER_MAX_TEST_ICON end
	if o == "UIConfigFilgerpvp_size" then o = L_GUI_FILGER_PVP_SIZE end
	if o == "UIConfigFilgershow_tooltip" then o = L_GUI_FILGER_SHOW_TOOLTIP end
	if o == "UIConfigFilgertest_mode" then o = L_GUI_FILGER_TEST_MODE end
	-- General Settings
	if o == "UIConfigGeneral" then o = GENERAL_LABEL end
	if o == "UIConfigGeneralAuto_Scale" then o = L_GUI_GENERAL_AUTOSCALE end
	if o == "UIConfigGeneralchatbubble_fontsize" then o = L_GUI_GENERAL_CHATBUBBLE_FONTSIZE end
	if o == "UIConfigGeneralchatbubble_nobackdrop" then o = L_GUI_GENERAL_CHATBUBBLE_NOBACKDROP end
	if o == "UIConfigGeneralReplace_Blizzard_Fonts" then o = L_GUI_GENERAL_Replace_Blizzard_Fonts end
	if o == "UIConfigGeneraltranslate_message" then o = L_GUI_GENERAL_TRANSLATE_MESSAGE end
	if o == "UIConfigGeneralUIScale" then o = L_GUI_GENERAL_UISCALE end
	if o == "UIConfigGeneralwelcome_message" then o = L_GUI_GENERAL_WELCOME_MESSAGE end
	-- Loot Settings
	if o == "UIConfigLoot" then o = LOOT end
	if o == "UIConfigLootauto_confirm_de" then o = L_GUI_LOOT_AUTODE end
	if o == "UIConfigLootauto_greed" then o = L_GUI_LOOT_AUTOGREED end
	if o == "UIConfigLootbetterlootfilter" then o = L_GUI_LOOT_BETTER_LOOTFILTER end
	if o == "UIConfigLooticon_size" then o = L_GUI_LOOT_ICON_SIZE end
	if o == "UIConfigLootlootframe" then o = L_GUI_LOOT_ENABLE end
	if o == "UIConfigLootrolllootframe" then o = L_GUI_LOOT_ROLL_ENABLE end
	if o == "UIConfigLootwidth" then o = L_GUI_LOOT_WIDTH end
	-- Minimap Settings
	if o == "UIConfigMinimap" then o = L_GUI_MINIMAP end
	if o == "UIConfigMinimapTime_24" then o = L_GUI_MINIMAP_TIME_24 end
	if o == "UIConfigMinimapcollectbuttons" then o = L_GUI_MINIMAP_COLLECTBUTTONS end
	if o == "UIConfigMinimapenable" then o = L_GUI_MINIMAP_ENABLEMINIMAP end
	if o == "UIConfigMinimapping" then o = L_GUI_MINIMAP_PING end
	if o == "UIConfigMinimapsize" then o = L_GUI_MINIMAP_MINIMAPSIZE end
	if o == "UIConfigMinimapLocal_Time" then o = L_GUI_MINIMAP_LOCAL_TIME end
	-- Misc Settings
	if o == "UIConfigMisc" then o = L_GUI_MISC end
	if o == "UIConfigMiscafk_spin_camera" then o = L_GUI_MISC_SPIN_CAMERA end
	if o == "UIConfigMiscalreadyknown" then o = L_GUI_MISC_ALREADY_KNOWN end
	if o == "UIConfigMiscarmory_link" then o = L_GUI_MISC_ARMORY_LINK end
	if o == "UIConfigMiscdurability_warninig" then o = L_GUI_MISC_DURABILITY_WARNINIG end
	if o == "UIConfigMiscenhancedmail" then o = L_GUI_MISC_ENCHANCED_MAIL end
	if o == "UIConfigMischattrick" then o = L_GUI_MISC_HATTRICK end
	if o == "UIConfigMischide_bg_spam" then o = L_GUI_MISC_HIDE_BG_SPAM end
	if o == "UIConfigMiscinvite_keyword" then o = L_GUI_MISC_INVKEYWORD end
	-- Nameplates Settings
	if o == "UIConfigNameplate" then o = UNIT_NAMEPLATES end
	if o == "UIConfigNameplatead_height" then o = L_GUI_NAMEPLATE_AD_HEIGHT end
	if o == "UIConfigNameplatead_width" then o = L_GUI_NAMEPLATE_AD_WIDTH end
	if o == "UIConfigNameplateauras_size" then o = L_GUI_NAMEPLATE_DEBUFFS_SIZE end
	if o == "UIConfigNameplatebad_color" then o = L_GUI_NAMEPLATE_BAD_COLOR end
	if o == "UIConfigNameplateclass_icons" then o = L_GUI_NAMEPLATE_CLASS_ICON end
	if o == "UIConfigNameplatecombat" then o = L_GUI_NAMEPLATE_COMBAT end
	if o == "UIConfigNameplateenable" then o = L_GUI_NAMEPLATE_ENABLE end
	if o == "UIConfigNameplateenhance_threat" then o = L_GUI_NAMEPLATE_THREAT end
	if o == "UIConfigNameplategood_color" then o = L_GUI_NAMEPLATE_GOOD_COLOR end
	if o == "UIConfigNameplatehealth_value" then o = L_GUI_NAMEPLATE_HEALTH end
	if o == "UIConfigNameplateheight" then o = L_GUI_NAMEPLATE_HEIGHT end
	if o == "UIConfigNameplatename_abbrev" then o = L_GUI_NAMEPLATE_NAME_ABBREV end
	if o == "UIConfigNameplatenear_color" then o = L_GUI_NAMEPLATE_NEAR_COLOR end
	if o == "UIConfigNameplateshow_castbar" then o = L_GUI_NAMEPLATE_CASTBAR end
	if o == "UIConfigNameplateshow_castbar_name" then o = L_GUI_NAMEPLATE_CASTBAR_NAME end
	if o == "UIConfigNameplatetrack_auras" then o = L_GUI_NAMEPLATE_SHOW_DEBUFFS end
	if o == "UIConfigNameplatewidth" then o = L_GUI_NAMEPLATE_WIDTH end
	-- PowerBar Settings
	if o == "UIConfigPowerBar" then o = L_GUI_POWERBAR end
	if o == "UIConfigPowerBarenable" then o = L_GUI_POWERBAR_ENABLE end
	if o == "UIConfigPowerBarfont_outline" then o = L_GUI_POWERBAR_FONT_OUTLINE end
	if o == "UIConfigPowerBarheight" then o = L_GUI_POWERBAR_HEIGHT end
	if o == "UIConfigPowerBarhide_blizzard_runebar" then o = L_GUI_POWERBAR_HIDE_BLIZZ_RUNEBAR end
	if o == "UIConfigPowerBarshow_combo" then o = L_GUI_POWERBAR_SHOW_COMBO end
	if o == "UIConfigPowerBarshow_energy" then o = L_GUI_POWERBAR_SHOW_ENERGY end
	if o == "UIConfigPowerBarshow_mana" then o = L_GUI_POWERBAR_SHOW_MANA end
	if o == "UIConfigPowerBarshow_rage" then o = L_GUI_POWERBAR_SHOW_RAGE end
	if o == "UIConfigPowerBarshow_rune" then o = L_GUI_POWERBAR_SHOW_RUNE end
	if o == "UIConfigPowerBarshow_rune_cooldown" then o = L_GUI_POWERBAR_SHOW_RUNE_CD end
	if o == "UIConfigPowerBarvalue_abbrev" then o = L_GUI_POWERBAR_VALUE_SHORT end
	if o == "UIConfigPowerBarwidth" then o = L_GUI_POWERBAR_WIDTH end
	-- PulseCD Settings
	if o == "UIConfigPulseCD" then o = L_GUI_PULSECD end
	if o == "UIConfigPulseCDenable" then o = L_GUI_PULSECD_ENABLE end
	if o == "UIConfigPulseCDsize" then o = L_GUI_PULSECD_SIZE end
	if o == "UIConfigPulseCDsound" then o = L_GUI_PULSECD_SOUND end
	if o == "UIConfigPulseCDanim_scale" then o = L_GUI_PULSECD_ANIM_SCALE end
	if o == "UIConfigPulseCDhold_time" then o = L_GUI_PULSECD_HOLD_TIME end
	if o == "UIConfigPulseCDthreshold" then o = L_GUI_PULSECD_THRESHOLD end
	-- Skins Settings
	if o == "UIConfigSkins" then o = L_GUI_SKINS end
	if o == "UIConfigSkinschatbubble" then o = L_GUI_SKINS_CHAT_BUBBLE end
	if o == "UIConfigSkinsclcret" then o = L_GUI_SKINS_CLCR end
	if o == "UIConfigSkinsdbm" then o = L_GUI_SKINS_DBM end
	if o == "UIConfigSkinsminimap_buttons" then o = L_GUI_SKINS_MINIMAP_BUTTONS end
	if o == "UIConfigSkinsrecount" then o = L_GUI_SKINS_RECOUNT end
	if o == "UIConfigSkinsskada" then o = L_GUI_SKINS_SKADA end
	if o == "UIConfigSkinsspy" then o = L_GUI_SKINS_SPY end
	if o == "UIConfigSkinsweakauras" then o = L_GUI_SKINS_WEAKAURAS end
	if o == "UIConfigSkinsworldmap" then o = L_GUI_SKINS_WORLDMAP end
	-- Tooltip Settings
	if o == "UIConfigTooltip" then o = L_GUI_TOOLTIP end
	if o == "UIConfigTooltipachievements" then o = L_GUI_TOOLTIP_ACHIEVEMENTS end
	if o == "UIConfigTooltiparena_experience" then o = L_GUI_TOOLTIP_ARENA_EXPERIENCE end
	if o == "UIConfigTooltipcursor" then o = L_GUI_TOOLTIP_CURSOR end
	if o == "UIConfigTooltipenable" then o = L_GUI_TOOLTIP_ENABLE end
	if o == "UIConfigTooltiphealth_value" then o = L_GUI_TOOLTIP_HEALTH end
	if o == "UIConfigTooltiphide_combat" then o = L_GUI_TOOLTIP_HIDE_COMBAT end
	if o == "UIConfigTooltiphidebuttons" then o = L_GUI_TOOLTIP_HIDE end
	if o == "UIConfigTooltipinstance_lock" then o = L_GUI_TOOLTIP_INSTANCE_LOCK end
	if o == "UIConfigTooltipitem_count" then o = L_GUI_TOOLTIP_ITEM_COUNT end
	if o == "UIConfigTooltipitem_icon" then o = L_GUI_TOOLTIP_ICON end
	if o == "UIConfigTooltipquality_Border_Color" then o = L_GUI_TOOLTIP_QUALITY_BORDER end
	if o == "UIConfigTooltipraid_icon" then o = L_GUI_TOOLTIP_RAID_ICON end
	if o == "UIConfigTooltiprank" then o = L_GUI_TOOLTIP_RANK end
	if o == "UIConfigTooltiprealm" then o = L_GUI_TOOLTIP_REALM end
	if o == "UIConfigTooltipspell_id" then o = L_GUI_TOOLTIP_SPELL_ID end
	if o == "UIConfigTooltiptalents" then o = L_GUI_TOOLTIP_TALENTS end
	if o == "UIConfigTooltiptarget" then o = L_GUI_TOOLTIP_TARGET end
	if o == "UIConfigTooltiptitle" then o = L_GUI_TOOLTIP_TITLE end
	if o == "UIConfigTooltipwho_targetting" then o = L_GUI_TOOLTIP_WHO_TARGETTING end
	-- Unitframe Settings
	if o == "UIConfigUnitframe" then o = L_GUI_UNITFRAME end
	if o == "UIConfigUnitframeauraoffsety" then o = L_GUI_UNITFRAME_AURA_OFFSETY end
	if o == "UIConfigUnitframebetterpowercolor" then o = L_GUI_UNITFRAME_BETTER_POWER_COLOR end
	if o == "UIConfigUnitframecbscale" then o = L_GUI_UNITFRAME_CASTBAR_SCALE end
	if o == "UIConfigUnitframeclasshealth" then o = L_GUI_UNITFRAME_CLASS_HEALTH end
	if o == "UIConfigUnitframeclassicon" then o = L_GUI_UNITFRAME_CLASS_ICON end
	if o == "UIConfigUnitframecombatfeedback" then o = L_GUI_UNITFRAME_COMBAT_FEEDBACK end
	if o == "UIConfigUnitframeenable" then o = L_GUI_UNITFRAME_ENABLE end
	if o == "UIConfigUnitframeenhancedframes" then o = L_GUI_UNITFRAME_ENHANCED_UNITFRAMES end
	if o == "UIConfigUnitframegroupnumber" then o = L_GUI_UNITFRAME_GROUP_NUMBER end
	if o == "UIConfigUnitframehide_pvpicon" then o = L_GUI_UNITFRAME_HIDE_PVPICON end
	if o == "UIConfigUnitframelargeaura" then o = L_GUI_UNITFRAME_LARGE_AURA end
	if o == "UIConfigUnitframeoutline" then o = L_GUI_UNITFRAME_OUTLINE end
	if o == "UIConfigUnitframepercent_health" then o = L_GUI_UNITFRAME_PERCENT_HEALTH end
	if o == "UIConfigUnitframescale" then o = L_GUI_UNITFRAME_SCALE end
	if o == "UIConfigUnitframesmallaura" then o = L_GUI_UNITFRAME_SMALL_AURA end

	K.option = o
end

local NewButton = function(text, parent)
	local K, C, L, _ = KkthnxUI:unpack()

	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetText(text)
	result:SetWidth(label:GetWidth())
	result:SetHeight(label:GetHeight())
	result:SetFontString(label)
	result:SetNormalTexture("")
	result:SetHighlightTexture("")
	result:SetPushedTexture("")

	return result
end

local NormalButton = function(text, parent)
	local K, C, L, _ = KkthnxUI:unpack()

	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetJustifyH("LEFT")
	label:SetText(text)
	result:SetSize(100, 23)
	result:SetFontString(label)

	return result
end

local NormalButton = function(text, parent)
	local K, C, L, _ = KkthnxUI:unpack()

	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetJustifyH("LEFT")
	label:SetText(text)
	result:SetSize(100, 23)
	result:SetFontString(label)
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.Reskin(result)
	end

	return result
end

StaticPopupDialogs.PERCHAR = {
	text = L_GUI_PER_CHAR,
	OnAccept = function()
		if UIConfigAllCharacters:GetChecked() then
			GUIConfigAll[realm][name] = true
		else
			GUIConfigAll[realm][name] = false
		end
		ReloadUI()
	end,
	OnCancel = function()
		UIConfigCover:Hide()
		if UIConfigAllCharacters:GetChecked() then
			UIConfigAllCharacters:SetChecked(false)
		else
			UIConfigAllCharacters:SetChecked(true)
		end
	end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs.RESET_PERCHAR = {
	text = L_GUI_RESET_CHAR,
	OnAccept = function()
		GUIConfig = GUIConfigSettings
		ReloadUI()
	end,
	OnCancel = function() if UIConfig and UIConfig:IsShown() then UIConfigCover:Hide() end end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs.RESET_ALL = {
	text = L_GUI_RESET_ALL,
	OnAccept = function()
		GUIConfigSettings = nil
		GUIConfig = nil
		ReloadUI()
	end,
	OnCancel = function() UIConfigCover:Hide() end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

local function SetValue(group, option, value)
	local mergesettings
	if GUIConfig == GUIConfigSettings then
		mergesettings = true
	else
		mergesettings = false
	end

	if GUIConfigAll[realm][name] == true then
		if not GUIConfig then GUIConfig = {} end
		if not GUIConfig[group] then GUIConfig[group] = {} end
		GUIConfig[group][option] = value
	else
		if mergesettings == true then
			if not GUIConfig then GUIConfig = {} end
			if not GUIConfig[group] then GUIConfig[group] = {} end
			GUIConfig[group][option] = value
		end

		if not GUIConfigSettings then GUIConfigSettings = {} end
		if not GUIConfigSettings[group] then GUIConfigSettings[group] = {} end
		GUIConfigSettings[group][option] = value
	end
end

local VISIBLE_GROUP = nil
local lastbutton = nil
local function ShowGroup(group, button)
	local K, C, L, _ = KkthnxUI:unpack()

	if lastbutton then
		lastbutton:SetText(lastbutton:GetText().sub(lastbutton:GetText(), 11, -3))
	end
	if VISIBLE_GROUP then
		_G["UIConfig"..VISIBLE_GROUP]:Hide()
	end
	if _G["UIConfig"..group] then
		local o = "UIConfig"..group
		Local(o)
		_G["UIConfigTitle"]:SetText(K.option)
		local height = _G["UIConfig"..group]:GetHeight()
		_G["UIConfig"..group]:Show()
		local scrollamntmax = 400
		local scrollamntmin = scrollamntmax - 10
		local max = height > scrollamntmax and height-scrollamntmin or 1

		if max == 1 then
			_G["UIConfigGroupSlider"]:SetValue(1)
			_G["UIConfigGroupSlider"]:Hide()
		else
			_G["UIConfigGroupSlider"]:SetMinMaxValues(0, max)
			_G["UIConfigGroupSlider"]:Show()
			_G["UIConfigGroupSlider"]:SetValue(1)
		end
		_G["UIConfigGroup"]:SetScrollChild(_G["UIConfig"..group])

		local x
		if UIConfigGroupSlider:IsShown() then
			_G["UIConfigGroup"]:EnableMouseWheel(true)
			_G["UIConfigGroup"]:SetScript("OnMouseWheel", function(self, delta)
				if UIConfigGroupSlider:IsShown() then
					if delta == -1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x + 10)
					elseif delta == 1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x - 30)
					end
				end
			end)
		else
			_G["UIConfigGroup"]:EnableMouseWheel(false)
		end

		VISIBLE_GROUP = group
		lastbutton = button
	end
end

local loaded
function CreateUIConfig()
	if InCombatLockdown() and not loaded then Print("|cffffe02e"..ERR_NOT_IN_COMBAT.."|r") return end
	local K, C, L, _ = KkthnxUI:unpack()

	if UIConfigMain then
		ShowGroup("General")
		UIConfigMain:Show()
		return
	end

	-- Main Frame
	local UIConfigMain = CreateFrame("Frame", "UIConfigMain", UIParent)
	UIConfigMain:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 200)
	UIConfigMain:SetSize(780, 520)
	UIConfigMain:SetBackdrop(K.Backdrop)
	UIConfigMain:SetBackdropColor(unpack(C["Media"].Backdrop_Color))
	UIConfigMain:SetBackdropBorderColor(K.Color.r, K.Color.g, K.Color.b)
	UIConfigMain:SetFrameStrata("DIALOG")
	UIConfigMain:SetFrameLevel(20)
	tinsert(UISpecialFrames, "UIConfigMain")

	-- Version Title
	local TitleBoxVer = CreateFrame("Frame", "TitleBoxVer", UIConfigMain)
	TitleBoxVer:SetSize(180, 24)
	TitleBoxVer:SetPoint("TOPLEFT", UIConfigMain, "TOPLEFT", 23, -15)

	local TitleBoxVerText = TitleBoxVer:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	TitleBoxVerText:SetPoint("CENTER")
	TitleBoxVerText:SetText("|cff2eb6ffKkthnxUI|r "..K.Version)

	-- Main Frame Title
	local TitleBox = CreateFrame("Frame", "TitleBox", UIConfigMain)
	TitleBox:SetSize(540, 24)
	TitleBox:SetPoint("TOPLEFT", TitleBoxVer, "TOPRIGHT", 15, 0)

	local TitleBoxText = TitleBox:CreateFontString("UIConfigTitle", "OVERLAY", "GameFontNormal")
	TitleBoxText:SetPoint("LEFT", TitleBox, "LEFT", 15, 0)

	-- Options Frame
	local UIConfig = CreateFrame("Frame", "UIConfig", UIConfigMain)
	UIConfig:SetPoint("TOPLEFT", TitleBox, "BOTTOMLEFT", 10, -15)
	UIConfig:SetSize(520, 400)

	local UIConfigBG = CreateFrame("Frame", "UIConfigBG", UIConfig)
	UIConfigBG:SetPoint("TOPLEFT", -10, 10)
	UIConfigBG:SetPoint("BOTTOMRIGHT", 10, -10)

	-- Group Frame
	local groups = CreateFrame("ScrollFrame", "UIConfigCategoryGroup", UIConfig)
	groups:SetPoint("TOPLEFT", TitleBoxVer, "BOTTOMLEFT", 10, -15)
	groups:SetSize(160, 400)

	local groupsBG = CreateFrame("Frame", "groupsBG", UIConfig)
	groupsBG:SetPoint("TOPLEFT", groups, -10, 10)
	groupsBG:SetPoint("BOTTOMRIGHT", groups, 10, -10)

	local UIConfigCover = CreateFrame("Frame", "UIConfigCover", UIConfigMain)
	UIConfigCover:SetPoint("TOPLEFT", 0, 0)
	UIConfigCover:SetPoint("BOTTOMRIGHT", 0, 0)
	UIConfigCover:SetFrameLevel(UIConfigMain:GetFrameLevel() + 20)
	UIConfigCover:EnableMouse(true)
	UIConfigCover:SetScript("OnMouseDown", function(self) print(L_GUI_MAKE_SELECTION) end)
	UIConfigCover:Hide()

	-- Group Scroll
	local slider = CreateFrame("Slider", "UIConfigCategorySlider", groups)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetSize(20, 400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) groups:SetVerticalScroll(value) end)

	if not slider.bg then
		slider.bg = CreateFrame("Frame", nil, slider)
		slider.bg:SetPoint("TOPLEFT", slider:GetThumbTexture(), "TOPLEFT", 10, -7)
		slider.bg:SetPoint("BOTTOMRIGHT", slider:GetThumbTexture(), "BOTTOMRIGHT", -7, 7)
		slider:GetThumbTexture():SetAlpha(0)
	end

	local function sortMyTable(a, b)
		return ALLOWED_GROUPS[a] < ALLOWED_GROUPS[b]
	end
	local function pairsByKey(t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, sortMyTable)
		local i = 0
		local iter = function()
			i = i + 1
			if a[i] == nil then return nil
			else return a[i], t[a[i]]
			end
		end
		return iter
	end

	local GetOrderedIndex = function(t)
		local OrderedIndex = {}

		for key in pairs(t) do table.insert(OrderedIndex, key) end
		table.sort(OrderedIndex)
		return OrderedIndex
	end

	local OrderedNext = function(t, state)
		local Key

		if (state == nil) then
			t.OrderedIndex = GetOrderedIndex(t)
			Key = t.OrderedIndex[1]
			return Key, t[Key]
		end

		Key = nil
		for i = 1, #t.OrderedIndex do
			if (t.OrderedIndex[i] == state) then Key = t.OrderedIndex[i + 1] end
		end

		if Key then return Key, t[Key] end
		t.OrderedIndex = nil
		return
	end

	local PairsByKeys = function(t) return OrderedNext, t, nil end

	local child = CreateFrame("Frame", nil, groups)
	child:SetPoint("TOPLEFT")
	local offset = 5
	for i in pairsByKey(ALLOWED_GROUPS) do
		local o = "UIConfig"..i
		Local(o)
		local button = NewButton(K.option, child)
		button:SetSize(125, 16)
		button:SetPoint("TOPLEFT", 5, -offset)
		button:SetScript("OnClick", function(self) ShowGroup(i, button) self:SetText(format("|cff%02x%02x%02x%s|r", K.Color.r*255, K.Color.g*255, K.Color.b*255, K.option)) end)
		offset = offset + 20
	end
	child:SetSize(125, offset)
	--slider:SetMinMaxValues(0, (offset == 0 and 1 or offset - 12 * 33))
	slider:SetValue(1)
	groups:SetScrollChild(child)

	local x
	_G["UIConfigCategoryGroup"]:EnableMouseWheel(true)
	_G["UIConfigCategoryGroup"]:SetScript("OnMouseWheel", function(self, delta)
		if _G["UIConfigCategorySlider"]:IsShown() then
			if delta == -1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x + 10)
			elseif delta == 1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x - 20)
			end
		end
	end)

	local group = CreateFrame("ScrollFrame", "UIConfigGroup", UIConfig)
	group:SetPoint("TOPLEFT", 0, 5)
	group:SetSize(520, 400)

	-- Options Scroll
	local slider = CreateFrame("Slider", "UIConfigGroupSlider", group)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetSize(20, 400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) group:SetVerticalScroll(value) end)

	for i in pairs(ALLOWED_GROUPS) do
		local frame = CreateFrame("Frame", "UIConfig"..i, UIConfigGroup)
		frame:SetPoint("TOPLEFT")
		frame:SetWidth(225)

		local offset = 5

		if type(C[i]) ~= "table" then Error(i.." GroupName not found in config table.") return end
		for j, value in PairsByKeys(C[i]) do
			if type(value) == "boolean" then
				local button = CreateFrame("CheckButton", "UIConfig"..i..j, frame, "InterfaceOptionsCheckButtonTemplate")
				local o = "UIConfig"..i..j
				Local(o)
				_G["UIConfig"..i..j.."Text"]:SetText(K.option)
				_G["UIConfig"..i..j.."Text"]:SetFontObject(GameFontHighlight)
				_G["UIConfig"..i..j.."Text"]:SetWidth(460)
				_G["UIConfig"..i..j.."Text"]:SetJustifyH("LEFT")
				button:SetChecked(value)
				button:SetScript("OnClick", function(self) SetValue(i, j, (self:GetChecked() and true or false)) end)
				button:SetPoint("TOPLEFT", 5, -offset)
				offset = offset + 25
			elseif type(value) == "number" or type(value) == "string" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..i..j
				Local(o)
				label:SetText(K.option)
				label:SetSize(460, 20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -offset)

				local editbox = CreateFrame("EditBox", nil, frame)
				editbox:SetAutoFocus(false)
				editbox:SetMultiLine(false)
				editbox:SetSize(220, 22)
				editbox:SetMaxLetters(255)
				editbox:SetTextInsets(3, 0, 0, 0)
				editbox:SetFontObject(GameFontHighlight)
				editbox:SetPoint("TOPLEFT", 8, -(offset + 20))
				editbox:SetText(value)
				editbox:SetBackdrop(K.Backdrop)
				editbox:SetBackdropColor(unpack(C["Media"].Backdrop_Color))

				local okbutton = CreateFrame("Button", nil, frame)
				okbutton:SetHeight(editbox:GetHeight())
				okbutton:SetPoint("LEFT", editbox, "RIGHT", 2, 0)

				local oktext = okbutton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				oktext:SetText(OKAY)
				oktext:SetPoint("CENTER", okbutton, "CENTER", -1, 0)
				okbutton:SetWidth(oktext:GetWidth() + 5)
				okbutton:Hide()

				if type(value) == "number" then
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(i, j, tonumber(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(i, j, tonumber(editbox:GetText())) end)
				else
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(i, j, tostring(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(i, j, tostring(editbox:GetText())) end)
				end

				offset = offset + 45
			elseif type(value) == "table" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "UIConfig"..i..j
				Local(o)
				label:SetText(K.option)
				label:SetSize(440, 20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -offset)

				colorbuttonname = (label:GetText().."ColorPicker")

				local colorbutton = CreateFrame("Button", colorbuttonname, frame)
				colorbutton:SetHeight(20)
				colorbutton:SetBackdrop(K.Backdrop)
				colorbutton:SetBackdropBorderColor(unpack(value))
				colorbutton:SetBackdropColor(value[1], value[2], value[3], 0.3)
				colorbutton:SetPoint("LEFT", label, "RIGHT", 2, 0)

				local colortext = colorbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				colortext:SetText(COLOR)
				colortext:SetPoint("CENTER")
				colortext:SetJustifyH("CENTER")
				colorbutton:SetWidth(colortext:GetWidth() + 5)

				local oldvalue = value

				local function round(number, decimal)
					return (("%%.%df"):format(decimal)):format(number)
				end

				colorbutton:SetScript("OnMouseDown", function(self)
					if ColorPickerFrame:IsShown() then return end
					local newR, newG, newB, newA
					local fired = 0

					local r, g, b, a = self:GetBackdropBorderColor()
					r, g, b, a = round(r, 2), round(g, 2), round(b, 2), round(a, 2)
					local originalR, originalG, originalB, originalA = r, g, b, a

					local function ShowColorPicker(r, g, b, a, changedCallback)
						ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, changedCallback
						ColorPickerFrame:SetColorRGB(r, g, b)
						a = tonumber(a)
						ColorPickerFrame.hasOpacity = (a ~= nil and a ~= 1)
						ColorPickerFrame.opacity = a
						ColorPickerFrame.previousValues = {originalR, originalG, originalB, originalA}
						ColorPickerFrame:Hide()
						ColorPickerFrame:Show()
					end

					local function myColorCallback(restore)
						fired = fired + 1
						if restore ~= nil then
							-- The user bailed, we extract the old color from the table created by ShowColorPicker
							newR, newG, newB, newA = unpack(restore)
						else
							-- Something changed
							newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
						end

						value = {newR, newG, newB, newA}
						SetValue(i, j, (value))
						self:SetBackdropBorderColor(newR, newG, newB, newA)
						self:SetBackdropColor(newR, newG, newB, 0.3)
					end

					ShowColorPicker(originalR, originalG, originalB, originalA, myColorCallback)
				end)

				offset = offset + 25
			end
		end

		frame:SetHeight(offset)
		frame:Hide()
	end

	local reset = NormalButton(DEFAULT, UIConfigMain)
	reset:SetPoint("TOPLEFT", UIConfig, "BOTTOMLEFT", -10, -25)
	reset:SetScript("OnClick", function(self)
		UIConfigCover:Show()
		if GUIConfigAll[realm][name] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end)

	local close = NormalButton(CLOSE, UIConfigMain)
	close:SetPoint("TOPRIGHT", UIConfig, "BOTTOMRIGHT", 10, -25)
	close:SetScript("OnClick", function(self) PlaySound("igMainMenuOption") UIConfigMain:Hide() end)

	local load = NormalButton(APPLY, UIConfigMain)
	load:SetPoint("RIGHT", close, "LEFT", -4, 0)
	load:SetScript("OnClick", function(self) ReloadUI() end)

	local totalreset = NormalButton(L_GUI_BUTTON_RESET, UIConfigMain)
	totalreset:SetWidth(120)
	totalreset:SetPoint("TOPLEFT", groupsBG, "BOTTOMLEFT", 0, -15)
	totalreset:SetScript("OnClick", function(self)
		StaticPopup_Show("RESET_UI")
		GUIConfig = {}
		if GUIConfigAll[realm][name] == true then
			GUIConfigAll[realm][name] = {}
		end
		GUIConfigSettings = {}
	end)

	if GUIConfigAll then
		local button = CreateFrame("CheckButton", "UIConfigAllCharacters", TitleBox, "InterfaceOptionsCheckButtonTemplate")
		button:SetScript("OnClick", function(self) StaticPopup_Show("PERCHAR") UIConfigCover:Show() end)
		button:SetPoint("RIGHT", TitleBox, "RIGHT", -3, 0)
		button:SetHitRectInsets(0, 0, 0, 0)

		local label = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		label:SetText(L_GUI_SET_SAVED_SETTTINGS)
		label:SetPoint("RIGHT", button, "LEFT")

		if GUIConfigAll[realm][name] == true then
			button:SetChecked(true)
		else
			button:SetChecked(false)
		end
	end

	local bgSkins = {TitleBox, TitleBoxVer, UIConfigBG, groupsBG}
	for _, sb in pairs(bgSkins) do
		sb:SetBackdrop(K.Backdrop)
		sb:SetBackdropColor(unpack(C["Media"].Backdrop_Color))
		sb:SetBackdropBorderColor(unpack(C["Media"].Border_Color))
	end

	ShowGroup("General")
	loaded = true
end

do
	function SlashCmdList.CONFIG(msg, editbox)
		if not UIConfigMain or not UIConfigMain:IsShown() then
			PlaySound("igMainMenuOption")
			CreateUIConfig()
			HideUIPanel(GameMenuFrame)
		else
			PlaySound("igMainMenuOption")
			UIConfigMain:Hide()
		end
	end
	SLASH_CONFIG1 = "/config"
	SLASH_CONFIG2 = "/cfg"
	SLASH_CONFIG3 = "/configui"

	function SlashCmdList.RESETCONFIG()
		if UIConfigMain and UIConfigMain:IsShown() then UIConfigCover:Show() end

		if GUIConfigAll[realm][name] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end
	SLASH_RESETCONFIG1 = "/resetconfig"
end

do
	local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
	frame:Hide()

	frame.name = "|cff2eb6ffKkthnxUI|r"
	frame:SetScript("OnShow", function(self)
		if self.show then return end
		local K, C, L, _ = KkthnxUI:unpack()
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText("Info:")

		local subtitle = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle:SetWidth(380)
		subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
		subtitle:SetJustifyH("LEFT")
		subtitle:SetText("UI Site: |cff2eb6ffhttps://kkthnx.github.io/KkthnxUI_WotLK/|r\nGitHub: |cff2eb6ffhttps://github.com/Kkthnx/KkthnxUI_WotLK|r\nLog: |cff2eb6ffhttps://github.com/Kkthnx/KkthnxUI_WotLK/commits/master|r")

		local title2 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title2:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -16)
		title2:SetText("Credits:")

		local subtitle2 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle2:SetWidth(380)
		subtitle2:SetPoint("TOPLEFT", title2, "BOTTOMLEFT", 0, -8)
		subtitle2:SetJustifyH("LEFT")
		subtitle2:SetText("ALZA, AcidWeb, Aezay, Affli, Ailae, Allez, Ammo, Astromech, Beoko, Bitbyte, Blamdarot, Bozo, Bunny67, Caellian, Califpornia, Camealion, Chiril, Crum, CrusaderHeimdall, Cybey, Dawn, Don Kaban, Dridzt, Duffed, Durcyn, Eclipse, Egingell, Elv22, Evilpaul, Evl, Favorit, Fernir, Foof, Freebaser, freesay, |ccfff7d0aGoldpaw|r, Gorlasch, Gsuz, Haleth, Haste, Hoochie, Hungtar, HyPeRnIcS, Hydra, Ildyria, Jaslm, Karl_w_w, Karudon, Katae, Kellett, Kemayo, Killakhan, Kraftman, Kunda, Leatrix, Magdain, Meurtcriss, Monolit, MrRuben5, Myrilandell of Lothar, Nathanyel, Nefarion, Nightcracker, Nils Ruesch, Partha, Phanx, Rahanprout, Renstrom, RustamIrzaev, SDPhantom, Safturento, Sara.Festung, Sildor, Silverwind, SinaC, Slakah, Soeters, Starlon, Suicidal Katt, Syzgyn, Tekkub, Telroth, Thalyra, Thizzelle, Tia Lynn, Tohveli, Tukz, Tuller, Veev, Villiv, Wetxius, Woffle of Dark Iron, Wrug, Xuerian, Yleaf, Zork, g0st, gi2k15, iSpawnAtHome, m2jest1c, p3lim, sticklord, |cFFFF69B4Magicnachos|r")

		local title3 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title3:SetPoint("TOPLEFT", subtitle2, "BOTTOMLEFT", 0, -16)
		title3:SetText("Translation:")

		local subtitle3 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle3:SetWidth(380)
		subtitle3:SetPoint("TOPLEFT", title3, "BOTTOMLEFT", 0, -8)
		subtitle3:SetJustifyH("LEFT")
		subtitle3:SetText("Bunny67, freesay")

		local title4 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title4:SetPoint("TOPLEFT", subtitle3, "BOTTOMLEFT", 0, -16)
		title4:SetText("Supporters")

		local subtitle4 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle4:SetWidth(380)
		subtitle4:SetPoint("TOPLEFT", title4, "BOTTOMLEFT", 0, -8)
		subtitle4:SetJustifyH("LEFT")
		subtitle4:SetText("XploitNT, jChirp, |cFFFF69B4Magicnachos|r")

		local version = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		version:SetPoint("BOTTOMRIGHT", -16, 16)
		version:SetText("Version: "..K.Version)

		self.show = true
	end)

	InterfaceOptions_AddCategory(frame)
end

-- Button in GameMenuButton frame
local button = CreateFrame("Button", "GameMenuButtonContinue", GameMenuFrame, "GameMenuButtonTemplate")
button:SetText("|cff2eb6ffKkthnxUI|r")
button:SetPoint("TOP", "GameMenuButtonContinue", "BOTTOM", 0, -13)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + button:GetHeight()+ 5)
button:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not UIConfigMain or not UIConfigMain:IsShown() then
		CreateUIConfig()
	else
		UIConfigMain:Hide()
	end
end)