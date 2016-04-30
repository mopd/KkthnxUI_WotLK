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
			-- UNIT FRAMES
			PlayerFrameTexture,
			PlayerFrameAlternateManaBarBorder,
			PlayerFrameAlternateManaBarLeftBorder,
			PlayerFrameAlternateManaBarRightBorder,
			AlternatePowerBarBorder,
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
			select(1, ComboPoint1:GetRegions()),
			select(1, ComboPoint2:GetRegions()),
			select(1, ComboPoint3:GetRegions()),
			select(1, ComboPoint4:GetRegions()),
			select(1, ComboPoint5:GetRegions()),
			CastingBarFrameBorder,
			FocusFrameSpellBarBorder,
			TargetFrameSpellBarBorder,
			SlidingActionBarTexture0,
			SlidingActionBarTexture1,
			MainMenuBarTexture0,
			MainMenuBarTexture1,
			MainMenuBarTexture2,
			MainMenuBarTexture3,
			MainMenuMaxLevelBar1,
			MainMenuMaxLevelBar2,
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
			select(1, TimeManagerClockButton:GetRegions())
		}) do
			v:SetVertexColor(unpack(C["blizzard"].dark_textures_color))
		end

		self:UnregisterEvent("ADDON_LOADED")
		Dark_Textures:SetScript("OnEvent", nil)
	end
end)