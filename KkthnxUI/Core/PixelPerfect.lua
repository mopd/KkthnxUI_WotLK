local K, C, _ = select(2, ...):unpack()

local format = string.format
local match = string.match
local select = select
local tonumber = tonumber
local max = math.max
local min = math.min
local CreateFrame = CreateFrame
local GetCVar = GetCVar
local SetCVar = SetCVar
local monitorIndex = (tonumber(GetCVar('gxMonitor')) or 0) + 1
local resolution = select(GetCurrentResolution(monitorIndex), GetScreenResolutions(monitorIndex))

if (C["General"].Auto_Scale) then
	C["General"].UIScale = min(2, max(0.64, 768 / match(resolution, "%d+x(%d+)")))
end

-- PixelPerfect Script for KkthnxUI.
local PixelPerfect = CreateFrame("Frame")
PixelPerfect:RegisterEvent("PLAYER_ENTERING_WORLD")
PixelPerfect:SetScript("OnEvent", function(self, event)
	-- Enable UIScale for KkthnxUI
	local UseUIScale = GetCVar("useUiScale")
	
	if (UseUIScale ~= "1") then
		SetCVar("useUiScale", 1)
	end

	-- UIScale security
	if C["General"].UIScale > 1 then C["General"].UIScale = 1 end
	if C["General"].UIScale < 0.64 then C["General"].UIScale = 0.64 end

	-- Set our new UIScale now if it doesn't match Blizzard saved UIScale.
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["General"].UIScale)) then
		-- if we set an UIScale, it broke quest when opening full size map in combat
		K.FullMapQuestTaintFix = true

		-- set new ui scale
		SetCVar("uiScale", C["General"].UIScale)
	end

	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
	-- the lowest value of UIParent scale by default
	if C["General"].UIScale < 0.64 then
		UIParent:SetScale(C["General"].UIScale)
	end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

K.Mult = 768 / match(resolution, "%d+x(%d+)") / C["General"].UIScale
K.Scale = function(x) return K.Mult * floor(x / K.Mult + .5) end
K.NoScaleMult = K.Mult * C["General"].UIScale

-- Pixel perfect fonts function?
if K.ScreenHeight <= 1200 then return end
C["Media"].Font_Size = C["Media"].Font_Size * mult