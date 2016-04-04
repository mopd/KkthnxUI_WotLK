local K, C, L = unpack(select(2, ...));
if C["blizzard"].dark_textures ~= true then return end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, addon)
        if (addon == "Blizzard_TimeManager") then
                for i, v in pairs({PlayerFrameTexture, TargetFrameTextureFrameTexture, PetFrameTexture, PartyMemberFrame1Texture, PartyMemberFrame2Texture, PartyMemberFrame3Texture, PartyMemberFrame4Texture,
                        PartyMemberFrame1PetFrameTexture, PartyMemberFrame2PetFrameTexture, PartyMemberFrame3PetFrameTexture, PartyMemberFrame4PetFrameTexture, FocusFrameTextureFrameTexture,
                        TargetFrameToTTextureFrameTexture, FocusFrameToTTextureFrameTexture, BonusActionBarFrameTexture0, BonusActionBarFrameTexture1, BonusActionBarFrameTexture2, BonusActionBarFrameTexture3,
                        BonusActionBarFrameTexture4, MainMenuBarTexture0, MainMenuBarTexture1, MainMenuBarTexture2, MainMenuMaxLevelBar0, MainMenuMaxLevelBar1, MainMenuMaxLevelBar2,
                        MainMenuMaxLevelBar3, MinimapBorder, CastingBarFrameBorder, FocusFrameSpellBarBorder, TargetFrameSpellBarBorder, MiniMapTrackingButtonBorder, MiniMapLFGFrameBorder, MiniMapBattlefieldBorder,
                        MiniMapMailBorder, MinimapBorderTop,
                        select(1, TimeManagerClockButton:GetRegions())
                }) do
			v:SetVertexColor(unpack(C["blizzard"].dark_textures_color));
		end

		for i,v in pairs({ select(2, TimeManagerClockButton:GetRegions()) }) do
			v:SetVertexColor(1, 1, 1)
		end

		self:UnregisterEvent("ADDON_LOADED")
		frame:SetScript("OnEvent", nil)
	end
end)

for i, v in pairs({ MainMenuBarLeftEndCap, MainMenuBarRightEndCap }) do
	v:SetVertexColor(unpack(C["blizzard"].dark_textures_color));
end