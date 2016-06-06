local K, C, L, _ = select(2, ...):unpack()
if C["skins"].worldmap ~= true or IsAddOnLoaded("Mapster") == true or IsAddOnLoaded("Aurora") then return end

local floor = math.floor
local select = select
local CreateFrame = CreateFrame

local Taint = K.FullMapQuestTaintFix

local function LoadSkin()
	WorldMapFrame:CreateBackdrop(2)
	WorldMapDetailFrame.backdrop = CreateFrame("Frame", nil, WorldMapFrame)
	WorldMapDetailFrame.backdrop:CreateBackdrop(2)
	WorldMapDetailFrame.backdrop:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -2, 2)
	WorldMapDetailFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 2, -2)
	WorldMapDetailFrame.backdrop:SetFrameLevel(WorldMapDetailFrame:GetFrameLevel() - 2)

	WorldMapZoomOutButton:SetPoint("LEFT", WorldMapZoneDropDown, "RIGHT", 0, 4)
	WorldMapLevelUpButton:SetPoint("TOPLEFT", WorldMapLevelDropDown, "TOPRIGHT", -2, 8)
	WorldMapLevelDownButton:SetPoint("BOTTOMLEFT", WorldMapLevelDropDown, "BOTTOMRIGHT", -2, 2)

	--Mini
	local function SmallSkin()
		WorldMapLevelDropDown:ClearAllPoints()
		WorldMapLevelDropDown:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -10, -4)

		WorldMapFrame.backdrop:ClearAllPoints()
		WorldMapFrame.backdrop:SetPoint("TOPLEFT", 2, 2)
		WorldMapFrame.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	end

	--Large
	local function LargeSkin()
		if not InCombatLockdown() then
			WorldMapFrame:SetParent(UIParent)
			WorldMapFrame:EnableMouse(false)
			WorldMapFrame:EnableKeyboard(false)
			UIPanelWindows["WorldMapFrame"].area = "center"
			WorldMapFrame:SetAttribute("UIPanelLayout-defined", nil)
		end

		WorldMapFrame.backdrop:ClearAllPoints()
		WorldMapFrame.backdrop:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -25, 70)
		WorldMapFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 25, -30)
	end

	local function QuestSkin()
		if not InCombatLockdown() then
			WorldMapFrame:SetParent(UIParent)
			WorldMapFrame:EnableMouse(false)
			WorldMapFrame:EnableKeyboard(false)
			UIPanelWindows["WorldMapFrame"].area = "center"
			WorldMapFrame:SetAttribute("UIPanelLayout-defined", nil)
		end

		WorldMapFrame.backdrop:ClearAllPoints()
		WorldMapFrame.backdrop:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -25, 70)
		WorldMapFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 325, -235)

		if not WorldMapQuestDetailScrollFrame.backdrop then
			WorldMapQuestDetailScrollFrame:CreateBackdrop(2)
			WorldMapQuestDetailScrollFrame.backdrop:SetPoint("TOPLEFT", -22, 2)
			WorldMapQuestDetailScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 23, -4)
			WorldMapQuestDetailScrollFrame.backdrop:SetFrameLevel(WorldMapQuestDetailScrollFrame:GetFrameLevel())
		end

		if not WorldMapQuestRewardScrollFrame.backdrop then
			WorldMapQuestRewardScrollFrame:CreateBackdrop(2)
			WorldMapQuestRewardScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 22, -4)
			WorldMapQuestRewardScrollFrame.backdrop:SetFrameLevel(WorldMapQuestRewardScrollFrame:GetFrameLevel())
		end

		if not WorldMapQuestScrollFrame.backdrop then
			WorldMapQuestScrollFrame:CreateBackdrop(2)
			WorldMapQuestScrollFrame.backdrop:SetPoint("TOPLEFT", 0, 2)
			WorldMapQuestScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 24, -3)
			WorldMapQuestScrollFrame.backdrop:SetFrameLevel(WorldMapQuestScrollFrame:GetFrameLevel())
		end

		WorldMapQuestDetailScrollFrameTrack:Hide()
		WorldMapQuestDetailScrollFrameTrack.Show = K.Dummy
	end

	local function FixSkin()
		WorldMapFrame:StripTextures()
		if WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
			LargeSkin()
		elseif WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
			SmallSkin()
		elseif WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
			QuestSkin()
		end

		if not InCombatLockdown() then
			WorldMapFrame:SetFrameLevel(3)
			WorldMapDetailFrame:SetFrameLevel(WorldMapFrame:GetFrameLevel() + 1)
			WorldMapFrame:SetFrameStrata("HIGH")
		end

		WorldMapFrameAreaLabel:SetFont(C["media"].normal_font, 50, "OUTLINE")
		WorldMapFrameAreaLabel:SetShadowOffset(K.mult, -K.mult)
		WorldMapFrameAreaLabel:SetTextColor(0.90, 0.8294, 0.6407)

		WorldMapFrameAreaDescription:SetFont(C["media"].normal_font, 40, "OUTLINE")
		WorldMapFrameAreaDescription:SetShadowOffset(K.mult, -K.mult)

		WorldMapZoneInfo:SetFont(C["media"].normal_font, 27, "OUTLINE")
		WorldMapZoneInfo:SetShadowOffset(K.mult, -K.mult)
	end

	WorldMapFrame:HookScript("OnShow", FixSkin)
	hooksecurefunc("WorldMapFrame_SetFullMapView", LargeSkin)
	hooksecurefunc("WorldMapFrame_SetQuestMapView", QuestSkin)
	hooksecurefunc("WorldMap_ToggleSizeUp", function()
		if WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
			Taint = true
		end
		FixSkin()
	end)

	WorldMapFrame:RegisterEvent("PLAYER_LOGIN")
	WorldMapFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- fix taint with small map & big map
	WorldMapFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- fix taint with small map & big map
	WorldMapFrame:HookScript("OnEvent", function(self, event)
		local miniWorldMap = GetCVarBool("miniWorldMap")
		local quest = WorldMapQuestShowObjectives:GetChecked()

		if event == "PLAYER_LOGIN" then
			if not miniWorldMap then
				WorldMapFrame:Show()
				WorldMapFrame:Hide()
			end
		elseif event == "PLAYER_REGEN_DISABLED" then
			WorldMapFrameSizeDownButton:Disable()
			WorldMapFrameSizeUpButton:Disable()

			if (quest) and (miniWorldMap or Taint) then
				if WorldMapFrame:IsShown() then
					HideUIPanel(WorldMapFrame)
				end

				if not miniWorldMap and Taint and WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
					WorldMapFrame_SetFullMapView()
				end

				WatchFrame.showObjectives = nil
				WorldMapTitleButton:Hide()
				WorldMapBlobFrame:Hide()
				WorldMapPOIFrame:Hide()

				WorldMapQuestShowObjectives.Show = K.Dummy
				WorldMapTitleButton.Show = K.Dummy
				WorldMapBlobFrame.Show = K.Dummy
				WorldMapPOIFrame.Show = K.Dummy

				WatchFrame_Update()
			end
			WorldMapQuestShowObjectives:Hide()
		elseif event == "PLAYER_REGEN_ENABLED" then
			WorldMapFrameSizeDownButton:Enable()
			WorldMapFrameSizeUpButton:Enable()

			if (quest) and (miniWorldMap or Taint) then
				WorldMapQuestShowObjectives.Show = WorldMapQuestShowObjectives:Show()
				WorldMapTitleButton.Show = WorldMapTitleButton:Show()
				WorldMapBlobFrame.Show = WorldMapBlobFrame:Show()
				WorldMapPOIFrame.Show = WorldMapPOIFrame:Show()

				WorldMapTitleButton:Show()

				WatchFrame.showObjectives = true

				if not miniWorldMap and Taint and WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
					WorldMapFrame_SetFullMapView()
				end

				WorldMapBlobFrame:Show()
				WorldMapPOIFrame:Show()

				WatchFrame_Update()

				if Taint and not miniWorldMap and WorldMapFrame:IsShown() and WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
					HideUIPanel(WorldMapFrame)
					ShowUIPanel(WorldMapFrame)
				end
			end
			WorldMapQuestShowObjectives:Show()
		end
	end)

	local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
	local fontheight = select(2, WorldMapQuestShowObjectivesText:GetFont())*1.1
	coords:SetFrameLevel(90)
	coords:FontString("PlayerText", C["media"].normal_font, fontheight, "THINOUTLINE")
	coords:FontString("MouseText", C["media"].normal_font, fontheight, "THINOUTLINE")
	coords.PlayerText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())
	coords.MouseText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())
	coords.PlayerText:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "BOTTOMLEFT", 5, 5)
	coords.PlayerText:SetText("Player:   0, 0")
	coords.MouseText:SetPoint("BOTTOMLEFT", coords.PlayerText, "TOPLEFT", 0, 5)
	coords.MouseText:SetText("Mouse:   0, 0")
	local int = 0

	WorldMapFrame:HookScript("OnUpdate", function(self, elapsed)
		if WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
			WorldMapFrameSizeUpButton:Hide()
			WorldMapFrameSizeDownButton:Show()
		elseif WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
			WorldMapFrameSizeUpButton:Show()
			WorldMapFrameSizeDownButton:Hide()
		elseif WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
			WorldMapFrameSizeUpButton:Hide()
			WorldMapFrameSizeDownButton:Show()
		end

		int = int + 1

		if int >= 3 then
			local inInstance, _ = IsInInstance()
			local x,y = GetPlayerMapPosition("player")
			x = floor(100 * x)
			y = floor(100 * y)
			if x ~= 0 and y ~= 0 then
				coords.PlayerText:SetText(PLAYER..":   "..x..", "..y)
			else
				coords.PlayerText:SetText(" ")
			end


			local scale = WorldMapDetailFrame:GetEffectiveScale()
			local width = WorldMapDetailFrame:GetWidth()
			local height = WorldMapDetailFrame:GetHeight()
			local centerX, centerY = WorldMapDetailFrame:GetCenter()
			local x, y = GetCursorPosition()
			local adjustedX = (x / scale - (centerX - (width/2))) / width
			local adjustedY = (centerY + (height/2) - y / scale) / height

			if (adjustedX >= 0  and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1) then
				adjustedX = floor(100 * adjustedX)
				adjustedY = floor(100 * adjustedY)
				coords.MouseText:SetText(MOUSE_LABEL..":   "..adjustedX..", "..adjustedY)
			else
				coords.MouseText:SetText(" ")
			end

			int = 0
		end
	end)

	-- dropdown on full map is scaled incorrectly
	WorldMapContinentDropDownButton:HookScript("OnClick", function() DropDownList1:SetScale(C["general"].uiscale) end)
	WorldMapZoneDropDownButton:HookScript("OnClick", function(self)
		DropDownList1:SetScale(C["general"].uiscale)
		DropDownList1:ClearAllPoints()
		DropDownList1:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 2, -4)
	end)
end

LoadSkin()