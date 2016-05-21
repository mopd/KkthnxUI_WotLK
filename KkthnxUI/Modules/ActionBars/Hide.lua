local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true or C["actionbar"].removetextures ~= true then return end

local _G = _G
local ipairs = ipairs

-- Kill certain textures
for _, KillTextures in ipairs({
	MainMenuBarLeftEndCap,
	MainMenuBarRightEndCap,
	MainMenuBarTexture0,
	MainMenuBarTexture1,
	MainMenuMaxLevelBar0,
	MainMenuMaxLevelBar1,
	MainMenuXPBarTexture1,
	MainMenuXPBarTexture2,
	MainMenuXPBarTextureLeftCap,
	MainMenuXPBarTextureMid,
	MainMenuXPBarTextureRightCap,
}) do
	KillTextures:Kill()
end
-- Hide certain textures.
for _, HideTextures in ipairs({
	ExhaustionTick,
	ReputationWatchBarTexture0,
	ReputationWatchBarTexture1,
	ReputationXPBarTexture0,
	ReputationXPBarTexture1,
}) do
	HideTextures:SetAlpha(0)
end

-- Clean up some stuff.
MainMenuBarExpText:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size - 1)
MainMenuBarExpText:SetShadowOffset(K.mult, -K.mult)
MainMenuBarOverlayFrame:SetSize(500, 10)
MainMenuExpBar:SetSize(500, 10)
ReputationWatchBar:SetSize(500, 12)
ReputationWatchStatusBar:SetSize(500, 12)
ReputationWatchStatusBarText:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size - 1)
ReputationWatchStatusBarText:SetShadowOffset(K.mult, -K.mult)