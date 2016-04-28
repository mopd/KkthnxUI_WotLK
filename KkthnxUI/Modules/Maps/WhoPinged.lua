local K, C, L, _ = unpack(select(2, ...))

-- Who Pinged?
local wPing = CreateFrame('ScrollingMessageFrame', nil, Minimap)
wPing:SetHeight(10)
wPing:SetWidth(100)
wPing:SetPoint('BOTTOM', Minimap, 0, 20)

wPing:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
wPing:SetJustifyH'CENTER'
wPing:SetJustifyV'CENTER'
wPing:SetMaxLines(1)
wPing:SetFading(true)
wPing:SetFadeDuration(3)
wPing:SetTimeVisible(5)

wPing:RegisterEvent'MINIMAP_PING'
wPing:SetScript('OnEvent', function(self, event, u)
	local c = RAID_CLASS_COLORS[select(2,UnitClass(u))]
	local name = UnitName(u)
	if(name ~= K.Name) then
		wPing:AddMessage(name, c.r, c.g, c.b)
	end
end)