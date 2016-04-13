local K, C, L = unpack(select(2, ...));
if C["nameplate"].enable ~= true then return end

local numChildren = -1
local frames = {}

if(C["nameplate"].showhealth ~= true) then
	C["nameplate"].hp_height = 7
	C["nameplate"].icon_size = 20
end

local NamePlates = CreateFrame("Frame", "NamePlates", UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if(C["nameplate"].trackdebuffs == true or C["nameplate"].trackcc == true) then
	NamePlates:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local function QueueObject(parent, object)
	parent.queue = parent.queue or {}
	parent.queue[object] = true
end

local function HideObjects(parent)
	for object in pairs(parent.queue) do
		if(object:GetObjectType() == "Texture") then
			object:SetTexture(nil)
			object.SetTexture = K.Dummy
		elseif(object:GetObjectType() == "FontString") then
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

local function CreateVirtualFrame(parent, point)
	if(point == nil) then point = parent end
	
	if(point.backdrop) then return end
	parent.backdrop = parent:CreateTexture(nil, "BORDER")
	parent.backdrop:SetDrawLayer("BORDER", -8)
	parent.backdrop:SetPoint("TOPLEFT", point, "TOPLEFT", -K.noscalemult * 3, K.noscalemult * 3)
	parent.backdrop:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", K.noscalemult * 3, -K.noscalemult * 3)
	parent.backdrop:SetTexture(0, 0, 0, 1)
	
	parent.backdrop2 = parent:CreateTexture(nil, "BORDER")
	parent.backdrop2:SetDrawLayer("BORDER", -7)
	parent.backdrop2:SetAllPoints(point)
	parent.backdrop2:SetTexture(unpack(C["media"].backdrop_color))
	
	parent.bordertop = parent:CreateTexture(nil, "BORDER")
	parent.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -K.noscalemult * 2, K.noscalemult * 2)
	parent.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", K.noscalemult * 2, K.noscalemult * 2)
	parent.bordertop:SetHeight(K.noscalemult)
	parent.bordertop:SetTexture(unpack(C["media"].border_color))
	parent.bordertop:SetDrawLayer("BORDER", -7)
	
	parent.borderbottom = parent:CreateTexture(nil, "BORDER")
	parent.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -K.noscalemult * 2, -K.noscalemult * 2)
	parent.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", K.noscalemult * 2, -K.noscalemult * 2)
	parent.borderbottom:SetHeight(K.noscalemult)
	parent.borderbottom:SetTexture(unpack(C["media"].border_color))
	parent.borderbottom:SetDrawLayer("BORDER", -7)
	
	parent.borderleft = parent:CreateTexture(nil, "BORDER")
	parent.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -K.noscalemult * 2, K.noscalemult * 2)
	parent.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", K.noscalemult * 2, -K.noscalemult * 2)
	parent.borderleft:SetWidth(K.noscalemult)
	parent.borderleft:SetTexture(unpack(C["media"].border_color))
	parent.borderleft:SetDrawLayer("BORDER", -7)
	
	parent.borderright = parent:CreateTexture(nil, "BORDER")
	parent.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", K.noscalemult * 2, K.noscalemult * 2)
	parent.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -K.noscalemult * 2, -K.noscalemult * 2)
	parent.borderright:SetWidth(K.noscalemult)
	parent.borderright:SetTexture(unpack(C["media"].border_color))
	parent.borderright:SetDrawLayer("BORDER", -7)	
end

local function SetVirtualBorder(parent, r, g, b)
	parent.bordertop:SetTexture(r, g, b)
	parent.borderbottom:SetTexture(r, g, b)
	parent.borderleft:SetTexture(r, g, b)
	parent.borderright:SetTexture(r, g, b)
end

