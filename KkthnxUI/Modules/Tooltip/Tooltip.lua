﻿local K, C, L, _ = select(2, ...):unpack()
if C["Tooltip"].enable ~= true then return end

local _G = _G
local gsub, find, format = string.gsub, string.find, string.format

local GameTooltip, GameTooltipStatusBar = _G["GameTooltip"], _G["GameTooltipStatusBar"]
local NeedBackdropBorderRefresh = false
local Tooltip = CreateFrame("Frame", nil, UIParent)
local Tooltips = {GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, WorldMapTooltip}

local TipAnchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
TipAnchor:SetSize(200, 40)
TipAnchor:SetPoint(unpack(C["position"].tooltip))

local classification = {
	worldboss = "|cffAF5050Boss|r",
	rareelite = "|cffAF5050+ Rare|r",
	elite = "|cffAF5050+|r",
	rare = "|cffAF5050Rare|r",
}

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
	if C["Tooltip"].cursor == true then
		self:SetOwner(parent, "ANCHOR_CURSOR")
	else
		self:SetOwner(parent, "ANCHOR_NONE")
		self:SetPoint("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
	end
	self.default = 1
end)

GameTooltip:HookScript("OnUpdate",function(self, ...)
	if self:GetAnchorType() == "ANCHOR_CURSOR" and NeedBackdropBorderRefresh == true and C["Tooltip"].cursor ~= true then
		NeedBackdropBorderRefresh = false
		self:SetBackdropColor(unpack(C["Media"].Backdrop_Color))
		self:SetBackdropBorderColor(unpack(C["Media"].Border_Color))
	elseif self:GetAnchorType() == "ANCHOR_NONE" then
		if InCombatLockdown() and C["Tooltip"].hide_combat == true then
			self:SetAlpha(0)
		else
			self:SetAlpha(1)
			if C["Bag"].enable == true and StuffingFrameBags:IsShown() then
				self:ClearAllPoints()
				self:SetPoint("BOTTOMRIGHT", StuffingFrameBags, "TOPRIGHT", 0, K.Scale(4))
			else
				self:ClearAllPoints()
				self:SetPoint("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
			end
		end
	end
end)

local function Hex(color)
	return string.format('|cff%02x%02x%02x', color.r * 255, color.g * 255, color.b * 255)
end

local function GetColor(unit)
	if(UnitIsPlayer(unit) and not UnitHasVehicleUI(unit)) then
		local _, class = UnitClass(unit)
		local color = RAID_CLASS_COLORS[class]
		if not color then return end
		local r,g,b = color.r, color.g, color.b
		return Hex(color), r, g, b
	else
		local color = BETTER_FACTION_BAR_COLORS[UnitReaction("player", unit)]
		if not color then return end
		local r,g,b = color.r, color.g, color.b
		return Hex(color), r, g, b
	end
end

GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
	if not value then
		return
	end
	local min, max = self:GetMinMaxValues()

	if (value < min) or (value > max) then
		return
	end
	local _, unit = GameTooltip:GetUnit()

	if (not unit) then
		local GMF = GetMouseFocus()
		unit = GMF and GMF:GetAttribute("unit")
	end

	if not self.text then
		self.text = self:CreateFontString(nil, "OVERLAY")
		self.text:SetPoint("CENTER", GameTooltipStatusBar, 0, K.Scale(6))
		self.text:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)
		self.text:Show()
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			local hp = K.ShortValue(min).." / "..K.ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText("Ghost")
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText("Dead")
			else
				self.text:SetText(hp)
			end
		end
	else
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			self.text:Show()
			local hp = K.ShortValue(min).." / "..K.ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText("Ghost")
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText("Dead")
			else
				self.text:SetText(hp)
			end
		else
			self.text:Hide()
		end
	end
end)

local healthBar = GameTooltipStatusBar
healthBar:ClearAllPoints()
healthBar:SetHeight(K.Scale(6))
healthBar:SetPoint("BOTTOMLEFT", healthBar:GetParent(), "TOPLEFT", K.Scale(4), K.Scale(1))
healthBar:SetPoint("BOTTOMRIGHT", healthBar:GetParent(), "TOPRIGHT", -K.Scale(4), K.Scale(1))
healthBar:SetStatusBarTexture(C["Media"].Texture)

