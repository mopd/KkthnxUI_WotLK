local K, C, L, _ = unpack(select(2, ...))
if C["map"].enable ~= true or IsAddOnLoaded("Mapster") == true or IsAddOnLoaded("Aurora") then return end

local math = math.floor
local unpack = unpack
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded

-- WorldMap style(m_Map by Monolit)
WORLDMAP_WINDOWED_SIZE = C["map"].scale
local mapscale = WORLDMAP_WINDOWED_SIZE

local mapbg = CreateFrame("Frame", nil, WorldMapDetailFrame)
K.AddBorder(mapbg, 12, 1)
mapbg:SetBorderColor(K.Color.r, K.Color.g, K.Color.b)

-- Create move button for map
local movebutton = CreateFrame("Frame", nil, WorldMapFrameSizeUpButton)
movebutton:SetSize(32,32)
movebutton:SetPoint("TOP", WorldMapFrameSizeUpButton, "BOTTOM", -1, 4)
movebutton:SetBackdrop({bgFile = "Interface\\AddOns\\KkthnxUI\\Media\\Worldmap\\Cross.tga"})
movebutton:EnableMouse(true)

movebutton:SetScript("OnMouseDown", function()
	if InCombatLockdown() then return end
	WorldMapScreenAnchor:ClearAllPoints()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:StartMoving()
	WorldMapBlobFrame:Hide()
end)

movebutton:SetScript("OnMouseUp", function()
	if InCombatLockdown() then return end
	WorldMapFrame:StopMovingOrSizing()
	WorldMapScreenAnchor:StartMoving()
	WorldMapScreenAnchor:StopMovingOrSizing()
	WorldMapBlobFrame:Show()
	WorldMapFrame:Hide()
	WorldMapFrame:Show()
end)

local SmallerMap = GetCVarBool("miniWorldMap")
if SmallerMap == nil then
	SetCVar("miniWorldMap", 1)
end

-- Styling World Map
local SmallerMapSkin = function()
	mapbg:SetScale(1 / mapscale)
	mapbg:SetPoint("TOPLEFT", WorldMapDetailFrame, -2, 2)
	mapbg:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, 2, -2)
	mapbg:SetFrameStrata("MEDIUM")
	mapbg:SetFrameLevel(20)

	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true)
	WorldMapFrame:SetClampRectInsets(12, 227, -31, -134)
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint(unpack(C["position"].worldmap))

	WorldMapDetailFrame:SetFrameStrata("MEDIUM")

	WorldMapTitleButton:Show()
	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")

	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()

	WorldMapFrameSizeUpButton:ClearAllPoints()
	WorldMapFrameSizeUpButton:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, -18)
	WorldMapFrameSizeUpButton:SetFrameStrata("HIGH")
	WorldMapFrameSizeUpButton:SetFrameLevel(18)

	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, 3)
	WorldMapFrameCloseButton:SetFrameStrata("HIGH")

	WorldMapFrameSizeDownButton:SetPoint("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -66, 7)

	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(WorldMapDetailFrame)
	WorldMapFrameTitle:SetPoint("TOP", WorldMapDetailFrame, 0, -3)
	WorldMapFrameTitle:SetFont(C["media"].normal_font, 17)

	WorldMapQuestShowObjectivesText:SetFont(C["media"].normal_font, 13)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 4)

	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:SetPoint("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("HIGH")

	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, 0)
	WorldMapTrackQuest:SetFrameStrata("HIGH")

	WorldMapTrackQuestText:SetFont(C["media"].normal_font, 13)

	WorldMapFrameAreaLabel:SetFont(C["media"].normal_font, 40)
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)

	WorldMapFrameAreaDescription:SetFont(C["media"].normal_font, 40)
	WorldMapFrameAreaDescription:SetShadowOffset(2, -2)

	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.00001)

	-- Fix tooltip not hidding after leaving quest # tracker icon
	hooksecurefunc("WorldMapQuestPOI_OnLeave", function() WorldMapTooltip:Hide() end)
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)

