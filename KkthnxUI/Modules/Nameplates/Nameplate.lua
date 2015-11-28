local K, C, L = unpack(select(2, ...));
if C["nameplate"].enable ~= true then return end

--Dont Touch
local numChildren = -1
local frames = {}

--Change defaults if we are showing health text or not
if C["nameplate"].healthvalue ~= true then
	C["nameplate"].height = 8
	C["nameplate"].iconsize = 20
end

local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if C["nameplate"].trackauras == true then
	NamePlates:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end
SetCVar("ShowClassColorInNameplate", 1)
SetCVar("showVKeyCastbar", 1)

local Abbrev = function(name)
	local newname = (string.len(name) > 18) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return K.UTF(newname, 18, false)
end

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

-- Create our blacklist for nameplates
local function CheckBlacklist(frame, ...)
	if C["nameplate"].nameabbrev == true then return end
	if K["PlateBlacklist"][frame.name:GetText()] then
		frame:SetScript("OnUpdate", function() end)
		frame.hp:Hide()
		frame.cb:Hide()
		frame.overlay:Hide()
		frame.oldlevel:Hide()
	end
end

-- When becoming intoxicated blizzard likes to re-show the old level text, this should fix that
local function HideDrunkenText(frame, ...)
	if frame and frame.oldlevel and frame.oldlevel:IsShown() then
		frame.oldlevel:Hide()
	end
end

local function AdjustNameLevel(frame, ...)
	if UnitName("target") == frame.name:GetText() and frame:GetAlpha() == 1 then
		frame.name:SetDrawLayer("OVERLAY")
	else
		frame.name:SetDrawLayer("BORDER")
	end
end

-- Create aura icons
local function CreateAuraIcon(parent)
	local button = CreateFrame("Frame", nil, parent)
	button:SetWidth(C["nameplate"].aurassize)
	button:SetHeight(C["nameplate"].aurassize)
	
	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetTexture(0.05, 0.05, 0.05, 0.6)
	button.bg:SetAllPoints(button)
	
	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", K.noscalemult * 3, -K.noscalemult * 3)
	button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -K.noscalemult * 3, K.noscalemult * 3)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	
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

local function HealthBar_ValueChanged(frame)
	frame = frame:GetParent()
	frame.hp:SetMinMaxValues(frame.healthOriginal:GetMinMaxValues())
	--frame.hp:SetValue(frame.healthOriginal:GetValue() - 1) -- Blizzard bug fix
	frame.hp:SetValue(frame.healthOriginal:GetValue())
end

--[[
local goodR, goodG, goodB = unpack(C["nameplate"].goodcolor)
local badR, badG, badB = unpack(C["nameplate"].badcolor)
local transitionR, transitionG, transitionB = unpack(C["nameplate"].transitioncolor)
local function UpdateThreat(frame, elapsed)
	frame.hp:Show()
	
	if C["nameplate"].enhancethreat ~= true then
		if(frame.region:IsShown()) then
			local _, val = frame.region:GetVertexColor()
			if(val > 0.7) then
				frame.healthbarbackdrop_tex:SetTexture(transitionR, transitionG, transitionB)
			else
				frame.healthbarbackdrop_tex:SetTexture(badR, badG, badB)
			end
		else
			frame.healthbarbackdrop_tex:SetTexture(0.05, 0.05, 0.05, 0.6)
		end
	else
		if not frame.region:IsShown() then
			if InCombatLockdown() and frame.hasclass ~= true and frame.isFriendly ~= true then
				--No Threat
				if K.Role == "Tank" then
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				else
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				end		
			else
				--Set colors to their original, not in combat
				frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
				frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
			end
		else
			--Ok we either have threat or we're losing/gaining it
			local r, g, b = frame.region:GetVertexColor()
			if g + b == 0 then
				--Have Threat
				if K.Role == "Tank" then
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				else
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				end
			else
				--Losing/Gaining Threat
				frame.hp:SetStatusBarColor(transitionR, transitionG, transitionB)	
				frame.hp.hpbg:SetTexture(transitionR, transitionG, transitionB, 0.25)
			end
		end
	end
	
	-- Show current health value
	local _, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local d = (valueHealth / maxHealth) * 100
	
	if C["nameplate"].healthvalue == true then
		-- Possible bug in 3.3.5 
		frame.hp.value:SetText(K.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100))))
		--frame.hp.value:SetText(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100)))
	end
	
	--Change frame style if the frame is our target or not
	if UnitName("target") == frame.name:GetText() and frame:GetAlpha() == 1 then
		--Targetted Unit
		frame.name:SetTextColor(1, 1, 0)
	else
		--Not Targetted
		frame.name:SetTextColor(1, 1, 1)
	end
	
	--Setup frame shadow to change depending on enemy players health, also setup targetted unit to have white shadow
	if frame.hasclass == true or frame.isFriendly == true then
		if(d <= 50 and d >= 20) then
			frame.healthbarbackdrop_tex:SetTexture(1, 1, 0)
		elseif(d < 20) then
			frame.healthbarbackdrop_tex:SetTexture(1, 0, 0)
		else
			frame.healthbarbackdrop_tex:SetTexture(0.05, 0.05, 0.05, 0.6)
		end
	elseif (frame.hasclass ~= true and frame.isFriendly ~= true) and C["nameplate"].enhancethreat == true then
		frame.healthbarbackdrop_tex:SetTexture(0.05, 0.05, 0.05, 0.6)
	end
