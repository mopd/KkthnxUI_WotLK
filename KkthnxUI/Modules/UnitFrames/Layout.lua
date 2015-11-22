local K, C, L = unpack(select(2, ...));
if C["unitframe"].enable ~= true then return end

local KkthnxUF = CreateFrame( "Frame", "Unitframes", UIParent );

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent);
PlayerAnchor:SetSize(146, 28);
PlayerAnchor:SetPoint(unpack(C["position"].playerframe));

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent);
TargetAnchor:SetSize(146, 28);
TargetAnchor:SetPoint(unpack(C["position"].targetframe));

local function SetUnitFrames()
	
	-- Tweak Party Frame
	PartyMemberFrame1:ClearAllPoints();
	PartyMemberFrame1:SetScale( C["unitframe"].partyscale );
	PartyMemberFrame2:SetScale( C["unitframe"].partyscale );
	PartyMemberFrame3:SetScale( C["unitframe"].partyscale );
	PartyMemberFrame4:SetScale( C["unitframe"].partyscale );
	PartyMemberFrame1:SetPoint(unpack(C["position"].partyframe));
	
	-- Tweak Player Frame
	PlayerFrame:SetMovable( true );
	PlayerFrame:ClearAllPoints();
	PlayerFrame:SetScale(C["unitframe"].scale);
	PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3);
	PlayerFrame:SetUserPlaced(true);
	PlayerFrame:SetMovable( false );
	
	-- Tweak Target Frame
	TargetFrame:SetMovable( true );
	TargetFrame:ClearAllPoints();
	TargetFrame:SetScale(C["unitframe"].scale);
	TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3);
	TargetFrame:SetUserPlaced(true);
	TargetFrame:SetMovable( false );
	TargetFrame.buffsOnTop = true;
	-- Tweak Name Background
	TargetFrameNameBackground:SetTexture(0, 0, 0, 0.1)
	
	-- Tweak Focus Frame
	FocusFrame:SetMovable( true );
	FocusFrame:ClearAllPoints();
	FocusFrame:SetScale(C["unitframe"].scale);
	FocusFrame:SetPoint("TOP", PlayerFrame, "TOP", -80, 180);
	FocusFrame:SetUserPlaced( true );
	FocusFrame:SetMovable( false );
	
end

local function UnitFrames_HandleEvents( self, event, ... )
	
	if( event == "PLAYER_ENTERING_WORLD" ) then
		if(not InCombatLockdown()) then
			SetUnitFrames();
		end
	end
	
	if( event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" ) then
		if(not InCombatLockdown()) then
			if( UnitControllingVehicle("player") or UnitHasVehiclePlayerFrameUI("player") ) then
				SetUnitFrames();
			end
		end
	end
end

local function UnitFrames_Load()
	KkthnxUF:SetScript( "OnEvent", UnitFrames_HandleEvents );
	
	KkthnxUF:RegisterEvent( "PLAYER_ENTERING_WORLD" );
	KkthnxUF:RegisterEvent( "UNIT_EXITED_VEHICLE" );
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

-- Run Initialisation
UnitFrames_Load();