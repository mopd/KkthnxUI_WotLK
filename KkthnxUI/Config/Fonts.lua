local K, C, L, _ = select(2, ...):unpack()

-- Fonts Settings
C["font"] = {
	["action_bars_font"] = C["media"].normal_font,
	["action_bars_font_size"] = 12,
	["action_bars_font_style"] = "OUTLINE",

	["bags_font"] = C["media"].normal_font,
	["bags_font_size"] = 12,
	["bags_font_style"] = "OUTLINE",

	["basic_font"] = C["media"].normal_font,
	["basic_font_size"] = 12,
	["basic_font_style"] = "OUTLINE",

	["chat_font"] = C["media"].normal_font,
	["chat_font_style"] = "",

	["chat_tabs_font"] = C["media"].normal_font,
	["chat_tabs_font_size"] = 12,
	["chat_tabs_font_style"] = "OUTLINE",

	["combat_font"] = C["media"].combat_font,
	["combat_font_size"] = 12,
	["combat_font_style"] = "OUTLINE",

	["cooldown_timers_font"] = C["media"].normal_font,
	["cooldown_timers_font_size"] = 20,
	["cooldown_timers_font_style"] = "OUTLINE",

	["filger_font"] = C["media"].normal_font,
	["filger_font_size"] = 12,
	["filger_font_style"] = "OUTLINE",

	["loot_font"] = C["media"].normal_font,
	["loot_font_size"] = 12,
	["loot_font_style"] = "OUTLINE",

	["nameplates_font"] = C["media"].normal_font,
	["nameplates_font_size"] = 12,
	["nameplates_font_style"] = "OUTLINE",

	["powerbar_font"] = C["media"].normal_font,
	["powerbar_font_size"] = 14,
	["powerbar_font_style"] = "OUTLINE",

	["stats_font"] = C["media"].normal_font,
	["stats_font_size"] = 12,
	["stats_font_style"] = "OUTLINE",

	["tooltip_font"] = C["media"].normal_font,
	["tooltip_font_size"] = 12,
	["tooltip_font_style"] = "OUTLINE",

	["unitframes_font"] = C["media"].normal_font,
	["unitframes_font_size"] = 12,
	["unitframes_font_style"] = "OUTLINE"
}
--	Font replace for zhTW and zhCN client
if K.Client == "zhTW" then
	C["font"].action_bars_font = "Fonts\\bLEI00D.ttf"
	C["font"].action_bars_font_size = 12
	C["font"].action_bars_font_style = "OUTLINE"

	C["font"].bags_font = "Fonts\\bLEI00D.ttf"
	C["font"].bags_font_size = 12
	C["font"].bags_font_style = "OUTLINE"

	C["font"].basic_font = "Fonts\\bLEI00D.ttf"
	C["font"].basic_font_size = 12
	C["font"].basic_font_style = "OUTLINE"

	C["font"].chat_font = "Fonts\\bLEI00D.ttf"
	C["font"].chat_font_style = ""

	C["font"].chat_tabs_font = "Fonts\\bLEI00D.ttf"
	C["font"].chat_tabs_font_size = 12
	C["font"].chat_tabs_font_style = "OUTLINE"

	C["font"].combat_font = "Fonts\\bLEI00D.ttf"
	C["font"].combat_font_size = 16
	C["font"].combat_font_style = "OUTLINE"

	C["font"].cooldown_timers_font = "Fonts\\bLEI00D.ttf"
	C["font"].cooldown_timers_font_size = 13
	C["font"].cooldown_timers_font_style = "OUTLINE"

	C["font"].loot_font = "Fonts\\bLEI00D.ttf"
	C["font"].loot_font_size = 13
	C["font"].loot_font_style = "OUTLINE"

	C["font"].nameplates_font = "Fonts\\bLEI00D.ttf"
	C["font"].nameplates_font_size = 13
	C["font"].nameplates_font_style = "OUTLINE"

	C["font"].powerbar_font = "Fonts\\bLEI00D.ttf"
	C["font"].powerbar_font_size = 12
	C["font"].powerbar_font_style = "OUTLINE"

	C["font"].stats_font = "Fonts\\bLEI00D.ttf"
	C["font"].stats_font_size = 12
	C["font"].stats_font_style = "OUTLINE"

	C["font"].tooltip_font = "Fonts\\bLEI00D.ttf"
	C["font"].tooltip_font_size = 13
	C["font"].tooltip_font_style = "OUTLINE"

	C["font"].unit_frames_font = "Fonts\\bLEI00D.ttf"
	C["font"].unit_frames_font_size = 12
	C["font"].unit_frames_font_style = "OUTLINE"
elseif K.Client == "zhCN" then
	C["font"].action_bars_font = "Fonts\\ARKai_T.ttf"
	C["font"].action_bars_font_size = 12
	C["font"].action_bars_font_style = "OUTLINE"

	C["font"].bags_font = "Fonts\\ARKai_T.ttf"
	C["font"].bags_font_size = 12
	C["font"].bags_font_style = "OUTLINE"

	C["font"].basic_font = "Fonts\\ARKai_T.ttf"
	C["font"].basic_font_size = 12
	C["font"].basic_font_style = "OUTLINE"

	C["font"].chat_font = "Fonts\\ARKai_T.ttf"
	C["font"].chat_font_style = ""

	C["font"].chat_tabs_font = "Fonts\\ARKai_T.ttf"
	C["font"].chat_tabs_font_size = 12
	C["font"].chat_tabs_font_style = "OUTLINE"

	C["font"].combat_font = "Fonts\\ARKai_T.ttf"
	C["font"].combat_font_size = 16
	C["font"].combat_font_style = "OUTLINE"

	C["font"].cooldown_timers_font = "Fonts\\ARKai_T.ttf"
	C["font"].cooldown_timers_font_size = 13
	C["font"].cooldown_timers_font_style = "OUTLINE"

	C["font"].loot_font = "Fonts\\ARKai_T.ttf"
	C["font"].loot_font_size = 13
	C["font"].loot_font_style = "OUTLINE"

	C["font"].nameplates_font = "Fonts\\ARKai_T.ttf"
	C["font"].nameplates_font_size = 13
	C["font"].nameplates_font_style = "OUTLINE"

	C["font"].powerbar_font = "Fonts\\ARKai_T.ttf"
	C["font"].powerbar_font_size = 12
	C["font"].powerbar_font_style = "OUTLINE"

	C["font"].stats_font = "Fonts\\ARKai_T.ttf"
	C["font"].stats_font_size = 12
	C["font"].stats_font_style = "OUTLINE"

	C["font"].tooltip_font = "Fonts\\ARKai_T.ttf"
	C["font"].tooltip_font_size = 13
	C["font"].tooltip_font_style = "OUTLINE"

	C["font"].unit_frames_font = "Fonts\\ARKai_T.ttf"
	C["font"].unit_frames_font_size = 12
	C["font"].unit_frames_font_style = "OUTLINE"
end