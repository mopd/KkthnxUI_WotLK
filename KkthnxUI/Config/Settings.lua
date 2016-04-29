local K, C, L, _ = unpack(select(2, ...))

-- Main Media Options
C["media"] = {
	["abtextures"] = [[Interface\Addons\KkthnxUI\Media\Actionbars\]],
	["auratextures"] = [[Interface\Addons\KkthnxUI\Media\Buffs\]],
	["backdrop_color"] = {0.03, 0.03, 0.03, .9},
	["blank"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Blank.tga]],
	["blank_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Invisible.ttf]],
	["blizz"] = [[Interface\Tooltips\UI-Tooltip-Border]],
	["blizzborder"] = [[Interface\Buttons\UI-Quickslot2]],
	["border_color"] = {0.7, 0.7, 0.7, 1},
	["bordertextures"] = [[Interface\Addons\KkthnxUI\Media\Border\]],
	["combat_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]],
	["empty"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Empty.tga]],
	["glow"] = [[Interface\AddOns\KkthnxUI\Media\Textures\GlowTex.tga]],
	["highlight"] = [[Interface\Addons\KkthnxUI\Media\Textures\HighlightNP]],
	["normal_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["overlay_color"] = {0, 0, 0, 0.7},
	["raidicons"] = [[Interface\AddOns\KkthnxUI\Media\Textures\raidicons.blp]],
	["texture"] = [[Interface\TargetingFrame\UI-StatusBar]],
	["unitframe_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["warning_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Warning.ogg]],
	["whisp_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Whisper.ogg]],
	["datatextcolor1"] = { .4, .4, .4 },
	["datatextcolor2"] = { 1, 1, 1 },
}
-- ActionBar Options
C["actionbar"] = {
	["bagsbar"] = true,
	["bagshide"] = false,
	["bagsmouseover"] = true,
	["enable"] = true,
	["micromenu"] = true,
	["micromenuhide"] = false,
	["micromenumouseover"] = false,
	["out_of_mana"] = {0.5, 0.5, 1},
	["out_of_range"] = {0.8, 0.1, 0.1},
	["removetextures"] = false,
	["scale"] = 1,
	["showgrid"] = true,
	["showhotkeys"] = true,
	["showmacroname"] = true,
	["skinbuttons"] = true,
}
-- Announcements Options
C["announcements"] = {
	["saysapped"] = true,
	["drinking"] = false,
	["spells"] = false,
	["pull_countdown"] = true,
	["spells_from_all"] = false,
	["interrupt"] = false,
}
-- Automation Options
C["automation"] = {
	["autocollapse"] = true,
	["autoinvite"] = false,
	["auto_collapse_reload"] = false,
	["declineduel"] = false,
	["sellgrey_n_repair"] = false,
	["cancel_bad_buffs"] = false,
	["tab_binder"] = false,
	["resurrection"] = false,
	["watchframebutton"] = false,
}
-- Blizzard Options
C["blizzard"] = {
	["capturebar"] = true,
	["classcolor"] = true,
	["durability"] = true,
	["moveachievements"] = true,
	["questbuttonsize"] = 26,
	["reputations"] = true,
	["dark_textures"] = false,
	["dark_textures_color"] = {.4, .4, .4},
}
-- Buffs & Debuffs Options
C["buffs"] = {
	["aurasperrow"] = 12,
	["buffsize"] = 34,
	["debuffsize"] = 40,
	["enable"] = true,
	["cast_by"] = false,
	["paddingx"] = 6,
	["paddingy"] = 6,
	["class_color"] = false,
}
-- Raid Buffs Reminder Options
C["reminder"] = {
	["raid_buffs_enable"] = true,
	["raid_buffs_always"] = false,
	["raid_buffs_size"] = 24,
	["raid_buffs_alpha"] = 0.4,
}
-- Chat Options
C["chat"] = {
	["combatlog"] = true,
	["enable"] = true,
	["filter"] = true,
	["height"] = 150,
	["outline"] = false,
	["spam"] = false,
	["sticky"] = true,
	["tabmouseover"] = true,
	["tabsoutline"] = false,
	["time_color"] = {1, 1, 0},
	["whisp_sound"] = true,
	["width"] = 400,
	["damage_meter_spam"] = false,
}
-- Cooldown Options
C["cooldown"] = {
	["enable"] = true,
	["font_size"] = 20,
	["threshold"] = 3,
}
-- Error Options
C["error"] = {
	["black"] = true,
	["combat"] = false,
	["white"] = false,
}
-- Filger Options
C["filger"] = {
	["enable"] = true,
	["test_mode"] = false,
	["max_test_icon"] = 5,
	["show_tooltip"] = false,
	["buffs_size"] = 37,
	["cooldown_size"] = 30,
	["pvp_size"] = 60,
}
-- General Options
C["general"] = {
	["auto_scale"] = true,
	["translate_message"] = true,
	["uiscale"] = 0.71,
	["welcome_message"] = true,
}
-- Loot Options
C["loot"] = {
	["auto_confirm_de"] = false,
	["auto_greed"] = false,
	["betterlootfilter"] = true,
	["icon_size"] = 30,
	["lootframe"] = true,
	["rolllootframe"] = true,
	["width"] = 222,
}
-- Minimap Options
C["map"] = {
	["enable"] = true,
	["scale"] = 0.8,
	["group_icons"] = true,
	["bg_map_stylization"] = true,
}
-- Minimap Options
C["minimap"] = {
	["collectbuttons"] = true,
	["enable"] = true,
	["nodeflash"] = true,
	["size"] = 150,
	["classcolor"] = false,
}
-- Miscellaneous Options
C["misc"] = {
	["afk_spin_camera"] = false,
	["alreadyknown"] = false,
	["enhancedmail"] = true,
	["move_blizzard"] = false,
	["sum_buyouts"] = false,	
	["profession_tabs"] = true,
	["easy_friend"] = true,
	["fadegamemenu"] = true,
	["hattrick"] = true,
	["hide_bg_spam"] = false,
	["armory_link"] = false,	
}
-- Nameplate Options
C["nameplate"] = {
	["enable"] = true,
	["height"] = 9,
	["width"] = 120,
	["ad_height"] = 0,
	["ad_width"] = 0,
	["combat"] = false,
	["health_value"] = false,
	["show_castbar_name"] = false,
	["enhance_threat"] = true,
	["class_icons"] = false,
	["name_abbrev"] = false,
	["good_color"] = {0.2, 0.8, 0.2},
	["near_color"] = {1, 1, 0},
	["bad_color"] = {1, 0, 0},
	["track_auras"] = false,
	["auras_size"] = 22,
}
-- PowerBar Options
C["powerbar"] = {
	["enable"] = false,
	["font_outline"] = false,
	["show_combo"] = true,
	["show_energy"] = true,
	["show_mana"] = true,
	["show_rage"] = true,
	["show_rune"] = true,
	["hide_blizzard_runebar"] = false,
	["show_rune_cooldown"] = true,
	["value_abbrev"] = true,
	["width"] = 200,
	["height"] = 4,
}
-- Skins Options
C["skins"] = {
	["bigwigs"] = false,
	["chatbubble"] = true,
	["clcret"] = true,
	["dbm"] = false,
	["skada"] = false,
	["weakauras"] = false,
	["minimap_buttons"] = true,
}
-- Tooltip Options
C["tooltip"] = {
	["enable"] = true,
	["shift_modifer"] = false,
	["cursor"] = false,
	["item_icon"] = false,
	["health_value"] = false,
	["hidebuttons"] = false,
	["hide_combat"] = false,
	["quality_border_color"] = false,
	-- Plugins
	["talents"] = false,
	["achievements"] = true,
	["target"] = true,
	["title"] = false,
	["rank"] = true,
	["arena_experience"] = false,
	["spell_id"] = false,
	["raid_icon"] = false,
	["who_targetting"] = false,
	["item_count"] = false,
	["unit_role"] = false,
	["instance_lock"] = false,
}
-- Unitframe Options
C["unitframe"] = {
	["auraoffsety"] = 3,
	["betterpowercolor"] = false,
	["cbscale"] = 1.2,
	["classhealth"] = false,
	["percent_health"] = false,
	["classicon"] = false,
	["combatfeedback"] = false,
	["enable"] = true,
	["enhancedframes"] = false,
	["groupnumber"] = false,
	["largeaura"] = 26,
	["outline"] = false,
	["scale"] = 1.2,
	["smallaura"] = 22,
}