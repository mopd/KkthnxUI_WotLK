local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true then return end

local _G = _G
local pairs = pairs
local format = string.format
local CreateFrame, UIParent = CreateFrame, UIParent
local GetName, GetText = GetName, GetText
local UIPARENT_MANAGED_FRAME_POSITIONS = UIPARENT_MANAGED_FRAME_POSITIONS

-- Clean up Keys
local ActionbarsFont = CreateFont("HotKeyFont")
ActionbarsFont:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
ActionbarsFont:SetShadowOffset(K.mult, -K.mult)
NumberFontNormalSmallGray:SetFontObject(ActionbarsFont)

local FRAMES_DISABLE_MOVEMENT = {
	"MULTICASTACTIONBAR_YPOS",
	"MultiBarBottomRight",
	"MultiBarLeft",
	"MultiBarRight",
	"MultiCastActionBarFrame",
	"PETACTIONBAR_YPOS",
	"PossessBarFrame",
	"ShapeshiftBarFrame",
}

local HIDE_FRAMES = {
	"ActionBarUpButton", "ActionBarDownButton",
	"MainMenuBarPageNumber", "SlidingActionBarTexture0", "SlidingActionBarTexture1", "ShapeshiftBarLeft",
	"MainMenuBarTexture2","MainMenuMaxLevelBar2","MainMenuBarTexture3","MainMenuMaxLevelBar3",
	"MainMenuXPBarTexture3", "MainMenuXPBarTexture0", "ReputationWatchBarTexture2","ReputationXPBarTexture2",
	"PossessBackground1", "PossessBackground2",
	"ReputationWatchBarTexture3","ReputationXPBarTexture3", "ShapeshiftBarMiddle", "ShapeshiftBarRight",
}

local SHORTEN_FRAMES = {
	"MainMenuBar",
	"MainMenuBarMaxLevelBar",
	"MainMenuExpBar",
	"ReputationWatchBar",
	"ReputationWatchStatusBar",
}

local Actionbars = CreateFrame("Frame", "Actionbars", UIParent)

function ShapeshiftBar_Update()
	ShapeshiftBar_UpdateState()
end

function Actionbars:CreateShortBars()
	-- Fix some stuff
	for _, frame in pairs(FRAMES_DISABLE_MOVEMENT) do
		UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
	end

	for _, name in pairs(HIDE_FRAMES) do
		local object = _G[name]
		if not object then K.Print(name) end
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

function Actionbars:SetupBars()
	-- MultiBarRight
	MultiBarRight:ClearAllPoints()
	MultiBarRight:SetPoint("TOPRIGHT", UIParent, "RIGHT", -6, (MultiBarRight:GetHeight() / 2))

	-- MultiBarLeft
	MultiBarLeft:SetParent(UIParent)
	MultiBarLeft:ClearAllPoints()
	MultiBarLeft:SetPoint("TOPRIGHT", MultiBarRightButton1, "TOPLEFT", -6, 0)
end

function Actionbars:Load()
	Actionbars:SetupBars()
	Actionbars:CreateShortBars()
end

Actionbars:Load()