local K, C, L, _ = select(2, ...):unpack()

local format = string.format
local match = string.match
local max = math.max
local min = math.min
local CreateFrame = CreateFrame
local GetCVar = GetCVar
local SetCVar = SetCVar

if C["general"].auto_scale then C["general"].uiscale = min(2, max(0.32, 768 / match(K.Resolution, "%d+x(%d+)"))) end

-- PixelPerfect Script for KkthnxUI.
local PixelPerfect = CreateFrame("Frame")
PixelPerfect:RegisterEvent("PLAYER_ENTERING_WORLD")
PixelPerfect:SetScript("OnEvent", function(self, event)
	-- Enable uiscale for KkthnxUI
	local UseUIScale = GetCVar("useUiScale")
	if (UseUIScale ~= "1") then
		SetCVar("useUiScale", 1)
	end

	if C["general"].uiscale > 1 then C["general"].uiscale = 1 end
	if C["general"].uiscale < 0.64 then C["general"].uiscale = 0.64 end

	-- Set our new uiscale now if it doesn't match Blizzard saved uiScale.
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].uiscale)) then
		SetCVar("uiScale", C["general"].uiscale)
	end

	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
	-- the lowest value of UIParent scale by default
	if C["general"].uiscale < 0.64 then
		UIParent:SetScale(C["general"].uiscale)
	end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

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