-- GUI for KkthnxUI (by Fernir, Tukz and Tohveli, Shestak)

local realm = GetRealmName()
local name = UnitName("player")

local ALLOWED_GROUPS = {
	["general"] = 1,
	["actionbar"] = 2,
	["announcements"] = 3,
	["automation"] = 4,
	["blizzard"] = 5,
	["buffs"] = 6,
	["chat"] = 7,
	["error"] = 8,
	["loot"] = 9,
	["map"] = 10,
	["minimap"] = 11,
	["misc"] = 12,
	["skins"] = 13,
	["tooltip"] = 14,
	["unitframe"] = 15,
}

local function Local(o)
	local K, C, L = unpack(KkthnxUI)

	-- ActionBar options
	if o == "UIConfigactionbar" then o = ACTIONBAR_LABEL end
	if o == "UIConfigactionbarenable" then o = L_GUI_ACTIONBAR_ENABLE end
	if o == "UIConfigactionbarscale" then o = L_GUI_ACTIONBAR_SCALE end
	if o == "UIConfigactionbarshowbarart" then o = L_GUI_ACTIONBAR_SHOW_BARART end
	if o == "UIConfigactionbarshowhotkeys" then o = L_GUI_ACTIONBAR_SHOW_HOTKEYS end
	if o == "UIConfigactionbarshowmacroname" then o = L_GUI_ACTIONBAR_SHOW_MACRONAME end
	if o == "UIConfigactionbarskinbuttons" then o = L_GUI_ACTIONBAR_SKIN_BUTTONS end

	-- Announcements options
	if o == "UIConfigannouncements" then o = L_GUI_ANNOUNCEMENTS end
	if o == "UIConfigannouncementssaysapped" then o = L_GUI_ANNOUNCEMENTS_SAYSAPPED end

	-- Automation options
	if o == "UIConfigautomation" then o = L_GUI_AUTOMATION end
	if o == "UIConfigautomationautocollapse" then o = L_GUI_AUTOMATION_AUTOCOLLAPSE end
	if o == "UIConfigautomationautoinvite" then o = L_GUI_AUTOMATION_ACCEPTINVITE end
	if o == "UIConfigautomationautoscreenshot" then o = L_GUI_AUTOMATION_SCREENSHOT end
	if o == "UIConfigautomationbannerhide" then o = L_GUI_AUTOMATION_BANNER_HIDE end
	if o == "UIConfigautomationcollectgarbage" then o = L_GUI_AUTOMATION_COLLECTGARBAGE end
	if o == "UIConfigautomationdeclineduel" then o = L_GUI_AUTOMATION_DECLINEDUEL end
	if o == "UIConfigautomationopenitems" then o = L_GUI_AUTOMATION_OPEN_ITEMS end
	if o == "UIConfigautomationresurrection" then o = L_GUI_AUTOMATION_RESURRECTION end
	if o == "UIConfigautomationtabbinder" then o = L_GUI_AUTOMATION_TAB_BINDER end

	-- Blizzard options
	if o == "UIConfigblizzard" then o = L_GUI_BLIZZARD end
	if o == "UIConfigblizzardcapturebar" then o = L_GUI_BLIZZARD_CAPTUREBAR end
	if o == "UIConfigblizzardmoveachievements" then o = L_GUI_BLIZZARD_ACHIEVEMENTS end
	if o == "UIConfigblizzardmoveblizzard" then o = L_GUI_BLIZZARD_MOVE_BLIZZARD end
	if o == "UIConfigblizzardrepreward" then o = L_GUI_BLIZZARD_REPREWARD end
	if o == "UIConfigblizzarddurability" then o = L_GUI_BLIZZARD_DURABILITY end

	-- Buffs options
	if o == "UIConfigbuffs" then o = L_GUI_BUFFS end
	if o == "UIConfigbuffsaurasperrow" then o = L_GUI_BUFFS_BUFFPERROW end
	if o == "UIConfigbuffsbuffsize" then o = L_GUI_BUFFS_BUFFSIZE end
	if o == "UIConfigbuffscastby" then o = L_GUI_BUFFS_CAST_BY end
	if o == "UIConfigbuffsdebuffsize" then o = L_GUI_BUFFS_DEBUFFSIZE end
	if o == "UIConfigbuffsenable" then o = L_GUI_BUFFS_ENABLE end
	if o == "UIConfigbuffspaddingx" then o = L_GUI_BUFFS_PADDINGX end
	if o == "UIConfigbuffspaddingy" then o = L_GUI_BUFFS_PADDINGY end

	-- Chat options
	if o == "UIConfigchat" then o = SOCIALS end
	if o == "UIConfigchatbackground" then o = L_GUI_CHAT_BACKGROUND end
	if o == "UIConfigchatbackground_alpha" then o = L_GUI_CHAT_BACKGROUND_ALPHA end
	if o == "UIConfigchatbubbles" then o = L_GUI_CHAT_SKIN_BUBBLE end
	if o == "UIConfigchatchatfilter" then o = L_GUI_CHAT_SPAM end
	if o == "UIConfigchatcombatlog" then o = L_GUI_CHAT_CL_TAB end
	if o == "UIConfigchatdamagemeterspam" then o = L_GUI_CHAT_DAMAGE_METER_SPAM end
	if o == "UIConfigchatenable" then o = L_GUI_CHAT_ENABLE end
	if o == "UIConfigchatheight" then o = L_GUI_CHAT_HEIGHT end
	if o == "UIConfigchatoutline" then o = L_GUI_CHAT_OUTLINE end
	if o == "UIConfigchattabsoutline" then o = L_GUI_CHAT_TABS_OUTLINE end
	if o == "UIConfigchatsticky" then o = L_GUI_CHAT_STICKY end
	if o == "UIConfigchattabmouseover" then o = L_GUI_CHAT_TABS_MOUSEOVER end
	if o == "UIConfigchattime_color" then o = L_GUI_CHAT_TIMESTAMP end
	if o == "UIConfigchatwhisp_sound" then o = L_GUI_CHAT_WHISP end
	if o == "UIConfigchatwidth" then o = L_GUI_CHAT_WIDTH end

	-- Error filter options
	if o == "UIConfigerror" then o = L_GUI_ERROR end
	if o == "UIConfigerrorblack" then o = L_GUI_ERROR_BLACK end
	if o == "UIConfigerrorcombat" then o = L_GUI_ERROR_HIDE_COMBAT end
	if o == "UIConfigerrorwhite" then o = L_GUI_ERROR_WHITE end

	-- General options
	if o == "UIConfiggeneral" then o = GENERAL_LABEL end
	if o == "UIConfiggeneralauto_scale" then o = L_GUI_GENERAL_AUTOSCALE end
	if o == "UIConfiggeneralcustomlagtolerance" then o = L_GUI_GENERAL_LAG_TOLERANCE end
	if o == "UIConfiggeneraluiscale" then o = L_GUI_GENERAL_UISCALE end
	if o == "UIConfiggeneralwelcome_message" then o = L_GUI_GENERAL_WELCOME_MESSAGE end

	-- Loot options
	if o == "UIConfigloot" then o = LOOT end
	if o == "UIConfiglootauto_confirm_de" then o = L_GUI_LOOT_AUTODE end
	if o == "UIConfiglootauto_greed" then o = L_GUI_LOOT_AUTOGREED end
	if o == "UIConfiglooticon_size" then o = L_GUI_LOOT_ICON_SIZE end
	if o == "UIConfiglootlootframe" then o = L_GUI_LOOT_ENABLE end
	if o == "UIConfiglootrolllootframe" then o = L_GUI_LOOT_ROLL_ENABLE end
	if o == "UIConfiglootwidth" then o = L_GUI_LOOT_WIDTH end

	-- Map options
	if o == "UIConfigmap" then o = WORLD_MAP end
	if o == "UIConfigmapexploremap" then o = L_GUI_MAP_EXPLORE end
	if o == "UIConfigmapfogofwar" then o = L_GUI_MAP_FOG_OF_WAR end
	if o == "UIConfigmapmapbosscount" then o = L_GUI_MAP_BOSS_COUNT end

	-- Minimap options
	if o == "UIConfigminimap" then o = L_GUI_MINIMAP end
	if o == "UIConfigminimapcollectbuttons" then o = L_GUI_MINIMAP_COLLECTBUTTONS end
	if o == "UIConfigminimapenable" then o = L_GUI_MINIMAP_ENABLEMINIMAP end
	if o == "UIConfigminimapsize" then o = L_GUI_MINIMAP_MINIMAPSIZE end

	-- Miscellaneous options
	if o == "UIConfigmisc" then o = L_GUI_MISC end
	if o == "UIConfigmiscafkcam" then o = L_GUI_MISC_SPIN_CAMERA end
	if o == "UIConfigmiscalreadyknown" then o = L_GUI_MISC_ALREADY_KNOWN end
	if o == "UIConfigmiscbetterlootfilter" then o = L_GUI_MISC_BETTERLOOTFILTER end
	if o == "UIConfigmiscbgspam" then o = L_GUI_MISC_HIDE_BG_SPAM end
	if o == "UIConfigmiscbossbanner" then o = L_GUI_MISC_BOSSBANNER end
	if o == "UIConfigmiscclickcast" then o = L_GUI_MISC_CLICK_CAST end
	if o == "UIConfigmiscclickcastfilter" then o = L_GUI_MISC_CLICK_CAST_FILTER end
	if o == "UIConfigmiscdisenchanting" then o = L_GUI_MISC_DISENCHANTING end
	if o == "UIConfigmiscenchantscroll" then o = L_GUI_MISC_ENCHANTMENT_SCROLL end
	if o == "UIConfigmiscfadegamemenu" then o = L_GUI_MISC_FADEGAMEMENU end
	if o == "UIConfigmischattrick" then o = L_GUI_MISC_HATTRICK end
	if o == "UIConfigmiscenhancedmail" then o = L_GUI_ENCHANCED_MAIL end
	if o == "UIConfigmisclfgqueuetimer" then o = L_GUI_MISC_LFGQUEUETIMER end
	if o == "UIConfigmiscitemlevel" then o = L_GUI_MISC_ITEM_LEVEL end
	if o == "UIConfigmiscprofessiontabs" then o = L_GUI_MISC_PROFESSION_TABS end
	if o == "UIConfigmiscquestautobutton" then o = L_GUI_MISC_QUEST_AUTOBUTTON end
	if o == "UIConfigmiscrarealert" then o = L_GUI_MISC_HIDE_RAREALERT end
	if o == "UIConfigmiscshortengold" then o = L_GUI_MISC_SHORTGOLD end
	if o == "UIConfigmiscsumbuyouts" then o = L_GUI_MISC_SUM_BUYOUTS end

	-- Skins options
	if o == "UIConfigskins" then o = L_GUI_SKINS end
	if o == "UIConfigskinsbigwigs" then o = L_GUI_SKINS_BW end
	if o == "UIConfigskinsdbm" then o = L_GUI_SKINS_DBM end
	if o == "UIConfigskinsskada" then o = L_GUI_SKINS_SKADA end
	if o == "UIConfigskinsweakauras" then o = L_GUI_SKINS_WEAKAURAS end

	-- Stats options
	if o == "UIConfigstats" then o = L_GUI_STATS end
	if o == "UIConfigstatsbattleground" then o = L_GUI_STATS_BG end
	if o == "UIConfigstatsclock" then o = L_GUI_STATS_CLOCK end
	if o == "UIConfigstatscoords" then o = L_GUI_STATS_COORDS end
	if o == "UIConfigstatscurrency_archaeology" then o = L_GUI_STATS_CURRENCY_ARCHAEOLOGY end
	if o == "UIConfigstatscurrency_cooking" then o = L_GUI_STATS_CURRENCY_COOKING end
	if o == "UIConfigstatscurrency_misc" then o = L_GUI_STATS_CURRENCY_MISCELLANEOUS end
	if o == "UIConfigstatscurrency_professions" then o = L_GUI_STATS_CURRENCY_PROFESSIONS end
	if o == "UIConfigstatscurrency_pvp" then o = L_GUI_STATS_CURRENCY_PVP end
	if o == "UIConfigstatscurrency_raid" then o = L_GUI_STATS_CURRENCY_RAID end
	if o == "UIConfigstatsdurability" then o = DURABILITY end
	if o == "UIConfigstatsexperience" then o = L_GUI_STATS_EXPERIENCE end
	if o == "UIConfigstatsfps" then o = L_GUI_STATS_FPS end
	if o == "UIConfigstatsfriend" then o = FRIENDS end
	if o == "UIConfigstatsguild" then o = GUILD end
	if o == "UIConfigstatslatency" then o = L_GUI_STATS_LATENCY end
	if o == "UIConfigstatslocation" then o = L_GUI_STATS_LOCATION end
	if o == "UIConfigstatsmemory" then o = L_GUI_STATS_MEMORY end

	-- Tooltip options
	if o == "UIConfigtooltip" then o = L_GUI_TOOLTIP end
	if o == "UIConfigtooltipenable" then o = L_GUI_TOOLTIP_ENABLE end
	if o == "UIConfigtooltipitemicon" then o = L_GUI_TOOLTIP_ICONS end
	if o == "UIConfigtooltipfontoutline" then o = L_GUI_TOOLTIP_OUTLINE end
	if o == "UIConfigtooltipshortrealm" then o = L_GUI_TOOLTIP_SHORT_REALM end
	if o == "UIConfigtooltiphideincombat" then o = L_GUI_TOOLTIP_HIDE_IN_COMBAT end
	if o == "UIConfigtooltiphiderealm" then o = L_GUI_TOOLTIP_HIDE_REALM end
	if o == "UIConfigtooltipreactionbordercolor" then o = L_GUI_TOOLTIP_REACTION_BORDER_COLOR end
	if o == "UIConfigtooltipqualitybordercolor" then o = L_GUI_TOOLTIP_QUALITY_BORDER_COLOR end
	if o == "UIConfigtooltipshowtitles" then o = L_GUI_TOOLTIP_SHOW_TITLES end
	if o == "UIConfigtooltipshowpvpicons" then o = L_GUI_TOOLTIP_SHOW_PVP_ICONS end
	if o == "UIConfigtooltipmouseovertarget" then o = L_GUI_TOOLTIP_MOUSEOVER_TARGET end
	if o == "UIConfigtooltipcursor" then o = L_GUI_TOOLTIP_CURSOR end

	-- Top Panel options
	if o == "UIConfigtoppanel" then o = L_GUI_TOP_PANEL end
	if o == "UIConfigtoppanelenable" then o = L_GUI_TOP_PANEL_ENABLE end
	if o == "UIConfigtoppanelheight" then o = L_GUI_TOP_PANEL_HEIGHT end
	if o == "UIConfigtoppanelmouseover" then o = L_GUI_TOP_PANEL_MOUSE end
	if o == "UIConfigtoppanelwidth" then o = L_GUI_TOP_PANEL_WIDTH end

	-- Custom Unitframe options
	if o == "UIConfigunitframe" then o = L_GUI_UNITFRAME end
	if o == "UIConfigunitframeenable" then o = L_GUI_UNITFRAME_ENABLE end
	if o == "UIConfigunitframescale" then o = L_GUI_UNITFRAME_SCALE end
	if o == "UIConfigunitframecbscale" then o = L_GUI_UNITFRAME_CASTBAR_SCALE end
	if o == "UIConfigunitframepartyscale" then o = L_GUI_UNITFRAME_PARTY_SCALE end
	if o == "UIConfigunitframebossscale" then o = L_GUI_UNITFRAME_BOSS_SCALE end
	if o == "UIConfigunitframearenascale" then o = L_GUI_UNITFRAME_ARENA_SCALE end
	if o == "UIConfigunitframeclasshealth" then o = L_GUI_UNITFRAME_CLASS_HEALTH end
	if o == "UIConfigunitframeclassicon" then o = L_GUI_UNITFRAME_CLASS_ICON end
	if o == "UIConfigunitframecombatfeedback" then o = L_GUI_UNITFRAME_COMBAT_FEEDBACK end
	if o == "UIConfigunitframegroupnumber" then o = L_GUI_UNITFRAME_GROUP_NUMBER end
	if o == "UIConfigunitframeformattext" then o = L_GUI_UNITFRAME_FORMAT_TEXT end
	
	K.option = o
