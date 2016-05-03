local K, C, L, _ = unpack(select(2, ...))
if C["minimap"].enable ~= true then return end

local print = print

-- Minimap Farmmode
local farm = false
local minisize = 144
local farmsize = 300
function SlashCmdList.FARMMODE(msg, editbox)
	if farm == false then
		Minimap:SetSize(farmsize, farmsize)
		MinimapAnchor:SetSize(farmsize, farmsize)
		farm = true
		print("|cffffff00Farmmode is now|r |cFF008000enabled|r")
	else
		Minimap:SetSize(minisize, minisize)
		MinimapAnchor:SetSize(minisize, minisize)
		farm = false
		print("|cffffff00Farmmode is now|r |cFFFF0000disabled|r")
	end

	local defaultBlip = "Interface\\Minimap\\ObjectIcons"
	Minimap:SetBlipTexture(defaultBlip)
end
SLASH_FARMMODE1 = "/farmmode"
SLASH_FARMMODE2 = "/fm"