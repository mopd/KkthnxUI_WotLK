local K, C, L, _ = select(2, ...):unpack()

local min, max = math.min, math.max
local match = string.match
local floor = math.floor
local GetCVar = GetCVar
local CreateFrame = CreateFrame

-- Pixel perfect script of custom ui Scale
K.UIScale = function()
	if C["general"].auto_scale == true then
		C["general"].uiscale = min(2, max(0.64, 768 / match(K.Resolution, "%d+x(%d+)")))
	end
end
K.UIScale()

-- Pixel perfect fonts function
if K.ScreenHeight <= 1200 then return end
C["font"].action_bars_font_size = action_bars_font_size * mult
C["font"].bags_font_size = bags_font_size * mult
C["font"].basic_font_size = basic_font_size * mult
C["font"].chat_tabs_font_size = chat_tabs_font_size * mult
C["font"].combat_font_size = combat_font_size * mult
C["font"].cooldown_timers_font_size = cooldown_timers_font_size * mult
C["font"].filger_font_size = filger_font_size * mult
C["font"].loot_font_size = loot_font_size * mult
C["font"].nameplates_font_size = nameplates_font_size * mult
C["font"].powerbar_font_size = powerbar_font_size * mult
C["font"].stats_font_size = stats_font_size * mult
C["font"].tooltip_font_size = tooltip_font_size * mult
C["font"].unitframes_font_size = unitframes_font_size * mult