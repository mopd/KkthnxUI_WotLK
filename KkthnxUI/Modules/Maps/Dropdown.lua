local K, C, L, _ = unpack(select(2, ...))
if C["minimap"].enable ~= true then return end

local select = select
local hooksecurefunc = hooksecurefunc

local function RearrangeDropDownMenu()
	DropDownList1:ClearAllPoints()
	DropDownList1:SetPoint("TOPRIGHT", MiniMapLFGFrame, "BOTTOMLEFT", 0, 0)
end
hooksecurefunc("ToggleDropDownMenu", function(...)
	local relframe = select(4,...)
	if relframe == "MiniMapLFGFrame" then
		RearrangeDropDownMenu()
	end
end)