local goodR, goodG, goodB = unpack(C["nameplate"].goodcolor)
local badR, badG, badB = unpack(C["nameplate"].badcolor)
local transitionR, transitionG, transitionB = unpack(C["nameplate"].transitioncolor)
local function UpdateThreat(frame, elapsed)
	frame.hp:Show()
	if(frame.hasClass == true) then return end
	
	if(C["nameplate"].enhancethreat ~= true) then
		if(frame.region:IsShown()) then
			local _, val = frame.region:GetVertexColor()
			if(val > 0.7) then
				SetVirtualBorder(frame.hp, transitionR, transitionG, transitionB)
			else
				SetVirtualBorder(frame.hp, badR, badG, badB)
			end
		else
			SetVirtualBorder(frame.hp, unpack(C["media"].border_color))
		end
	else
		if not frame.region:IsShown() then
			if(InCombatLockdown() and frame.isFriendly ~= true) then
				if(K.Role == "Tank") then
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				else
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				end
			else
				frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
				frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
			end
		else
			local r, g, b = frame.region:GetVertexColor()
			if(g + b == 0) then
				if(K.Role == "Tank") then
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				else
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				end
			else
				frame.hp:SetStatusBarColor(transitionR, transitionG, transitionB)	
				frame.hp.hpbg:SetTexture(transitionR, transitionG, transitionB, 0.25)
			end
		end
	end
end

local function CreateAuraIcon(parent)
	local button = CreateFrame("Frame", nil, parent)
	button:SetWidth(20)
	button:SetHeight(20)
	
	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetTexture(unpack(C["media"].backdrop_color))
	button.bg:SetAllPoints(button)
	
	button.bord = button:CreateTexture(nil, "BORDER")
	button.bord:SetTexture(unpack(C["media"].border_color))
	button.bord:SetPoint("TOPLEFT", button, "TOPLEFT", K.noscalemult, -K.noscalemult)
	button.bord:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -K.noscalemult, K.noscalemult)
	
	button.bg2 = button:CreateTexture(nil, "ARTWORK")
	button.bg2:SetTexture(unpack(C["media"].border_color))
	button.bg2:SetPoint("TOPLEFT", button, "TOPLEFT", K.noscalemult * 2, -K.noscalemult * 2)
	button.bg2:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -K.noscalemult * 2, K.noscalemult * 2)	
	
	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", K.noscalemult * 3, -K.noscalemult * 3)
	button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -K.noscalemult * 3, K.noscalemult * 3)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.cd = CreateFrame("Cooldown", nil, button)
	button.cd:SetAllPoints(button)
	button.cd:SetReverse(true)
	button.count = button:CreateFontString(nil, "OVERLAY")
	button.count:SetFont(C["font"].nameplates_font, 10, C["font"].nameplates_font_style)
	button.count:SetShadowColor(0, 0, 0, 0.4)
	button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 2)
	return button
end

local function UpdateAuraIcon(button, unit, index, filter)
	local name, _, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitAura(unit, index, filter)
	
	button.icon:SetTexture(icon)
	button.cd:SetCooldown(expirationTime - duration, duration)
	button.expirationTime = expirationTime
	button.duration = duration
	button.spellID = spellID
	if(count > 1) then
		button.count:SetText(count)
	else
		button.count:SetText("")
	end
	button.cd:SetScript("OnUpdate", function(self)
		if not button.cd.timer then
			self:SetScript("OnUpdate", nil)
			return
		end
		button.cd.timer.text:SetFont(C["font"].nameplates_font, 10, C["font"].nameplates_font_style)
		button.cd.timer.text:SetShadowColor(0, 0, 0, 0.4)
	end)
	button:Show()
end

