local K, C, L, _ = select(2, ...):unpack()
if C["Minimap"].enable ~= true then return end

local _G = _G
local unpack = unpack
local pairs = pairs
local PlaySound, CreateFrame, UIParent = PlaySound, CreateFrame, UIParent
local IsAddOnLoaded = IsAddOnLoaded

-- Minimap border
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)
MinimapAnchor:CreatePanel("Invisible", C["Minimap"].size, C["Minimap"].size, unpack(C["position"].minimap))

local frames = {
	"GameTimeFrame",
	"MinimapBorder",
	"MinimapZoomIn",
	"MinimapZoomOut",
	"MinimapBorderTop",
	"BattlegroundShine",
	"MiniMapWorldMapButton",
	"MinimapZoneTextButton",
	"MiniMapTrackingBackground",
	"MiniMapVoiceChatFrameBackground",
	"MiniMapVoiceChatFrameBorder",
	"MiniMapVoiceChatFrame",
	"MinimapNorthTag",
	"MiniMapBattlefieldBorder",
	"MiniMapMailBorder",
	"MiniMapTracking",
}

for i in pairs(frames) do
	_G[frames[i]]:Hide()
	_G[frames[i]].Show = K.Noop
end

-- Kill Minimap Cluster
MinimapCluster:Kill()

-- Parent Minimap into our frame
Minimap:SetParent(MinimapAnchor)
Minimap:ClearAllPoints()
Minimap:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 0, 0)
Minimap:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", 0, 0)
Minimap:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())
-- Backdrop
MinimapBackdrop:ClearAllPoints()
MinimapBackdrop:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
MinimapBackdrop:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
MinimapBackdrop:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())

-- Mail
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 5)
MiniMapMailFrame:SetScale(1.2)
MiniMapMailIcon:SetTexture('Interface\\Addons\\KkthnxUI\\Media\\Textures\\Mail')

MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("TOP", Minimap, "TOP", 1, 1)

MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 2)

-- Invites icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent(Minimap)
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

-- Default LFG icon
local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("TOP", Minimap, "TOP", 1, 6)
	MiniMapLFGFrame:SetHighlightTexture(nil)
	MiniMapLFGFrameBorder:Kill()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, delta)
	if (delta > 0) then
		MinimapZoomIn:Click()
	elseif (delta < 0) then
		MinimapZoomOut:Click()
	end
end)

-- ClockFrame
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
local ClockFrame, ClockTime = TimeManagerClockButton:GetRegions()
ClockFrame:Hide()
ClockTime:SetFont(C["font"].stats_font, C["font"].stats_font_size, C["font"].stats_font_style)
ClockTime:SetShadowOffset(K.Mult, -K.Mult)
ClockTime:SetShadowColor(0, 0, 0, K.ShadowAlpha)
TimeManagerClockButton:ClearAllPoints()
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -5)
TimeManagerClockButton:SetScript('OnShow', nil)
TimeManagerClockButton:Hide()
TimeManagerClockButton:SetScript('OnClick', function(self, button)
	if(button == "RightButton") then
		if(self.alarmFiring) then
			PlaySound('igMainMenuQuit')
			TimeManager_TurnOffAlarm()
		else
			ToggleTimeManager()
		end
	else
		ToggleCalendar()
	end
end)

-- For others mods with a minimap button, set minimap buttons position in square mode.
function GetMinimapShape() return 'SQUARE' end

-- Set Boarder Texture
MinimapBackdrop:SetBackdrop(K.Backdrop)
MinimapBackdrop:SetBackdropColor(0.05, 0.05, 0.05, 0.0)
MinimapBackdrop:SetBackdropBorderColor(unpack(C["Media"].Border_Color))
MinimapBackdrop:SetOutside(Minimap, 4, 4)

-- Set Square Map View
Minimap:SetMaskTexture(C["Media"].Blank)
MinimapBorder:Hide()