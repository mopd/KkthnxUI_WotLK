local K, C, L, _ = unpack(select(2, ...))

local min, max = math.min, math.max
local format = string.format

local GetCVar, SetCVar = GetCVar, SetCVar
local CreateFrame = CreateFrame

if C["general"].auto_scale then C["general"].uiscale = min(2, max(0.32, 768 / string.match(K.Resolution, "%d+x(%d+)"))) end

local PixelPerfect = CreateFrame("Frame")
PixelPerfect:RegisterEvent("PLAYER_ENTERING_WORLD")
PixelPerfect:SetScript("OnEvent", function(self, event)
	local Useuiscale = GetCVar("useUiScale")
	
	if (Useuiscale ~= "1") then SetCVar("useUiScale", 1) end
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].uiscale)) then SetCVar("uiScale", C["general"].uiscale) end
	
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / C["general"].uiscale
local Scale = function(x) return mult * math.floor(x / mult + 0.5) end

K.Scale = function(x) return Scale(x) end
K.mult = mult
K.noscalemult = K.mult * C["general"].uiscale