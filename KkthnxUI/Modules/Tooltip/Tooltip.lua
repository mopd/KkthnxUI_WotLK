local K, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true then return end

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(200, 40)
anchor:SetPoint(unpack(C.position.tooltip))

-- Some tooltip changes
if (C.tooltip.fontoutline) then
	GameTooltipHeaderText:SetFont(C.font.tooltip_font, C.font.tooltip_font_size + 2, C.font.tooltip_font_style)
	GameTooltipHeaderText:SetShadowOffset(0, 0)
	
	GameTooltipText:SetFont(C.font.tooltip_font, C.font.tooltip_font_size, C.font.tooltip_font_style)
	GameTooltipText:SetShadowOffset(0, 0)
	
	GameTooltipTextSmall:SetFont(C.font.tooltip_font, C.font.tooltip_font_size - 1, C.font.tooltip_font_style)
	GameTooltipTextSmall:SetShadowOffset(0, 0)
else
	GameTooltipHeaderText:SetFont(C.font.tooltip_font, C.font.tooltip_font_size + 2)
	GameTooltipText:SetFont(C.font.tooltip_font, C.font.tooltip_font_size)
	GameTooltipTextSmall:SetFont(C.font.tooltip_font, C.font.tooltip_font_size - 1)
end

GameTooltipStatusBar:SetHeight(7)
GameTooltipStatusBar:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)

local function ApplyTooltipStyle(self)
	self:SetBackdrop(K.Backdrop)
	
	self:HookScript("OnShow", function(tooltip)
		tooltip:SetBackdropColor(0.05, 0.05, 0.05, .9)
	end)
end

for _, tooltip in pairs({
	DropDownList1Backdrop;
	DropDownList2Backdrop;
	DropDownList1MenuBackdrop;
	DropDownList2MenuBackdrop;
	
	GameTooltip; 
	ItemRefTooltip; 
	ShoppingTooltip1; 
	ShoppingTooltip2; 
	ShoppingTooltip3;
	WorldMapTooltip; 
	
	ChatMenu;
	EmoteMenu;
	LanguageMenu;
	VoiceMacroMenu;
}) do
	ApplyTooltipStyle(tooltip)
end

-- Itemquaility border
if (C.tooltip.qualitybordercolor) then
	for _, tooltip in pairs({
		GameTooltip,
		ItemRefTooltip,
		
		ShoppingTooltip1,
		ShoppingTooltip2,
		ShoppingTooltip3,
	}) do
		tooltip:HookScript("OnTooltipSetItem", function(self)
			local name, item = self:GetItem()
			if (item) then
				local quality = select(3, GetItemInfo(item))
				if (quality) then
					local r, g, b = GetItemQualityColor(quality)
					self:SetBackdropBorderColor(r, g, b)
				end
			end
		end)
		
		tooltip:HookScript("OnTooltipCleared", function(self)
			self:SetBackdropBorderColor(.7, .7, .7, 1)
		end)
	end
end

local function GameTooltip_GetUnit(self)
	if (GetMouseFocus() and not GetMouseFocus():GetAttribute("unit") and GetMouseFocus() ~= WorldFrame) then
		return select(2, self:GetUnit())
	elseif (GetMouseFocus() and GetMouseFocus():GetAttribute("unit")) then
		return GetMouseFocus():GetAttribute("unit")
	else
		return select(2, self:GetUnit()) 
	end
end

local function GameTooltip_UnitCreatureType(unit)
	local creaturetype = UnitCreatureType(unit)
	if (creaturetype) then
		return creaturetype
	else
		return ""
	end
end

local function GameTooltip_UnitClassification(unit)
	local class = UnitClassification(unit)
	if (class == "worldboss") then
		return "|cffFF0000"..BOSS.."|r "
	elseif (class == "rareelite") then
		return "|cffFF66CCRare|r |cffFFFF00"..ELITE.."|r "
	elseif (class == "rare") then 
		return "|cffFF66CCRare|r "
	elseif (class == "elite") then
		return "|cffFFFF00"..ELITE.."|r "
	else
		return ""
	end
end

