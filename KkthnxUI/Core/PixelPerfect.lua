local K, C, _ = select(2, ...):unpack()

local format = string.format
local match = string.match
local max = math.max
local min = math.min
local CreateFrame = CreateFrame
local GetCVar = GetCVar
local SetCVar = SetCVar

if (C["General"].Auto_Scale) then
	C["General"].UIScale = min(2, max(0.64, 768 / match(K.Resolution, "%d+x(%d+)")))
end

-- PixelPerfect Script for KkthnxUI.
local PixelPerfect = CreateFrame("Frame")
PixelPerfect:RegisterEvent("PLAYER_ENTERING_WORLD")
PixelPerfect:SetScript("OnEvent", function(self, event)
	-- Enable UIScale for KkthnxUI
	local UseUIScale = GetCVar("useUIScale")
	if (UseUIScale ~= "1") then
		SetCVar("useUIScale", 1)
	end

	-- UIScale security
	if C["General"].UIScale > 1 then C["General"].UIScale = 1 end
	if C["General"].UIScale < 0.64 then C["General"].UIScale = 0.64 end

	-- Set our new UIScale now if it doesn't match Blizzard saved UIScale.
	if (format("%.2f", GetCVar("UIScale")) ~= format("%.2f", C["General"].UIScale)) then
		-- if we set an UIScale, it broke quest when opening full size map in combat
		K.FullMapQuestTaintFix = true

		-- set new ui scale
		SetCVar("UIScale", C["General"].UIScale)
	end

	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
	-- the lowest value of UIParent scale by default
	if C["General"].UIScale < 0.64 then
		UIParent:SetScale(C["General"].UIScale)
	end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)