local healthBarBG = CreateFrame("Frame", "StatusBarBG", healthBar)
healthBarBG:SetFrameLevel(healthBar:GetFrameLevel() - 1)
healthBarBG:SetPoint("TOPLEFT", -K.Scale(1), K.Scale(1))
healthBarBG:SetPoint("BOTTOMRIGHT", K.Scale(1), -K.Scale(1))
healthBarBG:CreatePixelShadow(2)
healthBarBG:SetBackdrop(K.BorderBackdrop)
healthBarBG:SetBackdropColor(unpack(C["Media"].Backdrop_Color))

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local lines = self:NumLines()
	local GMF = GetMouseFocus()
	local unit = (select(2, self:GetUnit())) or (GMF and GMF:GetAttribute("unit"))

	if (not unit) and (UnitExists("mouseover")) then
		unit = "mouseover"
	end

	if not unit then self:Hide() return end

	if (UnitIsUnit(unit,"mouseover")) then
		unit = "mouseover"
	end

	local race = UnitRace(unit)
	local class = UnitClass(unit)
	local level = UnitLevel(unit)
	local guild = GetGuildInfo(unit)
	local name, realm = UnitName(unit)
	local crtype = UnitCreatureType(unit)
	local classif = UnitClassification(unit)
	local title = UnitPVPName(unit)
	local r, g, b = GetQuestDifficultyColor(level).r, GetQuestDifficultyColor(level).g, GetQuestDifficultyColor(level).b

	local color = GetColor(unit)
	if not color then color = "|CFFFFFFFF" end

	_G["GameTooltipTextLeft1"]:SetFormattedText("%s%s%s", color, title or name, realm and realm ~= "" and " - "..realm.."|r" or "|r")

	if(UnitIsPlayer(unit)) then
		if UnitIsAFK(unit) then
			self:AppendText((" %s"):format(CHAT_FLAG_AFK))
		elseif UnitIsDND(unit) then
			self:AppendText((" %s"):format(CHAT_FLAG_DND))
		end

		local offset = 2
		if guild then
			_G["GameTooltipTextLeft2"]:SetFormattedText("%s", IsInGuild() and GetGuildInfo("player") == guild and "|cff0090ff"..guild.."|r" or "|cff00ff10"..guild.."|r")
			offset = offset + 1
		end

		for i= offset, lines do
			if(_G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", r*255, g*255, b*255, level > 0 and level or "??", race, color, class.."|r")
				break
			end
		end
	else
		for i = 2, lines do
			if((_G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) or (crtype and _G["GameTooltipTextLeft"..i]:GetText():find("^"..crtype))) then
				if level == -1 and classif == "elite" then classif = "worldboss" end
				_G["GameTooltipTextLeft"..i]:SetFormattedText("|cff%02x%02x%02x%s|r%s %s", r*255, g*255, b*255, classif ~= "worldboss" and level ~= 0 and level or "", classification[classif] or "", crtype or "")
				break
			end
		end
	end

	local pvpLine
	for i = 1, lines do
		local text = _G["GameTooltipTextLeft"..i]:GetText()
		if text and text == PVP_ENABLED then
			pvpLine = _G["GameTooltipTextLeft"..i]
			pvpLine:SetText()
			break
		end
	end

	if UnitExists(unit.."target") and unit~="player" then
		local hex, r, g, b = GetColor(unit.."target")
		if not r and not g and not b then r, g, b = 1, 1, 1 end
		GameTooltip:AddLine(UnitName(unit.."target"), r, g, b)
	end

	self.fadeOut = nil
end)

local BorderColor = function(self)
	local GMF = GetMouseFocus()
	local unit = (select(2, self:GetUnit())) or (GMF and GMF:GetAttribute("unit"))

	local reaction = unit and UnitReaction("player", unit)
	local player = unit and UnitIsPlayer(unit)
	local tapped = unit and UnitIsTapped(unit)
	local tappedbyme = unit and UnitIsTappedByPlayer(unit)
	local connected = unit and UnitIsConnected(unit)
	local dead = unit and UnitIsDead(unit)

	if player then
		local class = select(2, UnitClass(unit))
		local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		r, g, b = c.r, c.g, c.b
		self:SetBackdropBorderColor(r, g, b)
		healthBarBG:SetBackdropBorderColor(r, g, b)
		healthBar:SetStatusBarColor(r, g, b)
	elseif reaction then
		local c = BETTER_FACTION_BAR_COLORS[reaction]
		r, g, b = c.r, c.g, c.b
		self:SetBackdropBorderColor(r, g, b)
		healthBarBG:SetBackdropBorderColor(r, g, b)
		healthBar:SetStatusBarColor(r, g, b)
	else
		local _, link = self:GetItem()
		local quality = link and select(3, GetItemInfo(link))
		if quality and quality >= 2 then
			local r, g, b = GetItemQualityColor(quality)
			self:SetBackdropBorderColor(r, g, b)
		else
			self:SetBackdropBorderColor(unpack(C["Media"].Border_Color))
			healthBarBG:SetBackdropBorderColor(unpack(C["Media"].Border_Color))
			healthBar:SetStatusBarColor(unpack(C["Media"].Border_Color))
		end
	end

	NeedBackdropBorderRefresh = true
end

local SetStyle = function(self)
	self:SetBackdropColor(unpack(C["Media"].Backdrop_Color))
	self:SetBackdropBorderColor(unpack(C["Media"].Border_Color))
	BorderColor(self)
end

Tooltip:RegisterEvent("PLAYER_ENTERING_WORLD")
Tooltip:SetScript("OnEvent", function(self)
	for _, tt in pairs(Tooltips) do
		tt:SetBackdrop(K.Backdrop)
		tt:HookScript("OnShow", SetStyle)
	end

	--FriendsTooltip:SetBackdrop(K.Backdrop)

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", nil)

	if C["Tooltip"].hidebuttons == true then
		local CombatHideActionButtonsTooltip = function(self)
			if not IsShiftKeyDown() then
				self:Hide()
			end
		end

		hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
		hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
		hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
	end
end)