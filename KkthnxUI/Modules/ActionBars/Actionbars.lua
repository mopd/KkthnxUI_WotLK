local K, C, L = unpack(select(2, ...));
if C["actionbar"].enable ~= true then return end

local Actionbars = CreateFrame("Frame", "Actionbars", WorldFrame)

-- Clean up Keys
local ActionbarsFont = CreateFont("HotKeyFont")
ActionbarsFont:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
ActionbarsFont:SetShadowOffset(0, 0)
NumberFontNormalSmallGray:SetFontObject(ActionbarsFont)

-- Safety
SetCVar("alwaysShowActionBars", 1)

local function ForceTransparent(frame) 
	frame:Kill()
	frame:SetAlpha(0)
end

-- fix main bar keybind not working after a talent switch. :X
hooksecurefunc('TalentFrame_LoadUI', function()
	PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
end)

local function RefreshMainActionBars()
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
		ShapeshiftButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset);
		anchor = ShapeshiftButton1
		anchorOffset = 4
	end
	
	if MultiCastActionBarFrame:IsShown() then	-- Totem bar
		MultiCastActionBarFrame:ClearAllPoints();
		MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset);
		anchor = MultiCastActionBarFrame
		anchorOffset = 4
	end
	
	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset)
	anchor = PetActionButton1
	anchorOffset = 4
	
	PossessButton1:ClearAllPoints();
	PossessButton1:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, anchorOffset);
	
	MainMenuBarVehicleLeaveButton:SetFrameStrata('HIGH');
	MainMenuBarVehicleLeaveButton:SetToplevel(true);
	MainMenuBarVehicleLeaveButton:SetSize(30, 30);
	MainMenuBarVehicleLeaveButton:ClearAllPoints();
	MainMenuBarVehicleLeaveButton:SetPoint('BOTTOM', MainMenuBarRightEndCap, -13, 8);
end

local function RefreshPositions()
	if InCombatLockdown() then return end 
	-- Change the size of the central button and status bars
	
	MainMenuBar:SetWidth(512);
	MainMenuExpBar:SetWidth(512);
	ReputationWatchBar:SetWidth(512);
	MainMenuBarMaxLevelBar:SetWidth(512);
	ReputationWatchStatusBar:SetWidth(512);
	-- Hide backgrounds
	ForceTransparent(SlidingActionBarTexture0)
	ForceTransparent(SlidingActionBarTexture1)
	ForceTransparent(ShapeshiftBarLeft)
	ForceTransparent(ShapeshiftBarMiddle)
	ForceTransparent(ShapeshiftBarRight)
	ForceTransparent(PossessBackground1)
	ForceTransparent(PossessBackground2)
	
	RefreshMainActionBars()
end

-- Event Handlers
local events = {}

function events:UNIT_EXITED_VEHICLE() RefreshPositions(); end
events.PLAYER_ENTERING_WORLD = RefreshPositions
events.UPDATE_INSTANCE_INFO = RefreshPositions	
events.PLAYER_TALENT_UPDATE = RefreshPositions
events.PLAYER_LEVEL_UP = RefreshPositions
events.ACTIVE_TALENT_GROUP_CHANGED = RefreshPositions
events.SPELL_UPDATE_USEABLE = RefreshPositions
events.PET_BAR_UPDATE = RefreshPositions
events.UNIT_ENTERED_VEHICLE = RefreshPositions
events.UPDATE_BONUS_ACTIONBAR = RefreshPositions
events.UPDATE_MULTI_CAST_ACTIONBAR = RefreshPositions
events.CLOSE_WORLD_MAP = RefreshPositions
events.PLAYER_LEVEL_UP = RefreshPositions

events.PLAYER_GAINS_VEHICLE_DATA = RefreshPositions
events.PLAYER_LOSES_VEHICLE_DATA = RefreshPositions
events.UPDATE_VEHICLE_ACTIONBAR = RefreshPositions

local function EventHandler(frame, event) 
	if events[event] then 
		--print(GetTime(), event)
		events[event]() 
	end 
end

-- Set Event Monitoring
for eventname in pairs(events) do 
	Actionbars:RegisterEvent(eventname)
end

-----------------------------------------------------------------------------
-- Menu Menu and Artwork
do
	-- Call Update Function when the default UI makes changes
	hooksecurefunc("UIParent_ManageFramePositions", RefreshPositions);
	-- Required in order to move the frames around
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomRight"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PetActionBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS["MultiCastActionBarFrame"] = nil
	
	-- Scaling
	MainMenuBar:SetScale(C["actionbar"].scale)
	MultiBarBottomRight:SetScale(C["actionbar"].scale)
	MultiBarBottomLeft:SetScale(C["actionbar"].scale)
	MultiBarRight:SetScale(C["actionbar"].scale)
	MultiBarLeft:SetScale(C["actionbar"].scale)
	-- Adjust the fill and endcap artwork
	MainMenuXPBarTexture0:SetPoint("BOTTOM", "MainMenuExpBar", "BOTTOM", -128, 2);
	MainMenuXPBarTexture1:SetPoint("BOTTOM", "MainMenuExpBar", "BOTTOM", 128, 3);
	MainMenuBarTexture0:SetPoint("LEFT", MainMenuBar, "LEFT", 0, 0);
	MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBar, "RIGHT", 0, 0);
	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBar, "LEFT", 32, 0);
	MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBar, "RIGHT", -32, 0); 
	-- Hide Unwanted Art
	MainMenuBarPageNumber:Kill();
	ActionBarUpButton:Kill();
	ActionBarDownButton:Kill();
	MainMenuXPBarTexture2:Kill();
	MainMenuXPBarTexture3:Kill();
	-- Experience Bar
	MainMenuBarTexture2:SetTexture(C["media"].empty)
	MainMenuBarTexture3:SetTexture(C["media"].empty)
	MainMenuBarTexture2:SetAlpha(0)
	MainMenuBarTexture3:SetAlpha(0)
	-- Hide Rested State
	ExhaustionLevelFillBar:SetTexture(C["media"].empty)
	ExhaustionTick:SetAlpha(0)
	-- Max-level Rep Bar
	MainMenuMaxLevelBar0:SetAlpha(0)
	MainMenuMaxLevelBar1:SetAlpha(0)
	MainMenuMaxLevelBar2:SetAlpha(0)
	MainMenuMaxLevelBar3:SetAlpha(0)
	-- Rep Bar Bubbles (For the Rep Bar)
	ReputationWatchBarTexture0:SetAlpha(0)
	ReputationWatchBarTexture1:SetAlpha(0)
	ReputationWatchBarTexture2:SetAlpha(0)
	ReputationWatchBarTexture3:SetAlpha(0)
	-- Rep Bar Bubbles (for the XP bar)
	ReputationXPBarTexture0:SetAlpha(0)
	ReputationXPBarTexture1:SetAlpha(0)
	ReputationXPBarTexture2:SetAlpha(0)
	ReputationXPBarTexture3:SetAlpha(0)
	-- Set Pet Bars
	PetActionBarFrame:SetAttribute("unit", "pet")
	RegisterUnitWatch(PetActionBarFrame)
	
	MainMenuBar:HookScript("OnShow", function() 
		--print("Showing")
		RefreshPositions() 
	end)
end

-- Start Bars
Actionbars:SetScript("OnEvent", EventHandler);
Actionbars:SetFrameStrata("TOOLTIP")
Actionbars:Show()