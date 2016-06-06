local K, C, _ = select(2, ...):unpack()

local format = string.format
local match = string.match
local max = math.max
local min = math.min
local CreateFrame = CreateFrame
local GetCVar = GetCVar
local SetCVar = SetCVar

if (C["general"].auto_scale) then
	C["general"].uiscale = min(2, max(0.64, 768 / match(K.Resolution, "%d+x(%d+)")))
end

-- PixelPerfect Script for KkthnxUI.
local PixelPerfect = CreateFrame("Frame")
PixelPerfect:RegisterEvent("PLAYER_ENTERING_WORLD")
PixelPerfect:SetScript("OnEvent", function(self, event)
	-- Enable uiscale for KkthnxUI
	local UseUIScale = GetCVar("useUiScale")
	if (UseUIScale ~= "1") then
		SetCVar("useUiScale", 1)
	end

	-- uiscale security
	if C["general"].uiscale > 1 then C["general"].uiscale = 1 end
	if C["general"].uiscale < 0.64 then C["general"].uiscale = 0.64 end

	-- Set our new uiscale now if it doesn't match Blizzard saved uiScale.
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].uiscale)) then
		-- if we set an uiscale, it broke quest when opening full size map in combat
		K.FullMapQuestTaintFix = true
		
		-- set new ui scale
		SetCVar("uiScale", C["general"].uiscale)
	end

	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
	-- the lowest value of UIParent scale by default
	if C["general"].uiscale < 0.64 then
		UIParent:SetScale(C["general"].uiscale)
	end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)