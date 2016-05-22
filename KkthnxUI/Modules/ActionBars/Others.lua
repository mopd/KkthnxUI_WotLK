local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true then return end

local _G = _G
local pairs = pairs
local format = string.format
local unpack = unpack
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

local FrameShift = CreateFrame("Frame", "ShapeShiftHolder", UIParent)
FrameShift:SetSize(196, 32 + 2)
FrameShift:SetPoint(unpack(C["position"].stancebar))

local FramePet = CreateFrame("Frame", "PetBarHolder", UIParent)
FramePet:SetSize(32 * 10 + 4 * 9, 32 + 2)
FramePet:SetPoint(unpack(C["position"].petbar))

ShapeshiftBarFrame:SetParent(FrameShift)
ShapeshiftButton1:ClearAllPoints()
ShapeshiftButton1:SetPoint("BOTTOMLEFT", FrameShift, "BOTTOMLEFT", 0, 0)
local function MoveShapeshift()
	ShapeshiftButton1:SetPoint("BOTTOMLEFT", FrameShift, "BOTTOMLEFT", 0, 0)
end
if not InCombatLockdown() then
	hooksecurefunc("ShapeshiftBar_Update", MoveShapeshift)
end
for i = 2, 10 do
	local b = _G["ShapeshiftButton"..i]
	local b2 = _G["ShapeshiftButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", 6, 0)
end

PetActionBarFrame:SetParent(FramePet)
PetActionBarFrame.showgrid = 1 -- hack to never hide pet button. :X
PetActionButton1:ClearAllPoints()
PetActionButton1:SetPoint("BOTTOMLEFT", FramePet, "BOTTOMLEFT", 0, 0)
for i = 2, 10 do
	local b = _G["PetActionButton"..i]
	local b2 = _G["PetActionButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", 6, 0)
end

if MultiCastActionBarFrame and K.Class == "SHAMAN" then
	MultiCastActionBarFrame:SetParent(FrameShift)
	MultiCastActionBarFrame:ClearAllPoints()
	MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", FrameShift, "BOTTOMLEFT", -2, -2)

	for i = 1, 4 do
		local b = _G["MultiCastSlotButton"..i]
		local b2 = _G["MultiCastActionButton"..i]

		b:ClearAllPoints()
		b:SetAllPoints(b2)
	end

	MultiCastActionBarFrame.SetParent = K.Dummy
	MultiCastActionBarFrame.SetPoint = K.Dummy
	MultiCastRecallSpellButton.SetPoint = K.Dummy
end