local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

local Unitframes = CreateFrame("Frame", "KkthnxUF", UIParent)

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent)
PlayerAnchor:SetSize(146, 28)
PlayerAnchor:SetPoint(unpack(C.position.playerframe))

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent)
TargetAnchor:SetSize(146, 28)
TargetAnchor:SetPoint(unpack(C.position.targetframe))

local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C.unitframe.cbscale, CastingBarFrame:GetHeight() * 2)
PlayerCastbarAnchor:SetPoint(unpack(C.position.playercastbar))

PowerBarColor["MANA"] = { r = 0.31, g = 0.45, b = 0.63 }
PowerBarColor["RAGE"] = { r = 0.78, g = 0.25, b = 0.25 }
PowerBarColor["FOCUS"] = { r = 0.71, g = 0.43, b = 0.27 }
PowerBarColor["ENERGY"] = { r = 0.65, g = 0.63, b = 0.35 }
PowerBarColor["RUNIC_POWER"] = { r = 0, g = 0.82, b = 1.00 }

local Unitframes = CreateFrame("Frame")
Unitframes:RegisterEvent("ADDON_LOADED")
Unitframes:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "KkthnxUI" then	
		
		-- Unit Font Color
		if C.unitframe.classhealth == false then
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
		
		-- Unit Name Background Color
		for _, NameBG in pairs({
			TargetFrameNameBackground,
			FocusFrameNameBackground,
			Boss1TargetFrameNameBackground, 
			Boss2TargetFrameNameBackground, 
			Boss3TargetFrameNameBackground, 
			Boss4TargetFrameNameBackground,
			Boss5TargetFrameNameBackground, 
			
		}) do
			NameBG:SetTexture(0, 0, 0, 0.1)
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
			FrameBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 2)
			FrameBarText:SetShadowOffset(1, -1)
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
			PartyMemberFrame5HealthBarText,
			PartyMemberFrame5ManaBarText,
		}) do
			PartyBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 3)
			PartyBarText:SetShadowOffset(1, -1)
		end
		
		-- Unit LevelText
		for _, LevelText in pairs({
			PlayerLevelText,
			TargetFrameTextureFrameLevelText,
		}) do
			LevelText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size + 1)
			LevelText:SetShadowOffset(1, -1)
		end
		
		-- Tweak Party Frame
		PartyMemberFrame1:ClearAllPoints();
		PartyMemberFrame1:SetPoint("LEFT" , 120, 125);
		for i = 1, MAX_PARTY_MEMBERS do
			_G["PartyMemberFrame"..i]:SetScale(C.unitframe.partyscale)
		end
		
		-- Tweak Player Frame
		PlayerFrame:SetMovable(true)
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetScale(C.unitframe.scale)
		PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3)
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame:SetMovable(false)
		
		-- Tweak Target Frame
		TargetFrame:SetMovable(true)
		TargetFrame:ClearAllPoints()
		TargetFrame:SetScale(C.unitframe.scale)
		TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3)
		TargetFrame:SetUserPlaced(true)
		TargetFrame:SetMovable(false)
		--TargetFrame.buffsOnTop = true;
		
		-- Tweak Focus Frame
		FocusFrame:SetMovable(true)
		FocusFrame:ClearAllPoints()
		FocusFrame:SetScale(C.unitframe.scale)
		FocusFrame:SetPoint("TOP", PlayerFrame, "TOP", -80, 180)
		FocusFrame:SetUserPlaced(true)
		FocusFrame:SetMovable(false)
		
		-- Move Cast Bar
		CastingBarFrame:SetMovable(true)
		CastingBarFrame:ClearAllPoints()
		CastingBarFrame:SetScale(C.unitframe.cbscale)
		CastingBarFrame:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3)
		CastingBarFrame:SetUserPlaced(true)
		CastingBarFrame:SetMovable(false)
		
		-- Player Castbar Icon
		CastingBarFrameIcon:Show()
		CastingBarFrameIcon:SetSize(30, 30)
		CastingBarFrameIcon:ClearAllPoints()
		CastingBarFrameIcon:SetPoint("CENTER", CastingBarFrame, "TOP", 0, 24)
		
		-- Target Castbar
		TargetFrameSpellBar:ClearAllPoints()
		TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, 150)
		TargetFrameSpellBar.SetPoint = K.Dummy
		TargetFrameSpellBar:SetScale(C.unitframe.cbscale)
		
		-- Casting Timer
		CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil)
		CastingBarFrame.timer:SetFont(C.font.basic_font, C.font.basic_font_size + 1)
		CastingBarFrame.timer:SetShadowOffset(1, -1)
		CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, -3)
		CastingBarFrame.updateDelay = 0.1;
		
		-- Class Portaraits
		hooksecurefunc("UnitFramePortrait_Update", function(self)
			if(C.unitframe.classicon == true) then
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
			end
		end)
		
		-- ClassColor Bars
		if (C.unitframe.classhealth == true) then
			local UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS =
			UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS
			local _, class, c
			
			local function colour(statusbar, unit)
				if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
					_, class = UnitClass(unit)
					c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
					statusbar:SetStatusBarColor(c.r, c.g, c.b)
				end
			end
			
			hooksecurefunc("UnitFrameHealthBar_Update", colour)
			hooksecurefunc("HealthBar_OnValueChanged", function(self)
				colour(self, self.unit)
			end)
		end
		
		-- Remove Portrait Damage Spam
		if(C.unitframe.combatfeedback == true) then
			PlayerHitIndicator:SetText(nil)
			PlayerHitIndicator.SetText = K.Dummy
		end
		
		-- Remove Group Number Frame
		if(C.unitframe.groupnumber == true) then
			PlayerFrameGroupIndicator.Show = K.Dummy
		end
		
		-- Casting Bar Update
		function CastingUpdate(self, elapsed)
			if(not self.timer) then
				return;
			end
			if(self.updateDelay) and (self.updateDelay < elapsed) then
				self:SetStatusBarColor(K.Color.r, K.Color.g, K.Color.b)
				if(self.casting) then
					self.timer:SetText(format("%2.1f / %1.1f", max(self.maxValue - self.value, 0), self.maxValue))
				elseif(self.channeling) then
					self.timer:SetText(format("%.1f", max(self.value, 0)))
				else
					self.timer:SetText("")
				end
				self.updateDelay = 0.1;
			else
				self.updateDelay = self.updateDelay - elapsed;
			end
		end
		do
			hooksecurefunc("CastingBarFrame_OnUpdate", CastingUpdate)
		end
	end
end)