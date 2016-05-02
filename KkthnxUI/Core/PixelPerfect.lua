local K, C, L, _ = unpack(select(2, ...))

local min, max = math.min, math.max
local format = string.format

local GetCVar, SetCVar = GetCVar, SetCVar
local CreateFrame = CreateFrame

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / C["general"].uiscale
local Scale = function(x) return mult * math.floor(x / mult + 0.5) end

-- Optimize the UIScale when we enter the world.
local PixelPerfect = CreateFrame("Frame")
PixelPerfect:RegisterEvent("PLAYER_ENTERING_WORLD")
PixelPerfect:SetScript("OnEvent", function(self, event)
	local Useuiscale = GetCVar("useUiScale")

	if C["general"].auto_scale then C["general"].uiscale = min(2, max(0.32, 768 / string.match(K.Resolution, "%d+x(%d+)"))) end

	if (Useuiscale ~= "1") then SetCVar("useUiScale", 1) end
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].uiscale)) then SetCVar("uiScale", C["general"].uiscale) end

	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
	-- the lowest value of UIParent scale by default
	if (C["general"].uiscale < 0.64) then
		UIParent:SetScale(C["general"].uiscale)
	end
	-- This will force graphics changes to be applied no matter what.
	-- If a user changes their resolution this will force the changes.
	VideoOptionsFrameOkay:HookScript("OnClick", ReloadUI)
	VideoOptionsFrameApply:HookScript("OnClick", ReloadUI)

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

K.Scale = function(x) return Scale(x) end
K.mult = mult
K.noscalemult = K.mult * C["general"].uiscale

-- Pixel perfect fonts function
if K.ScreenHeight <= 1200 then return end
C["font"].action_bars_font_size = action_bars_font_size * mult
C["font"].bags_font_size = bags_font_size * mult
C["font"].basic_font_size = basic_font_size * mult
C["font"].chat_tabs_font_size = chat_tabs_font_size * mult
C["font"].combat_font_size = combat_font_size * mult
C["font"].combat_text_font_size = combat_text_font_size * mult
C["font"].cooldown_timers_font_size = cooldown_timers_font_size * mult
C["font"].filger_font_size = filger_font_size * mult
C["font"].loot_font_size = loot_font_size * mult
C["font"].nameplates_font_size = nameplates_font_size * mult
C["font"].powerbar_font_size = powerbar_font_size * mult
C["font"].stats_font_size = stats_font_size * mult
C["font"].tooltip_font_size = tooltip_font_size * mult
C["font"].unitframes_font_size = unitframes_font_size * mult