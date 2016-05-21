local K, C, L, _ = select(2, ...):unpack()
if C["unitframe"].enhancedframes ~= true then return end

local _G = _G
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
local MAX_PARTY_MEMBERS = MAX_PARTY_MEMBERS

PlayerFrameTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame")
PlayerStatusTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-Player-Status")
hooksecurefunc("TargetFrame_CheckClassification", function (self, forceNormalTexture)
	local classification = UnitClassification(self.unit);

	if forceNormalTexture then
		self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame");
	elseif classification == "minus" then
		self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Minus");
		self.nameBackground:Hide();
		self.manabar:Hide();
		self.manabar.TextString:Hide();
		forceNormalTexture = true;
	elseif classification == "worldboss" or classification == "elite" then
		self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Elite");
	elseif classification == "rareelite" then
		self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Rare-Elite");
	elseif classification == "rare" then
		self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Rare");
	else
		self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame");
		forceNormalTexture = true;
	end
end)

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

FocusFrameToT:ClearAllPoints()
FocusFrameToT:SetPoint("CENTER", FocusFrame, "CENTER", 60, -45)

--Names
PlayerName:SetAlpha(0)

TargetFrame.name:ClearAllPoints()
TargetFrame.name:SetPoint("CENTER", TargetFrame, "CENTER", -50, 35)
TargetFrame.name.SetPoint = K.Dummy

FocusFrame.name:ClearAllPoints()
FocusFrame.name:SetPoint("CENTER", FocusFrame, "CENTER", -45, 35)
FocusFrame.name.SetPoint = K.Dummy

--Player bars
PlayerFrameHealthBar:SetHeight(27)
PlayerFrameHealthBar:ClearAllPoints()
PlayerFrameHealthBar:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 14)
PlayerFrameHealthBar.SetPoint = K.Dummy

PlayerFrameManaBar:ClearAllPoints()
PlayerFrameManaBar:SetPoint("CENTER", PlayerFrame, "CENTER", 51, -7)
PlayerFrameManaBar.SetPoint = K.Dummy

--Target bars
TargetFrameHealthBar:SetHeight(27)
TargetFrameHealthBar:ClearAllPoints()
TargetFrameHealthBar:SetPoint("CENTER", TargetFrame, "CENTER", -50, 14)
TargetFrameHealthBar.SetPoint = K.Dummy

TargetFrameTextureFrameDeadText:ClearAllPoints()
TargetFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
TargetFrameTextureFrameDeadText.SetPoint = K.Dummy

TargetFrameManaBar:ClearAllPoints()
TargetFrameManaBar:SetPoint("CENTER", TargetFrame, "CENTER", -51, -7)
TargetFrameManaBar.SetPoint = K.Dummy

TargetFrameNumericalThreat:SetScale(0.9)
TargetFrameNumericalThreat:ClearAllPoints()
TargetFrameNumericalThreat:SetPoint("BOTTOM", PlayerFrame, "TOP", 75, -22)
TargetFrameNumericalThreat.SetPoint = K.Dummy

--Focus bars
FocusFrameHealthBar:SetHeight(27)
FocusFrameHealthBar:ClearAllPoints()
FocusFrameHealthBar:SetPoint("CENTER", FocusFrame, "CENTER", -50, 14)
FocusFrameHealthBar.SetPoint = K.Dummy

FocusFrameTextureFrameDeadText:ClearAllPoints()
FocusFrameTextureFrameDeadText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
FocusFrameTextureFrameDeadText.SetPoint = K.Dummy

FocusFrameManaBar:ClearAllPoints()
FocusFrameManaBar:SetPoint("CENTER", FocusFrame, "CENTER", -51, -7)
FocusFrameManaBar.SetPoint = K.Dummy

FocusFrameNumericalThreat:ClearAllPoints()
FocusFrameNumericalThreat:SetPoint("CENTER", FocusFrame, "CENTER", 44, 48)
FocusFrameNumericalThreat.SetPoint = K.Dummy

--Textstrings
TargetFrameHealthBar.TextString:ClearAllPoints()
TargetFrameHealthBar.TextString:SetPoint("CENTER", TargetFrame, "CENTER", -53, 12)
TargetFrameHealthBar.TextString.SetPoint = K.Dummy

PlayerFrameHealthBar.TextString:ClearAllPoints()
PlayerFrameHealthBar.TextString:SetPoint("CENTER", PlayerFrame, "CENTER", 53, 12)
PlayerFrameHealthBar.TextString.SetPoint = K.Dummy

FocusFrameHealthBar.TextString:ClearAllPoints()
FocusFrameHealthBar.TextString:SetPoint("CENTER", FocusFrame, "CENTER", -53, 12)
FocusFrameHealthBar.TextString.SetPoint = K.Dummy

PlayerFrameManaBar.TextString:ClearAllPoints()
PlayerFrameManaBar.TextString:SetPoint("CENTER", PlayerFrame, "CENTER", 53, -7)
PlayerFrameManaBar.TextString.SetPoint = K.Dummy

TargetFrameManaBar.TextString:ClearAllPoints()
TargetFrameManaBar.TextString:SetPoint("CENTER", TargetFrame, "CENTER", -50, -7)
TargetFrameManaBar.TextString.SetPoint = K.Dummy

FocusFrameManaBar.TextString:ClearAllPoints()
FocusFrameManaBar.TextString:SetPoint("CENTER", FocusFrame, "CENTER", -50, -7)
FocusFrameManaBar.TextString.SetPoint = K.Dummy