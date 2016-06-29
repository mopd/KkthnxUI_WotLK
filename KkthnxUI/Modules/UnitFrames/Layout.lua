local K, C, L, _ = select(2, ...):unpack()
if C["Unitframe"].enable ~= true then return end

local _G = _G
local unpack = unpack
local pairs = pairs
local select = select
local IsAddOnLoaded = IsAddOnLoaded
local CreateFrame = CreateFrame
local UIParent = UIParent
local InCombatLockdown = InCombatLockdown
local hooksecurefunc = hooksecurefunc
local UnitIsPlayer = UnitIsPlayer
local UnitClass = UnitClass
local CUSTOM_CLASS_COLORS = CUSTOM_CLASS_COLORS
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

local UnitFrames = CreateFrame("Frame", nil, UIParent)

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent)
if not InCombatLockdown() then
	PlayerAnchor:SetSize(146, 28)
	PlayerAnchor:SetPoint(unpack(C["position"].unitframes.player))
end

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent)
if not InCombatLockdown() then
	TargetAnchor:SetSize(146, 28)
	TargetAnchor:SetPoint(unpack(C["position"].unitframes.target))
end

-- Helper function for moving a Blizzard frame that has a SetMoveable flag
local function ModifyFrame(frame, anchor, parent, posX, posY, scale)
    frame:SetMovable(true)
    frame:ClearAllPoints()
    if(parent == nil) then frame:SetPoint(anchor, posX, posY) else frame:SetPoint(anchor, parent, posX, posY) end
    if(scale ~= nil) then frame:SetScale(scale) end
    frame:SetUserPlaced(true)
    frame:SetMovable(false)
end

-- Helper function for moving a Blizzard frame that does NOT have a SetMoveable flag
local function ModifyBasicFrame(frame, anchor, parent, posX, posY, scale)
    frame:ClearAllPoints()
    if(parent == nil) then frame:SetPoint(anchor, posX, posY) else frame:SetPoint(anchor, parent, posX, posY) end
    if(scale ~= nil) then frame:SetScale(scale) end
end

-- Does the bulk of the tweaking to the unit frames
local function AdjustUnitFrames()
    if not InCombatLockdown() then
        ModifyFrame(PlayerFrame, "CENTER", PlayerFrameAnchor, -51, 3, C["Unitframe"].scale) -- Player Frame

        ModifyFrame(TargetFrame, "CENTER", TargetFrameAnchor, 51, 3, C["Unitframe"].scale) -- Target Frame
		TargetFrameNameBackground:SetTexture(0/255, 0/255, 0/255, 0.01)

        ModifyFrame(FocusFrame, (unpack(C["position"].unitframes.focus)), 1.0) -- Focus Frame
		FocusFrameNameBackground:SetTexture(0/255, 0/255, 0/255, 0.01)

		PetName:Hide()

        -- Party Frames
        --ModifyFrame(PartyMemberFrame1, "LEFT", nil, 100, 125, C["Unitframe"].scale) -- Not sure if I wanna move these.
        for i = 1, 4 do _G["PartyMemberFrame"..i]:SetScale(C["Unitframe"].scale) end -- Resize the other children

        -- Boss Frames
        for i = 1, 4 do -- Scale Them
            _G["Boss"..i.."TargetFrame"]:SetParent(UIParent)
            _G["Boss"..i.."TargetFrame"]:SetScale(C["Unitframe"].scale)
            _G["Boss"..i.."TargetFrame"]:SetFrameStrata("BACKGROUND")
        end
        for i = 2, 4 do -- Adjust Positions
            _G["Boss"..i.."TargetFrame"]:SetPoint("TOPLEFT", _G["Boss"..(i-1).."TargetFrame"], "BOTTOMLEFT", 0, 15)
        end

        -- Arena Frames
        ArenaEnemyFrames:SetScale(C["Unitframe"].scale)

		-- RuneFrame
		if K.Class == "DEATHKNIGHT" then
			RuneFrame:ClearAllPoints()
			RuneFrame:SetPoint("TOPLEFT", PlayerFrameManaBar, "BOTTOMLEFT", -1, -5)
			for i = 1, 6 do
				_G["RuneButtonIndividual"..i]:SetScale(C["Unitframe"].scale)
			end
		end

		-- ComboFrame
		if K.Class == "ROGUE" then
			for i = 1, 5 do
				_G["ComboPoint"..i]:SetScale(C["Unitframe"].scale)
			end
		end

		-- Unit Name
		for _, FrameNames in pairs({
			PlayerName,
			TargetFrameTextureFrameName,
			FocusFrameTextureFrameName,
		}) do
			if C["Unitframe"].outline then
				FrameNames:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)
				FrameNames:SetShadowOffset(0, -0)
			else
				FrameNames:SetFont(C["Media"].Font, C["Media"].Font_Size)
				FrameNames:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
			end
		end

		-- Unit HealthBarText
		for _, FrameBarText in pairs({
			PlayerFrameHealthBarText,
			PlayerFrameManaBarText,
			TargetFrameTextureFrameHealthBarText,
			TargetFrameTextureFrameManaBarText,
			FocusFrameTextureFrameHealthBarText,
			FocusFrameTextureFrameManaBarText,
			PetFrameHealthBarText,
			PetFrameManaBarText,
		}) do
			if C["Unitframe"].outline then
				FrameBarText:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)
				FrameBarText:SetShadowOffset(0, -0)
			else
				FrameBarText:SetFont(C["Media"].Font, C["Media"].Font_Size)
				FrameBarText:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
			end
		end

		-- Party Unit HealthBarText
		for _, PartyBarText in pairs({
			PartyMemberFrame1HealthBarText,
			PartyMemberFrame1ManaBarText,
			PartyMemberFrame2HealthBarText,
			PartyMemberFrame2ManaBarText,
			PartyMemberFrame3HealthBarText,
			PartyMemberFrame3ManaBarText,
			PartyMemberFrame4HealthBarText,
			PartyMemberFrame4ManaBarText,
		}) do
			if C["Unitframe"].outline then
				PartyBarText:SetFont(C["Media"].Font, C["Media"].Font_Size - 3, C["Media"].Font_Style)
				PartyBarText:SetShadowOffset(0, -0)
			else
				PartyBarText:SetFont(C["Media"].Font, C["Media"].Font_Size - 3)
				PartyBarText:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
			end
		end

		-- Unit LevelText
		for _, LevelText in pairs({
			PlayerLevelText,
			TargetFrameTextureFrameLevelText,
			FocusFrameTextureFrameLevelText,
		}) do
			if C["Unitframe"].outline then
				LevelText:SetFont(C["Media"].Font, C["Media"].Font_Size + 1, C["Media"].Font_Style)
				LevelText:SetShadowOffset(0, -0)
			else
				LevelText:SetFont(C["Media"].Font, C["Media"].Font_Size + 1)
				LevelText:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
			end
		end
    end
