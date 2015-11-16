local K, C, L = unpack(select(2, ...));
if C["actionbar"].enable ~= true then return end

-- Tidy Bar
-- ..with a lotta help from his friends.
-- Disclaimer: Your computer might explode. It's not my fault.

-- Watch for a diff event
-- test by removing timer event

local config = {
	ShapeshiftBar = { offsetX = 0 },
	TotemBar = { offsetX = 0 },
	PetBar = { offsetX = 0 },
	PossessBar = { offsetX = 0 },
}

local RegisterEvents
local events = {}

local menubuttons = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	SocialsMicroButton,
	PVPMicroButton,
	--LFGMicroButton,
	LFDMicroButton,
	MainMenuMicroButton,
	HelpMicroButton,
}

local bagbuttons = {
	MainMenuBarBackpackButton,
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
	KeyRingButton,
}

local totembuttons = {
	MultiCastSummonSpellButton,
	MultiCastActionPage1,
	MultiCastActionPage2,
	MultiCastActionPage3,
	MultiCastSlotButton1,
	MultiCastSlotButton2,
	MultiCastSlotButton3,
	MultiCastSlotButton4,
	MultiCastFlyoutFrame,
	MultiCastFlyoutButton,
	MultiCastRecallSpellButton,
}

local gridShown = false
local prevAlpha = 0
local initTime = 0

TidyBar = CreateFrame("Frame", "TidyBar", UIParent)

function TidyBar:Startup()
	-- Required in order to move the frames around
	hooksecurefunc("UIParent_ManageFramePositions", TidyBar.UpdateUI);
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomRight"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PetActionBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiCastActionBarFrame"] = nil
	--UIPARENT_MANAGED_FRAME_POSITIONS["MULTICASTACTIONBAR_YPOS"] = nil
	
	MainMenuBarPageNumber:Hide();
	ActionBarUpButton:Hide();
	ActionBarDownButton:Hide();
	MainMenuXPBarTexture2:Hide();
	MainMenuXPBarTexture3:Hide();
	MainMenuBarTexture2:Hide();
	MainMenuBarTexture3:Hide();
	MainMenuMaxLevelBar2:Hide();
	MainMenuMaxLevelBar3:Hide();
	
	ReputationWatchBarTexture2:SetTexture("");
	ReputationWatchBarTexture3:SetTexture("");
	ReputationXPBarTexture2:SetTexture("");
	ReputationXPBarTexture3:SetTexture("");
	
	MainMenuBar:SetWidth(512);
	MainMenuExpBar:SetWidth(512);
	ReputationWatchBar:SetWidth(512);
	MainMenuBarMaxLevelBar:SetWidth(512);
	ReputationWatchStatusBar:SetWidth(512);
	
	MainMenuXPBarTexture0:SetPoint("BOTTOM", "MainMenuExpBar", "BOTTOM", -128, 2);
	MainMenuXPBarTexture1:SetPoint("BOTTOM", "MainMenuExpBar", "BOTTOM", 128, 3);
	MainMenuMaxLevelBar0:SetPoint("BOTTOM", "MainMenuBarMaxLevelBar", "TOP", -128, 0);
	MainMenuBarTexture0:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", -128, 0);
	MainMenuBarTexture1:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", 128, 0);
	MainMenuBarLeftEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", -290, 0);
	MainMenuBarRightEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", 287, 0); 
	
	-- Set Pet Bars
	PetActionBarFrame:SetAttribute("unit", "pet")
	RegisterUnitWatch(PetActionBarFrame)
	
	-- Set Mouseover for Right-side Button Bar
	if C["actionbar"].mouseoversidebars then
		TidyBar:SetMouseOverSideBars()
		TidyBar:FadeSideBars(0)
	end
	TidyBar:SetMouseOverCornerBars()
	TidyBar:FadeCorner(0)
	
	-- 
	MultiCastActionBarFrame._SetPoint = MultiCastActionBarFrame.SetPoint
	MultiCastActionBarFrame.SetPoint = function() TidyBar:UpdateUI() end
	
	-- Register for events
	RegisterEvents(self)
	self:SetScript("OnEvent", self.OnEvent);
	
	return true
end

function MakeInvisible(frame) 
	frame:Hide()
	frame:SetAlpha(0)
end

function TidyBar:UpdateUI()
	if InCombatLockdown() then return end 
	-- Hide backgrounds
	MakeInvisible(SlidingActionBarTexture0)
	MakeInvisible(SlidingActionBarTexture1)
	MakeInvisible(ShapeshiftBarLeft)
	MakeInvisible(ShapeshiftBarMiddle)
	MakeInvisible(ShapeshiftBarRight)
	MakeInvisible(PossessBackground1)
	MakeInvisible(PossessBackground2)
	
	TidyBar:UpdateActionBars()
	TidyBar:UpdateCorner()
	--	/script MultiCastActionBarFrame_Update(MultiCastActionBar)
	--	MultiCastActionBarFrame_Update(MultiCastActionBar)
	
	-- Scaling
	MainMenuBar:SetScale(C["actionbar"].scale)
	MultiBarBottomRight:SetScale(C["actionbar"].scale)
	MultiBarBottomLeft:SetScale(C["actionbar"].scale)
	MultiBarRight:SetScale(C["actionbar"].scale)
	MultiBarLeft:SetScale(C["actionbar"].scale)
	
	return true
