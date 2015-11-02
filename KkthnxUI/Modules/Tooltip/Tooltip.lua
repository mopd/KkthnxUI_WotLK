local K, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true then return end

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(200, 40)
anchor:SetPoint(unpack(C.position.tooltip))

-- Hide PVP text
PVP_ENABLED = ""

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

GameTooltipStatusBar:SetHeight(6)
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
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

local OnTooltipSetItem = function(self, ...)
	local name, item = self:GetItem()
	if(item) then
		local _, _, quality = GetItemInfo(item)
		if(quality) then
			local r, g, b = GetItemQualityColor(quality)

			self:SetBackdropBorderColor(r, g, b)
		end
	end
end

for _, obj in next, {
	GameTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	ItemRefTooltip,
} do
	obj:HookScript("OnTooltipSetItem", OnTooltipSetItem)
end


local CUSTOM_FACTION_BAR_COLORS = {
	[1] = {r = 1, g = 0, b = 0},
	[2] = {r = 1, g = 0, b = 0},
	[3] = {r = 1, g = 1, b = 0},
	[4] = {r = 1, g = 1, b = 0},
	[5] = {r = 0, g = 1, b = 0},
	[6] = {r = 0, g = 1, b = 0},
	[7] = {r = 0, g = 1, b = 0},
	[8] = {r = 0, g = 1, b = 0},
}
function GameTooltip_UnitColor(unit)
	local r, g, b
	
	if (UnitIsDead(unit) or UnitIsGhost(unit) or UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
		r = 0.5
		g = 0.5
		b = 0.5 
	elseif (UnitIsPlayer(unit)) then
		if (UnitIsFriend(unit, "player")) then
			local _, class = UnitClass(unit)
			r = RAID_CLASS_COLORS[class].r
			g = RAID_CLASS_COLORS[class].g
			b = RAID_CLASS_COLORS[class].b
		elseif (not UnitIsFriend(unit, "player")) then
			r = 1
			g = 0
			b = 0
		end
	elseif (UnitPlayerControlled(unit)) then
		if (UnitCanAttack(unit, "player")) then
			if (not UnitCanAttack("player", unit)) then
				r = 157/255
				g = 197/255
				b = 255/255
			else
				r = 1
				g = 0
				b = 0
			end
		elseif (UnitCanAttack("player", unit)) then
			r = 1
			g = 1
			b = 0
		elseif (UnitIsPVP(unit)) then
			r = 0
			g = 1
			b = 0
		else
			r = 157/255
			g = 197/255
			b = 255/255
		end
	else
		local reaction = UnitReaction(unit, "player")
		
		if (reaction) then
			r = CUSTOM_FACTION_BAR_COLORS[reaction].r
			g = CUSTOM_FACTION_BAR_COLORS[reaction].g
			b = CUSTOM_FACTION_BAR_COLORS[reaction].b
		else
			r = 157/255
			g = 197/255
			b = 255/255
		end
	end
	
	return r, g, b
end

UnitSelectionColor = GameTooltip_UnitColor

local function GetRealUnit(self)
	if (GetMouseFocus() and not GetMouseFocus():GetAttribute("unit") and GetMouseFocus() ~= WorldFrame) then
		return select(2, self:GetUnit())
	elseif (GetMouseFocus() and GetMouseFocus():GetAttribute("unit")) then
		return GetMouseFocus():GetAttribute("unit")
	elseif (select(2, self:GetUnit())) then
		return select(2, self:GetUnit()) 
	else
		return "mouseover"
	end
end

local function GetFormattedUnitType(unit)
	local creaturetype = UnitCreatureType(unit)
	if (creaturetype) then
		return creaturetype
	else
		return ""
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

local function GetFormattedUnitClassification(unit)
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

local function GetFormattedUnitLevel(unit)
	local diff = GetQuestDifficultyColor(UnitLevel(unit))
	if (UnitLevel(unit) == -1) then
		return "|cffff0000??|r "
	elseif (UnitLevel(unit) == 0) then
		return "? "
	else
		return format("|cff%02x%02x%02x%s|r ", diff.r*255, diff.g*255, diff.b*255, UnitLevel(unit)) 
	end
end

local function GetFormattedUnitClass(unit)
	local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
	if (color) then
		return format(" |cff%02x%02x%02x%s|r", color.r*255, color.g*255, color.b*255, UnitClass(unit))
	end
end

local function GetFormattedUnitString(unit) 
	if (UnitIsPlayer(unit)) then
		return GetFormattedUnitLevel(unit)..UnitRace(unit)..GetFormattedUnitClass(unit)
	else
		return GetFormattedUnitLevel(unit)..GetFormattedUnitClassification(unit)..GetFormattedUnitType(unit)
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local unit = GetRealUnit(self)
	
	if (UnitExists(unit) and UnitName(unit) ~= UNKNOWN) then
		local name, realm = UnitName(unit)
		
		GameTooltipTextLeft1:SetText(name)
		
		if GetGuildInfo(unit) then
			_G["GameTooltipTextLeft2"]:SetFormattedText("%s", GetGuildInfo(unit))
			if UnitIsInMyGuild(unit) then
				_G["GameTooltipTextLeft2"]:SetTextColor(255/255, 209/255, 0/255)
			else
				_G["GameTooltipTextLeft2"]:SetTextColor(157/255, 197/255, 255/255)
			end
		end
		
		-- Tooltip level text
		for i = 2, GameTooltip:NumLines() do
			if (_G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) then
				_G["GameTooltipTextLeft"..i]:SetText(GetFormattedUnitString(unit))
			end
		end
		
		if (UnitIsAFK(unit)) then 
			self:AppendText("|cff00ff00 <AFK>|r") 
		elseif (UnitIsDND(unit)) then
			self:AppendText("|cff00ff00 <DND>|r")
		end
		
		if (UnitIsDead(unit) or UnitIsGhost(unit)) then
			GameTooltipStatusBar:SetBackdropColor(0.5, 0.5, 0.5, 0.35)
		else
			GameTooltipStatusBar:SetBackdropColor(27/255, 243/255, 27/255, 0.35)
		end
		
		if C.tooltip.target == true and UnitExists(unit.."target") then
			local r, g, b = GameTooltip_UnitColor(unit.."target")
			local text = ""
			
			if UnitIsEnemy("player", unit.."target") then
				r, g, b = 199/255, 64/255, 64/255;
			elseif not UnitIsFriend("player", unit.."target") then
				r, g, b = 79/255, 115/255, 161/255;
			end
			
			if UnitName(unit.."target") == UnitName("player") then
				text = "|cfffed100"..STATUS_TEXT_TARGET..":|r ".."|cffff0000> "..UNIT_YOU.." <|r"
			else
				text = "|cfffed100"..STATUS_TEXT_TARGET..":|r "..UnitName(unit.."target")
			end
			
			self:AddLine(text, r, g, b)
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

-- Fix compare tooltips(by Blizzard)(../FrameXML/GameTooltip.lua)
hooksecurefunc("GameTooltip_ShowCompareItem", function(self, shift)
	if not self then
		self = GameTooltip
	end
	local item, link = self:GetItem()
	if not link then return end

	local shoppingTooltip1, shoppingTooltip2, shoppingTooltip3 = unpack(self.shoppingTooltips)

	local item1 = nil
	local item2 = nil
	local item3 = nil
	local side = "left"
	if shoppingTooltip1:SetHyperlinkCompareItem(link, 1, shift, self) then
		item1 = true
	end
	if shoppingTooltip2:SetHyperlinkCompareItem(link, 2, shift, self) then
		item2 = true
	end
	if shoppingTooltip3:SetHyperlinkCompareItem(link, 3, shift, self) then
		item3 = true
	end

	-- Find correct side
	local rightDist = 0
	local leftPos = self:GetLeft()
	local rightPos = self:GetRight()
	if not rightPos then
		rightPos = 0
	end
	if not leftPos then
		leftPos = 0
	end

	rightDist = GetScreenWidth() - rightPos

	if leftPos and (rightDist < leftPos) then
		side = "left"
	else
		side = "right"
	end

	-- See if we should slide the tooltip
	if self:GetAnchorType() and self:GetAnchorType() ~= "ANCHOR_PRESERVE" then
		local totalWidth = 0

		if item1 then
			totalWidth = totalWidth + shoppingTooltip1:GetWidth()
		end
		if item2 then
			totalWidth = totalWidth + shoppingTooltip2:GetWidth()
		end
		if item3 then
			totalWidth = totalWidth + shoppingTooltip3:GetWidth()
		end

		if side == "left" and totalWidth > leftPos then
			self:SetAnchorType(self:GetAnchorType(), totalWidth - leftPos, 0)
		elseif side == "right" and (rightPos + totalWidth) > GetScreenWidth() then
			self:SetAnchorType(self:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0)
		end
	end

	-- Anchor the compare tooltips
	if item3 then
		shoppingTooltip3:SetOwner(self, "ANCHOR_NONE")
		shoppingTooltip3:ClearAllPoints()
		if side and side == "left" then
			shoppingTooltip3:SetPoint("TOPRIGHT", self, "TOPLEFT", -3, -10)
		else
			shoppingTooltip3:SetPoint("TOPLEFT", self, "TOPRIGHT", 3, -10)
		end
		shoppingTooltip3:SetHyperlinkCompareItem(link, 3, shift, self)
		shoppingTooltip3:Show()
	end

	if item1 then
		if item3 then
			shoppingTooltip1:SetOwner(shoppingTooltip3, "ANCHOR_NONE")
		else
			shoppingTooltip1:SetOwner(self, "ANCHOR_NONE")
		end
		shoppingTooltip1:ClearAllPoints()
		if side and side == "left" then
			if item3 then
				shoppingTooltip1:SetPoint("TOPRIGHT", shoppingTooltip3, "TOPLEFT", -3, 0)
			else
				shoppingTooltip1:SetPoint("TOPRIGHT", self, "TOPLEFT", -3, -10)
			end
		else
			if item3 then
				shoppingTooltip1:SetPoint("TOPLEFT", shoppingTooltip3, "TOPRIGHT", 3, 0)
			else
				shoppingTooltip1:SetPoint("TOPLEFT", self, "TOPRIGHT", 3, -10)
			end
		end
		shoppingTooltip1:SetHyperlinkCompareItem(link, 1, shift, self)
		shoppingTooltip1:Show()

		if item2 then
			shoppingTooltip2:SetOwner(shoppingTooltip1, "ANCHOR_NONE")
			shoppingTooltip2:ClearAllPoints()
			if side and side == "left" then
				shoppingTooltip2:SetPoint("TOPRIGHT", shoppingTooltip1, "TOPLEFT", -3, 0)
			else
				shoppingTooltip2:SetPoint("TOPLEFT", shoppingTooltip1, "TOPRIGHT", 3, 0)
			end
			shoppingTooltip2:SetHyperlinkCompareItem(link, 2, shift, self)
			shoppingTooltip2:Show()
		end
	end
end)

-- Fix GameTooltipMoneyFrame font size
local function FixFont(self)
	for i = 1, 2 do
		if _G["GameTooltipMoneyFrame"..i] then
			_G["GameTooltipMoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
			_G["GameTooltipMoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
		end
	end
	for i = 1, 2 do
		if _G["ItemRefTooltipMoneyFrame"..i] then
			_G["ItemRefTooltipMoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
			_G["ItemRefTooltipMoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
		end
	end
end

GameTooltip:HookScript("OnTooltipSetItem", FixFont)
ItemRefTooltip:HookScript("OnTooltipSetItem", FixFont)