local function GameTooltip_UnitLevel(unit)
	local diff = GetQuestDifficultyColor(UnitLevel(unit))
	if (UnitLevel(unit) == -1) then
		return "|cffff0000??|r "
	elseif (UnitLevel(unit) == 0) then
		return "? "
	else
		return format("|cff%02x%02x%02x%s|r ", diff.r*255, diff.g*255, diff.b*255, UnitLevel(unit)) 
	end
end

local function GameTooltip_UnitClass(unit)
	local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
	if (color) then
		return format(" |cff%02x%02x%02x%s|r", color.r*255, color.g*255, color.b*255, UnitClass(unit))
	end
end

local function GameTooltip_UnitType(unit) 
	if (UnitIsPlayer(unit)) then
		return GameTooltip_UnitLevel(unit)..UnitRace(unit)..GameTooltip_UnitClass(unit)
	else
		return GameTooltip_UnitLevel(unit)..GameTooltip_UnitClassification(unit)..GameTooltip_UnitCreatureType(unit)
	end
end

local function GameTooltipDefault(self, parent)
	if C.tooltip.cursor == true then
		self:SetOwner(parent, "ANCHOR_CURSOR_RIGHT", 20, 20)
	else
		self:SetOwner(parent, "ANCHOR_NONE")
		self:ClearAllPoints()
		self:SetPoint("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
		self.default = 1
	end
end
hooksecurefunc("GameTooltip_SetDefaultAnchor", GameTooltipDefault)

GameTooltip:HookScript("OnTooltipCleared", function(self)
	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0.5, 3)
	GameTooltipStatusBar:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -1, 3)
	GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local unit = GameTooltip_GetUnit(self)
	
	if (UnitExists(unit) and UnitName(unit) ~= UNKNOWN) then
		local name = UnitName(unit)
		
		GameTooltipTextLeft1:SetText(name)
		
		if (GetGuildInfo(unit)) then
			if (GetGuildInfo(unit) == GetGuildInfo("player") and IsInGuild("player")) then
				GameTooltipTextLeft2:SetText("|cffFF66CC"..GameTooltipTextLeft2:GetText().."|r")
			end
		end
		
		for i = 2, GameTooltip:NumLines() do
			if (_G["GameTooltipTextLeft"..i]:GetText():find("^"..TOOLTIP_UNIT_LEVEL:gsub("%%s", ".+"))) then
				_G["GameTooltipTextLeft"..i]:SetText(GameTooltip_UnitType(unit))
			end
		end
		
		for i = 3, GameTooltip:NumLines() do
			if (_G["GameTooltipTextLeft"..i]:GetText():find(PVP_ENABLED)) then
				_G["GameTooltipTextLeft"..i]:SetText(nil)
				if (UnitIsPVPFreeForAll(unit)) then
					GameTooltipTextLeft1:SetText("|cffFF0000# |r"..GameTooltipTextLeft1:GetText())
				elseif (UnitIsPVP(unit)) then
					GameTooltipTextLeft1:SetText("|cff00FF00# |r"..GameTooltipTextLeft1:GetText())
				end
			end
		end
		
		if (UnitIsAFK(unit)) then 
			self:AppendText(" |cffffffff[|r|cff00ff00AFK|r|cffffffff]|r") 
		elseif (UnitIsDND(unit)) then
			self:AppendText(" |cffffffff[|r|cff00ff00DND|r|cffffffff]|r")
		end
		
		if (UnitIsDead(unit) or UnitIsGhost(unit)) then
			GameTooltipStatusBar:SetBackdropColor(0.5, 0.5, 0.5, 0.35)
		else
			GameTooltipStatusBar:SetBackdropColor(27/255, 243/255, 27/255, 0.35)
		end
		
		-- Move the healthbar inside the tooltip
		if GameTooltipStatusBar:IsShown() then
			self:AddLine(" ")
			GameTooltipStatusBar:ClearAllPoints()
			GameTooltipStatusBar:SetPoint("LEFT", self:GetName().."TextLeft"..self:NumLines(), 1, -3)
			GameTooltipStatusBar:SetPoint("RIGHT", self, -10, 0)
		end
	end
end)