local K, C, L = unpack(select(2, ...));

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
	["out_of_mana"] = {0.1, 0.3, 1},
	["out_of_range"] = {1, 0.1, 0.1},
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
	["spells_from_all"] = false,
	["interrupt"] = false,
}
-- Automation Options
C["automation"] = {
	["autocollapse"] = true,
	["autoinvite"] = false,
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
	["repreward"] = true,
	["dark_textures"] = false,
	["dark_textures_color"] = {.4, .4, .4},
}
-- Buffs & Debuffs Options
C["buffs"] = {
	["aurasperrow"] = 12,
	["buffsize"] = 34,
	["debuffsize"] = 40,
	["enable"] = true,
	["paddingx"] = 6,
	["paddingy"] = 6,
	["class_color"] = false,
}
-- Buffs reminder Options
C["reminder"] = {
	-- Self buffs
	["solo_buffs_enable"] = true,
	["solo_buffs_sound"] = false,
	["solo_buffs_size"] = 45,
	-- Raid buffs
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
	["uiscale"] = 0.71111112833023,
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
	["fadegamemenu"] = true,
	["hattrick"] = true,
	["hide_bg_spam"] = false,
	["armory_link"] = false,	
}
-- Nameplate Options
C["nameplate"] = {
	["enable"] = true,
	["showhealth"] = true,
	["enhancethreat"] = true,
	["combat"] = false,
	["goodcolor"] = {75/255, 175/255, 76/255},
	["badcolor"] = {0.78, 0.25, 0.25},
	["transitioncolor"] = {218/255, 197/255, 92/255},
	["trackcc"] = true,
	["trackdebuffs"] = true,
	["hp_height"] = 10,
	["hp_width"] = 100,
	["icon_size"] = 25,
	["cb_height"] = 5,
	["cb_width"] = 100,
}
-- PowerBar Options
C["powerbar"] = {
	["enable"] = true,
	["font_outline"] = false,
	["show_combo"] = true,
	["show_energy"] = true,
	["show_mana"] = true,
	["show_rage"] = true,
	["show_rune"] = true,
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
	["achievements"] = true,
	["arenaexperience"] = false,
	["enable"] = true,
	["fontoutline"] = false,
	["hidebuttons"] = false,
	["itemicon"] = true,
	["qualitybordercolor"] = true,
	["rank"] = true,
	["shiftmodifer"] = false,
	["spellid"] = true,
	["talents"] = false,
	["target"] = true,
	["title"] = false,
	["health_value"] = false,
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
	["partyscale"] = 1.2,
	["scale"] = 1.2,
	["smallaura"] = 22,
	["tradeskill_cast"] = true,
}