end
]]--
local function Colorize(frame)
	local r, g, b = frame.hp:GetStatusBarColor()
	if frame.hasclass == true then frame.isFriendly = false return end
	
	frame.isTapped = false
	
	if r + b + b > 2 then	-- Tapped
		r, g, b = 0.6, 0.6, 0.6
		frame.isFriendly = false
		frame.isTapped = true
	elseif g + b == 0 then -- Hostile
		r, g, b = unpack(C["nameplate"].hostilecolor)
		frame.isFriendly = false
	elseif r + b == 0 then -- Friendly npc
		r, g, b = unpack(C["nameplate"].friendlynpccolor)
		frame.isFriendly = true
	elseif r + g > 1.95 then -- Neutral
		r, g, b = unpack(C["nameplate"].neutralcolor)
		frame.isFriendly = false
	elseif r + g == 0 then -- Friendly player
		r, g, b = unpack(C["nameplate"].friendlyplayercolor)
		frame.isFriendly = true
	else -- Enemy player
		frame.isFriendly = false
	end
	frame.hp:SetStatusBarColor(r, g, b)
end

local function UpdateObjects(frame)
	local frame = frame:GetParent()
	
	local r, g, b = frame.hp:GetStatusBarColor()
	local r, g, b = floor(r*100+.5)/100, floor(g*100+.5)/100, floor(b*100+.5)/100
	local classname = ""
	
	frame.hp:ClearAllPoints()
	frame.hp:SetSize(C["nameplate"].width, C["nameplate"].height)	
	frame.hp:SetPoint('TOP', frame, 'TOP', 0, -K.noscalemult*3)
	frame.hp:GetStatusBarTexture():SetHorizTile(true)
	
	--frame.healthbarbackdrop_tex:ClearAllPoints()
	--frame.healthbarbackdrop_tex:SetPoint("TOPLEFT", frame.hp, "TOPLEFT", -K.noscalemult*3, K.noscalemult*3)
	--frame.healthbarbackdrop_tex:SetPoint("BOTTOMRIGHT", frame.hp, "BOTTOMRIGHT", K.noscalemult*3, -K.noscalemult*3)
	
	--Class Icons
	for class, color in pairs(RAID_CLASS_COLORS) do
		if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
			classname = class
		end
	end
	if (classname) then
		texcoord = CLASS_BUTTONS[classname]
		if texcoord then
			frame.hasclass = true
		else
			texcoord = {0.5, 0.75, 0.5, 0.75}
			frame.hasclass = false
		end
	else
		texcoord = {0.5, 0.75, 0.5, 0.75}
		frame.hasclass = false
	end
	
	if frame.hp.rcolor == 0 and frame.hp.gcolor == 0 and frame.hp.bcolor ~= 0 then
		texcoord = {0.5, 0.75, 0.5, 0.75}
		frame.hasclass = true
	end
	frame.class:SetTexCoord(texcoord[1],texcoord[2],texcoord[3],texcoord[4])
	
	if C["nameplate"].classicons ~= true then
		frame.class:SetAlpha(0)
	end
	
	--create variable for original colors
	Colorize(frame)
	frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor = frame.hp:GetStatusBarColor()
	frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
	
	-- Set the name text
	if C["nameplate"].nameabbrev == true and C["nameplate"].trackauras ~= true then
		frame.name:SetText(Abbrev(frame.oldname:GetText()))
	else
		frame.name:SetText(frame.oldname:GetText())
	end
	
	--Setup level text
	local level, elite, mylevel = tonumber(frame.oldlevel:GetText()), frame.elite:IsShown(), UnitLevel("player")
	frame.hp.level:ClearAllPoints()
	if C["nameplate"].healthvalue == true then
		frame.hp.level:SetPoint("RIGHT", frame.hp, "RIGHT", 2, 0)
	else
		frame.hp.level:SetPoint("RIGHT", frame.hp, "LEFT", -1, 0)
	end
	
	frame.hp.level:SetTextColor(frame.oldlevel:GetTextColor())
	if frame.boss:IsShown() then
		frame.hp.level:SetText("B")
		frame.hp.level:SetTextColor(0.8, 0.05, 0)
		frame.hp.level:Show()
	elseif not elite and level == mylevel then
		frame.hp.level:Hide()
	else
		frame.hp.level:SetText(level..(elite and "+" or ""))
	end
	
	frame.overlay:ClearAllPoints()
	frame.overlay:SetAllPoints(frame.hp)
	
	-- Show current health value
	local _, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local d = (valueHealth / maxHealth) * 100
	
	if C["nameplate"].healthvalue == true then
		-- Possible bug in 3.3.5 
		frame.hp.value:SetText(K.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100))))
		--frame.hp.value:SetText(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100)))
	end
	
	--Change frame style if the frame is our target or not
	if UnitName("target") == frame.name:GetText() and frame:GetAlpha() == 1 then
		--Targetted Unit
		frame.name:SetTextColor(1, 1, 0)
	else
		--Not Targetted
		frame.name:SetTextColor(1, 1, 1)
	end
	
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
	frame:SetSize(C["nameplate"].cbwidth, C["nameplate"].cbheight)
	frame:SetPoint('TOP', frame:GetParent().hp, 'BOTTOM', 0, -8)
	frame:GetStatusBarTexture():SetHorizTile(true)
	
	if(not frame.shield:IsShown()) then
		frame:SetStatusBarColor(0.78, 0.25, 0.25, 1)
	end
	
	local frame = frame:GetParent()
	frame.castbarbackdrop_tex:ClearAllPoints()
	frame.castbarbackdrop_tex:SetPoint("TOPLEFT", frame.cb, "TOPLEFT", -K.noscalemult*3, K.noscalemult*3)
	frame.castbarbackdrop_tex:SetPoint("BOTTOMRIGHT", frame.cb, "BOTTOMRIGHT", K.noscalemult*3, -K.noscalemult*3)
