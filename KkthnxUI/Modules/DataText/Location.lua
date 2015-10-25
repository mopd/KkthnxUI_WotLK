local K, C, L, _ = unpack(select(2, ...))

local Location = CreateFrame("Button", "Location", UIParent)

local text, Zone
function Location:New()

	self:SetPoint(unpack(C.position.locframe))
	self:SetWidth(C.minimap.size)
	self:SetHeight(C.font.stats_font_size * 2)
	
	text = self:CreateFontString(nil, "OVERLAY")

	text:SetFont(C.font.stats_font, C.font.stats_font_size, C.font.stats_font_style)
	text:SetShadowOffset(0, 0)
	text:SetTextColor(232/255, 180/255, 68/255)

	text:SetPoint("CENTER", self)
	
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
	self:SetScript("OnUpdate", self.update) 
	self:SetScript("OnEvent", self.event)
end
function Location:event()
	if (event == "ZONE_CHANGED_NEW_AREA") then 
		SetMapToCurrentZone()
	end
end

function Location:update()

	Zone = GetMinimapZoneText()
	Zone = Zone
	
	text:SetText(Zone) 
end

Location:New()