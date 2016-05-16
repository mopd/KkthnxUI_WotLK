local K, C, L, _ = select(2, ...):unpack()
if C["unitframe"].enhancedframes ~= true then return end

local _G = _G
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
local InCombatLockdown = InCombatLockdown
local UnitClassification = UnitClassification
local MAX_PARTY_MEMBERS = MAX_PARTY_MEMBERS

local EnhancedFrames = CreateFrame("Frame", "EnhancedFrames", UIParent)
function EnhancedFrames:SetupFrames()
	hooksecurefunc("PlayerFrame_ToPlayerArt", EnhancedFrames_PlayerFrame_ToPlayerArt)
	hooksecurefunc("PlayerFrame_ToVehicleArt", EnhancedFrames_PlayerFrame_ToVehicleArt)
	hooksecurefunc("TargetFrame_CheckClassification", EnhancedFrames_TargetFrame_CheckClassification)
	hooksecurefunc("BossTargetFrame_OnLoad", EnhancedFrames_BossTargetFrame_Style)
	EnhancedFrames_Style_PlayerFrame()
	EnhancedFrames_BossTargetFrame_Style(Boss1TargetFrame)
	EnhancedFrames_BossTargetFrame_Style(Boss2TargetFrame)
	EnhancedFrames_BossTargetFrame_Style(Boss3TargetFrame)
	EnhancedFrames_BossTargetFrame_Style(Boss4TargetFrame)
	EnhancedFrames_Style_TargetFrame(TargetFrame)
	EnhancedFrames_Style_FocusFrame(FocusFrame)
	EnhancedFrames_Style_PartyFrames(PartyFrames)
end

function EnhancedFrames_Style_PlayerFrame()
	if not InCombatLockdown() then
		PlayerFrameHealthBar:SetHeight(29)
		PlayerFrameHealthBar:SetPoint("TOPLEFT",106,-22)
		PlayerFrameHealthBarText:ClearAllPoints()
		PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, "CENTER", 0, 0)
		PlayerName:SetAlpha(0)
	end
	PlayerFrameTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame")
	PlayerStatusTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-Player-Status")
end

function EnhancedFrames_Style_PartyFrames()
	if not InCombatLockdown() then
		for i = 1, MAX_PARTY_MEMBERS do
			_G["PartyMemberFrame"..i.."HealthBar"]:SetHeight(12)
			_G["PartyMemberFrame"..i.."HealthBar"]:SetPoint("TOPLEFT", 46, -13)
			_G["PartyMemberFrame"..i.."ManaBar"]:SetPoint("TOPLEFT", 46, -25)
			_G["PartyMemberFrame"..i.."Texture"]:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-PartyFrame")
			_G["PartyMemberFrame"..i.."Flash"]:Kill() -- For now until I figure out what to do with this.
			_G["PartyMemberFrame"..i.."HealthBarText"]:ClearAllPoints()
			_G["PartyMemberFrame"..i.."HealthBarText"]:SetPoint("CENTER", _G["PartyMemberFrame"..i], "CENTER", 18, 9)
			_G["PartyMemberFrame"..i.."ManaBarText"]:ClearAllPoints()
			_G["PartyMemberFrame"..i.."ManaBarText"]:SetPoint("CENTER", _G["PartyMemberFrame"..i], "CENTER", 18, -1)
		end
	end
end

function EnhancedFrames_Style_TargetFrame(self)
	local classification = UnitClassification(self.unit)
	if(classification == "minus") then
		self.healthbar:SetHeight(12)
		self.healthbar:SetPoint("TOPLEFT",7,-41)
		self.healthbar.TextString:SetPoint("CENTER",-50,4)
		self.deadText:SetPoint("CENTER",-50,4)
		self.Background:SetPoint("TOPLEFT",7,-41)
	else
		self.healthbar:SetHeight(29)
		self.healthbar:SetPoint("TOPLEFT",7,-22)
		self.healthbar.TextString:SetPoint("CENTER",-50,6)
		self.deadText:SetPoint("CENTER",-50,6)
		self.nameBackground:Hide()
	end
	TargetFrameTextureFrameHealthBarText:ClearAllPoints()
	TargetFrameTextureFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
	TargetFrameTextureFrameName:ClearAllPoints()
	TargetFrameTextureFrameName:SetPoint("BOTTOMRIGHT", TargetFrame, "TOP", 0, -19)
	TargetFrame.deadText:ClearAllPoints()
	TargetFrame.deadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
	TargetFrame.threatNumericIndicator:SetPoint("BOTTOM", PlayerFrame, "TOP", 75, -22)
end

function EnhancedFrames_Style_FocusFrame(self)
	local classification = UnitClassification(self.unit)
	if(classification == "minus") then
		self.healthbar:SetHeight(12)
		self.healthbar:SetPoint("TOPLEFT", 7, -41)
		self.healthbar.TextString:SetPoint("CENTER", -50, 4)
		self.deadText:SetPoint("CENTER", -50, 4)
		self.Background:SetPoint("TOPLEFT", 7, -41)
	else
		self.healthbar:SetHeight(29)
		self.healthbar:SetPoint("TOPLEFT", 7, -22)
		self.healthbar.TextString:SetPoint("CENTER",-50,6)
		self.deadText:SetPoint("CENTER", -50, 6)
		self.nameBackground:Hide()
	end
	-- Focus Frame
	FocusFrameTextureFrameName:ClearAllPoints()
	FocusFrameTextureFrameName:SetPoint("BOTTOMRIGHT", FocusFrame, "TOP", 10, -20)
	FocusFrameTextureFrameHealthBarText:ClearAllPoints()
	FocusFrameTextureFrameHealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
	FocusFrame.deadText:ClearAllPoints()
	FocusFrame.deadText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
	FocusFrameTextureFrameTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame")
end

function EnhancedFrames_BossTargetFrame_Style(self)
	self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-UnitFrame-Boss")
	EnhancedFrames_Style_TargetFrame(self)
end

function EnhancedFrames_PlayerFrame_ToPlayerArt(self)
	if not InCombatLockdown() then
		EnhancedFrames_Style_PlayerFrame()
	end
end

function EnhancedFrames_PlayerFrame_ToVehicleArt(self)
	if not InCombatLockdown() then
		PlayerFrameHealthBar:SetHeight(12)
		PlayerFrameHealthBarText:SetPoint("CENTER", 50, 3)
	end
end

function EnhancedFrames_TargetFrame_CheckClassification(self, forceNormalTexture)
	local texture
	local classification = UnitClassification(self.unit)
	if(classification == "worldboss" or classification == "elite" ) then
		texture = "Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Elite"
	elseif(classification == "rareelite" ) then
		texture = "Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Rare-Elite"
	elseif(classification == "rare" ) then
		texture = "Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Rare"
	end
	if(texture and not forceNormalTexture) then
		self.borderTexture:SetTexture(texture)
	else
		if(not(classification == "minus") ) then
			self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame")
		end
	end
	self.nameBackground:Hide()
end

function EnhancedFrames:Load()
	EnhancedFrames:SetupFrames()
end

EnhancedFrames:Load()