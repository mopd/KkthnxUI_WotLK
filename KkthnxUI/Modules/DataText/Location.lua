local K, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("Carbonite") then return end

local Location = CreateFrame("Frame", "MinimapLocation", Minimap)

local Location_Text = Location:CreateFontString("MinimapLocationText", "Overlay")
Location_Text:SetFont(C["font"].stats_font, C["font"].stats_font_size, C["font"].stats_font_style)
Location_Text:SetPoint(unpack(C["position"].locframe))
Location_Text:SetHeight(C["font"].stats_font_size * 2)
Location_Text:SetWidth(C["minimap"].size)

local Location_Update = function()
	local pvp = GetZonePVPInfo()
	Location_Text:SetText(GetMinimapZoneText())
	if pvp == "friendly" then
		Location_Text:SetTextColor(.1, 1, .1)
	elseif pvp == "sanctuary" then
		Location_Text:SetTextColor(.41, .8, .94)
	elseif pvp == "arena" or pvp == "hostile" then
		Location_Text:SetTextColor(1, .1, .1)
	elseif pvp == "contested" then
		Location_Text:SetTextColor(1, .7, 0)
	else
		Location_Text:SetTextColor(1, 1, 1)
	end
end
 
Location:RegisterEvent("PLAYER_ENTERING_WORLD")
Location:RegisterEvent("ZONE_CHANGED_NEW_AREA")
Location:RegisterEvent("ZONE_CHANGED")
Location:RegisterEvent("ZONE_CHANGED_INDOORS")
Location:SetScript("OnEvent", Location_Update)