end	

-- Determine whether or not the cast is Channelled or a Regular cast so we can grab the proper Cast Name
local function UpdateCastText(frame, curValue)
	local minValue, maxValue = frame:GetMinMaxValues()
	
	if UnitChannelInfo("target") then
		frame.time:SetFormattedText("%.1f ", curValue)
		if C["nameplate"].showcastbarname == true then
			frame.name:SetText(select(1, (UnitChannelInfo("target"))))
		end
	end
	
	if UnitCastingInfo("target") then
		frame.time:SetFormattedText("%.1f ", maxValue - curValue)
		if C["nameplate"].show_castbar_name == true then
			frame.name:SetText(select(1, (UnitCastingInfo("target"))))
		end
	end
end

-- Sometimes castbar likes to randomly resize
local OnValueChanged = function(self, curValue)
	UpdateCastText(self, curValue)
	if self.needFix then
		UpdateCastbar(self)
		self.needFix = nil
	end
end

-- Sometimes castbar likes to randomly resize
local OnSizeChanged = function(self)
	self.needFix = true
end


local function OnHide(frame)
	frame.overlay:Hide()
	frame.cb:Hide()
	frame.unit = nil
	frame.guid = nil
	frame.hasclass = nil
	frame.isFriendly = nil
	frame.hp.rcolor = nil
	frame.hp.gcolor = nil
	frame.hp.bcolor = nil
	
	if frame.icons then
		for _, icon in ipairs(frame.icons) do
			icon:Hide()
		end
	end
	
	frame:SetScript("OnUpdate", nil)
end

