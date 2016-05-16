local K, C, L, _ = select(2, ...):unpack()
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
		K.Print("|cffffe02eFarmmode is now|r |cFF008000enabled|r")
	else
		Minimap:SetSize(minisize, minisize)
		MinimapAnchor:SetSize(minisize, minisize)
		farm = false
		K.Print("|cffffe02eFarmmode is now|r |cFFFF0000disabled|r")
	end

	local defaultBlip = "Interface\\Minimap\\ObjectIcons"
	Minimap:SetBlipTexture(defaultBlip)
end
SLASH_FARMMODE1 = "/farmmode"
SLASH_FARMMODE2 = "/fm"