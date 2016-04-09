local K, C, L = unpack(select(2, ...));
if C["unitframe"].enable ~= true then return end

local Unitframes = CreateFrame("Frame", "Unitframes", UIParent);

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent);
PlayerAnchor:SetSize(146, 28);
if not InCombatLockdown() then
	PlayerAnchor:SetPoint(unpack(C["position"].playerframe));
end

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent);
TargetAnchor:SetSize(146, 28);
if not InCombatLockdown() then
	TargetAnchor:SetPoint(unpack(C["position"].targetframe));
end

if C["unitframe"].betterpowercolor == true then
	PowerBarColor["MANA"] = { r = 0.31, g = 0.45, b = 0.63 };
	PowerBarColor["RAGE"] = { r = 0.69, g = 0.31, b = 0.31 };
	PowerBarColor["FOCUS"] = { r = 0.71, g = 0.43, b = 0.27 };
	PowerBarColor["ENERGY"] = { r = 0.65, g = 0.63, b = 0.35 };
	PowerBarColor["RUNES"] = { r = 0.50, g = 0.57, b = 0.61 };
	PowerBarColor["RUNIC_POWER"] = { r = 0, g = 0.82, b = 1.00 };
	PowerBarColor["AMMOSLOT"] = { r = 0.8, g = 0.6, b = 0};
end

local Unitframes = CreateFrame("Frame")
Unitframes:RegisterEvent("ADDON_LOADED")
Unitframes:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "KkthnxUI" then
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
			
			local PET_COLOR = { r = 157/255, g = 197/255, b = 255/255 }
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
				FrameNames:SetShadowOffset(1, -1)
			end
		end
		
		-- Unit HealthBarText
		for _, FrameBarText in pairs({
			PlayerFrameHealthBarText,
			PlayerFrameManaBarText,
			TargetFrameTextureFrameHealthBarText,
			TargetFrameTextureFrameManaBarText,
			PetFrameHealthBarText,
			PetFrameManaBarText,
		}) do
			if C["unitframe"].outline then
				FrameBarText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size * K.mult, C["font"].unitframes_font_style)
				FrameBarText:SetShadowOffset(0, -0)
			else
				FrameBarText:SetFont(C["font"].unitframes_font, C["font"].unitframes_font_size * K.mult)
				FrameBarText:SetShadowOffset(1, -1)
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
				PartyBarText:SetShadowOffset(1, -1)
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
				LevelText:SetShadowOffset(1, -1)
			end
		end
		
		-- Tweak Party Frame
		for i = 1, MAX_PARTY_MEMBERS do
			_G["PartyMemberFrame"..i]:ClearAllPoints();
			_G["PartyMemberFrame"..i]:SetScale(C["unitframe"].partyscale);
			_G["PartyMemberFrame"..i]:SetPoint(unpack(C["position"].partyframe));
		end
		
		-- Tweak Player Frame
		PlayerFrame:SetMovable(true);
		PlayerFrame:ClearAllPoints();
		PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3);
		PlayerFrame.SetPoint = K.Dummy
		
		-- Tweak Target Frame
		TargetFrame:SetMovable(true);
		TargetFrame:ClearAllPoints();
		TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3);
		-- Tweak Name Background
		TargetFrameNameBackground:SetTexture(0, 0, 0, 0.1);
		
		-- Tweak Focus Frame
		FocusFrame:ClearAllPoints();
		FocusFrame:SetPoint("CENTER", UIParent, "CENTER", -320, 60);
		-- Tweak Name Background
		FocusFrameNameBackground:SetTexture(0, 0, 0, 0.1);
		
		for _, FrameScale in pairs({
			PlayerFrame,
			TargetFrame,
			FocusFrame,
		}) do
			FrameScale:SetScale(C["unitframe"].scale)
		end
		
		-- Tweak Focus Frame
		FocusFrameToT:SetScale(1.0);
		FocusFrameToT:ClearAllPoints();
		FocusFrameToT:SetPoint("TOP", FocusFrame, "BOTTOM", 34, 35);
		
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