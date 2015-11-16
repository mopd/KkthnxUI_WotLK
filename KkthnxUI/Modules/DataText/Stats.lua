local K, C, L = unpack(select(2, ...))
if IsAddOnLoaded("Carbonite") then return end

local addonList = 50
local StatsFrame = CreateFrame('Frame', 'Stats', UIParent)

local gradientColor = {
    0, 1, 0,
    1, 1, 0,
    1, 0, 0
}

local function memFormat(number)
	if number > 1024 then
		return string.format("%.2f mb", (number / 1024))
	else
		return string.format("%.1f kb", floor(number))
	end
end

local function numFormat(v)
	if v > 1E10 then
		return (floor(v/1E9)).."b"
	elseif v > 1E9 then
		return (floor((v/1E9)*10)/10).."b"
	elseif v > 1E7 then
		return (floor(v/1E6)).."m"
	elseif v > 1E6 then
		return (floor((v/1E6)*10)/10).."m"
	elseif v > 1E4 then
		return (floor(v/1E3)).."k"
	elseif v > 1E3 then
		return (floor((v/1E3)*10)/10).."k"
	else
		return v
	end
end

-- http://www.wowwiki.com/ColorGradient
local function ColorGradient(perc, ...)
    if (perc > 1) then
        local r, g, b = select(select('#', ...) - 2, ...) return r, g, b
    elseif (perc < 0) then
        local r, g, b = ... return r, g, b
    end

    local num = select('#', ...) / 3

    local segment, relperc = math.modf(perc*(num-1))
    local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

    return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

local function RGBGradient(num)
    local r, g, b = ColorGradient(num, unpack(gradientColor))
    return r, g, b
end

local function RGBToHex(r, g, b)
    r = r <= 1 and r >= 0 and r or 0
    g = g <= 1 and g >= 0 and g or 0
    b = b <= 1 and b >= 0 and b or 0
    return string.format('|cff%02x%02x%02x', r*255, g*255, b*255)
end

local function addonCompare(a, b)
	return a.memory > b.memory
end

local function clearGarbage()
	UpdateAddOnMemoryUsage()
	local before = gcinfo()
	collectgarbage()
	UpdateAddOnMemoryUsage()
	local after = gcinfo()
	print("|cFF4488FFCleaned:|r "..memFormat(before-after))
end

StatsFrame:EnableMouse(true)
StatsFrame:SetScript("OnMouseDown", function()
	clearGarbage()
end)

local function getFPS()
	return "|c00ffffff" .. floor(GetFramerate()) .. "|r fps"
end

local function getLatencyRaw()
	return select(3, GetNetStats())
end

local function getLatency()
	return "|c00ffffff" .. getLatencyRaw() .. "|r ms"
end

local function addonTooltip(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	local blizz = collectgarbage("count")
	local addons = {}
	local enry, memory
	local total = 0
	local nr = 0
	UpdateAddOnMemoryUsage()
	GameTooltip:AddLine("AddOns", K.Color.r, K.Color.g, K.Color.b)
	for i=1, GetNumAddOns(), 1 do
		if (GetAddOnMemoryUsage(i) > 0 ) then
			memory = GetAddOnMemoryUsage(i)
			entry = {name = GetAddOnInfo(i), memory = memory}
			table.insert(addons, entry)
			total = total + memory
		end
	end
	table.sort(addons, addonCompare)
	for _, entry in pairs(addons) do
		if nr < addonList then
			GameTooltip:AddDoubleLine(entry.name, memFormat(entry.memory), 1, 1, 1, RGBGradient(entry.memory / 800))
			nr = nr+1
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total", memFormat(total), 1, 1, 1, RGBGradient(total / (1024*10)))
	GameTooltip:AddDoubleLine("Total incl. Blizzard", memFormat(blizz), 1, 1, 1, RGBGradient(blizz / (1024*10)))
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("Network", K.Color.r, K.Color.g, K.Color.b)
	GameTooltip:AddDoubleLine("Home", getLatencyRaw().." ms", 1, 1, 1, RGBGradient(getLatencyRaw()/ 100))
	GameTooltip:Show()
end

StatsFrame:SetScript("OnEnter", function()
	addonTooltip(StatsFrame)
end)
StatsFrame:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)

StatsFrame:SetPoint(unpack(C.position.statsframe))
StatsFrame:SetWidth(C.minimap.size)
StatsFrame:SetHeight(C.font.stats_font_size * 2)

StatsFrame.text = StatsFrame:CreateFontString(nil, 'BACKGROUND')
StatsFrame.text:SetPoint("CENTER", StatsFrame)
StatsFrame.text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
StatsFrame.text:SetShadowOffset(0, -0)
StatsFrame.text:SetTextColor(K.Color.r, K.Color.g, K.Color.b)

local lastUpdate = 0

local function update(self,elapsed)
	lastUpdate = lastUpdate + elapsed
	if lastUpdate > 1 then
		lastUpdate = 0
		StatsFrame.text:SetText(getFPS().." "..getLatency())
	end
end

StatsFrame:SetScript("OnEvent", function(self, event)
	if(event=="PLAYER_LOGIN") then
		self:SetScript("OnUpdate", update)
	end
end)
StatsFrame:RegisterEvent("PLAYER_LOGIN")