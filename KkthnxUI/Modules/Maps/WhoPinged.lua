local K, C, L, _ = unpack(select(2, ...))

local select = select
local CreateFrame = CreateFrame
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

-- Who Pinged?
local wPing = CreateFrame("ScrollingMessageFrame", nil, Minimap)
wPing:SetHeight(10)
wPing:SetWidth(100)
wPing:SetPoint("BOTTOM", Minimap, 0, 20)

wPing:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
wPing:SetShadowOffset(K.mult, -K.mult)
wPing:SetJustifyH("CENTER")
wPing:SetJustifyV("CENTER")
wPing:SetMaxLines(1)
wPing:SetFading(true)
wPing:SetFadeDuration(3)
wPing:SetTimeVisible(5)

wPing:RegisterEvent("MINIMAP_PING")
wPing:SetScript("OnEvent", function(self, event, u)
	local c = RAID_CLASS_COLORS[select(2,UnitClass(u))]
	--local name = UnitName(u)
	if(UnitName(u) ~= K.Name) then
		wPing:AddMessage(UnitName(u), c.r, c.g, c.b)
	end
end)