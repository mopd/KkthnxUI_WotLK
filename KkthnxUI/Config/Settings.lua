local K, C, L, _ = select(2, ...):unpack()

-- Media Options
C["Media"] = {
	["AB_Textures"] = [[Interface\Addons\KkthnxUI\Media\Actionbars\]],
	["Aura_Textures"] = [[Interface\Addons\KkthnxUI\Media\Buffs\]],
	["Backdrop_Color"] = {0.02, 0.02, 0.02, 0.8},
	["Blank"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Blank.tga]],
	["Blank_Font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Invisible.ttf]],
	["Blizz"] = [[Interface\Tooltips\UI-Tooltip-Border]],
	["Border_Color"] = {1, 1, 1, 1},
	["Combat_Font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]],
	["Glow"] = [[Interface\AddOns\KkthnxUI\Media\Textures\GlowTex.tga]],
	["Font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["Overlay_Color"] = {0, 0, 0, 0.8},
	["Proc_Sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Proc.ogg]],
	["Texture"] = [[Interface\TargetingFrame\UI-StatusBar]],
	["Warning_Sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Warning.ogg]],
	["Whisp_Sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Whisper.ogg]],
}
-- ActionBar Options
C["ActionBar"] = {
	["BottomBars"] = 3,
	["Button_Size"] = 36,
	["Button_Space"] = 3,
	["Enable"] = true,
	["Hotkey"] = true,
	["Macro"] = true,
	["Out_Of_Mana"] = {0.5, 0.5, 1},
	["Out_Of_Range"] = {0.8, 0.1, 0.1},
	["PetBar_Hide"] = false,
	["PetBar_Horizontal"] = false,
	["RightBars"] = 2,
	["Selfcast"] = false,
	["StanceBar_Hide"] = false,
	["StanceBar_Horizontal"] = true,
	["Show_Grid"] = true,
	["SplitBars"] = false,
	["Toggle_Mode"] = true,
}
-- Announcements Options
C["Announcements"] = {
	["Interrupt"] = false,
	["Pull_Countdown"] = true,
	["Say_Sapped"] = false,
	["Spells"] = false,
	["Spells_From_All"] = false,
}
-- Automation Options
C["Automation"] = {
	["autocollapse"] = true,
	["autoinvite"] = false,
	["declineduel"] = false,
	["logging_combat"] = false,
	["resurrection"] = false,
	["screenshot"] = false,
	["sellgrey_n_repair"] = false,
	["tab_binder"] = false,
}
-- Bag Options
C["Bag"] = {
	["bag_columns"] = 10,
	["bank_columns"] = 17,
	["button_size"] = 34,
	["button_space"] = 4,
	["enable"] = true,
}
-- Blizzard Options
C["Blizzard"] = {
	["capturebar"] = true,
	["class_color"] = true,
	["dark_textures"] = false,
	["dark_textures_color"] = {.3, .3, .3},
	["durability"] = true,
	["moveachievements"] = true,
	["questbuttonsize"] = 26,
	["reputations"] = true,
}
-- Buffs & Debuffs Options
C["Auras"] = {
	["aurasperrow"] = 12,
	["buffsize"] = 34,
	["cast_by"] = false,
	["debuffsize"] = 40,
	["enable"] = true,
	["paddingx"] = 4,
	["paddingy"] = 4,
}
-- Chat Options
C["Chat"] = {
	["combatlog"] = true,
	["damage_meter_spam"] = false,
	["enable"] = true,
	["filter"] = true,
	["height"] = 150,
	["outline"] = false,
	["spam"] = false,
	["sticky"] = true,
	["tabs_mouseover"] = true,
	["tabsoutline"] = false,
	["whisp_sound"] = true,
	["width"] = 400,
}
-- Cooldown Options
C["Cooldown"] = {
	["enable"] = true,
	["font_size"] = 20,
	["threshold"] = 3,
}
-- Error Options
C["Error"] = {
	["enable"] = true,
}
-- Filger Options
C["Filger"] = {
	["buffs_size"] = 37,
	["cooldown_size"] = 30,
	["enable"] = true,
	["max_test_icon"] = 5,
	["pvp_size"] = 60,
	["show_tooltip"] = false,
	["test_mode"] = false,
}
-- General Options
C["General"] = {
	["Auto_Scale"] = true,
	["chatbubble_fontsize"] = 12,
	["chatbubble_nobackdrop"] = false,
	["replace_blizz_fonts"] = true,
	["translate_message"] = true,
	["UIScale"] = 0.71,
	["welcome_message"] = true,
}
-- Loot Options
C["Loot"] = {
	["auto_confirm_de"] = false,
	["auto_greed"] = false,
	["betterlootfilter"] = true,
	["icon_size"] = 30,
	["lootframe"] = true,
	["rolllootframe"] = true,
	["width"] = 222,
}
-- Minimap Options
C["Minimap"] = {
	["collectbuttons"] = true,
	["enable"] = true,
	["ping"] = true,
	["size"] = 150,
	["Local_Time"] = true,
	["Time_24"] = false,
}
-- Miscellaneous Options
C["Misc"] = {
	["afk_spin_camera"] = false,
	["alreadyknown"] = false,
	["armory_link"] = false,
	["invite_keyword"] = "inv",
	["durability_warninig"] = false,
	["enhancedmail"] = true,
	["hattrick"] = true,
	["hide_bg_spam"] = false,
}
-- Nameplate Options
C["Nameplate"] = {
	["ad_height"] = 0,
	["ad_width"] = 0,
	["auras_size"] = 20,
	["bad_color"] = {0.78, 0.25, 0.25},
	["class_icons"] = false,
	["combat"] = false,
	["enable"] = true,
	["enhance_threat"] = false,
	["good_color"] = {0.29, 0.68, 0.29},
	["health_value"] = true,
	["height"] = 9,
	["name_abbrev"] = true,
	["near_color"] = {0.85, 0.77, 0.36},
	["show_castbar_name"] = true,
	["track_auras"] = false,
	["width"] = 120,
}
-- PowerBar Options
C["PowerBar"] = {
	["enable"] = false,
	["font_outline"] = false,
	["height"] = 4,
	["hide_blizzard_runebar"] = false,
	["show_combo"] = true,
	["show_energy"] = true,
	["show_mana"] = true,
	["show_rage"] = true,
	["show_rune"] = true,
	["show_rune_cooldown"] = true,
	["value_abbrev"] = true,
	["width"] = 200,
}
-- PulseCD Options
C["PulseCD"] = {
	["enable"] = false,
	["size"] = 75,
	["sound"] = false,
	["anim_scale"] = 1.5,
	["hold_time"] = 0,
	["threshold"] = 3,
}
-- Skins Options
C["Skins"] = {
	["spy"] = false,
	["chatbubble"] = true,
	["clcret"] = false,
	["dbm"] = false,
	["minimap_buttons"] = true,
	["recount"] = false,
	["skada"] = false,
	["weakauras"] = false,
	["worldmap"] = false,
}
-- Tooltip Options
C["Tooltip"] = {
	["achievements"] = true,
	["arena_experience"] = false,
	["cursor"] = false,
	["enable"] = true,
	["health_value"] = false,
	["hide_combat"] = false,
	["hidebuttons"] = false,
	["instance_lock"] = false,
	["item_count"] = false,
	["item_icon"] = false,
	["quality_Border_Color"] = false,
	["raid_icon"] = false,
	["rank"] = true,
	["spell_id"] = false,
	["talents"] = false,
	["target"] = true,
	["title"] = false,
	["who_targetting"] = false,
}
-- Unitframe Options
C["Unitframe"] = {
	["auraoffsety"] = 3,
	["betterpowercolor"] = false,
	["cbscale"] = 1.2,
	["classhealth"] = false,
	["classicon"] = false,
	["combatfeedback"] = false,
	["hide_pvpicon"] = true,
	["enable"] = true,
	["enhancedframes"] = false,
	["groupnumber"] = false,
	["largeaura"] = 26,
	["outline"] = false,
	["percent_health"] = false,
	["scale"] = 1.2,
	["smallaura"] = 22,
}