local BiggerMapSkin = function()
	WorldMapFrame:EnableKeyboard(nil)
	WorldMapFrame:EnableMouse(nil)

	UIPanelWindows["WorldMapFrame"].area = "center"
	WorldMapFrame:SetAttribute("UIPanelLayout-defined", nil)

	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint("CENTER")

	WorldMapLevelDropDown:SetAlpha(1)
	WorldMapLevelDropDown:SetScale(1)

	WorldMapFrameTitle:SetParent(WorldMapPositioningGuide)
	WorldMapFrameTitle:SetFont(C["media"].normal_font, 13)
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetPoint("TOP", WorldMapPositioningGuide, "TOP", 0, -5)

	WorldMapQuestShowObjectivesText:SetFont(C["media"].normal_font, 12)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapPositioningGuide, "BOTTOMRIGHT", -10, 10)

	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:SetPoint("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("TOOLTIP")

	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapPositioningGuide, "BOTTOMLEFT", 10, 3)
	WorldMapTrackQuest:SetFrameStrata("HIGH")

	WorldMapTrackQuestText:SetFont(C["media"].normal_font, 12)
end
hooksecurefunc("WorldMap_ToggleSizeUp", function() BiggerMapSkin() end)

mapbg:SetScript("OnShow", function(self)
	local SmallerMap = GetCVarBool("miniWorldMap")
	if SmallerMap == nil then
		BiggerMapSkin()
	end
	self:SetScript("OnShow", K.Dummy)
end)

local addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")
addon:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		SetCVar("questPOI", 1)
		BlackoutWorld:Hide()
		BlackoutWorld.Show = K.Dummy
		BlackoutWorld.Hide = K.Dummy
		WorldMapBlobFrame.Show = K.Dummy
		WorldMapBlobFrame.Hide = K.Dummy
		WorldMapQuestPOI_OnLeave = function()
			WorldMapTooltip:Hide()
		end
		WorldMap_ToggleSizeDown()
		if FeedbackUIMapTip then
			FeedbackUIMapTip:Hide()
			FeedbackUIMapTip.Show = K.Dummy
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		WorldMapFrameSizeUpButton:Disable()
		WorldMap_ToggleSizeDown()
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapFrameSizeUpButton:Enable()
	end
end)

-- Creating coords
local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
coords.PlayerText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.PlayerText:SetFont(C["media"].normal_font, 17)
coords.PlayerText:SetJustifyH("LEFT")
coords.PlayerText:SetText(UnitName("player")..": 0,0")
if IsAddOnLoaded("_NPCScan.Overlay") then
	coords.PlayerText:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -50)
else
	coords.PlayerText:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -3)
end

coords.MouseText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.MouseText:SetFont(C["media"].normal_font, 17)
coords.MouseText:SetJustifyH("LEFT")
coords.MouseText:SetPoint("TOPLEFT", coords.PlayerText, "BOTTOMLEFT", 0, -3)
coords.MouseText:SetText(L_MAP_CURSOR..": 0,0")

local int = 0
coords:SetScript("OnUpdate", function(self, elapsed)
	int = int + 1

	if int >= 3 then
		local inInstance, _ = IsInInstance()
		local x,y = GetPlayerMapPosition("player")
		x = math(100 * x)
		y = math(100 * y)
		if x ~= 0 and y ~= 0 then
			self.PlayerText:SetText(UnitName("player")..": "..x..","..y)
		else
			self.PlayerText:SetText(UnitName("player")..": ".."|cffff0000"..L_MAP_BOUNDS.."|r")
		end

		local scale = WorldMapDetailFrame:GetEffectiveScale()
		local width = WorldMapDetailFrame:GetWidth()
		local height = WorldMapDetailFrame:GetHeight()
		local centerX, centerY = WorldMapDetailFrame:GetCenter()
		local x, y = GetCursorPosition()
		local adjustedX = (x / scale - (centerX - (width/2))) / width
		local adjustedY = (centerY + (height/2) - y / scale) / height

		if adjustedX >= 0 and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1 then
			adjustedX = math(100 * adjustedX)
			adjustedY = math(100 * adjustedY)
			coords.MouseText:SetText(L_MAP_CURSOR..adjustedX..","..adjustedY)
		else
			coords.MouseText:SetText(L_MAP_CURSOR.."|cffff0000"..L_MAP_BOUNDS.."|r")
		end

		int = 0
	end
end)