end

function TidyBar:UpdateActionBars()
	local anchor
	local anchorOffset = 4
	local repOffset = 0
	
	if MainMenuExpBar:IsShown() then repOffset = 9 end
	if ReputationWatchBar:IsShown() then repOffset = repOffset + 9 end
	
	if MultiBarRight:IsShown() then
		MultiBarRight:ClearAllPoints();
		MultiBarRight:SetPoint('TOPRIGHT', UIParent, 'RIGHT', -6, (MultiBarRight:GetHeight() / 2))
	end
	
	if MultiBarBottomLeft:IsShown() then
		anchor = MultiBarBottomLeft
		anchorOffset = 4
	else
		anchor = ActionButton1;
		anchorOffset = 8 + repOffset
	end
	
	if MultiBarBottomRight:IsShown() then
		MultiBarBottomRight:ClearAllPoints()
		MultiBarBottomRight:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset )
		anchor = MultiBarBottomRight
		anchorOffset = 4
	end
	
	if ShapeshiftButton1:IsShown() then
		ShapeshiftButton1:ClearAllPoints();
		ShapeshiftButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", config.ShapeshiftBar.offsetX, anchorOffset);
		anchor = ShapeshiftButton1
		anchorOffset = 4
	end
	
	if MultiCastActionBarFrame:IsShown() then	-- Totem bar
		MultiCastActionBarFrame:ClearAllPoints();
		--MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", config.TotemBar.offsetX, anchorOffset);
		--/script MultiCastActionBarFrame:_SetPoint("BOTTOMLEFT", MultiBarBottomRight, "TOPLEFT", 15, 15);
		MultiCastActionBarFrame:_SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", config.TotemBar.offsetX, anchorOffset);
		anchor = MultiCastActionBarFrame
		anchorOffset = 4
	end
	
	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", config.PetBar.offsetX, anchorOffset)
	anchor = PetActionButton1
	anchorOffset = 4
	
	PossessButton1:ClearAllPoints();
	PossessButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", config.PossessBar.offsetX, anchorOffset);
end

function TidyBar:UpdateCorner()
	-- Main Menu
	if C["actionbar"].hidemircomenu then
		CharacterMicroButton:ClearAllPoints();
		CharacterMicroButton:SetPoint('BOTTOMLEFT', 9999, 9999);
	else
		CharacterMicroButton:ClearAllPoints();
		CharacterMicroButton:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -226, 0);
	end
	
	-- Bags
	point, relativeTo, relativePoint, xOfs, yOfs = MainMenuBar:GetPoint();
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", relativeTo, "BOTTOMRIGHT", -25, 40);
	KeyRingButton:ClearAllPoints();
	KeyRingButton:SetPoint("BOTTOMRIGHT", MainMenuBarBackpackButton, "BOTTOMRIGHT", 22, -1);
	
	if C["actionbar"].hidebags then
		MainMenuBarBackpackButton:Hide()
		KeyRingButton:Hide()
	
		CharacterBag0Slot:Hide()
		CharacterBag1Slot:Hide()
		CharacterBag2Slot:Hide()
		CharacterBag3Slot:Hide()
	end
	
end

function TidyBar:FadeSideBars(desired)
	sideBarAlpha = desired
	if gridShown then final = 1 else final = desired end
	
	for i = 1, 12 do
		_G["MultiBarRightButton"..i]:SetAlpha(final);
		_G["MultiBarLeftButton"..i]:SetAlpha(final);
	end
	
end

function TidyBar:FadeCorner(Alpha)
	if UnitHasVehicleUI("player") then 
		Alpha = 1
	end
	
	for i, name in pairs(menubuttons) do name:SetAlpha(Alpha) end
	for i, name in pairs(bagbuttons) do name:SetAlpha(Alpha) end
end

function TidyBar:SetMouseOverCornerBars()
	local CornerMouseoverFrame = CreateFrame("Frame", "BagBarMouseoverBox", UIParent)
	CornerMouseoverFrame:EnableMouse();
	CornerMouseoverFrame:HookScript("OnEnter", function() TidyBar:FadeCorner(1) end)
	CornerMouseoverFrame:HookScript("OnLeave", function() TidyBar:FadeCorner(0) end)
	
	CornerMouseoverFrame:SetPoint("TOP", MainMenuBarBackpackButton, "TOP", 0,10)
	CornerMouseoverFrame:SetPoint("RIGHT", KeyRingButton, "RIGHT", 4,0)
	CornerMouseoverFrame:SetPoint("LEFT", CharacterMicroButton, "LEFT", -20,0)
	
	KeyRingButton:Enable();
	KeyRingButton:EnableDrawLayer();
	KeyRingButton:Show();
	
	for i, name in pairs(menubuttons) do TidyBar:SetMouseOverCornerButton( name) end
	for i, name in pairs(bagbuttons) do TidyBar:SetMouseOverCornerButton( name) end
