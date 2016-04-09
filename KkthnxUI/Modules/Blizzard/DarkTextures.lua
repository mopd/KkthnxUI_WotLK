local K, C, L = unpack(select(2, ...));
if C["blizzard"].dark_textures ~= true then return end

local Dark_Textures = CreateFrame("Frame")
Dark_Textures:RegisterEvent("ADDON_LOADED")

Dark_Textures:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_TimeManager") then
		for i, v in pairs({
			-- UNIT FRAMES
			PlayerFrameTexture,
			TargetFrameTextureFrameTexture,
			PetFrameTexture,
			PartyMemberFrame1Texture,
			PartyMemberFrame2Texture,
			PartyMemberFrame3Texture,
			PartyMemberFrame4Texture,
			PartyMemberFrame1PetFrameTexture,
			PartyMemberFrame2PetFrameTexture,
			PartyMemberFrame3PetFrameTexture,
			PartyMemberFrame4PetFrameTexture,
			FocusFrameTextureFrameTexture,
			TargetFrameToTTextureFrameTexture,
			FocusFrameToTTextureFrameTexture,
			Boss1TargetFrameTextureFrameTexture,
			Boss2TargetFrameTextureFrameTexture,
			Boss3TargetFrameTextureFrameTexture,
			Boss4TargetFrameTextureFrameTexture,
			Boss5TargetFrameTextureFrameTexture,
			Boss1TargetFrameSpellBarBorder,
			Boss2TargetFrameSpellBarBorder,
			Boss3TargetFrameSpellBarBorder,
			Boss4TargetFrameSpellBarBorder,
			Boss5TargetFrameSpellBarBorder,
			RuneButtonIndividual1BorderTexture,
			RuneButtonIndividual2BorderTexture,
			RuneButtonIndividual3BorderTexture,
			RuneButtonIndividual4BorderTexture,
			RuneButtonIndividual5BorderTexture,
			RuneButtonIndividual6BorderTexture,
			PaladinPowerBarBG,
			PaladinPowerBarBankBG,
			CastingBarFrameBorder,
			FocusFrameSpellBarBorder,
			TargetFrameSpellBarBorder,
			--MAIN MENU
			SlidingActionBarTexture0,
			SlidingActionBarTexture1,
			MainMenuBarTexture0,
			MainMenuBarTexture1,
			MainMenuBarTexture2,
			MainMenuBarTexture3,
			MainMenuMaxLevelBar0,
			MainMenuMaxLevelBar1,
			MainMenuMaxLevelBar2,
			MainMenuMaxLevelBar3,
			MainMenuXPBarTextureLeftCap,
			MainMenuXPBarTextureRightCap,
			MainMenuXPBarTextureMid,
			ReputationWatchBarTexture0,
			ReputationWatchBarTexture1,
			ReputationWatchBarTexture2,
			ReputationWatchBarTexture3,
			ReputationXPBarTexture0,
			ReputationXPBarTexture1,
			ReputationXPBarTexture2,
			ReputationXPBarTexture3,
			MainMenuBarLeftEndCap,
			MainMenuBarRightEndCap, 
			StanceBarLeft,
			StanceBarMiddle,
			StanceBarRight,
			--ARENA FRAMES
			ArenaEnemyFrame1Texture,
			ArenaEnemyFrame2Texture,
			ArenaEnemyFrame3Texture, 
			ArenaEnemyFrame4Texture,
			ArenaEnemyFrame5Texture,
			ArenaEnemyFrame1SpecBorder,
			ArenaEnemyFrame2SpecBorder,
			ArenaEnemyFrame3SpecBorder,
			ArenaEnemyFrame4SpecBorder,
			ArenaEnemyFrame5SpecBorder,
			ArenaEnemyFrame1PetFrameTexture,
			ArenaEnemyFrame2PetFrameTexture,
			ArenaEnemyFrame3PetFrameTexture,
			ArenaEnemyFrame4PetFrameTexture, 
			ArenaEnemyFrame5PetFrameTexture,
			ArenaPrepFrame1Texture,
			ArenaPrepFrame2Texture,
			ArenaPrepFrame3Texture,
			ArenaPrepFrame4Texture,
			ArenaPrepFrame5Texture,
			ArenaPrepFrame1SpecBorder,
			ArenaPrepFrame2SpecBorder,
			ArenaPrepFrame3SpecBorder,
			ArenaPrepFrame4SpecBorder,
			ArenaPrepFrame5SpecBorder,
			select(1, TimeManagerClockButton:GetRegions())
		}) do
			v:SetVertexColor(unpack(C["blizzard"].dark_textures_color));
		end
		
		for i,v in pairs({ select(2, TimeManagerClockButton:GetRegions()) }) do
			v:SetVertexColor(1, 1, 1)
		end
		
		self:UnregisterEvent("ADDON_LOADED")
		Dark_Textures:SetScript("OnEvent", nil)
	end
end)