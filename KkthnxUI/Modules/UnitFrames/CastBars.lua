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
	
	-- Casting Timer
	CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil);
	CastingBarFrame.timer:SetFont(C["font"].basic_font, C["font"].basic_font_size + 1);
	CastingBarFrame.timer:SetShadowOffset(1, -1)
	CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, -2);
	CastingBarFrame.updateDelay = 0.1;
	
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
	
	-- Target Casting Timer
	TargetFrameSpellBar.timer = TargetFrameSpellBar:CreateFontString(nil)
	TargetFrameSpellBar.timer:SetFont(C["font"].basic_font, C["font"].basic_font_size + 1)
	TargetFrameSpellBar.timer:SetShadowOffset(1, -1)
	TargetFrameSpellBar.timer:SetPoint("TOP", TargetFrameSpellBar, "BOTTOM", 0, -2)
	TargetFrameSpellBar.updateDelay = 0.1;
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

-- Casting Bar Update
function CastingUpdate(self, elapsed)
	if( not self.timer ) then
		return;
	end
	if( self.updateDelay ) and (self.updateDelay < elapsed ) then
		if( self.casting ) then
			self.timer:SetText( format( "%2.1f / %1.1f", max( self.maxValue - self.value, 0), self.maxValue ));
		elseif( self.channeling ) then
			self.timer:SetText( format( "%.1f", max( self.value, 0 )));
		else
			self.timer:SetText("");
		end
		self.updateDelay = 0.1;
	else
		self.updateDelay = self.updateDelay - elapsed;
	end
end

do
	hooksecurefunc("CastingBarFrame_OnUpdate", CastingUpdate);
end

-- Run Initialisation
Castbars_Load();