end

-- Builds the optional class icon on the Unitframes
local function BuildClassIcon()
	if C["Unitframe"].classicon then
		hooksecurefunc("UnitFramePortrait_Update", function(self)
			if self.portrait then
				if UnitIsPlayer(self.unit) then
					local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
					if t then
						self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
						self.portrait:SetTexCoord(unpack(t))
					end
				else
					self.portrait:SetTexCoord(0, 1, 0, 1)
				end
			end
		end)
	end
end

-- Updates the class colours on the Target and Focus frames
local function UpdateClassColours()
	if C["Unitframe"].classhealth then
		local function colorHealthBar(statusbar, unit)
			local _, class, color
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
				_, class = UnitClass(unit)
				color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
				statusbar:SetStatusBarColor(color.r, color.g, color.b)
			end
		end

		hooksecurefunc("UnitFrameHealthBar_Update", colorHealthBar)
		hooksecurefunc("HealthBar_OnValueChanged", function(self)
			colorHealthBar(self, self.unit)
		end)
	end
end

local function HandleEvents(self, event, ...)
    if(event == "ADDON_LOADED" and ... == "KkthnxUI") then
        BuildClassIcon()
		UpdateClassColours()
    end

    if(event == "PLAYER_ENTERING_WORLD") then
        AdjustUnitFrames()
    end

    if(event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE") then
        if(UnitControllingVehicle("player")) then
            AdjustUnitFrames()
        end
    end
	--[[ -- I really don't think this code is ever gonna be needed?
    if(event == "PLAYER_TARGET_CHANGED") then
        UpdateClassColours()
    end

    if(event == "UNIT_FACTION" or event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" or event == "PLAYER_FOCUS_CHANGED") then
		UpdateClassColours()
	else
		UpdateClassColours() -- We put this here to be sure we update if the above doesnt properly update.
	end
	]]--
end

-- Remove Portrait Damage Spam
-- Reimplimentation of CombatFeedback_OnCombatEvent from CombatFeedback.lua
function CombatFeedback_OnCombatEvent_Hook(self, event, flags, amount, type)
    if(C["Unitframe"].combatfeedback) then
        self.feedbackText:SetText(" ")
    end
end

-- Remove Group Number Frame
if C["Unitframe"].groupnumber == true then
	PlayerFrameGroupIndicator.Show = K.Noop
end

-- Remove PvPIcons
if C["Unitframe"].hide_pvpicon == true then
	PlayerPVPIcon:Kill()
	TargetFrameTextureFramePVPIcon:Kill()
	FocusFrameTextureFramePVPIcon:Kill()
	for i = 1, MAX_PARTY_MEMBERS do
		_G["PartyMemberFrame"..i.."PVPIcon"]:Kill()
	end
end

-- Sets up Event Handlers etc
function Init()
    UnitFrames:SetScript("OnEvent", HandleEvents)
    LoadAddOn("Blizzard_ArenaUI")

    UnitFrames:RegisterEvent("PLAYER_ENTERING_WORLD")
    UnitFrames:RegisterEvent("ADDON_LOADED")
    UnitFrames:RegisterEvent("UNIT_EXITED_VEHICLE")
    UnitFrames:RegisterEvent("UNIT_ENTERED_VEHICLE")
    UnitFrames:RegisterEvent("PLAYER_TARGET_CHANGED")
	-- UnitFrames:RegisterEvent("UNIT_FACTION")
	-- UnitFrames:RegisterEvent("RAID_ROSTER_UPDATE")
	-- UnitFrames:RegisterEvent("PARTY_MEMBERS_CHANGED")
    -- UnitFrames:RegisterEvent("PLAYER_FOCUS_CHANGED")
end

hooksecurefunc("CombatFeedback_OnCombatEvent", CombatFeedback_OnCombatEvent_Hook)

-- End of file, call Init
Init()