local function OnAura(frame, unit)
	if not frame.icons or not frame.unit then return end
	local i = 1
	for index = 1,40 do
		if(i > 5) then return end
		local match
		local name, _, _, _, _, duration, _, caster, _, _, spellid = UnitAura(frame.unit, index, "HARMFUL")
		
		if(C["nameplate"].trackdebuffs == true) then
			if(caster == "player") then match = true end
		end
		
		if(C["nameplate"].trackcc == true) then
			if(K.DebuffWhiteList[name]) then match = true end
		end
		
		if(duration and match == true) then
			if not frame.icons[i] then frame.icons[i] = CreateAuraIcon(frame) end
			local icon = frame.icons[i]
			if(i == 1) then icon:SetPoint("RIGHT", frame.icons, "RIGHT") end
			if(i ~= 1 and i <= 5) then icon:SetPoint("RIGHT", frame.icons[i - 1], "LEFT", -2, 0) end
			i = i + 1
			UpdateAuraIcon(icon, frame.unit, index, "HARMFUL")
		end
	end
	for index = i, #frame.icons do frame.icons[index]:Hide() end
end

local function UpdateCastbar(frame)
	frame:ClearAllPoints()
	frame:SetSize(C["nameplate"].cb_width, C["nameplate"].cb_height)
	frame:SetPoint("TOP", frame:GetParent().hp, "BOTTOM", 0, -8)
	frame:GetStatusBarTexture():SetHorizTile(true)
	if(frame.shield:IsShown()) then
		frame:SetStatusBarColor(0.78, 0.25, 0.25, 1)
	end
end	

local function UpdateCastText(frame, curValue)
	local minValue, maxValue = frame:GetMinMaxValues()
	
	if(UnitChannelInfo("target")) then
		frame.time:SetFormattedText("%.1f ", curValue)
		frame.name:SetText(select(1, (UnitChannelInfo("target"))))
	end
	
	if(UnitCastingInfo("target")) then
		frame.time:SetFormattedText("%.1f ", maxValue - curValue)
		frame.name:SetText(select(1, (UnitCastingInfo("target"))))
	end
end

local OnValueChanged = function(self, curValue)
	UpdateCastText(self, curValue)
	if(self.needFix) then
		UpdateCastbar(self)
		self.needFix = nil
	end
end

local OnSizeChanged = function(self)
	self.needFix = true
end

local function OnHide(frame)
	frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
	frame.overlay:Hide()
	frame.cb:Hide()
	frame.unit = nil
	frame.guid = nil
	frame.hasClass = nil
	frame.isFriendly = nil
	frame.hp.rcolor = nil
	frame.hp.gcolor = nil
	frame.hp.bcolor = nil
	if(frame.icons) then
		for _, icon in ipairs(frame.icons) do
			icon:Hide()
		end
	end
	
	frame:SetScript("OnUpdate", nil)
end

local function Colorize(frame)
	local r, g, b = frame.healthOriginal:GetStatusBarColor()
	
	if frame.hasclass == true then frame.isFriendly = false return end
	
	if(g + b == 0) then
		r, g, b = 222/255, 95/255, 95/255
		frame.isFriendly = false
	elseif(r + b == 0) then
		r, g, b = 0.31, 0.45, 0.63
		frame.isFriendly = true
	elseif(r + g > 1.95) then
		r, g, b = 218/255, 197/255, 92/255
		frame.isFriendly = false
	elseif(r + g == 0) then
		r, g, b = 5/255, 175/255, 76/255
		frame.isFriendly = true
	else
		frame.isFriendly = false
	end
	frame.hasClass = false
	
	frame.hp:SetStatusBarColor(r, g, b)
end