end

function TidyBar:FadeMain(Alpha)
	MainMenuBar:SetAlpha(alpha)
end

function TidyBar:SetMouseOverMainBars()
	local MainBarMouseoverFrame = CreateFrame("Frame", "MainBarMouseoverBox", UIParent)
	MainBarMouseoverFrame:EnableMouse();
	MainBarMouseoverFrame:HookScript("OnEnter", function() TidyBar:FadeMain(1) end)
	MainBarMouseoverFrame:HookScript("OnLeave", function() TidyBar:FadeMain(0) end)
	
	MainBarMouseoverFrame:SetPoint("TOP", MainMenuBarBackpackButton, "TOP", 0,10)
	MainBarMouseoverFrame:SetPoint("RIGHT", KeyRingButton, "RIGHT", 4,0)
	MainBarMouseoverFrame:SetPoint("LEFT", CharacterMicroButton, "LEFT", -20,0)
	
	
	-- Need to do this for ActionButton1.., ShapeshiftButton1.., and all other buttons
	--including MainMenuExpBar
	for index, framename in pairs(menubuttons) do 
		framename:HookScript("OnEnter", function() TidyBar:FadeMain(1) end)
		framename:HookScript("OnLeave", function() TidyBar:FadeMain(0) end)
	end
	
end

function TidyBar:SetMouseOverCornerButton(frameTarget)
	frameTarget:HookScript("OnEnter", function() TidyBar:FadeCorner(1) end)
	frameTarget:HookScript("OnLeave", function() TidyBar:FadeCorner(0) end)
end

function TidyBar:SetMouseOverSideBars()
	local SideMouseoverFrame = CreateFrame("Frame", "SideBarMouseoverBox", UIParent)
	
	SideMouseoverFrame:SetPoint("TOPLEFT", MultiBarLeft, "TOPLEFT", -10,0)
	SideMouseoverFrame:SetPoint("BOTTOMRIGHT", MultiBarRight, "BOTTOMRIGHT", 0,0)
	
	SideMouseoverFrame:EnableMouse();
	SideMouseoverFrame:HookScript("OnEnter", function() TidyBar:FadeSideBars(1) end)
	SideMouseoverFrame:HookScript("OnLeave", function() TidyBar:FadeSideBars(0) end)
	
	MultiBarRight:EnableMouse();
	MultiBarRight:HookScript("OnEnter", function() TidyBar:FadeSideBars(1) end)
	MultiBarRight:HookScript("OnLeave", function() TidyBar:FadeSideBars(0) end)
	
	MultiBarLeft:EnableMouse();
	MultiBarLeft:HookScript("OnEnter", function() TidyBar:FadeSideBars(1) end)
	MultiBarLeft:HookScript("OnLeave", function() TidyBar:FadeSideBars(0) end)
	
	for i = 1, 12 do
		TidyBar:SetMouseOverSideButton( _G["MultiBarRightButton"..i] )
		TidyBar:SetMouseOverSideButton( _G["MultiBarLeftButton"..i] )
	end
	
end

function TidyBar:SetMouseOverSideButton(frameTarget)
	frameTarget:HookScript("OnEnter", function() TidyBar:FadeSideBars(1) end)
	frameTarget:HookScript("OnLeave", function() TidyBar:FadeSideBars(0) end)
end

RegisterEvents = function(handler) for eventname in pairs(events) do handler:RegisterEvent(eventname) end end
function TidyBar:OnEvent(event) 
	events[event]() 
end

function events:ACTIONBAR_SHOWGRID() gridShown = true; TidyBar:FadeSideBars(sideBarAlpha) end
function events:ACTIONBAR_HIDEGRID() gridShown = false; TidyBar:FadeSideBars(sideBarAlpha) end
function events:UNIT_ENTERED_VEHICLE() TidyBar:UpdateUI(); TidyBar:FadeCorner(1) end
function events:UNIT_EXITED_VEHICLE() TidyBar:UpdateUI(); TidyBar:FadeCorner(0) end
function events:PLAYER_ENTERING_WORLD() TidyBar:UpdateUI(); TidyBar:FadeCorner(0) end
function events:UPDATE_INSTANCE_INFO() TidyBar:UpdateUI(); end
function events:SPELL_UPDATE_USEABLE() TidyBar:UpdateUI(); end
function events:UPDATE_BONUS_ACTIONBAR() TidyBar:UpdateUI(); end
function events:UPDATE_MULTI_CAST_ACTIONBAR() TidyBar:UpdateUI(); end
function events:PET_BAR_UPDATE() TidyBar:UpdateUI();end
function events:CLOSE_WORLD_MAP() TidyBar:UpdateUI();end

TidyBar:Startup()