local K, C, L = unpack(select(2, ...));

-- Fonts options
C["font"] = {
	-- basic text font
	["basic_font"] = C["media"].normal_font,
	["basic_font_size"] = 12,
	["basic_font_style"] = "OUTLINE",

	["stats_font"] = C["media"].normal_font,
	["stats_font_size"] = 12,
	["stats_font_style"] = "OUTLINE",
	["stats_font_shadow"] = false,
	
	-- combat text font
	["combat_font"] = C["media"].combat_font,
	["combat_font_size"] = 12,
	["combat_font_style"] = "OUTLINE",
	
	-- Filger font
	["filger_font"] = C["media"].normal_font,
	["filger_font_size"] = 12,
	["filger_font_style"] = "OUTLINE",
	["filger_font_shadow"] = false,

	-- buff text font
	["buff_font"] = C["media"].normal_font,
	["buff_font_size"] = 14,
	["buff_font_style"] = "OUTLINE",

	-- debuff text font
	["debuff_font"] = C["media"].normal_font,
	["debuff_font_size"] = 14,
	["debuff_font_style"] = "OUTLINE",
	
	-- Infoline text font
	["infoline_text_font"] = C["media"].normal_font,
	["infoline_text_font_size"] = 12,
	["infoline_text_font_style"] = "OUTLINE",

	-- Chat font
	["chat_font"] = C["media"].normal_font,
	["chat_font_style"] = "",

	-- Chat tabs font
	["chat_tabs_font"] = C["media"].normal_font,
	["chat_tabs_font_size"] = 11,
	["chat_tabs_font_style"] = "OUTLINE",

	-- Action bars font
	["action_bars_font"] = C["media"].normal_font,
	["action_bars_font_size"] = 12,
	["action_bars_font_style"] = "OUTLINE",

	["bar_macro_font"] = C["media"].normal_font,
	["bar_macro_font_size"] = 10,
	["bar_macro_font_style"] = "OUTLINE",

	-- Cooldowns timer font
	["cooldown_timers_font"] = C["media"].normal_font,
	["cooldown_timers_font_size"] = 14,
	["cooldown_timers_font_style"] = "OUTLINE",

	-- Loot font
	["loot_font"] = C["media"].normal_font,
	["loot_font_size"] = 12,
	["loot_font_style"] = "OUTLINE",
	["loot_font_shadow"] = false,

	-- Nameplates font
	["nameplates_font"] = C["media"].normal_font,
	["nameplates_font_size"] = 12,
	["nameplates_font_style"] = "OUTLINE",
	["nameplates_font_shadow"] = false,

	-- Nameplates font
	["tooltip_font"] = C["media"].normal_font,
	["tooltip_font_size"] = 12,
	["tooltip_font_style"] = "OUTLINE",
	["tooltip_font_shadow"] = false,

	-- Unit frames font
	["unitframes_font"] = C["media"].normal_font,
	["unitframes_font_size"] = 12,
	["unitframes_font_style"] = "OUTLINE",
	["unitframes_font_shadow"] = false,

	-- Auras font
	["auras_font"] = C["media"].normal_font,
	["auras_font_size"] = 12,
	["auras_font_style"] = "OUTLINE",
	["auras_font_shadow"] = false,
}
--	Font replace for zhTW and zhCN client
if K.Client == "zhTW" then
	C["media"].basic_font = "Fonts\\bLEI00D.ttf"
	C["media"].basic_font_style = "OUTLINE"
	C["media"].basic_font_size = 11

	C["font"].infoline_font = "Fonts\\bLEI00D.ttf"
	C["font"].infoline_font_size = 12
	C["font"].infoline_font_style = "OUTLINE"

	C["font"].combat_text_font = "Fonts\\bLEI00D.ttf"
	C["font"].combat_text_font_size = 16
	C["font"].combat_text_font_style = "OUTLINE"

	C["font"].chat_font = "Fonts\\bLEI00D.ttf"
	C["font"].chat_font_style = "OUTLINE"

	C["font"].chat_tabs_font = "Fonts\\bLEI00D.ttf"
	C["font"].chat_tabs_font_size = 12
	C["font"].chat_tabs_font_style = "OUTLINE"

	C["font"].action_bars_font = "Fonts\\bLEI00D.ttf"
	C["font"].action_bars_font_size = 12
	C["font"].action_bars_font_style = "OUTLINE"

	C["font"].cooldown_timers_font = "Fonts\\bLEI00D.ttf"
	C["font"].cooldown_timers_font_size = 13
	C["font"].cooldown_timers_font_style = "OUTLINE"

	C["font"].loot_font = "Fonts\\bLEI00D.ttf"
	C["font"].loot_font_size = 13
	C["font"].loot_font_style = "OUTLINE"

	C["font"].nameplates_font = "Fonts\\bLEI00D.ttf"
	C["font"].nameplates_font_size = 13
	C["font"].nameplates_font_style = "OUTLINE"

	C["font"].unit_frames_font = "Fonts\\bLEI00D.ttf"
	C["font"].unit_frames_font_size = 12
	C["font"].unit_frames_font_style = "OUTLINE"

	C["font"].auras_font = "Fonts\\bLEI00D.ttf"
	C["font"].auras_font_size = 11
	C["font"].auras_font_style = "OUTLINE"