local function UpdateObjects(frame)
	local frame = frame:GetParent()
	
	local r, g, b = frame.hp:GetStatusBarColor()
	
	frame.hp:ClearAllPoints()
	frame.hp:SetSize(C["nameplate"].hp_width, C["nameplate"].hp_height)
	frame.hp:SetPoint("TOP", frame, "TOP", 0, -15)
	frame.hp:GetStatusBarTexture():SetHorizTile(true)
	
	frame.hp:SetMinMaxValues(frame.healthOriginal:GetMinMaxValues())
	frame.hp:SetValue(frame.healthOriginal:GetValue())
	frame.healthOriginal:SetScript("OnValueChanged", function()
		frame.hp:SetMinMaxValues(frame.healthOriginal:GetMinMaxValues())
		frame.hp:SetValue(frame.healthOriginal:GetValue())
	end)
	
	Colorize(frame)
	frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor = frame.hp:GetStatusBarColor()
	frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
	SetVirtualBorder(frame.hp, unpack(C["media"].border_color))
	if(C["nameplate"].enhancethreat == true) then
		frame.hp.name:SetTextColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
	end
	
	frame.hp.name:SetText(frame.hp.oldname:GetText())
	
	local level, elite, mylevel = tonumber(frame.hp.oldlevel:GetText()), frame.hp.elite:IsShown(), UnitLevel("player")
	frame.hp.level:ClearAllPoints()
	if(C["nameplate"].showhealth == true) then
		frame.hp.level:SetPoint("RIGHT", frame.hp, "RIGHT", 2, 1)
	else
		frame.hp.level:SetPoint("RIGHT", frame.hp, "LEFT", -1, 1)
	end
	
	frame.hp.level:SetTextColor(frame.hp.oldlevel:GetTextColor())
	if(frame.hp.boss:IsShown()) then
		frame.hp.level:SetText("??")
		frame.hp.level:SetTextColor(0.8, 0.05, 0)
		frame.hp.level:Show()
	elseif not elite and level == mylevel then
		frame.hp.level:Hide()
	else
		frame.hp.level:SetText(level .. (elite and "+" or ""))
		frame.hp.level:Show()
	end
	
	frame.overlay:ClearAllPoints()
	frame.overlay:SetAllPoints(frame.hp)
	
	if(C["nameplate"].trackdebuffs == true or C["nameplate"].trackcc == true) then
		if frame.icons then return end
		frame.icons = CreateFrame("Frame", nil, frame)
		frame.icons:SetPoint("BOTTOMRIGHT", frame.hp, "TOPRIGHT", 0, C["font"].nameplates_font_size * K.noscalemult + 5)
		frame.icons:SetWidth(20 + C["nameplate"].hp_width)
		frame.icons:SetHeight(25)
		frame.icons:SetFrameLevel(frame.hp:GetFrameLevel() + 2)
		frame:RegisterEvent("UNIT_AURA")
		frame:HookScript("OnEvent", OnAura)
	end	
	
	HideObjects(frame)
end

