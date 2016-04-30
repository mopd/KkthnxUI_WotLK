local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true or C["actionbar"].removetextures ~= true then return end

local _G = _G
local ipairs = ipairs

for _, KillTextures in ipairs({

	MainMenuMaxLevelBar0,
	MainMenuMaxLevelBar1,
	MainMenuBarRightEndCap,
	MainMenuBarLeftEndCap,
	MainMenuBarTexture0,
	MainMenuBarTexture1,
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

for _, HideTextures in ipairs({

	ReputationXPBarTexture0,
	ReputationXPBarTexture1,

}) do
	HideTextures:SetAlpha(0)
end

for i = 1, 19 do -- Remove EXP Dividers
	local texture = _G["MainMenuXPBarDiv"..i]
	if texture then
		texture:Kill()
	end
end