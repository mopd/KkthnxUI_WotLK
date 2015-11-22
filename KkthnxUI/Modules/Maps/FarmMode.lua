local K, C, L = unpack(select(2, ...));
if C["minimap"].enable ~= true then return end

-- Minimap Farmmode
local farm = false
local minisize = 144
local farmsize = 300
function SlashCmdList.FARMMODE(msg, editbox)
	if farm == false then
		Minimap:SetSize(farmsize, farmsize)
		MinimapAnchor:SetSize(farmsize, farmsize)
		farm = true
		print("Farm Mode : On")
	else
		Minimap:SetSize(minisize, minisize)
		MinimapAnchor:SetSize(minisize, minisize)
		farm = false
		print("Farm Mode : Off")
	end
	
	local defaultBlip = "Interface\\Minimap\\ObjectIcons"
	Minimap:SetBlipTexture(defaultBlip)
end
SLASH_FARMMODE1 = "/farmmode"