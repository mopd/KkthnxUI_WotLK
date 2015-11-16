local K, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true then return end

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(200, 40)
anchor:SetPoint(unpack(C.position.tooltip))

local _G = _G
local select = select
local format = string.format

local UnitName = UnitName
local UnitLevel = UnitLevel
local UnitExists = UnitExists
local UnitIsDead = UnitIsDead
local UnitIsGhost = UnitIsGhost
local UnitFactionGroup = UnitFactionGroup
local UnitCreatureType = UnitCreatureType
local GetQuestDifficultyColor = GetQuestDifficultyColor

local classColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

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
GameTooltipStatusBar:SetBackdrop({bgFile = 'Interface\\Buttons\\WHITE8x8'})
GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)

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
		if (UnitIsFriend(unit, 'player')) then
			local _, class = UnitClass(unit)
			r = RAID_CLASS_COLORS[class].r
			g = RAID_CLASS_COLORS[class].g
			b = RAID_CLASS_COLORS[class].b
		elseif (not UnitIsFriend(unit, 'player')) then
			r = 1
			g = 0
			b = 0
		end
	elseif (UnitPlayerControlled(unit)) then
		if (UnitCanAttack(unit, 'player')) then
			if (not UnitCanAttack('player', unit)) then
				r = 157/255
				g = 197/255
				b = 255/255
			else
				r = 1
				g = 0
				b = 0
			end
		elseif (UnitCanAttack('player', unit)) then
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
		local reaction = UnitReaction(unit, 'player')
		
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

local function ApplyTooltipStyle(self)
	local bgsize, bsize
	if (self == ConsolidatedBuffsTooltip) then
		bgsize = 1
		bsize = 8
	elseif (self == FriendsTooltip) then
		FriendsTooltip:SetScale(1)
		
		bgsize = 1
		bsize = 9
	else
		bgsize = 3
		bsize = 12
	end
	
	self:SetBackdrop(K.Backdrop)
	self:HookScript('OnShow', function(self)
		self:SetBackdropColor(0.05, 0.05, 0.05, .9)
	end)
	
	self:HookScript('OnHide', function(self)
		self:SetBackdropColor(0.05, 0.05, 0.05, .9)
	end)
	
	self:HookScript('OnUpdate', function(self)
		self:SetBackdropColor(0.05, 0.05, 0.05, .9)
	end)
end

