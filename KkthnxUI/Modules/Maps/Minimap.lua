local K, C, L, _ = unpack(select(2, ...))
if C["minimap"].enable ~= true then return end

-- Minimap border
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)
MinimapAnchor:CreatePanel("Invisible", C["minimap"].size, C["minimap"].size, unpack(C["position"].minimap))

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
	_G[frames[i]].Show = K.Dummy
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
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- ClockFrame
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
local ClockFrame, ClockTime = TimeManagerClockButton:GetRegions()
ClockFrame:Hide()
ClockTime:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
ClockTime:SetShadowOffset(0, 0)
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
MinimapBackdrop:ClearAllPoints()
MinimapBackdrop:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
MinimapBackdrop:SetBackdropColor(0.05, 0.05, 0.05, 0.0)
MinimapBackdrop:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -4, 4)
MinimapBackdrop:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 4, -4)
if C["minimap"].classcolor ~= false then
	MinimapBackdrop:SetBackdropBorderColor(K.Color.r, K.Color.g, K.Color.b)
end
if C["blizzard"].dark_textures == true then
	MinimapBackdrop:SetBackdropBorderColor(unpack(C["blizzard"].dark_textures_color));
else
	MinimapBackdrop:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
end

-- Set Square Map View
Minimap:SetMaskTexture(C["media"].blank)
MinimapBorder:Hide()