local function SkinObjects(frame)
	local hp, cb = frame:GetChildren()
	local threat, hpborder, cbshield, cbborder, cbicon, overlay, oldname, oldlevel, bossicon, raidicon, elite = frame:GetRegions()
	frame.healthOriginal = hp
	
	if not frame.threat then
		frame.threat = threat
	end
	
	--Just make sure these are correct
	hp:SetFrameLevel(9)
	cb:SetFrameLevel(9)
	
	---- Create Cast Icon Backdrop frame
	--local healthbarbackdrop_tex = hp:CreateTexture(nil, "BACKGROUND")
	--healthbarbackdrop_tex:SetPoint("TOPLEFT", hp, "TOPLEFT", -K.noscalemult*3, K.noscalemult*3)
	--healthbarbackdrop_tex:SetPoint("BOTTOMRIGHT", hp, "BOTTOMRIGHT", K.noscalemult*3, -K.noscalemult*3)
	--healthbarbackdrop_tex:SetTexture(0.1, 0.1, 0.1)
	--frame.healthbarbackdrop_tex = healthbarbackdrop_tex
	
	hp.hpGlow = CreateFrame("Frame", nil, hp)
	hp.hpGlow:SetBackdrop({
		bgFile = C["media"].blank, 
		tile = false, tileSize = 0, edgeSize = 1 * K.noscalemult, 
	})
	hp.hpGlow:SetBackdropColor(0.05, 0.05, 0.05, .6)
	hp.hpGlow:SetPoint("TOPLEFT", hp, "TOPLEFT", -3 * K.noscalemult, 3 * K.noscalemult)
	hp.hpGlow:SetPoint("BOTTOMRIGHT", hp, "BOTTOMRIGHT", 3 * K.noscalemult, -3 * K.noscalemult)
	hp.hpGlow:SetFrameLevel(hp:GetFrameLevel() -1 > 0 and hp:GetFrameLevel() -1 or 0)
	
	hp:SetStatusBarTexture(C["media"].texture)
	frame.hp = hp
	
	--Actual Background for the Healthbar
	hp.hpbg = hp:CreateTexture(nil, 'BORDER')
	hp.hpbg:SetAllPoints(hp)
	hp.hpbg:SetTexture(1,1,1,0.25) 
	
	--Create Overlay Highlight
	frame.overlay = overlay
	frame.overlay:SetTexture(1,1,1,0.15)
	frame.overlay:SetAllPoints(hp)
	
	--Create Name
	hp.level = hp:CreateFontString(nil, "OVERLAY")
	hp.level:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size - 2, C["font"].nameplates_font_style)
	hp.level:SetTextColor(1, 1, 1)
	hp.level:SetShadowOffset(K.mult, -K.mult)
	
	--Needed for level text
	frame.oldlevel = oldlevel
	frame.boss = bossicon
	frame.elite = elite
	
	--Create Health Text
	if C["nameplate"].healthvalue == true then
		hp.value = hp:CreateFontString(nil, "OVERLAY")	
		hp.value:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size - 2, C["font"].nameplates_font_style)
		hp.value:SetPoint("CENTER", hp)
		hp.value:SetTextColor(1,1,1)
		hp.value:SetShadowOffset(K.mult, -K.mult)
	end
	
	-- Create Cast Bar Backdrop frame
	local castbarbackdrop_tex = cb:CreateTexture(nil, "BACKGROUND")
	castbarbackdrop_tex:SetPoint("TOPLEFT", cb, "TOPLEFT", -K.noscalemult*3, K.noscalemult*3)
	castbarbackdrop_tex:SetPoint("BOTTOMRIGHT", cb, "BOTTOMRIGHT", K.noscalemult*3, -K.noscalemult*3)
	castbarbackdrop_tex:SetTexture(0.1, 0.1, 0.1)
	frame.castbarbackdrop_tex = castbarbackdrop_tex
	
	--Setup CastBar Icon
	cbicon:ClearAllPoints()
	cbicon:SetPoint("TOPLEFT", hp, "TOPRIGHT", 8, 0)		
	cbicon:SetSize(C["nameplate"].iconsize, C["nameplate"].iconsize)
	cbicon:SetTexCoord(.07, .93, .07, .93)
	cbicon:SetDrawLayer("OVERLAY")
	
	-- Create Cast Icon Backdrop frame
	local casticonbackdrop_tex = cb:CreateTexture(nil, "BACKGROUND")
	casticonbackdrop_tex:SetPoint("TOPLEFT", cbicon, "TOPLEFT", -K.noscalemult*3, K.noscalemult*3)
	casticonbackdrop_tex:SetPoint("BOTTOMRIGHT", cbicon, "BOTTOMRIGHT", K.noscalemult*3, -K.noscalemult*3)
	casticonbackdrop_tex:SetTexture(0.1, 0.1, 0.1)
	
	--Create Health Backdrop Frame
	--local casticonbackdrop2_tex = cb:CreateTexture(nil, "ARTWORK")
	--casticonbackdrop2_tex:SetPoint("TOPLEFT", cbicon, "TOPLEFT", -K.noscalemult, K.noscalemult)
	--casticonbackdrop2_tex:SetPoint("BOTTOMRIGHT", cbicon, "BOTTOMRIGHT", K.noscalemult, -K.noscalemult)
	--casticonbackdrop2_tex:SetTexture(0.1, 0.1, 0.1)
	
	--Create Cast Time Text
	cb.time = cb:CreateFontString(nil, "ARTWORK")
	cb.time:SetPoint("RIGHT", cb, "LEFT", -1, 0)
	cb.time:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size, C["font"].nameplates_font_style)
	cb.time:SetTextColor(1, 1, 1)
	cb.time:SetShadowOffset(K.mult, -K.mult)
	
	--Create Cast Name Text
	cb.name = cb:CreateFontString(nil, "ARTWORK")
	cb.name:SetPoint("TOP", cb, "BOTTOM", 0, -3)
	cb.name:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size, C["font"].nameplates_font_style)
	cb.name:SetTextColor(1, 1, 1)
	cb.name:SetShadowOffset(K.mult, -K.mult)
	
	cb.icon = cbicon
	cb.shield = cbshield
	cb:HookScript('OnShow', UpdateCastbar)
	cb:HookScript('OnSizeChanged', OnSizeChanged)
	cb:HookScript('OnValueChanged', OnValueChanged)	
	cb:SetStatusBarTexture(C["media"].texture)
	frame.cb = cb
	
	--Create Name Text
	local name = hp:CreateFontString(nil, 'OVERLAY')
	name:SetPoint('BOTTOMLEFT', hp, 'TOPLEFT', -10, 3)
	name:SetPoint('BOTTOMRIGHT', hp, 'TOPRIGHT', 10, 3)
	name:SetFont(C["font"].nameplates_font, C["font"].nameplates_font_size - 2, C["font"].nameplates_font_style)
	name:SetShadowOffset(K.mult, -K.mult)
	frame.oldname = oldname
	frame.name = name
	
	--Reposition and Resize RaidIcon
	raidicon:ClearAllPoints()
	raidicon:SetPoint("BOTTOM", hp, "TOP", 0, 16)
	raidicon:SetSize(C["nameplate"].iconsize*1.4, C["nameplate"].iconsize*1.4)
	frame.raidicon = raidicon
	
	--Create Class Icon
	local cIconTex = hp:CreateTexture(nil, "OVERLAY")
	cIconTex:SetPoint("BOTTOM", hp, "TOP", 0, 16)
	cIconTex:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
	cIconTex:SetSize(C["nameplate"].iconsize, C["nameplate"].iconsize)
	frame.class = cIconTex
	
	cIconTex.Glow = CreateFrame("Frame", nil, frame)
	cIconTex.Glow:SetBackdrop({
		bgFile = C["media"].blank, 
		tile = false, tileSize = 0, edgeSize = 1 * K.noscalemult, 
	})
	cIconTex.Glow:SetBackdropColor(0.05, 0.05, 0.05, .6)
	cIconTex.Glow:SetPoint("TOPLEFT", cIconTex, "TOPLEFT", 0, 0)
	cIconTex.Glow:SetPoint("BOTTOMRIGHT", cIconTex, "BOTTOMRIGHT", 0, 0)
	cIconTex.Glow:SetFrameLevel(hp:GetFrameLevel() -1 > 0 and hp:GetFrameLevel() -1 or 0)
	cIconTex.Glow:Hide()
	
	--Hide Old Stuff
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
	
	frame.hp:HookScript('OnShow', UpdateObjects)
	frame:HookScript('OnHide', OnHide)
	frames[frame] = true