local function SkinObjects(frame)
	local hp, cb = frame:GetChildren()
	local threat, hpborder, cbshield, cbborder, cbicon, overlay, oldname, oldlevel, bossicon, raidicon, elite = frame:GetRegions()
	
	frame.healthOriginal = hp
	
	hp:SetStatusBarTexture(C["media"].texture)
	CreateVirtualFrame(hp)
	
	hp.level = hp:CreateFontString(nil, "OVERLAY")
	hp.level:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
	hp.level:SetShadowColor(0, 0, 0, 0.4)
	hp.level:SetTextColor(1, 1, 1)
	hp.level:SetShadowOffset(K.mult, -K.mult)
	hp.oldlevel = oldlevel
	hp.boss = bossicon
	hp.elite = elite
	
	if(C["nameplate"].showhealth == true) then
		hp.value = hp:CreateFontString(nil, "OVERLAY")
		hp.value:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
		hp.value:SetShadowColor(0, 0, 0, 0.4)
		hp.value:SetPoint("CENTER", 0, 1)
		hp.value:SetTextColor(1, 1, 1)
		hp.value:SetShadowOffset(K.mult, -K.mult)
	end
	
	hp.name = hp:CreateFontString(nil, "OVERLAY")
	hp.name:SetPoint("BOTTOMLEFT", hp, "TOPLEFT", -10, 3)
	hp.name:SetPoint("BOTTOMRIGHT", hp, "TOPRIGHT", 10, 3)
	hp.name:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
	hp.name:SetShadowColor(0, 0, 0, 0.4)
	hp.name:SetShadowOffset(K.mult, -K.mult)
	hp.oldname = oldname
	
	hp.hpbg = hp:CreateTexture(nil, "BORDER")
	hp.hpbg:SetAllPoints(hp)
	hp.hpbg:SetTexture(1, 1, 1, 0.25)
	
	hp:HookScript("OnShow", UpdateObjects)
	frame.hp = hp
	
	cb:SetFrameLevel(1)
	cb:SetStatusBarTexture(C["media"].texture)
	CreateVirtualFrame(cb)
	
	cb.time = cb:CreateFontString(nil, "ARTWORK")
	cb.time:SetPoint("RIGHT", cb, "LEFT", -1, 0)
	cb.time:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
	cb.time:SetShadowColor(0, 0, 0, 0.4)
	cb.time:SetTextColor(1, 1, 1)
	cb.time:SetShadowOffset(K.mult, -K.mult)
	
	cb.name = cb:CreateFontString(nil, "ARTWORK")
	cb.name:SetPoint("TOP", cb, "BOTTOM", 0, -3)
	cb.name:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size * K.noscalemult, C["font"].nameplates_font_style)
	cb.name:SetTextColor(1, 1, 1)
	cb.name:SetShadowColor(0, 0, 0, 0.4)
	cb.name:SetShadowOffset(K.mult, -K.mult)
	
	cbicon:ClearAllPoints()
	cbicon:SetPoint("TOPLEFT", hp, "TOPRIGHT", 8, 0)
	cbicon:SetSize(C["nameplate"].icon_size, C["nameplate"].icon_size)
	cbicon:SetTexCoord(.07, .93, .07, .93)
	cbicon:SetDrawLayer("OVERLAY")
	cb.icon = cbicon
	CreateVirtualFrame(cb, cb.icon)
	
	cb.shield = cbshield
	cbshield:ClearAllPoints()
	cb:HookScript("OnShow", UpdateCastbar)
	cb:HookScript("OnSizeChanged", OnSizeChanged)
	cb:HookScript("OnValueChanged", OnValueChanged)
	frame.cb = cb
	
	overlay:SetTexture(1, 1, 1, 0.15)
	overlay:SetAllPoints(hp)	
	frame.overlay = overlay
	
	raidicon:ClearAllPoints()
	raidicon:SetPoint("BOTTOM", hp, "TOP", 0, 16)
	raidicon:SetSize(C["nameplate"].icon_size * 1.4, C["nameplate"].icon_size * 1.4)
	raidicon:SetTexture([[Interface\AddOns\Tukui\medias\textures\raidiconK.blp]])
	frame.raidicon = raidicon
	
	QueueObject(frame, oldlevel)
	QueueObject(frame, threat)
	QueueObject(frame, hpborder)
	QueueObject(frame, cbshield)
	QueueObject(frame, cbborder)
	QueueObject(frame, oldname)
	QueueObject(frame, bossicon)
	QueueObject(frame, elite)
	
	UpdateObjects(hp)
	UpdateCastbar(cb)
	
	frame.hp:HookScript("OnShow", UpdateObjects)
	frame:HookScript("OnHide", OnHide)
	frames[frame] = true
end

local function CheckBlacklist(frame, ...)
	if(K.PlateBlacklist[frame.hp.name:GetText()]) then
		frame:SetScript("OnUpdate", function() end)
		frame.hp:Hide()
		frame.cb:Hide()
		frame.overlay:Hide()
		frame.hp.oldlevel:Hide()
	end
end

local function HideDrunkenText(frame, ...)
	if(frame and frame.hp.oldlevel and frame.hp.oldlevel:IsShown()) then
		frame.hp.oldlevel:Hide()
	end
end

local function AdjustNameLevel(frame, ...)
	if(UnitName("target") == frame.hp.name:GetText() and frame:GetAlpha() == 1) then
		frame.hp.name:SetDrawLayer("OVERLAY")
	else
		frame.hp.name:SetDrawLayer("BORDER")
	end
