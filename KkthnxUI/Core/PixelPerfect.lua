local K, C, L = unpack(select(2, ...))

-- Pixel perfect script of custom ui Scale
K.UIScale = function()
	if K.getscreenwidth <= 1440 then
		K.low_resolution = true
	else
		K.low_resolution = false
	end

	if C.general.auto_scale == true then
		C.general.uiscale = min(2, max(0.64, 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)")))
	end
end
K.UIScale()

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / C.general.uiscale
local Scale = function(x)
	return mult * math.floor(x / mult + 0.5)
end

K.Scale = function(x) return Scale(x) end
K.mult = mult
K.noscalemult = K.mult * C.general.uiscale

-- Pixel perfect fonts function
if K.getscreenheight <= 1200 then return end
C.font.basic_font_size = C.font.basic_font_size * mult
C.font.stats_font_size = C.font.stats_font_size * mult
C.font.combat_font_size = C.font.combat_font_size * mult
C.font.filger_font_size = C.font.filger_font_size * mult
C.font.buff_font_size = C.font.buff_font_size * mult
C.font.debuff_font_size = C.font.debuff_font_size * mult
C.font.infoline_text_font_size = C.font.infoline_text_font_size * mult
C.font.chat_tabs_font_size = C.font.chat_tabs_font_size * mult
C.font.action_bars_font_size = C.font.action_bars_font_size * mult
C.font.bar_macro_font_size = C.font.bar_macro_font_size * mult
C.font.cooldown_timers_font_size = C.font.cooldown_timers_font_size * mult
C.font.loot_font_style = C.font.loot_font_style * mult
C.font.unitframes_font_size = C.font.unitframes_font_size * mult
