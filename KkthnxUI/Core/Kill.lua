local K, C, L, _ = unpack(select(2, ...))

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
local SetCVar = SetCVar

-- Kill all stuff on default UI that we don't need
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon, ...)
	
	if addon == "Blizzard_AchievementUI" then
		if C["tooltip"].enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end
	
	CharacterModelFrameRotateLeftButton:Kill()
	CharacterModelFrameRotateRightButton:Kill()
	if addon == "Blizzard_InspectUI" then
		if InspectFrame then
			InspectModelRotateLeftButton:Kill()
			InspectModelRotateRightButton:Kill()
		end
	end
	
	VideoOptionsResolutionPanelUIScaleSlider:Kill()
	VideoOptionsResolutionPanelUseUIScale:Kill()
	
	if C["chat"].enable then
		SetCVar("chatStyle", "im")
		InterfaceOptionsSocialPanelChatStyle:Kill()
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
	end
	
	if C["minimap"].enable then
		InterfaceOptionsDisplayPanelRotateMinimap:Kill()
	end
	
	if C["actionbar"].enable then
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
	end
	
	if C["nameplate"].enable then
		SetCVar("ShowClassColorInNameplate", 1)
	end
end)