end

local function ShowHealth(frame, ...)
	local minHealth, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local d =(valueHealth / maxHealth) * 100
	
	if(C["nameplate"].showhealth == true) then
		frame.hp.value:SetText(K.ShortValue(valueHealth) .. " - " .. (string.format("%d%%", math.floor((valueHealth / maxHealth) *100))))
	end
	
	if(frame.hasClass == true or frame.isFriendly == true) then
		if(d <= 50 and d >= 20) then
			SetVirtualBorder(frame.hp, 1, 1, 0)
		elseif(d < 20) then
			SetVirtualBorder(frame.hp, 1, 0, 0)
		else
			SetVirtualBorder(frame.hp, unpack(C["media"].border_color))
		end
	elseif((frame.hasClass ~= true and frame.isFriendly ~= true) and C["nameplate"].enhancethreat == true) then
		SetVirtualBorder(frame.hp, unpack(C["media"].border_color))
	end
end

local function CheckUnit_Guid(frame, ...)
	if(UnitExists("target") and frame:GetAlpha() == 1 and UnitName("target") == frame.hp.name:GetText()) then
		frame.guid = UnitGUID("target")
		frame.unit = "target"
		OnAura(frame, "target")
	elseif(frame.overlay:IsShown() and UnitExists("mouseover") and UnitName("mouseover") == frame.hp.name:GetText()) then
		frame.guid = UnitGUID("mouseover")
		frame.unit = "mouseover"
		OnAura(frame, "mouseover")
	else
		frame.unit = nil
	end
end

local function MatchGUID(frame, destGUID, spellID)
	if not frame.guid then return end
	
	if(frame.guid == destGUID) then
		for _, icon in ipairs(frame.icons) do
			if(icon.spellID == spellID) then
				icon:Hide()
			end
		end
	end
end

local function ForEachPlate(functionToRun, ...)
	for frame in pairs(frames) do
		if(frame:IsShown()) then
			functionToRun(frame, ...)
		end
	end
end

local select = select
local function HookFrames(...)
	for index = 1, select("#", ...) do
		local frame = select(index, ...)
		local region = frame:GetRegions()
		
		if(not frames[frame] and not frame:GetName() and region and region:GetObjectType() == 'Texture' and region:GetTexture() == [=[Interface\TargetingFrame\UI-TargetingFrame-Flash]=]) then
			SkinObjects(frame)
			frame.region = region
		end
	end
end

CreateFrame("Frame"):SetScript("OnUpdate", function(self, elapsed)
	if(WorldFrame:GetNumChildren() ~= numChildren) then
		numChildren = WorldFrame:GetNumChildren()
		HookFrames(WorldFrame:GetChildren())
	end
	
	if(self.elapsed and self.elapsed > 0.2) then
		ForEachPlate(UpdateThreat, self.elapsed)
		ForEachPlate(AdjustNameLevel)
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
	
	ForEachPlate(ShowHealth)
	ForEachPlate(CheckBlacklist)
	ForEachPlate(HideDrunkenText)
	ForEachPlate(CheckUnit_Guid)
end)

function NamePlates:COMBAT_LOG_EVENT_UNFILTERED(_, event, _, _, sourceName, _, destGUID, _, _, spellID)
	if(event == "SPELL_AURA_REMOVED") then
		ForEachPlate(MatchGUID, destGUID, spellID)
	end
end

if(C["nameplate"].combat == true) then
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
	if(C["nameplate"].combat == true) then
		if(InCombatLockdown()) then
			SetCVar("nameplateShowEnemies", 1)
		else
			SetCVar("nameplateShowEnemies", 0)
		end
	end
	
	if(C["nameplate"].enable == true and C["nameplate"].enhancethreat == true) then
		SetCVar("threatWarning", 3)
	end
end