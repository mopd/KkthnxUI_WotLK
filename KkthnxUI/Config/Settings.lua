local K, C, L = unpack(select(2, ...))

-- Main Media options
C["media"] = {
	["abtextures"] = [[Interface\Addons\KkthnxUI\Media\Actionbars\]],
	["auratextures"] = [[Interface\Addons\KkthnxUI\Media\Buffs\]],
	["backdrop_color"] = {0.05, 0.05, 0.05, 1},
	["blank"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Blank.tga]],
	["blank_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Invisible.ttf]],
	["blizz"] = [[Interface\Tooltips\UI-Tooltip-Border]],
	["border_color"] = {0.7, 0.7, 0.7, 1},
	["bordertextures"] = [[Interface\Addons\KkthnxUI\Media\Border\]],
	["combat_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]],
	["glow"] = [[Interface\AddOns\KkthnxUI\Media\Textures\GlowTex.tga]],
	["normal_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["overlay_color"] = {0, 0, 0, 0.7},
	["texture"] = [[Interface\TargetingFrame\UI-StatusBar]],
	["unitframe_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Unitframe.ttf]],
	["warning_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Warning.ogg]],
	["whisp_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Whisper.ogg]],
}
-- ActionBar options
C["actionbar"] = {
	["oor"] = { 0.8, 0.1, 0.1 },
	["oom"] = { 0.5, 0.5, 1.0 },
	["enable"] = true,
	["hidemircomenu"] = true,
	["scale"] = 1.0,
	["showgrid"] = true,
	["showhotkeys"] = true,
	["showmacroname"] = true,
	["skinbuttons"] = true,
	["hidebags"] = true,
}
-- Announcements options
C["announcements"] = {
	["checkflask"] = true,
	["saysapped"] = true,
	["arenaonly"] = false,
}
-- Automation options
C["automation"] = {
	["autocollapse"] = true,
	["autoinvite"] = false,
	["collectgarbage"] = true,
	["declineduel"] = false,
	["resurrection"] = false,
}
-- Blizzard options
C["blizzard"] = {
	["capturebar"] = true,
	["durability"] = true,
	["moveachievements"] = true,
	["questbuttonsize"] = 26,
	["repreward"] = true,
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
-- Chat options
C["chat"] = {
	["bubbles"] = true,
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
-- Error options
C["error"] = {
	["black"] = true,
	["combat"] = false,
	["white"] = false,
}
-- General options
C["general"] = {
	["auto_scale"] = true,
	["uiscale"] = 0.71111111111111,
	["welcome_message"] = true,
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
-- Minimap options
C["minimap"] = {
	["collectbuttons"] = true,
	["enable"] = true,
	["size"] = 150,
	["nodeflash"] = true,
}
-- Miscellaneous options
C["misc"] = {
	["alreadyknown"] = false,
	["hattrick"] = true,
}
-- Addonskin options
C["skins"] = {
	["bigwigs"] = false,
	["dbm"] = false,
	["skada"] = false,
}
-- Tooltip options
C["tooltip"] = {
	["enable"] = true,
	["fontoutline"] = false,
	["hideincombat"] = false,
	["showpvpicons"] = true,
	["mouseovertarget"] = true,
	["itemicon"] = true,
	["qualitybordercolor"] = true,
	["reactionbordercolor"] = true,
	["showtitles"] = true,
	["cursor"] = false,
	["spellid"] = true,
}
-- Unitframe options
C["unitframe"] = {
	["auraoffsety"] = 3,
	["cbscale"] = 1.193,
	["classhealth"] = false,
	["classicon"] = false,
	["combatfeedback"] = false,
	["enable"] = true,
	["groupnumber"] = false,
	["largeaura"] = 27,
	["partyscale"] = 1.193,
	["scale"] = 1.193,
	["smallaura"] = 22,
	["smoothbars"] = false,
	["betterpowercolor"] = false,
}