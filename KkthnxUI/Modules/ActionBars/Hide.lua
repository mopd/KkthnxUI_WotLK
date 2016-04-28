local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true then return end

local _G = _G

if C["actionbar"].removetextures then
	MainMenuBarRightEndCap:Kill();
	MainMenuBarLeftEndCap:Kill();
	MainMenuBarTexture0:Kill();
	MainMenuBarTexture1:Kill();
	MainMenuXPBarTexture0:Kill();
	MainMenuXPBarTexture1:Kill();
	MainMenuXPBarTexture2:Kill();
	
	for i = 1, 19 do -- Remove EXP Dividers
		local texture = _G["MainMenuXPBarDiv"..i]
		if texture then
			texture:Kill()
		end
	end
end