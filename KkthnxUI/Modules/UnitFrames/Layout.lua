local K, C, L, _ = select(2, ...):unpack()
if C["unitframe"].enable ~= true then return end

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
if not InCombatLockdown() then
	PlayerAnchor:SetPoint(unpack(C["position"].playerframe))
end

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent)
TargetAnchor:SetSize(146, 28)
if not InCombatLockdown() then
	TargetAnchor:SetPoint(unpack(C["position"].targetframe))
end

local Unitframes = CreateFrame("Frame", "Unitframes", UIParent)
Unitframes:RegisterEvent("ADDON_LOADED")
Unitframes:SetScript("OnEvent", function(self, event, addon)
	if addon == "KkthnxUI" then
		if C["unitframe"].classhealth ~= true then

			CUSTOM_FACTION_BAR_COLORS = {
				[1] = {r = 1, g = 0, b = 0},
				[2] = {r = 1, g = 0, b = 0},
				[3] = {r = 1, g = 1, b = 0},
				[4] = {r = 1, g = 1, b = 0},
				[5] = {r = 0, g = 1, b = 0},
				[6] = {r = 0, g = 1, b = 0},
				[7] = {r = 0, g = 1, b = 0},
				[8] = {r = 0, g = 1, b = 0},
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
			if C["unitframe"].outline then
				FrameNames:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size, C["font"].unitframes_font_style)
				FrameNames:SetShadowOffset(0, -0)
			else
				FrameNames:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size)
				FrameNames:SetShadowOffset(K.mult, -K.mult)
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
			if C["unitframe"].outline then
				FrameBarText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size * K.mult, C["font"].unitframes_font_style)
				FrameBarText:SetShadowOffset(0, -0)
			else
				FrameBarText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size * K.mult)
				FrameBarText:SetShadowOffset(K.mult, -K.mult)
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
			if C["unitframe"].outline then
				PartyBarText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size - 2, C["font"].unitframes_font_style)
				PartyBarText:SetShadowOffset(0, -0)
			else
				PartyBarText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size - 2)
				PartyBarText:SetShadowOffset(K.mult, -K.mult)
			end
		end

		-- Unit LevelText
		for _, LevelText in pairs({
			PlayerLevelText,
			TargetFrameTextureFrameLevelText,
			FocusFrameTextureFrameLevelText,
		}) do
			if C["unitframe"].outline then
				LevelText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size + 1, C["font"].unitframes_font_style)
				LevelText:SetShadowOffset(0, -0)
			else
				LevelText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size + 1)
				LevelText:SetShadowOffset(K.mult, -K.mult)
			end
		end

		-- Tweak Party Frame
		PartyMemberFrame1:ClearAllPoints()
		for i = 1, MAX_PARTY_MEMBERS do
			_G["PartyMemberFrame"..i]:SetScale(C["unitframe"].scale)
		end
		PartyMemberFrame1:SetPoint(unpack(C["position"].partyframe))

		-- Tweak Player Frame
		PlayerFrame:SetMovable(true)
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3)
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame.SetPoint = K.Dummy
		
		PetName:Hide()

		-- Tweak Target Frame
		TargetFrame:SetMovable(true)
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3)
		TargetFrame:SetUserPlaced(true)
		-- Tweak Name Background
		TargetFrameNameBackground:SetTexture(0, 0, 0, 0.1)

		-- Tweak Focus Frame
		FocusFrame:ClearAllPoints()
		FocusFrame:SetPoint("CENTER", UIParent, "CENTER", -320, 60)
		-- Tweak Name Background
		FocusFrameNameBackground:SetTexture(0, 0, 0, 0.1)

		for _, FrameScale in pairs({
			PlayerFrame,
			TargetFrame,
			FocusFrame,
		}) do
			FrameScale:SetScale(C["unitframe"].scale)
		end

		-- Tweak Focus Frame
		FocusFrameToT:SetScale(1.0)
		FocusFrameToT:ClearAllPoints()
		FocusFrameToT:SetPoint("TOP", FocusFrame, "BOTTOM", 34, 35)

		-- Arena Frames Scaling
		local function ScaleArenaFrames()
			for i = 1, MAX_ARENA_ENEMIES do
				_G["ArenaEnemyFrame"..i]:SetScale(C["unitframe"].scale)
			end
		end

		if IsAddOnLoaded("Blizzard_ArenaUI") then
			ScaleArenaFrames()
		else
			local f = CreateFrame("Frame")
			f:RegisterEvent("ADDON_LOADED")
			f:SetScript("OnEvent", function(self, event, addon)
				if addon == "Blizzard_ArenaUI" then
					self:UnregisterEvent(event)
					ScaleArenaFrames()
				end
			end)
		end

		-- RuneFrame
		if K.Class == "DEATHKNIGHT" then
			RuneFrame:ClearAllPoints()
			RuneFrame:SetPoint("TOPLEFT", PlayerFrameManaBar, "BOTTOMLEFT", -1, -5)
			for i = 1, 6 do
				_G["RuneButtonIndividual"..i]:SetScale(C["unitframe"].scale)
			end
		end

		-- ComboFrame
		if K.Class == "ROGUE" then
			for i = 1, 5 do
				_G["ComboPoint"..i]:SetScale(C["unitframe"].scale)
			end
		end

		self:UnregisterEvent("ADDON_LOADED")
	end

end)

-- Remove Portrait Damage Spam
if C["unitframe"].combatfeedback == true then
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = K.Dummy
end

-- Remove Group Number Frame
if C["unitframe"].groupnumber == true then
	PlayerFrameGroupIndicator.Show = K.Dummy
end