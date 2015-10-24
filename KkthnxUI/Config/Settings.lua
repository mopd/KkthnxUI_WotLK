local K, C, L, _ = unpack(select(2, ...))

-- Main Media options
C["media"] = {
	["normal_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["combat_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]],
	["unitframe_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Unitframe.ttf]],
	["blank_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Invisible.ttf]],
	["texture"] = [[Interface\AddOns\KkthnxUI\Media\Textures\KkthnxTex.tga]],
	["glow"] = [[Interface\AddOns\KkthnxUI\Media\Textures\GlowTex.tga]],
	["blizz"] = [[Interface\AddOns\KkthnxUI\Media\Tooltips\KkthnxBorder.blp]],
	["blank"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Blank.tga]],
	
	["abtextures"] = [[Interface\Addons\KkthnxUI\Media\Actionbars\]],
	["auratextures"] = [[Interface\Addons\KkthnxUI\Media\Buffs\]],
	["bordertextures"] = [[Interface\Addons\KkthnxUI\Media\Border\]],
	
	["whisp_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Whisper.ogg]],
	["warning_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Warning.ogg]],
	
	["border_color"] = {0.7, 0.7, 0.7, 1},
	["backdrop_color"] = {0.05, 0.05, 0.05, 1},
	["overlay_color"] = {0, 0, 0, 0.7},
}

-- General options
C["general"] = {
	["auto_scale"] = true,
	["uiscale"] = 0.96,
	["welcome_message"] = true,
}

-- Misc options
C["misc"] = {
	["afkcam"] = false,
	["alreadyknown"] = false,
	["betterlootfilter"] = false,
	["bgspam"] = true,
	["disenchanting"] = false,
	["enchantscroll"] = false,
	["fadegamemenu"] = true,
	["hattrick"] = true,
	["enhancedmail"] = true,
	["shortengold"] = false,
}

-- Pulse CD options
C["pulsecooldown"] = {
	["enable"] = true,							-- Show cooldowns pulse
	["size"] = 75,								-- Icon size
	["anim_scale"] = 1.5,						-- Animation scaling
	["hold_time"] = 0,							-- Max opacity hold time
}

-- Blizzard options
C["blizzard"] = {
	["questbuttonsize"] = 26,
	["capturebar"] = true,
	["moveachievements"] = true,
	["moveblizzard"] = true,
	["repreward"] = true,
	["durability"] = true,
}

-- Minimap options
C["minimap"] = {
	["collectbuttons"] = true,
	["enable"] = true,
	["size"] = 150,
}

-- Buffs / Debuffs options
C["buffs"] = {
	["aurasperrow"] = 12,
	["buffsize"] = 34,
	["debuffsize"] = 40,
	["enable"] = true,
	["paddingx"] = 6,
	["paddingy"] = 6,
}

-- ActionBar options
C["actionbar"] = {
	["enable"] = true,
	["showgrid"] = true,
	["totemmanagerscale"] = 1,
	["totemmanageralpha"] = 1,
	["hidetotemrecall"] = false,
	["scale"] = 1.0,
	["showbarart"] = true,
	["showhotkeys"] = true,
	["showmacroname"] = true,
	["skinbuttons"] = true,
}

-- Announcements options
C["announcements"] = {
	["saysapped"] = true,
	["checkflask"] = true,
}

-- Unitframe options
C["unitframe"] = {
	["enable"] = true,
	["classhealth"] = false,
	["classicon"] = false,
	["combatfeedback"] = false,
	["groupnumber"] = false,
	["scale"] = 1.2,
	["cbscale"] = 1.2,
	["partyscale"] = 1.3,
	["bossscale"] = 1.2,
	["arenascale"] = 1.2,
}

-- Addonskin options
C["skins"] = {
	["bigwigs"] = false,
	["dbm"] = false,
	["skada"] = false,
	["weakauras"] = false,
}

-- Tooltip options
C["tooltip"] = {
	["enable"] = true,
	["fontoutline"] = false,
	["itemicon"] = true,
	["hideincombat"] = false,
	["qualitybordercolor"] = true,
	["showtitles"] = false,
	["mouseovertarget"] = true,
	["cursor"] = false,
	["spellid"] = true,
}

-- Loot options
C["loot"] = {
	["auto_confirm_de"] = false,
	["auto_greed"] = false,
	["icon_size"] = 30,
	["lootframe"] = true,
	["rolllootframe"] = true,
	["width"] = 222,
}

-- Automation options
C["automation"] = {
	["autocollapse"] = true,
	["autoinvite"] = false,
	["collectgarbage"] = true,
	["declineduel"] = false,
	["resurrection"] = false,
}

-- Error options
C["error"] = {
	["black"] = true,
	["combat"] = false,
	["white"] = false,
}

C["stats"] = {
	["bgstats"] = true,
}

-- Chat options
C["chat"] = {
	["bubbles"] = true,
	["chatspam"] = false,
	["combatlog"] = true,
	["damagemeterspam"] = false,
	["enable"] = true,
	["height"] = 112,
	["outline"] = false,
	["tabsoutline"] = false,
	["sticky"] = true,
	["tabmouseover"] = true,
	["time_color"] = {1, 1, 0},
	["whisp_sound"] = true,
	["width"] = 350,
}