end

--[[
local goodR, goodG, goodB = unpack(C["nameplate"].goodcolor)
local badR, badG, badB = unpack(C["nameplate"].badcolor)
local transitionR, transitionG, transitionB = unpack(C["nameplate"].transitioncolor)
local function UpdateThreat(frame, elapsed)
	Colorize(frame)
	
	if frame.isClass or frame.isTapped then return end
	
	if C.nameplate.enhancethreat ~= true then
		if frame.threat:IsShown() then
			local _, val = frame.threat:GetVertexColor()
			if val > 0.7 then
				SetVirtualBorder(frame.hp, transitionR, transitionG, transitionB)
			else
				SetVirtualBorder(frame.hp, badR, badG, badB)
			end
		else
			SetVirtualBorder(frame.hp, unpack(C.media.border_color))
		end
	else
		if not frame.threat:IsShown() then
			if InCombatLockdown() and frame.isFriendly ~= true then
				-- No Threat
				if K.Role == "Tank" then
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.2)
				else
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.2)
				end
			end
		else
			-- Ok we either have threat or we're losing/gaining it
			local r, g, b = frame.threat:GetVertexColor()
			if g + b == 0 then
				-- Have Threat
				if K.Role == "Tank" then
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.2)
				else
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.2)
				end
			else
				-- Losing/Gaining Threat
				frame.hp:SetStatusBarColor(transitionR, transitionG, transitionB)
				frame.hp.hpbg:SetTexture(transitionR, transitionG, transitionB, 0.2)
			end
		end
	end
	-- Show current health value
	local _, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local d = (valueHealth / maxHealth) * 100
	
	if C["nameplate"].healthvalue == true then
		-- Possible bug in 3.3.5 
		frame.hp.value:SetText(K.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100))))
		--frame.hp.value:SetText(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100)))
	end
	
	--Change frame style if the frame is our target or not
	if UnitName("target") == frame.name:GetText() and frame:GetAlpha() == 1 then
		--Targetted Unit
		frame.name:SetTextColor(1, 1, 0)
	else
		--Not Targetted
		frame.name:SetTextColor(1, 1, 1)
	end
