local K, C, L, _ = select(2, ...):unpack()
if IsAddOnLoaded("Carbonite") then return end

local unpack = unpack
local CreateFrame = CreateFrame
local GetMinimapZoneText, GetZonePVPInfo = GetMinimapZoneText, GetZonePVPInfo

local Location = CreateFrame("Frame", "MinimapLocation", Minimap)

local Location_Text = Location:CreateFontString("MinimapLocationText", "Overlay")
Location_Text:SetFont(C["font"].stats_font, C["font"].stats_font_size, C["font"].stats_font_style)
Location_Text:SetPoint(unpack(C["position"].locframe))
Location_Text:SetHeight(C["font"].stats_font_size * 2)
Location_Text:SetWidth(C["minimap"].size)

local Location_Update = function()
	local Zone = GetZonePVPInfo()
	Location_Text:SetText(GetMinimapZoneText())
	if Zone == "friendly" then
		Location_Text:SetTextColor(0.1, 1, 0.1)
	elseif Zone == "sanctuary" then
		Location_Text:SetTextColor(0.41, 0.8, 0.94)
	elseif Zone == "arena" then
		Location_Text:SetTextColor(1, 0.1, 0.1)
	elseif Zone == "hostile" then
		Location_Text:SetTextColor(1, 0.1, 0.1)
	elseif Zone == "contested" then
		Location_Text:SetTextColor(1, 0.7, 0)
	elseif Zone == "combat" then
		Location_Text:SetTextColor(1, 0.1, 0.1)
	elseif Zone == "neutral" then
		Location_Text:SetTextColor(1, 0.93, 0.76)
	else
		Location_Text:SetTextColor(1, 1, 1)
	end
end

Location:RegisterEvent("PLAYER_ENTERING_WORLD")
Location:RegisterEvent("ZONE_CHANGED_NEW_AREA")
Location:RegisterEvent("ZONE_CHANGED")
Location:RegisterEvent("ZONE_CHANGED_INDOORS")
Location:SetScript("OnEvent", Location_Update)