local K, C, L = unpack(select(2, ...));
if C["unitframe"].enable ~= true or C["unitframe"].bigframes ~= true then return end

-- Create the addon main instance
local BigFrames = CreateFrame("Frame", "BigFrames", UIParent);

-- Event listener to make sure we enable the addon at the right time
function BigFrames:PLAYER_ENTERING_WORLD()
	EnableUnitFramesImproved();
end

function EnableUnitFramesImproved()
	
	-- Hook PlayerFrame functions
	hooksecurefunc("PlayerFrame_ToPlayerArt", BigFrames_PlayerFrame_ToPlayerArt);
	hooksecurefunc("PlayerFrame_ToVehicleArt", BigFrames_PlayerFrame_ToVehicleArt);
	
	hooksecurefunc("TargetFrame_CheckClassification", BigFrames_TargetFrame_CheckClassification);
	
	-- BossFrame hooks
	hooksecurefunc("BossTargetFrame_OnLoad", BigFrames_BossTargetFrame_Style);
	
	-- Set up some stylings
	BigFrames_Style_PlayerFrame();
	BigFrames_BossTargetFrame_Style(Boss1TargetFrame);
	BigFrames_BossTargetFrame_Style(Boss2TargetFrame);
	BigFrames_BossTargetFrame_Style(Boss3TargetFrame);
	BigFrames_BossTargetFrame_Style(Boss4TargetFrame);
	BigFrames_Style_TargetFrame(TargetFrame);
	BigFrames_Style_TargetFrame(FocusFrame);
end

function BigFrames_Style_PlayerFrame()
	if not InCombatLockdown() then 
		PlayerFrameHealthBar:SetWidth(119);
		PlayerFrameHealthBar:SetHeight(29);
		PlayerFrameHealthBar:SetPoint("TOPLEFT",106,-22);
		PlayerFrameHealthBarText:SetPoint("CENTER",50,6);
	end
	
	PlayerFrameTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame");
	PlayerStatusTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-Player-Status");
end

function BigFrames_Style_TargetFrame(self)
	--if not InCombatLockdown() then
		local classification = UnitClassification(self.unit);
		if (classification == "minus") then
			self.healthbar:SetHeight(12);
			self.healthbar:SetPoint("TOPLEFT",7,-41);
			self.healthbar.TextString:SetPoint("CENTER",-50,4);
			self.deadText:SetPoint("CENTER",-50,4);
			self.Background:SetPoint("TOPLEFT",7,-41);
		else
			self.healthbar:SetHeight(29);
			self.healthbar:SetPoint("TOPLEFT",7,-22);
			self.healthbar.TextString:SetPoint("CENTER",-50,6);
			self.deadText:SetPoint("CENTER",-50,6);
			self.nameBackground:Hide();
		end
		
		self.healthbar:SetWidth(119);
end

function BigFrames_BossTargetFrame_Style(self)
	self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-UnitFrame-Boss");

	BigFrames_Style_TargetFrame(self);
end

function BigFrames_PlayerFrame_ToPlayerArt(self)
	if not InCombatLockdown() then
		BigFrames_Style_PlayerFrame();
	end
end

function BigFrames_PlayerFrame_ToVehicleArt(self)
	if not InCombatLockdown() then
		PlayerFrameHealthBar:SetHeight(12);
		PlayerFrameHealthBarText:SetPoint("CENTER",50,3);
	end
end


function BigFrames_TargetFrame_CheckClassification(self, forceNormalTexture)
	local texture;
	local classification = UnitClassification(self.unit);
	if ( classification == "worldboss" or classification == "elite" ) then
		texture = "Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Elite";
	elseif ( classification == "rareelite" ) then
		texture = "Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Rare-Elite";
	elseif ( classification == "rare" ) then
		texture = "Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame-Rare";
	end
	if ( texture and not forceNormalTexture) then
		self.borderTexture:SetTexture(texture);
	else
		if ( not (classification == "minus") ) then
			self.borderTexture:SetTexture("Interface\\Addons\\KkthnxUI\\Media\\Unitframes\\UI-TargetingFrame");
		end
	end
	
	self.nameBackground:Hide();
end

-- Bootstrap
function BigFrames_StartUp(self)
	self:SetScript('OnEvent', function(self, event) self[event](self) end);
	self:RegisterEvent('PLAYER_ENTERING_WORLD');
end

BigFrames_StartUp(BigFrames);
