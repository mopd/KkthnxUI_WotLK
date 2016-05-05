local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true then return end

local _G = _G
local pairs = pairs
local format = string.format
local CreateFrame, UIParent = CreateFrame, UIParent
local InCombatLockdown = InCombatLockdown
local SetCVar = SetCVar
local IsAltKeyDown, IsShiftKeyDown = IsAltKeyDown, IsShiftKeyDown

-- Show empty buttons
local ShowGrid = CreateFrame("Frame")
ShowGrid:RegisterEvent("PLAYER_ENTERING_WORLD")
ShowGrid:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	SetCVar("alwaysShowActionBars", 0)
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
end)

-- Moveable Bars
for _, frame in pairs({
	_G["PetActionBarFrame"],
	_G["ShapeshiftBarFrame"],
	_G["PossessBarFrame"],
	_G["MultiCastActionBarFrame"],
}) do
	frame:EnableMouse(false)
end

-- Left-Alt + Left Click Move
for _, button in pairs({
	_G["PossessButton1"],
	_G["PetActionButton1"],
	_G["ShapeshiftButton1"],
}) do
	button:ClearAllPoints()
	button:SetPoint("CENTER", UIParent, -100)
	
	if InCombatLockdown() then
		button:SetMovable(false)
		button:SetUserPlaced(true)
	else
		button:SetMovable(true)
		button:SetUserPlaced(true)
	end
	
	button:RegisterForDrag("LeftButton")
	button:HookScript("OnDragStart", function(self)
		if (IsShiftKeyDown() and IsAltKeyDown()) then
			if InCombatLockdown() then return end
			self:StartMoving()
		end
	end)
	
	button:HookScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)
end

-- Fix main bar keybind not working after a talent switch. :X
hooksecurefunc('TalentFrame_LoadUI', function()
	PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
end)