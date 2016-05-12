local K, C, L, _ = unpack(select(2, ...))
if C["blizzard"].dark_textures ~= true then return end

local pairs = pairs
local select = select
local unpack = unpack
local CreateFrame = CreateFrame
local GetRegions = GetRegions

local Dark_Textures = CreateFrame("Frame")
Dark_Textures:RegisterEvent("ADDON_LOADED")
Dark_Textures:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_TimeManager") then
		for i, v in pairs({
			Boss1TargetFrameSpellBarBorder,
			Boss1TargetFrameTextureFrameTexture,
			Boss2TargetFrameSpellBarBorder,
			Boss2TargetFrameTextureFrameTexture,
			Boss3TargetFrameSpellBarBorder,
			Boss3TargetFrameTextureFrameTexture,
			Boss4TargetFrameSpellBarBorder,
			Boss4TargetFrameTextureFrameTexture,
			Boss5TargetFrameSpellBarBorder,
			Boss5TargetFrameTextureFrameTexture,
			CastingBarFrameBorder,
			FocusFrameSpellBarBorder,
			FocusFrameTextureFrameTexture,
			FocusFrameToTTextureFrameTexture,
			MainMenuBarLeftEndCap,
			MainMenuBarRightEndCap,
			MainMenuBarTexture0,
			MainMenuBarTexture1,
			MainMenuBarTexture2,
			MainMenuBarTexture3,
			MainMenuMaxLevelBar0,
			MainMenuMaxLevelBar1,
			MainMenuMaxLevelBar2,
			MainMenuXPBarTexture1,
			MainMenuXPBarTexture2,
			MainMenuXPBarTextureLeftCap,
			MainMenuXPBarTextureMid,
			MainMenuXPBarTextureRightCap,
			PartyMemberFrame1PetFrameTexture,
			PartyMemberFrame1Texture,
			PartyMemberFrame2PetFrameTexture,
			PartyMemberFrame2Texture,
			PartyMemberFrame3PetFrameTexture,
			PartyMemberFrame3Texture,
			PartyMemberFrame4PetFrameTexture,
			PartyMemberFrame4Texture,
			PetFrameTexture,
			PlayerFrameAlternateManaBarBorder,
			PlayerFrameAlternateManaBarLeftBorder,
			PlayerFrameAlternateManaBarRightBorder,
			PlayerFrameTexture,
			ReputationWatchBarTexture0,
			ReputationWatchBarTexture1,
			ReputationWatchBarTexture2,
			ReputationWatchBarTexture3,
			ReputationXPBarTexture0,
			ReputationXPBarTexture1,
			ReputationXPBarTexture2,
			ReputationXPBarTexture3,
			SlidingActionBarTexture0,
			SlidingActionBarTexture1,
			StanceBarLeft,
			StanceBarMiddle,
			StanceBarRight,
			TargetFrameSpellBarBorder,
			TargetFrameTextureFrameTexture,
			TargetFrameToTTextureFrameTexture,
			select(1, ComboPoint1:GetRegions()),
			select(1, ComboPoint2:GetRegions()),
			select(1, ComboPoint3:GetRegions()),
			select(1, ComboPoint4:GetRegions()),
			select(1, ComboPoint5:GetRegions()),
		}) do
			v:SetVertexColor(unpack(C["blizzard"].dark_textures_color))
		end

		self:UnregisterEvent("ADDON_LOADED")
		Dark_Textures:SetScript("OnEvent", nil)
	end
end)