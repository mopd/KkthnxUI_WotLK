local K, C, L, _ = select(2, ...):unpack()

-- Media Options
C["media"] = {
	["abtextures"] = [[Interface\Addons\KkthnxUI\Media\Actionbars\]],
	["auratextures"] = [[Interface\Addons\KkthnxUI\Media\Buffs\]],
	["backdrop_color"] = {0.02, 0.02, 0.02, 0.9},
	["background"] = [[Interface\Tooltips\ChatBubble-Background]],
	["blank"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Blank.tga]],
	["blank_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Invisible.ttf]],
	["blizz"] = [[Interface\Tooltips\UI-Tooltip-Border]],
	["blizzborder"] = [[Interface\Buttons\UI-Quickslot2]],
	["border_color"] = {1, 1, 1, 1},
	["bordertextures"] = [[Interface\Addons\KkthnxUI\Media\Border\]],
	["combat_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]],
	["empty"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Empty.tga]],
	["glow"] = [[Interface\AddOns\KkthnxUI\Media\Textures\GlowTex.tga]],
	["kkthnx"] = [[Interface\Addons\KkthnxUI\Media\Textures\Kkthnx]],
	["nameplate_border"] = {0.6, 0.6, 0.6, 1},
	["normal_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["texture"] = [[Interface\TargetingFrame\UI-StatusBar]],
	["warning_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Warning.ogg]],
	["whisp_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Whisper.ogg]],
}
-- ActionBar Options
C["actionbar"] = {
	["enable"] = true,
	["out_of_mana"] = {0.5, 0.5, 1},
	["out_of_range"] = {0.8, 0.1, 0.1},
	["removetextures"] = false,
	["scale"] = 1,
	["selfcast"] = false,
	["showgrid"] = true,
	["showhotkeys"] = true,
	["showmacroname"] = true,
	["skinbuttons"] = true,
}
-- Announcements Options
C["announcements"] = {
	["interrupt"] = false,
	["pull_countdown"] = true,
	["spells"] = false,
	["spells_from_all"] = false,
}
-- Automation Options
C["automation"] = {
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
C["bag"] = {
	["bag_columns"] = 10,
	["bank_columns"] = 17,
	["button_size"] = 34,
	["button_space"] = 4,
	["enable"] = true,
}
-- Blizzard Options
C["blizzard"] = {
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
C["buffs"] = {
	["aurasperrow"] = 12,
	["buffsize"] = 34,
	["cast_by"] = false,
	["debuffsize"] = 40,
	["enable"] = true,
	["paddingx"] = 6,
	["paddingy"] = 6,
}
-- Chat Options
C["chat"] = {
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
	["time_color"] = {1, 0.82, 0, 1},
	["whisp_sound"] = true,
	["width"] = 400,
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
	["buffs_size"] = 37,
	["cooldown_size"] = 30,
	["enable"] = true,
	["max_test_icon"] = 5,
	["pvp_size"] = 60,
	["show_tooltip"] = false,
	["test_mode"] = false,
}
-- General Options
C["general"] = {
	["auto_scale"] = true,
	["chatbubble_fontsize"] = 12,
	["chatbubble_nobackdrop"] = false,
	["replace_blizz_fonts"] = true,
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
	["bg_map_stylization"] = true,
	["enable"] = true,
	["scale"] = 0.8,
}
-- Minimap Options
C["minimap"] = {
	["collectbuttons"] = true,
	["enable"] = true,
	["ping"] = true,
	["size"] = 150,
}
-- Miscellaneous Options
C["misc"] = {
	["afk_spin_camera"] = false,
	["alreadyknown"] = false,
	["armory_link"] = false,
	["enhancedmail"] = true,
	["fadegamemenu"] = true,
	["hattrick"] = true,
	["hide_bg_spam"] = false,
	["profession_tabs"] = true,
}
-- Nameplate Options
C["nameplate"] = {
	["ad_height"] = 0,
	["ad_width"] = 0,
	["auras_size"] = 22,
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
C["powerbar"] = {
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
-- Skins Options
C["skins"] = {
	["bigwigs"] = false,
	["chatbubble"] = true,
	["clcret"] = false,
	["dbm"] = false,
	["minimap_buttons"] = true,
	["recount"] = false,
	["skada"] = false,
	["weakauras"] = false,
}
-- Tooltip Options
C["tooltip"] = {
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
	["quality_border_color"] = false,
	["raid_icon"] = false,
	["rank"] = true,
	["spell_id"] = false,
	["talents"] = false,
	["target"] = true,
	["title"] = false,
	["unit_role"] = false,
	["who_targetting"] = false,
}
-- Unitframe Options
C["unitframe"] = {
	["auraoffsety"] = 3,
	["betterpowercolor"] = false,
	["cbscale"] = 1.2,
	["classhealth"] = false,
	["classicon"] = false,
	["combatfeedback"] = false,
	["enable"] = true,
	["enhancedframes"] = false,
	["groupnumber"] = false,
	["largeaura"] = 26,
	["outline"] = false,
	["percent_health"] = false,
	["scale"] = 1.2,
	["smallaura"] = 22,
}