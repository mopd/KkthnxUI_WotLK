local K, C, L = unpack(select(2, ...));
if C["nameplate"].enable ~= true then return end

local numChildren = -1
local frames = {}

local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if C["nameplate"].trackauras == true then
	NamePlates:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

-- Hide Objects
local function QueueObject(parent, object)
	parent.queue = parent.queue or {}
	parent.queue[object] = true
end

local function HideObjects(frame)
	for object in pairs(frame.queue) do
		if object:GetObjectType() == "Texture" then
			object:SetTexture("")
		elseif object:GetObjectType() == "FontString" then
			object:SetWidth(0.001)
		elseif object:GetObjectType() == "StatusBar" then
			object:SetStatusBarTexture("")
		else
			object:Hide()
		end
	end
end

local function HideDrunkenText(frame, ...)
	if frame and frame.oldlevel and frame.oldlevel:IsShown() then
		frame.oldlevel:Hide()
	end
end

local function Abbrev(name)
	local newname = (string.len(name) > 18) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return K.UTF(newname, 18, false)
end

-- Create aura icons
local function CreateAuraIcon(parent)
	local button = CreateFrame("Frame", nil, parent)
	button:SetWidth(C["nameplate"].aurassize)
	button:SetHeight(C["nameplate"].aurassize)
	
	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", K.noscalemult, -K.noscalemult)
	button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -K.noscalemult, K.noscalemult)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	
	local AuraBackdrop = CreateFrame('Frame', nil, button)
	AuraBackdrop:SetFrameStrata('BACKGROUND')
	AuraBackdrop:SetPoint('TOPLEFT', -2, 2)
	AuraBackdrop:SetPoint('BOTTOMRIGHT', 2, -2)
	AuraBackdrop:SetBackdrop({
		BgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
		edgeFile = C["media"].glow, 
		edgeSize = 3,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	AuraBackdrop:SetBackdropBorderColor(0, 0, 0)
	
	button.cd = CreateFrame("Cooldown", nil, button)
	button.cd:SetAllPoints(button)
	button.cd:SetReverse(true)
	
	button.count = button:CreateFontString(nil, "OVERLAY")
	button.count:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
	button.count:SetShadowOffset(C["font"].nameplates_font_shadow and 1 or 0, C["font"].nameplates_font_shadow and -1 or 0)
	button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	
	return button
end

-- Update an aura icon
local function UpdateAuraIcon(button, unit, index, filter)
	local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitAura(unit, index, filter)
	
	button.icon:SetTexture(icon)
	button.cd:SetCooldown(expirationTime - duration, duration)
	button.expirationTime = expirationTime
	button.duration = duration
	button.spellID = spellID
	if count > 1 then
		button.count:SetText(count)
	else
		button.count:SetText("")
	end
	button.cd:SetScript("OnUpdate", function(self)
		if not button.cd.timer then
			self:SetScript("OnUpdate", nil)
			return
		end
		button.cd.timer.text:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
		button.cd.timer.text:SetShadowOffset(C["font"].nameplates_font_shadow and 1 or 0, C["font"].nameplates_font_shadow and -1 or 0)
	end)
	button:Show()
end

-- Filter auras on nameplate, and determine if we need to update them or not
local function OnAura(frame, unit)
	if not frame.icons or not frame.unit then return end
	local i = 1
	for index = 1, 40 do
		if i > C["nameplate"].width / C["nameplate"].aurassize then return end
		local match
		local name, _, _, _, _, duration, _, caster, _, _, spellid = UnitAura(frame.unit, index, "HARMFUL")
		
		if C["nameplate"].trackauras == true then
			if K.DebuffWhiteList[name] and caster == "player" then match = true end
		end
		
		if duration and match == true then
			if not frame.icons[i] then frame.icons[i] = CreateAuraIcon(frame) end
			local icon = frame.icons[i]
			if i == 1 then icon:SetPoint("LEFT", frame.icons, "LEFT") end
			if i ~= 1 and i <= C["nameplate"].width / C["nameplate"].aurassize then icon:SetPoint("LEFT", frame.icons[i-1], "RIGHT", 2, 0) end
			i = i + 1
			UpdateAuraIcon(icon, frame.unit, index, "HARMFUL")
		end
	end
	for index = i, #frame.icons do frame.icons[index]:Hide() end
end

local function UpdateFrame(frame)
	local name = frame.oldname:GetText()
	
	-- Name by Threat
	if(frame.region:IsShown()) then
		local _, val = frame.region:GetVertexColor()
		if(val > 0.7) then
			frame.name:SetTextColor(1, 1, 0)
		else
			frame.name:SetTextColor(1, 0, 0)
		end
	else
		frame.name:SetTextColor(1, 1, 1)
	end
	
	-- Health Value
	local minHealth, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local f =(valueHealth/maxHealth)*100
	
	if(f < 100) and valueHealth > 1 then
		frame.hp.value:SetText(K.ShortValue(valueHealth))
	else
		frame.hp.value:SetText("")
	end
	
	if(f <= 35 and f >= 25) then
		frame.hp.value:SetTextColor(253/255, 238/255, 80/255)
	elseif(f < 25 and f >= 20) then
		frame.hp.value:SetTextColor(250/255, 130/255, 0/255)
	elseif(f < 20) then
		frame.hp.value:SetTextColor(200/255, 20/255, 40/255)
	else
		frame.hp.value:SetTextColor(1,1,1)
	end	
	
	-- Highlight on Plate
	if(UnitName('target') and frame:GetAlpha() == 1) then
		frame.select:Show()
		frame.hp:SetSize(C["nameplate"].width, C["nameplate"].height)
	else
		frame.select:Hide()
		frame.hp:SetSize(C["nameplate"].width, C["nameplate"].height)	
	end		
end

local function UpdateObjects(frame)
	frame = frame:GetParent()
	local name = frame.oldname:GetText()
	
	local r, g, b = frame.level:GetTextColor()
	if(frame.boss:IsShown()) then
		frame.name:SetText('|cffff0000B|r ' .. frame.oldname:GetText())
	elseif C["nameplate"].name_abbrev == true and C["nameplate"].track_auras ~= true then
		frame.name:SetText(format('|cff%02x%02x%02x', r*255, g*255, b*255) .. tonumber(frame.level:GetText()) .. (frame.elite:IsShown() and '+' or '') .. '|r ' .. frame.oldname:GetText())
	else
		frame.name:SetText(frame.oldname:GetText())
	end	
	
	frame.hp:ClearAllPoints()
	frame.hp:SetSize(C["nameplate"].width, C["nameplate"].height)	
	frame.hp:SetPoint('CENTER', frame, 0, 8)		
	frame.name:SetPoint('BOTTOM', frame.hp, 'TOP', 0, 4)
	
	-- Aura tracking
	if C["nameplate"].trackauras == true then
		if frame.icons then return end
		frame.icons = CreateFrame("Frame", nil, frame)
		frame.icons:SetPoint("BOTTOMLEFT", frame.hp, "TOPLEFT", 0, C["font"].nameplates_font_size + 7)
		frame.icons:SetWidth(20 + C["nameplate"].width)
		frame.icons:SetHeight(25)
		frame.icons:SetFrameLevel(frame.hp:GetFrameLevel() + 2)
		frame:RegisterEvent("UNIT_AURA")
		frame:HookScript("OnEvent", OnAura)
	end
	
	HideObjects(frame)
end

local function UpdateCastbar(frame)
	frame:ClearAllPoints()
	frame:SetSize(C["nameplate"].width, C["nameplate"].height)
	frame:SetPoint('TOP', frame:GetParent().hp, 'BOTTOM', 0, -5)
	frame:GetStatusBarTexture():SetHorizTile(true)
	
	if(frame.shield:IsShown()) then
		frame:SetStatusBarColor(0.9, 0, 1.0, 0.6)
	end
end	

local OnValueChanged = function(self)
	if self.needFix then
		UpdateCastbar(self)
		self.needFix = nil
	end
end

local OnSizeChanged = function(self)
	self.needFix = true
end

local function OnHide(frame)
	frame.cb:Hide()
	frame.hasClass = nil
	
	if frame.icons then
		for _, icon in ipairs(frame.icons) do
			icon:Hide()
		end
	end
	
	frame:SetScript("OnUpdate",nil)
end

--- Nameplate Style
local function SkinObjects(frame)
	local hp, cb = frame:GetChildren()
	local threat, hpborder, cbshield, cbborder, cbicon, overlay, oldname, level, bossicon, raidicon, elite = frame:GetRegions()
	
	frame.healthOriginal = hp	

	local HPBackdrop = CreateFrame('Frame', nil, hp)
	HPBackdrop:SetFrameStrata('BACKGROUND')
	HPBackdrop:SetPoint('TOPLEFT', -3, 3)
	HPBackdrop:SetPoint('BOTTOMRIGHT', 3, -3)
	HPBackdrop:SetBackdrop({
		BgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
		edgeFile = C["media"].glow, 
		edgeSize = 3,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	HPBackdrop:SetBackdropBorderColor(0, 0, 0)
	
	local Background = hp:CreateTexture(nil, 'BORDER')
	Background:SetAllPoints()
	Background:SetTexture(1/3, 1/3, 1/3)
	
	hp:HookScript('OnShow', UpdateObjects)
	hp:SetStatusBarTexture(C["media"].texture)
	frame.hp = hp
	
	hp.value = hp:CreateFontString(nil, "OVERLAY")	
	hp.value:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
	hp.value:SetPoint("LEFT", hp, "RIGHT", 5, 0)
	hp.value:SetShadowOffset(0, -0)
	
	-- selection highlight
	local select = frame:CreateTexture(nil, 'OVERLAY')
	select:SetAllPoints(hp)
	select:SetTexture(C["media"].highlight)
	select:SetTexCoord(0,1,1,0)
	select:SetVertexColor(1,1,1,0.4)
	select:SetBlendMode('ADD')
	select:Hide()
	frame.select = select
	
	local CBBackdrop = CreateFrame('Frame', nil, cb)
	CBBackdrop:SetFrameStrata('BACKGROUND')
	CBBackdrop:SetPoint('TOPLEFT', -3, 3)
	CBBackdrop:SetPoint('BOTTOMRIGHT', 3, -3)
	CBBackdrop:SetBackdrop({
		BgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
		edgeFile = C["media"].glow, 
		edgeSize = 3,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	CBBackdrop:SetBackdropBorderColor(0, 0, 0)
	
	local Background = cb:CreateTexture(nil, 'BORDER')
	Background:SetAllPoints()
	Background:SetTexture(1/3, 1/3, 1/3)
	
	cbicon:ClearAllPoints()
	cbicon:SetPoint("TOPRIGHT", hp, "TOPLEFT", -4, 0)		
	cbicon:SetSize(C["nameplate"].cbiconsize, C["nameplate"].cbiconsize)
	cbicon:SetTexCoord(.07, .93, .07, .93)
	
	local cbiconbg = cb:CreateTexture(nil, 'BACKGROUND')
	cbiconbg:SetPoint('BOTTOMRIGHT', cbicon, K.noscalemult, -K.noscalemult)
	cbiconbg:SetPoint('TOPLEFT', cbicon, -K.noscalemult, K.noscalemult)
	cbiconbg:SetTexture(0, 0, 0)
	
	cb.icon = cbicon
	cb.shield = cbshield
	cb:HookScript('OnShow', UpdateCastbar)
	cb:HookScript('OnSizeChanged', OnSizeChanged)
	cb:HookScript('OnValueChanged', OnValueChanged)	
	cb:SetStatusBarTexture(C["media"].texture)
	frame.cb = cb
	
	-- Nameplate Name
	local name = hp:CreateFontString(nil, 'OVERLAY')
	name:SetPoint('LEFT', 3, 0)
	name:SetPoint('RIGHT', -3, 0)
	name:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
	name:SetJustifyH('LEFT')
	frame.oldname = oldname
	frame.name = name
	name:SetShadowOffset(0, -0)
	
	-- Raid Icon
	raidicon:ClearAllPoints()
	raidicon:SetParent(hp)	
	raidicon:SetPoint("TOPRIGHT", hp, "TOPLEFT", -4, 0)
	raidicon:SetSize(C["nameplate"].cbiconsize, C["nameplate"].cbiconsize)
	raidicon:SetTexture(C["media"].raidicons)		
	
	frame.level = level
	frame.elite = elite
	frame.boss = bossicon	
	
	QueueObject(frame, threat)
	QueueObject(frame, hpborder)
	QueueObject(frame, cbshield)
	QueueObject(frame, cbborder)
	QueueObject(frame, overlay)
	QueueObject(frame, oldname)
	QueueObject(frame, level)
	QueueObject(frame, bossicon)
	QueueObject(frame, elite)
	
	UpdateObjects(hp)
	UpdateCastbar(cb)
	
	frame:HookScript('OnHide', OnHide)	
	frames[frame] = true
end

-- Update
local select = select
local function HookFrames(...)
	for index = 1, select('#', ...) do
		local frame = select(index, ...)
		local region = frame:GetRegions()
		
		if(not frames[frame] and not frame:GetName() and region and region:GetObjectType() == 'Texture' and region:GetTexture() == [=[Interface\TargetingFrame\UI-TargetingFrame-Flash]=]) then
			SkinObjects(frame)
			frame.region = region
		end
	end
end

-- Scan all visible nameplate for a known unit
local function CheckUnit_Guid(frame, ...)
	if UnitExists("target") and frame:GetAlpha() == 1 and UnitName("target") == frame.name:GetText() then
		frame.guid = UnitGUID("target")
		frame.unit = "target"
		OnAura(frame, "target")
	elseif frame.select:IsShown() and UnitExists("mouseover") and UnitName("mouseover") == frame.name:GetText() then
		frame.guid = UnitGUID("mouseover")
		frame.unit = "mouseover"
		OnAura(frame, "mouseover")
	else
		frame.unit = nil
	end
end

-- Attempt to match a nameplate with a GUID from the combat log
local function MatchGUID(frame, destGUID, spellID)
	if not frame.guid then return end
	
	if frame.guid == destGUID then
		for _, icon in ipairs(frame.icons) do
			if icon.spellID == spellID then
				icon:Hide()
			end
		end
	end
end

-- Run a function for all visible nameplates, we use this for the blacklist, to check unitguid, and to hide drunken text
local function ForEachPlate(functionToRun, ...)
	for frame in pairs(frames) do
		if frame:IsShown() then
			functionToRun(frame, ...)
		end
	end
end

CreateFrame('Frame'):SetScript('OnUpdate', function(self, elapsed)
	if(WorldFrame:GetNumChildren() ~= numChildren) then
		numChildren = WorldFrame:GetNumChildren()
		HookFrames(WorldFrame:GetChildren())
	end
	
	if(self.elapsed and self.elapsed > 0.2) then
		for frame in pairs(frames) do
			UpdateFrame(frame)
		end
		
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
	
	ForEachPlate(HideDrunkenText)
	ForEachPlate(CheckUnit_Guid)
	
end)

function NamePlates:COMBAT_LOG_EVENT_UNFILTERED(_, event, ...)
	if event == "SPELL_AURA_REMOVED" then
		local _, sourceGUID, _, _, _, destGUID, _, _, _, spellID = ...
		
		if sourceGUID == UnitGUID("player") then
			ForEachPlate(MatchGUID, destGUID, spellID)
		end
	end
end

-- Only show Plates in Combat
if C["nameplate"].combat == true then
	NamePlates:RegisterEvent("PLAYER_REGEN_ENABLED")
	NamePlates:RegisterEvent("PLAYER_REGEN_DISABLED")
	
	function NamePlates:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end
	
	function NamePlates:PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end
end

NamePlates:RegisterEvent("PLAYER_ENTERING_WORLD")
function NamePlates:PLAYER_ENTERING_WORLD()
	if C["nameplate"].combat == true then
		if InCombatLockdown() then
			SetCVar("nameplateShowEnemies", 1)
		else
			SetCVar("nameplateShowEnemies", 0)
		end
	end
end