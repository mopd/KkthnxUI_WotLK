local K, C, L = unpack(select(2, ...));
if C["nameplate"].enable ~= true then return end

local numChildren = -1
local frames = {}

local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

-- Totem List
local totems = {
	["Earth Elemental Totem"] = [[Interface\Icons\Spell_nature_earthelemental_totem]],
	["Fire Elemental Totem"] = [[Interface\Icons\spell_fire_elemental_totem]],
	["Fire Resistance Totem"] = [[Interface\Icons\Spell_fireresistancetotem_01]],
	["Flametongue Totem"] = [[Interface\Icons\Spell_nature_guardianward]],
	["Frost Resistance Totem"] = [[Interface\Icons\Spell_frostresistancetotem_01]],
	["Healing Stream Totem"] = [[Interface\Icons\Inv_spear_04]],
	["Magma Totem"] = [[Interface\Icons\Spell_fire_selfdestruct]],
	["Mana Spring Totem"] = [[Interface\Icons\Spell_nature_manaregentotem]],
	["Nature Resistance Totem"] = [[Interface\Icons\Spell nature natureresistancetotem]],
	["Searing Totem"] = [[Interface\Icons\Spell_fire_searingtotem]],
	["Stoneclaw Totem"] = [[Interface\Icons\Spell_nature_stoneclawtotem]],
	["Stoneskin Totem"] = [[Interface\Icons\Spell_nature_stoneskintotem]],
	["Strength of Earth Totem"] = [[Interface\Icons\Spell_nature_earthbindtotem]],
	["Windfury Totem"] = [[Interface\Icons\Spell_nature_windfury]],
	["Totem of Wrath"] =  [[Interface\Icons\Spell_fire_totemofwrath]],
	["Wrath of Air Totem"] = [[Interface\Icons\Spell_nature_slowingtotem]],
}

-- hide objects
local function QueueObject(parent, object)
	parent.queue = parent.queue or {}
	parent.queue[object] = true
end

local function HideObjects(parent)
	for object in pairs(parent.queue) do
		if(object:GetObjectType() == 'Texture') then
			object:SetTexture(nil)
			object.SetTexture = K.Dummy
		elseif (object:GetObjectType() == 'FontString') then
			object.ClearAllPoints = K.Dummy
			object.SetFont = K.Dummy
			object.SetPoint = K.Dummy
			object:Hide()
			object.Show = K.Dummy
			object.SetText = K.Dummy
			object.SetShadowOffset = K.Dummy			
		else
			object:Hide()
			object.Show = K.Dummy
		end
	end
end

-- update
local function UpdateFrame(frame)
	local name = frame.oldname:GetText()
	
	-- color name by threat
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
	
	-- current health value
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
	
	-- highlight selected plate
	if(UnitName('target') and frame:GetAlpha() == 1) then
		frame.select:Show()
		if not totems[name] then
			frame.hp:SetSize(C["nameplate"].width, C["nameplate"].height)
		end
	else
		frame.select:Hide()
		if not totems[name] then
			frame.hp:SetSize(C["nameplate"].width, C["nameplate"].height)
		end		
	end		
end

local function UpdateObjects(frame)
	frame = frame:GetParent()
	local name = frame.oldname:GetText()
	
	local r, g, b = frame.level:GetTextColor()
	if(frame.boss:IsShown()) then
		frame.name:SetText('|cffff0000B|r ' .. frame.oldname:GetText())
	else
		frame.name:SetText(format('|cff%02x%02x%02x', r*255, g*255, b*255) .. tonumber(frame.level:GetText()) .. (frame.elite:IsShown() and '+' or '') .. '|r ' .. frame.oldname:GetText())
	end	
	
	-- Nameplate Totem Icons
	if totems[name] then		
		if not frame.totem then
			frame.icon:SetTexCoord(.08, .92, .08, .92)
			frame.totem = true
		end
		if frame.name ~= name then
			frame.icon:Show()
			frame.Ticon:Show()
			frame.icon:SetTexture(totems[name])
			frame.name:ClearAllPoints()
			frame.hp:ClearAllPoints()
			frame.hp:SetSize(C["nameplate"].totemsize, C["nameplate"].height)	
			frame.hp:SetPoint('TOP', frame.icon, 'BOTTOM', 0, -2)			
		end
	else
		if frame.totem then
			frame.icon:Hide()
			frame.Ticon:Hide()
			frame.icon:SetTexture()
			frame.totem = nil
		end
		frame.hp:ClearAllPoints()
		frame.hp:SetSize(C["nameplate"].width, C["nameplate"].height)	
		frame.hp:SetPoint('CENTER', frame, 0, 8)		
		frame.name:SetPoint('BOTTOM', frame.hp, 'TOP', 0, 4)
	end
	
	frame.level:ClearAllPoints()
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
	
	frame:SetScript("OnUpdate",nil)
end

-- Nameplate Style
local function SkinObjects(frame)
	local hp, cb = frame:GetChildren()
	local threat, hpborder, cbshield, cbborder, cbicon, overlay, oldname, level, bossicon, raidicon, elite = frame:GetRegions()
	
	frame.healthOriginal = hp	
	--[[
	local Backdrop = hp:CreateTexture(nil, 'BACKGROUND')
	Backdrop:SetPoint('BOTTOMLEFT', -K.noscalemult, -K.noscalemult)
	Backdrop:SetPoint('TOPRIGHT', K.noscalemult, K.noscalemult)
	Backdrop:SetTexture(0, 0, 0)
	]]
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
	--HPBackdrop:SetBackdropColor(0.15, 0.15, 0.15, 0.6)
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
	--[[
	local Backdrop = cb:CreateTexture(nil, 'BACKGROUND')
	Backdrop:SetPoint('BOTTOMLEFT', -K.noscalemult, -K.noscalemult)
	Backdrop:SetPoint('TOPRIGHT', K.noscalemult, K.noscalemult)
	Backdrop:SetTexture(0, 0, 0)
	]]
	local CBBackdrop = CreateFrame('Frame', nil, cb)
	CBBackdrop:SetFrameStrata('BACKGROUND')
	CBBackdrop:SetPoint('TOPLEFT', -3, 3)
	CBBackdrop:SetPoint('BOTTOMRIGHT', 3, -4)
	CBBackdrop:SetBackdrop({
		BgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
		edgeFile = C["media"].glow, 
		edgeSize = 3,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	--CBBackdrop:SetBackdropColor(0.15, 0.15, 0.15, 0.6)
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
	--cbiconbg:SetTexture(0, 0, 0)
	cbiconbg:SetTexture(C["media"].glow)
	
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
	
	-- Nameplate Name Totem Icons
	local icon = frame:CreateTexture(nil, "BACKGROUND")
	icon:SetPoint("CENTER", frame, 0, 28)
	icon:SetSize(C["nameplate"].totemsize, C["nameplate"].totemsize)
	icon:Hide()
	frame.icon = icon
	
	local Ticon = frame:CreateTexture(nil, 'BACKGROUND')
	Ticon:SetPoint('BOTTOMRIGHT', icon, K.noscalemult, -K.noscalemult)
	Ticon:SetPoint('TOPLEFT', icon, -K.noscalemult, K.noscalemult)
	Ticon:Hide()
	Ticon:SetTexture(0, 0, 0)
	frame.Ticon = Ticon
	
	-- raid icon
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

-- update
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
end)


-- Only show nameplates when in combat
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