for _, tooltip in pairs({
	GameTooltip,
	ItemRefTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3,
	AutoCompleteBox,
	FriendsTooltip,
	ConsolidatedBuffsTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	WorldMapTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	DropDownList1MenuBackdrop,
	DropDownList2MenuBackdrop,
	DropDownList3MenuBackdrop,
	BNToastFrame,
	SmallTextTooltip,
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
		tooltip:HookScript('OnTooltipSetItem', function(self)
			local name, item = self:GetItem()
			if (item) then
				local quality = select(3, GetItemInfo(item))
				if (quality) then
					local r, g, b = GetItemQualityColor(quality)
					self:SetBackdropBorderColor(r, g, b)
				end
			end
		end)
		
		tooltip:HookScript('OnTooltipCleared', function(self)
			self:SetBackdropBorderColor(.7, .7, .7, 1)
		end)
	end
end

-- Make sure we get a correct unit
local function GetRealUnit(self)
	if (GetMouseFocus() and not GetMouseFocus():GetAttribute('unit') and GetMouseFocus() ~= WorldFrame) then
		return select(2, self:GetUnit())
	elseif (GetMouseFocus() and GetMouseFocus():GetAttribute('unit')) then
		return GetMouseFocus():GetAttribute('unit')
	elseif (select(2, self:GetUnit())) then
		return select(2, self:GetUnit())
	else
		return 'mouseover'
	end
end

local function GetFormattedUnitType(unit)
	local creaturetype = UnitCreatureType(unit)
	if (creaturetype) then
		return creaturetype
	else
		return ''
	end
end

local function GetFormattedUnitClassification(unit)
	local class = UnitClassification(unit)
	if (class == 'worldboss') then
		return '|cffFF0000'..BOSS..'|r '
	elseif (class == 'rareelite') then
		return '|cffFF66CCRare|r |cffFFFF00'..ELITE..'|r '
	elseif (class == 'rare') then
		return '|cffFF66CCRare|r '
	elseif (class == 'elite') then
		return '|cffFFFF00'..ELITE..'|r '
	else
		return ''
	end
end

local function GetFormattedUnitLevel(unit)
	local diff = GetQuestDifficultyColor(UnitLevel(unit))
	if (UnitLevel(unit) == -1) then
		return '|cffff0000??|r '
	elseif (UnitLevel(unit) == 0) then
		return '? '
	else
		return format('|cff%02x%02x%02x%s|r ', diff.r*255, diff.g*255, diff.b*255, UnitLevel(unit))
	end
end

local function GetFormattedUnitClass(unit)
	local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
	if (color) then
		return format(' |cff%02x%02x%02x%s|r', color.r*255, color.g*255, color.b*255, UnitClass(unit))
	end
end

local function GetFormattedUnitString(unit)
	if (UnitIsPlayer(unit)) then
		if (not UnitRace(unit)) then
			return nil
		end
		return GetFormattedUnitLevel(unit)..UnitRace(unit)..GetFormattedUnitClass(unit)
	else
		return GetFormattedUnitLevel(unit)..GetFormattedUnitClassification(unit)..GetFormattedUnitType(unit)
	end
end

local function GetUnitRaidIcon(unit)
	local index = GetRaidTargetIndex(unit)
	
	if (index) then
		if (UnitIsPVP(unit) and C.tooltip.showpvpicons) then
			return ICON_LIST[index]..'11|t'
		else
			return ICON_LIST[index]..'11|t '
		end
	else
		return ''
	end
end

local function GetUnitPVPIcon(unit)
	local factionGroup = UnitFactionGroup(unit)
	
	if (UnitIsPVPFreeForAll(unit)) then
		if (C.tooltip.showpvpicons) then
			return '|TInterface\\AddOns\\cTooltip\\Media\\UI-PVP-FFA:12|t'
		else
			return '|cffFF0000# |r'
		end
	elseif (factionGroup and UnitIsPVP(unit)) then
		if (C.tooltip.showpvpicons) then
			return '|TInterface\\AddOns\\cTooltip\\Media\\UI-PVP-'..factionGroup..':12|t'
		else
			return '|cff00FF00# |r'
		end
	else
		return ''
	end
end

local function AddMouseoverTarget(self, unit)
	local unitTargetName = UnitName(unit..'target')
	local unitTargetClassColor = RAID_CLASS_COLORS[select(2, UnitClass(unit..'target'))] or { r = 1, g = 0, b = 1 }
	local unitTargetReactionColor = {
		r = select(1, UnitSelectionColor(unit..'target')),
		g = select(2, UnitSelectionColor(unit..'target')),
		b = select(3, UnitSelectionColor(unit..'target'))
	}
	
	if (UnitExists(unit..'target')) then
		if (UnitName('player') == unitTargetName) then
			self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cffff00ff%s|r', string.upper("** YOU **")), 1, 1, 1)
		else
			if (UnitIsPlayer(unit..'target')) then
				self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cff%02x%02x%02x%s|r', unitTargetClassColor.r*255, unitTargetClassColor.g*255, unitTargetClassColor.b*255, unitTargetName:sub(1, 40)), 1, 1, 1)
			else
				self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cff%02x%02x%02x%s|r', unitTargetReactionColor.r*255, unitTargetReactionColor.g*255, unitTargetReactionColor.b*255, unitTargetName:sub(1, 40)), 1, 1, 1)
			end
		end
	end
end

GameTooltip:HookScript('OnTooltipSetUnit', function(self, ...)
	local unit = GetRealUnit(self)
	
	if (C.tooltip.hideincombat and InCombatLockdown()) then
		self:Hide()
		return
	end
	
	if (UnitExists(unit) and UnitName(unit) ~= UNKNOWN) then
		
		local name, realm = UnitName(unit)
		
		-- Hide player titles
		if (C.tooltip.showtitles) then
			if (UnitPVPName(unit)) then
				name = UnitPVPName(unit)
			end
		end
		
		GameTooltipTextLeft1:SetText(name)
		
		-- Color guildnames
		if (GetGuildInfo(unit)) then
			if (GetGuildInfo(unit) == GetGuildInfo('player') and IsInGuild('player')) then
				GameTooltipTextLeft2:SetText('|cffFF66CC'..GameTooltipTextLeft2:GetText()..'|r')
			end
		end
		
		-- Tooltip level text
		for i = 2, GameTooltip:NumLines() do
			if (_G['GameTooltipTextLeft'..i]:GetText():find('^'..TOOLTIP_UNIT_LEVEL:gsub('%%s', '.+'))) then
				_G['GameTooltipTextLeft'..i]:SetText(GetFormattedUnitString(unit))
			end
		end
		
		-- Mouse over target with raidicon support
		if (C.tooltip.mouseovertarget) then
			AddMouseoverTarget(self, unit)
		end
		
		-- Pvp flag prefix
		for i = 3, GameTooltip:NumLines() do
			if (_G['GameTooltipTextLeft'..i]:GetText():find(PVP_ENABLED)) then
				_G['GameTooltipTextLeft'..i]:SetText(nil)
				GameTooltipTextLeft1:SetText(GetUnitPVPIcon(unit)..GameTooltipTextLeft1:GetText())
			end
		end
		
		-- Raid icon, want to see the raidicon on the left
		GameTooltipTextLeft1:SetText(GetUnitRaidIcon(unit)..GameTooltipTextLeft1:GetText())
		
		-- Afk and dnd prefix
		if (UnitIsAFK(unit)) then
			self:AppendText('|cff00ff00 <AFK>|r')
		elseif (UnitIsDND(unit)) then
			self:AppendText('|cff00ff00 <DND>|r')
		end
		
		-- Move the healthbar inside the tooltip
		if GameTooltipStatusBar:IsShown() then
			self:AddLine(' ')
			GameTooltipStatusBar:ClearAllPoints()
			GameTooltipStatusBar:SetPoint('LEFT', self:GetName()..'TextLeft'..self:NumLines(), 1, -3)
			GameTooltipStatusBar:SetPoint('RIGHT', self, -10, 0)
		end
		
		-- Border coloring
		if (C.tooltip.reactionbordercolor) then
			local r, g, b = UnitSelectionColor(unit)
			self:SetBackdropBorderColor(r, g, b)
		end
		
		-- Dead or ghost recoloring
		if (UnitIsDead(unit) or UnitIsGhost(unit)) then
			GameTooltipStatusBar:SetBackdropColor(0.5, 0.5, 0.5, 0.3)
		end
	end
end)

GameTooltip:HookScript('OnTooltipCleared', function(self)
	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0.5, 3)
	GameTooltipStatusBar:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -1, 3)
	GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)
	
	if (C.tooltip.reactionbordercolor) then
		self:SetBackdropColor(.7, .7, .7, 1)
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