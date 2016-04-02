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

RAID_CLASS_COLORS['PRIEST'] = { r = 220/255, g = 235/255, b = 250/255, colorStr = "ffdcebfa" } -- custom class color for priest.

if C.unitframe.betterpowercolor == true then
	PowerBarColor = {};
	PowerBarColor["MANA"] = { r = 0.31, g = 0.45, b = 0.63 };
	PowerBarColor["RAGE"] = { r = 0.78, g = 0.25, b = 0.25 };
	PowerBarColor["FOCUS"] = { r = 0.71, g = 0.43, b = 0.27 };
	PowerBarColor["ENERGY"] = { r = 0.65, g = 0.63, b = 0.35 };
	PowerBarColor["RUNES"] = { r = 0.50, g = 0.50, b = 0.50 };
	PowerBarColor["RUNIC_POWER"] = { r = 0, g = 0.82, b = 1.00 };
end

local function SetUnitFrames()
	
	-- Unit Name
	for _, FrameNames in pairs({
		PlayerName,
		TargetFrameTextureFrameName,
		FocusFrameTextureFrameName,
	}) do
		if C["unitframe"].outline then
			FrameNames:SetFont(C.font.unitframes_font, C.font.unitframes_font_size, C.font.unitframes_font_style)
			FrameNames:SetShadowOffset(0, -0)
		else
			FrameNames:SetFont(C.font.unitframes_font, C.font.unitframes_font_size)
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
			FrameBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 1, C.font.unitframes_font_style)
			FrameBarText:SetShadowOffset(0, -0)
		else
			FrameBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 1)
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
			PartyBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 2, C.font.unitframes_font_style)
			PartyBarText:SetShadowOffset(0, -0)
		else
			PartyBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 2)
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
			LevelText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size + 1, C.font.unitframes_font_style)
			LevelText:SetShadowOffset(0, -0)
		else
			LevelText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size + 1)
			LevelText:SetShadowOffset(1, -1)
		end
	end
	
	-- Tweak Party Frame
	PartyMemberFrame1:ClearAllPoints();
	PartyMemberFrame1:SetScale(C["unitframe"].partyscale);
	PartyMemberFrame2:SetScale(C["unitframe"].partyscale);
	PartyMemberFrame3:SetScale(C["unitframe"].partyscale);
	PartyMemberFrame4:SetScale(C["unitframe"].partyscale);
	PartyMemberFrame1:SetPoint(unpack(C["position"].partyframe));
	
	-- Tweak Player Frame
	PlayerFrame:ClearAllPoints();
	PlayerFrame:SetScale(C["unitframe"].scale);
	PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3);
	PlayerFrame.SetPoint = K.Dummy
	
	-- Tweak Target Frame
	TargetFrame:ClearAllPoints();
	TargetFrame:SetScale(C["unitframe"].scale);
	TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3);
	--TargetFrame.buffsOnTop = true;
	-- Tweak Name Background
	TargetFrameNameBackground:SetTexture(0, 0, 0, 0.1)
	
	-- Tweak Focus Frame
	FocusFrame:SetScale(C["unitframe"].scale);
	FocusFrame:ClearAllPoints();
	FocusFrame:SetPoint("CENTER", UIParent, "CENTER", -320, 60);
	-- Tweak Name Background
	FocusFrameNameBackground:SetTexture(0, 0, 0, 0.1)
	
	-- Tweak Focus Frame
	FocusFrameToT:SetScale(1.0);
	FocusFrameToT:ClearAllPoints();
	FocusFrameToT:SetPoint("TOP", FocusFrame, "BOTTOM", 34, 35);
end

local function UnitFrames_HandleEvents(self, event, ...)
	
	if event == "PLAYER_ENTERING_WORLD" then
		--if(InCombatLockdown() == false) then 
		SetUnitFrames();
		--end
	end
	
	if(event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE") then
		--if(InCombatLockdown() == false)then
		if(UnitControllingVehicle("player") or UnitInVehicle("player")) then
			SetUnitFrames();
		end
		--end
	end
end

local function UnitFrames_Load()
	Unitframes:SetScript("OnEvent", UnitFrames_HandleEvents);
	
	Unitframes:RegisterEvent("PLAYER_ENTERING_WORLD");
	Unitframes:RegisterEvent("UNIT_EXITED_VEHICLE");
end

-- Remove Portrait Damage Spam
if C["unitframe"].combatfeedback == true then
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = K.Dummy
end

-- Remove Group Number Frame
if C["unitframe"].groupnumber == true then
	PlayerFrameGroupIndicator.Show = K.Dummy
end

-- Run
UnitFrames_Load();