end
]]

-- Health Text, also border coloring for certain plates depending on health
local function ShowHealth(frame, ...)
	-- Match values
	HealthBar_ValueChanged(frame.hp)

	-- Show current health value
	local _, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local d = (valueHealth / maxHealth) * 100

	if C.nameplate.healthvalue == true then
		frame.hp.value:SetText(K.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100))))
		--frame.hp.value:SetText(string.format("%d%%", math.floor((valueHealth / maxHealth) * 100)))
	end

	--Change frame style if the frame is our target or not
	if UnitName("target") == frame.name:GetText() and frame:GetAlpha() == 1 then
		--Targetted Unit
		frame.name:SetTextColor(1, 1, 0)
	else
		--Not Targetted
		frame.name:SetTextColor(1, 1, 1)
	end
	
	-- Setup frame shadow to change depending on enemy players health, also setup targetted unit to have white shadow
	--if frame.isClass == true or frame.isFriendly == true then
	--	if d <= 50 and d >= 20 then
	--		SetVirtualBorder(frame.hp, 1, 1, 0)
	--	elseif d < 20 then
	--		SetVirtualBorder(frame.hp, 1, 0, 0)
	--	else
	--		SetVirtualBorder(frame.hp, unpack(C.media.border_color))
	--	end
	--elseif (frame.isClass ~= true and frame.isFriendly ~= true) and C.nameplate.enhance_threat == true then
	--	SetVirtualBorder(frame.hp, unpack(C.media.border_color))
	--end
end

-- Scan all visible nameplate for a known unit
local function CheckUnit_Guid(frame, ...)
	if UnitExists("target") and frame:GetAlpha() == 1 and UnitName("target") == frame.name:GetText() then
		frame.guid = UnitGUID("target")
		frame.unit = "target"
		OnAura(frame, "target")
	elseif frame.overlay:IsShown() and UnitExists("mouseover") and UnitName("mouseover") == frame.name:GetText() then
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
	
	if self.elapsed and self.elapsed > 0.2 then
		--ForEachPlate(UpdateThreat, self.elapsed)
		ForEachPlate(AdjustNameLevel)
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
	
	ForEachPlate(CheckBlacklist)
	ForEachPlate(ShowHealth)
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
	
	--if C["nameplate"].enable == true and C["nameplate"].enhancethreat == true then
	--	SetCVar("threatWarning", 3)
	--end
end