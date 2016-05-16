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
	ReputationWatchBarTexture0,
	ReputationWatchBarTexture1,
}) do
	KillTextures:Kill()
end
-- Hide certain textures.
for _, HideTextures in ipairs({

	ReputationXPBarTexture0,
	ReputationXPBarTexture1,

}) do
	HideTextures:SetAlpha(0)
end