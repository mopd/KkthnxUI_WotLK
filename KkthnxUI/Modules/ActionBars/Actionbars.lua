local K, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

local _G = _G
local pairs = pairs
local format = string.format

-- Clean up Keys
local ActionbarsFont = CreateFont("HotKeyFont")
ActionbarsFont:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
ActionbarsFont:SetShadowOffset(0, 0)
NumberFontNormalSmallGray:SetFontObject(ActionbarsFont)

local FRAMES_DISABLE_MOVEMENT = {
	"MultiBarLeft",
	"MultiBarRight",
	"MultiBarBottomRight",
	"PossessBarFrame",
	"ShapeshiftBarFrame",
	"MULTICASTACTIONBAR_YPOS",
	"MultiCastActionBarFrame",
	"PETACTIONBAR_YPOS",
}

local HIDE_FRAMES = {
	"ActionBarUpButton", "ActionBarDownButton",
	"MainMenuBarTexture2","MainMenuMaxLevelBar2","MainMenuBarTexture3","MainMenuMaxLevelBar3",
	"MainMenuXPBarTexture3", "MainMenuXPBarTexture0", "ReputationWatchBarTexture2","ReputationXPBarTexture2",
	"ReputationWatchBarTexture3","ReputationXPBarTexture3", "ShapeshiftBarMiddle", "ShapeshiftBarRight",
	"MainMenuBarPageNumber", "SlidingActionBarTexture0", "SlidingActionBarTexture1", "ShapeshiftBarLeft",
	"PossessBackground1", "PossessBackground2",
}

local SHORTEN_FRAMES = {
	"MainMenuBar",
	"MainMenuExpBar",
	"MainMenuBarMaxLevelBar",
	"ReputationWatchBar",
	"ReputationWatchStatusBar",
}

function ShapeshiftBar_Update() 
	ShapeshiftBar_UpdateState()
end

local function CreateShortBars()
	-- Fix some stuff 
	for _, frame in pairs(FRAMES_DISABLE_MOVEMENT) do
		UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
	end
	
	for _, name in pairs(HIDE_FRAMES) do
		local object = _G[name]
		if not object then print(name) end
		if (object:IsObjectType("Frame") or object:IsObjectType("Button")) then
			object:UnregisterAllEvents()
			object:SetScript("OnEnter", nil)
			object:SetScript("OnLeave", nil)
			object:SetScript("OnClick", nil)
		else
			object.Show = object.Hide
		end
		object:Hide()
	end
	-- Shorten textures
	for _, name in pairs(SHORTEN_FRAMES) do
		_G[name]:SetWidth(512)
	end
	
	-- Remove MainMenuXPBarDiv
	for i = 1, 19, 2 do
		for _, object in pairs({_G["MainMenuXPBarDiv"..i]}) do
			object.Show = object.Hide
			object:Hide()
		end
	end
	
	-- MultiBarBottomRight (now top middle)
	MultiBarBottomRight:EnableMouse(false)
	MultiBarBottomRight:ClearAllPoints()
	MultiBarBottomRight:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 0, 6)
	
	MainMenuBarTexture0:SetPoint("BOTTOM", MainMenuBarArtFrame, -128, 0)
	MainMenuBarTexture1:SetPoint("BOTTOM", MainMenuBarArtFrame, 128, 0)
	MainMenuMaxLevelBar0:SetPoint("BOTTOM", MainMenuBarMaxLevelBar, "TOP", -128, 0)
	MainMenuBarLeftEndCap:SetPoint("BOTTOM", MainMenuBarArtFrame, -289, 0)
	MainMenuBarRightEndCap:SetPoint("BOTTOM", MainMenuBarArtFrame, 289, 0)
	
	MainMenuBarVehicleLeaveButton:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:SetPoint("LEFT", MainMenuBar, "RIGHT", 10, 75)
	end)
end

local function SetupBars()
	-- Rep Bar 
	ReputationWatchStatusBarText:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
	ReputationWatchStatusBarText:SetShadowOffset(0, 0)
	ReputationWatchStatusBarText:SetAlpha(0)
	
	-- Exp Bar 
	MainMenuBarExpText:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
	MainMenuBarExpText:SetShadowOffset(0, 0)
	MainMenuBarExpText:SetAlpha(0)
	
	-- MultiBarRight 
	MultiBarRight:ClearAllPoints()
	MultiBarRight:SetPoint("TOPRIGHT", UIParent, "RIGHT", -6, (MultiBarRight:GetHeight() / 2))
	
	-- MultiBarLeft
	MultiBarLeft:SetParent(UIParent)
	MultiBarLeft:ClearAllPoints()
	MultiBarLeft:SetPoint("TOPRIGHT", MultiBarRightButton1, "TOPLEFT", -6, 0)
end

-- Show empty buttons
if C["actionbar"].showgrid == true then
	ActionButton_HideGrid = K.Dummy
	for i = 1, 12 do
		local button = _G[format("ActionButton%d", i)]
		button:SetAttribute("showgrid", 1)
		ActionButton_ShowGrid(button)
		
		button = _G[format("BonusActionButton%d", i)]
		button:SetAttribute("showgrid", 1)
		ActionButton_ShowGrid(button)
		
		button = _G[format("MultiBarRightButton%d", i)]
		button:SetAttribute("showgrid", 1)
		ActionButton_ShowGrid(button)
		
		button = _G[format("MultiBarBottomRightButton%d", i)]
		button:SetAttribute("showgrid", 1)
		ActionButton_ShowGrid(button)
		
		button = _G[format("MultiBarLeftButton%d", i)]
		button:SetAttribute("showgrid", 1)
		ActionButton_ShowGrid(button)
		
		button = _G[format("MultiBarBottomLeftButton%d", i)]
		button:SetAttribute("showgrid", 1)
		ActionButton_ShowGrid(button)
	end
end

hooksecurefunc('ActionButton_UpdateHotkeys', function(self, actionButtonType)
	local hotkey = _G[self:GetName() .. 'HotKey']
	local text = hotkey:GetText()
	
	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", 0, K.Scale(-3))
	hotkey:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size + 1, C["font"].action_bars_font_style)
	hotkey.ClearAllPoints = K.Dummy
	hotkey.SetPoint = K.Dummy
	--hotkey:SetShadowColor(0, 0, 0)
	--hotkey:SetShadowOffset(1.25, -1.25)
	
	if not (C["actionbar"].showhotkeys) == true then
		hotkey:SetText("")
		hotkey:Hide()
		hotkey.Show = K.Dummy
	end
	
	text = string.gsub(text, '(s%-)', 'S')
	text = string.gsub(text, '(a%-)', 'A')
	text = string.gsub(text, '(c%-)', 'C')
	text = string.gsub(text, '(Mouse Button )', 'M')
	text = string.gsub(text, '(Middle Mouse)', 'M3')
	text = string.gsub(text, '(Num Pad )', 'N')
	text = string.gsub(text, '(Page Up)', 'PU')
	text = string.gsub(text, '(Page Down)', 'PD')
	text = string.gsub(text, '(Spacebar)', 'SpB')
	text = string.gsub(text, '(Insert)', 'Ins')
	text = string.gsub(text, '(Home)', 'Hm')
	text = string.gsub(text, '(Delete)', 'Del')
	
	if hotkey:GetText() == _G['RANGE_INDICATOR'] then
		hotkey:SetText('')
	else
		hotkey:SetText(text)
	end
end)

local function LoadActionBars()
	SetupBars()
	CreateShortBars()
end

LoadActionBars();