end

local NewButton = function(text, parent)
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
	local K, C, L = unpack(KkthnxUI)
	
	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetJustifyH("LEFT")
	label:SetText(text)
	result:SetWidth(100)
	result:SetHeight(23)
	result:SetFontString(label)
	
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
	preferredIndex = 5,
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
	preferredIndex = 5,
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
	preferredIndex = 5,
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
	local K, C, L = unpack(KkthnxUI)
	
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
	if InCombatLockdown() and not loaded then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
	local K, C, L = unpack(KkthnxUI)
	
	if UIConfigMain then
		ShowGroup("general")
		UIConfigMain:Show()
		return
	end
	
	-- Main Frame
	local UIConfigMain = CreateFrame("Frame", "UIConfigMain", UIParent)
	UIConfigMain:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 200)
	UIConfigMain:SetWidth(780)
	UIConfigMain:SetHeight(520)
	CreateStyle(UIConfigMain, 2)
	UIConfigMain:SetBackdropBorderColor(.7, .7, .7, 1)
	UIConfigMain:SetFrameStrata("DIALOG")
	UIConfigMain:SetFrameLevel(20)
	tinsert(UISpecialFrames, "UIConfigMain")
	
	-- Version Title
	local TitleBoxVer = CreateFrame("Frame", "TitleBoxVer", UIConfigMain)
	TitleBoxVer:SetWidth(180)
	TitleBoxVer:SetHeight(24)
	TitleBoxVer:SetPoint("TOPLEFT", UIConfigMain, "TOPLEFT", 23, -15)
	
	local TitleBoxVerText = TitleBoxVer:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	TitleBoxVerText:SetPoint("CENTER")
	TitleBoxVerText:SetText("|cFF4488FFKkthnx|r|cFFFEB200UI|r "..K.Version)
	
	-- Main Frame Title
	local TitleBox = CreateFrame("Frame", "TitleBox", UIConfigMain)
	TitleBox:SetWidth(540)
	TitleBox:SetHeight(24)
	TitleBox:SetPoint("TOPLEFT", TitleBoxVer, "TOPRIGHT", 15, 0)
	
	local TitleBoxText = TitleBox:CreateFontString("UIConfigTitle", "OVERLAY", "GameFontNormal")
	TitleBoxText:SetPoint("LEFT", TitleBox, "LEFT", 15, 0)
	
	-- Options Frame
	local UIConfig = CreateFrame("Frame", "UIConfig", UIConfigMain)
	UIConfig:SetPoint("TOPLEFT", TitleBox, "BOTTOMLEFT", 10, -15)
	UIConfig:SetWidth(520)
	UIConfig:SetHeight(400)
	
	local UIConfigBG = CreateFrame("Frame", "UIConfigBG", UIConfig)
	UIConfigBG:SetPoint("TOPLEFT", -10, 10)
	UIConfigBG:SetPoint("BOTTOMRIGHT", 10, -10)
	
	-- Group Frame
	local groups = CreateFrame("ScrollFrame", "UIConfigCategoryGroup", UIConfig)
	groups:SetPoint("TOPLEFT", TitleBoxVer, "BOTTOMLEFT", 10, -15)
	groups:SetWidth(160)
	groups:SetHeight(400)
	
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
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) groups:SetVerticalScroll(value) end)
	
	if not slider.bg then
		slider.bg = CreateFrame("Frame", nil, slider)
		slider.bg:SetPoint("TOPLEFT", slider:GetThumbTexture(), "TOPLEFT", 7, -7)
		slider.bg:SetPoint("BOTTOMRIGHT", slider:GetThumbTexture(), "BOTTOMRIGHT", -7, 7)
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
	
	local child = CreateFrame("Frame", nil, groups)
	child:SetPoint("TOPLEFT")
	local offset = 5
	for i in pairsByKey(ALLOWED_GROUPS) do
		local o = "UIConfig"..i
		Local(o)
		local button = NewButton(K.option, child)
		button:SetHeight(16)
		button:SetWidth(125)
		button:SetPoint("TOPLEFT", 5, -offset)
		button:SetScript("OnClick", function(self) ShowGroup(i, button) self:SetText(format("|cff%02x%02x%02x%s|r", K.Color.r*255, K.Color.g*255, K.Color.r*255, K.option)) end)
		offset = offset + 20
	end
	child:SetWidth(125)
	child:SetHeight(offset)
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
	group:SetWidth(520)
	group:SetHeight(400)
	
	-- Options Scroll
	local slider = CreateFrame("Slider", "UIConfigGroupSlider", group)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) group:SetVerticalScroll(value) end)
	
	for i in pairs(ALLOWED_GROUPS) do
		local frame = CreateFrame("Frame", "UIConfig"..i, UIConfigGroup)
		frame:SetPoint("TOPLEFT")
		frame:SetWidth(225)
		
		local offset = 5
		
		if type(C[i]) ~= "table" then error(i.." GroupName not found in config table.") return end
		for j, value in pairs(C[i]) do
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
				label:SetWidth(460)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -offset)
				
				local editbox = CreateFrame("EditBox", nil, frame)
				editbox:SetAutoFocus(false)
				editbox:SetMultiLine(false)
				editbox:SetWidth(220)
				editbox:SetHeight(22)
				editbox:SetMaxLetters(255)
				editbox:SetTextInsets(3, 0, 0, 0)
				editbox:SetFontObject(GameFontHighlight)
				editbox:SetPoint("TOPLEFT", 8, -(offset + 20))
				editbox:SetText(value)
				editbox:SetBackdrop(K.Backdrop)
				editbox:SetBackdropColor(0.08, 0.08, 0.08, 1)
				
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
				label:SetWidth(440)
				label:SetHeight(20)
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
					
					local r, g, b, a = self:GetBackdropBorderColor();
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
	totalreset:SetWidth(180)
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
	
	local bgskins = {TitleBox, TitleBoxVer, UIConfigBG, groupsBG}
	for _, sb in pairs(bgskins) do
		sb:SetBackdrop(K.Backdrop)
		sb:SetBackdropColor(0, 0, 0, 1)
		sb:SetBackdropBorderColor(.3, .3, .3)
	end
	
	ShowGroup("general")
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
	
	frame.name = "|cFF4488FFKkthnx|r|cFFFEB200UI|r"
	frame:SetScript("OnShow", function(self)
		if self.show then return end
		local K, C, L = unpack(KkthnxUI)
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText("Info:")
		
		local subtitle = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle:SetWidth(580)
		subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
		subtitle:SetJustifyH("LEFT")
		subtitle:SetText("GitHub: https://github.com/Kkthnx/KkthnxUI - https://github.com/Kkthnx/KkthnxUI/commits/master")
		
		local title2 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title2:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -16)
		title2:SetText("Credits:")
		
		local subtitle2 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle2:SetWidth(580)
		subtitle2:SetPoint("TOPLEFT", title2, "BOTTOMLEFT", 0, -8)
		subtitle2:SetJustifyH("LEFT")
		subtitle2:SetText("|cFFc248d8Magicnachos|r, sticklord, syncrow, liquidbase, Nibelheim, Shestak, Munglunch, Neav, Goldpaw, AcidWeb, Aezay, Affli, Ailae, Allez, ALZA, Ammo, Astromech, Beoko, Bitbyte, Blamdarot, Bozo, Caellian, Califpornia, Camealion, Chiril, CrusaderHeimdall, Cybey, Dawn, Don Kaban, Dridzt, Duffed, Durcyn, Eclipse, Egingell, Elv22, Evilpaul, Evl, Favorit, Fernir, Foof, Freebaser, g0st, gi2k15, Gorlasch, Gsuz, Haleth, Haste, Hoochie, Hungtar, HyPeRnIcS, Hydra, Ildyria, iSpawnAtHome, Jaslm, Karl_w_w, Karudon, Katae, Kellett, Kemayo, Killakhan, Kraftman, Kunda, Leatrix, m2jest1c, Magdain, Meurtcriss, Monolit, MrRuben5, Myrilandell of Lothar, Nathanyel, Nefarion, Nightcracker, Nils Ruesch, p3lim, Partha, Phanx, Rahanprout, Renstrom, RustamIrzaev, Safturento, Sara.Festung, SDPhantom, Sildor, Silverwind, SinaC, Slakah, Soeters, Starlon, Suicidal Katt, Syzgyn, Tekkub, Telroth, Thalyra, Thizzelle, Tia Lynn, Tohveli, Tukz, Tuller, Veev, Villiv, Wetxius, Woffle of Dark Iron, Wrug, Xuerian, Yleaf, Zork.")
		
		local title3 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title3:SetPoint("TOPLEFT", subtitle2, "BOTTOMLEFT", 0, -16)
		title3:SetText("Translation:")
		
		local subtitle3 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle3:SetWidth(580)
		subtitle3:SetPoint("TOPLEFT", title3, "BOTTOMLEFT", 0, -8)
		subtitle3:SetJustifyH("LEFT")
		subtitle3:SetText("")
		
		local title4 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title4:SetPoint("TOPLEFT", subtitle3, "BOTTOMLEFT", 0, -16)
		title4:SetText("Supporters")
		
		local subtitle4 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle4:SetWidth(580)
		subtitle4:SetPoint("TOPLEFT", title4, "BOTTOMLEFT", 0, -8)
		subtitle4:SetJustifyH("LEFT")
		subtitle4:SetText("XploitNT, |cFFc248d8Magicnachos|r, jChirp")
		
		local version = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		version:SetPoint("BOTTOMRIGHT", -16, 16)
		version:SetText("Version: "..K.Version)
		
		self.show = true
	end)
	
	InterfaceOptions_AddCategory(frame)
end

----------------------------------------------------------------------------------------
--	Button in GameMenuButton frame
----------------------------------------------------------------------------------------