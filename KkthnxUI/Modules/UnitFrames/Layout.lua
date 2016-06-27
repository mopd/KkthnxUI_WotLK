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
local UnitPlayerControlled = UnitPlayerControlled
local UnitClass, GetUnitName = UnitClass, GetUnitName
local CUSTOM_CLASS_COLORS = CUSTOM_CLASS_COLORS
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local UnitIsEnemy = UnitIsEnemy
local UnitIsTappedByPlayer = UnitIsTappedByPlayer
local UnitIsTapped = UnitIsTapped
local UnitReaction = UnitReaction
local UnitIsDeadOrGhost = UnitIsDeadOrGhost

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent)
PlayerAnchor:SetSize(146, 28)
PlayerAnchor:SetPoint(unpack(C["position"].unitframes.player))

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent)
TargetAnchor:SetSize(146, 28)
TargetAnchor:SetPoint(unpack(C["position"].unitframes.target))

local Unitframes = CreateFrame("Frame", "Unitframes", UIParent)
Unitframes:RegisterEvent("ADDON_LOADED")
Unitframes:SetScript("OnEvent", function(self, event, addon)
	if addon == "KkthnxUI" then
		if C["Unitframe"].classhealth ~= true then

			CUSTOM_FACTION_BAR_COLORS = {
				[1] = {r = 255/255, g = 0/255, b = 0/255},
				[2] = {r = 255/255, g = 0/255, b = 0/255},
				[3] = {r = 255/255, g = 255/255, b = 0/255},
				[4] = {r = 255/255, g = 255/255, b = 0/255},
				[5] = {r = 0/255, g = 255/255, b = 0/255},
				[6] = {r = 0/255, g = 255/255, b = 0/255},
				[7] = {r = 0/255, g = 255/255, b = 0/255},
				[8] = {r = 0/255, g = 255/255, b = 0/255},
			}

			hooksecurefunc("UnitFrame_Update", function(self, isParty)
				if not self.name or not self:IsShown() then return end

				local PET_COLOR = {r = 157/255, g = 197/255, b = 255/255}
				local unit, color = self.unit
				if UnitPlayerControlled(unit) then
					if UnitIsPlayer(unit) then
						color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
					else
						color = PET_COLOR
					end
				elseif UnitIsDeadOrGhost(unit) or UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
					color = GRAY_FONT_COLOR
				else
					color = CUSTOM_FACTION_BAR_COLORS[UnitIsEnemy(unit, "player") and 1 or UnitReaction(unit, "player") or 5]
				end

				if not color then
					color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)["PRIEST"]
				end

				self.name:SetTextColor(color.r, color.g, color.b)
				if isParty then
					self.name:SetText(GetUnitName(self.overrideName or unit))
				end
			end)
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
				FrameNames:SetShadowOffset(K.Mult, -K.Mult)
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
				FrameBarText:SetShadowOffset(K.Mult, -K.Mult)
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
				PartyBarText:SetShadowOffset(K.Mult, -K.Mult)
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
				LevelText:SetShadowOffset(K.Mult, -K.Mult)
			end
		end

		-- Tweak Party Frame
		for i = 1, MAX_PARTY_MEMBERS do
			_G["PartyMemberFrame"..i]:SetScale(C["Unitframe"].scale)
		end
		PartyMemberBuffTooltip:Kill() -- I personally hate this shit.

		-- Tweak Player Frame
		PlayerFrame:SetMovable(true)
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3)
		PlayerFrame.SetPoint = K.Noop

		-- Hide Pet Name.
		PetName:Hide()

		-- Tweak Target Frame
		TargetFrame:SetMovable(true)
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3)
		-- Tweak Name Background
		TargetFrameNameBackground:SetTexture(0, 0, 0, 0.01)

		-- Tweak Focus Frame
		FocusFrame:ClearAllPoints()
		FocusFrame:SetPoint(unpack(C["position"].unitframes.focus))
		-- Tweak Name Background
		FocusFrameNameBackground:SetTexture(0, 0, 0, 0.01)

		for _, FrameScale in pairs({
			PlayerFrame,
			TargetFrame,
			FocusFrame,
		}) do
			FrameScale:SetScale(C["Unitframe"].scale)
		end

		-- Tweak Focus Frame
		FocusFrameToT:SetScale(1.0)
		FocusFrameToT:ClearAllPoints()
		FocusFrameToT:SetPoint("TOP", FocusFrame, "BOTTOM", 34, 35)

		-- Arena Frames Scaling
		local function SetArenaFrames()
			for i = 1, MAX_ARENA_ENEMIES do
				_G["ArenaEnemyFrame"..i]:SetScale(C["Unitframe"].scale)
				ArenaEnemyFrames:SetPoint(unpack(C["position"].unitframes.arena))
			end
		end

		if IsAddOnLoaded("Blizzard_ArenaUI") then
			SetArenaFrames()
		else
			local f = CreateFrame("Frame")
			f:RegisterEvent("ADDON_LOADED")
			f:SetScript("OnEvent", function(self, event, addon)
				if addon == "Blizzard_ArenaUI" then
					self:UnregisterEvent(event)
					SetArenaFrames()
				end
			end)
		end

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

		self:UnregisterEvent("ADDON_LOADED")
	end

end)

-- Remove Portrait Damage Spam
if C["Unitframe"].combatfeedback == true then
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = K.Noop
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