local K, C, L = unpack(select(2, ...));
if C["unitframe"].enable ~= true then return end

local KkthnxCB = CreateFrame( "Frame", "Castbars", UIParent );

-- Anchor
local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C["unitframe"].cbscale, CastingBarFrame:GetHeight() * 2)
PlayerCastbarAnchor:SetPoint(unpack(C["position"].playercastbar))

local function MoveCastBar()
	-- Move Cast Bar
	CastingBarFrame:SetMovable(true);
	CastingBarFrame:ClearAllPoints();
	CastingBarFrame:SetScale( C["unitframe"].cbscale );
	CastingBarFrame:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3);
	CastingBarFrame:SetUserPlaced(true);
	CastingBarFrame:SetMovable( false );
	
	-- Icon
	CastingBarFrameIcon:Show();
	CastingBarFrameIcon:SetSize(30, 30);
	CastingBarFrameIcon:ClearAllPoints();
	CastingBarFrameIcon:SetPoint("CENTER", CastingBarFrame, "TOP", 0, 24);
	
	-- Target Castbar
	TargetFrameSpellBar:SetMovable(true);
	TargetFrameSpellBar:ClearAllPoints();
	TargetFrameSpellBar:SetScale( C["unitframe"].cbscale );
	TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, 150);
	TargetFrameSpellBar:SetMovable( false );
	TargetFrameSpellBar.SetPoint = K.Dummy
end

local function Castbars_HandleEvents( self, event, ... )
	
	if( event == "PLAYER_ENTERING_WORLD" ) then
		if(not InCombatLockdown()) then
			MoveCastBar();
		end
	end
end

local function Castbars_Load()
	KkthnxCB:SetScript( "OnEvent", Castbars_HandleEvents );
	KkthnxCB:RegisterEvent( "PLAYER_ENTERING_WORLD" );
end

CastingBarTimer_DisplayString = " (%0.2fs)";

-- Function: Add count down timer to the Cast/Channelling Bar Frame.
function UICastingBarFrame_OnUpdate( self, ... )
	local timerValue	= self.maxValue - self.value;
	local textDisplay	= getglobal(self:GetName().."Text")
	local _, text, displayName;

	if ( self.casting ) then
		_, _, text = UnitCastingInfo(self.unit);
	elseif ( self.channeling ) then
		_, _, text = UnitChannelInfo(self.unit);
		timerValue = self.value;
	end

	if ( text ) then
		displayName = text..CastingBarTimer_DisplayString;
	end

	if (displayName ~= nil) then
		if (timerValue) then
			if (timerValue > 0.01) then
				textDisplay:SetText( format(displayName, timerValue) );
			end
		end
	end
end

-- Function: Add count down timer to the Mirror Bar Frame
function UIMirrorBarFrame_OnUpdate(self, elapsed)
	local text		= _G[self:GetName().."Text"];
	local displayName	= text:GetText();

	if (displayName) then
		local tempName	 = string.gsub(displayName, "(.+)", "");
		tempName	= tempName..CastingBarTimer_DisplayString;

		if ((self.value) and (self.value > 0.01)) then
			text:SetText( format(tempName, self.value) );
		end
	end
end

-- Hook the Blizzard OnUpdate handlers, using hooksecurefunc, reduces the risk of tainting.
hooksecurefunc("CastingBarFrame_OnUpdate", UICastingBarFrame_OnUpdate);
hooksecurefunc("MirrorTimerFrame_OnUpdate", UIMirrorBarFrame_OnUpdate);

-- Blizzard Tradeskills Castbar
-- This will modify the target castbar to also show tradeskills

local enableTradeskills = true

--initial override
if TargetFrameSpellBar then
	TargetFrameSpellBar.showTradeSkills = enableTradeskills
end

--double check the target castbar hasn't lost the tradeskill setting (another mod may change it)
hooksecurefunc("CastingBarFrame_OnEvent", function(self, event, ...)
	if self and self:GetName() == "TargetFrameSpellBar" then
		if TargetFrameSpellBar.showTradeSkills ~= enableTradeskills then
			TargetFrameSpellBar.showTradeSkills = enableTradeskills
		end
	end
end)

-- Run Initialisation
Castbars_Load();