elseif K.Client == "zhCN" then
	C["media"].basic_font = "Fonts\\ARKai_T.ttf"
	C["media"].basic_font = "Fonts\\ARKai_C.ttf"
	C["media"].basic_font_style = "OUTLINE"
	C["media"].basic_font_size = 11

	C["font"].infoline_font = "Fonts\\ARKai_T.ttf"
	C["font"].infoline_font_size = 12
	C["font"].infoline_font_style = "OUTLINE"

	C["font"].combat_text_font = "Fonts\\ARKai_T.ttf"
	C["font"].combat_text_font_size = 16
	C["font"].combat_text_font_style = "OUTLINE"

	C["font"].chat_font = "Fonts\\ARKai_T.ttf"
	C["font"].chat_font_style = "OUTLINE"

	C["font"].chat_tabs_font = "Fonts\\ARKai_T.ttf"
	C["font"].chat_tabs_font_size = 12
	C["font"].chat_tabs_font_style = "OUTLINE"

	C["font"].action_bars_font = "Fonts\\ARKai_T.ttf"
	C["font"].action_bars_font_size = 12
	C["font"].action_bars_font_style = "OUTLINE"

	C["font"].threat_meter_font = "Fonts\\ARKai_T.ttf"
	C["font"].threat_meter_font_size = 12
	C["font"].threat_meter_font_style = "OUTLINE"

	C["font"].raid_cooldowns_font = "Fonts\\ARKai_T.ttf"
	C["font"].raid_cooldowns_font_size = 12
	C["font"].raid_cooldowns_font_style = "OUTLINE"

	C["font"].cooldown_timers_font = "Fonts\\ARKai_T.ttf"
	C["font"].cooldown_timers_font_size = 13
	C["font"].cooldown_timers_font_style = "OUTLINE"

	C["font"].loot_font = "Fonts\\ARKai_T.ttf"
	C["font"].loot_font_size = 13
	C["font"].loot_font_style = "OUTLINE"

	C["font"].nameplates_font = "Fonts\\ARKai_T.ttf"
	C["font"].nameplates_font_size = 13
	C["font"].nameplates_font_style = "OUTLINE"

	C["font"].unit_frames_font = "Fonts\\ARKai_T.ttf"
	C["font"].unit_frames_font_size = 12
	C["font"].unit_frames_font_style = "OUTLINE"

	C["font"].auras_font = "Fonts\\ARKai_T.ttf"
	C["font"].auras_font_size = 11
	C["font"].auras_font_style = "OUTLINE"
end