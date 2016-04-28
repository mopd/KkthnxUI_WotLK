local K, C, L, _ = unpack(select(2, ...))

local unpack, select = unpack, select
local tonumber, type = tonumber, type
local tinsert, tremove = tinsert, tremove
local format, find, gsub = string.format, string.find, string.gsub

local CreateFrame = CreateFrame
local GetSpellInfo = GetSpellInfo
local IsInInstance, GetNumPartyMembers, GetNumRaidMembers = IsInInstance, GetNumPartyMembers, GetNumRaidMembers
local RequestBattlefieldScoreData = RequestBattlefieldScoreData
local GetSpecialization, GetActiveSpecGroup = GetSpecialization, GetActiveSpecGroup
local GetCombatRatingBonus = GetCombatRatingBonus
local UnitStat, UnitAttackPower, UnitBuff = UnitStat, UnitAttackPower, UnitBuff

-- Backdrops
K.Backdrop = { bgFile = C["media"].blank, edgeFile = C["media"].blizz, edgeSize = 14, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5 }}
K.BasicBackdrop = { bgFile = C["media"].blank, tile = true, tileSize = 16, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.SimpleBackdrop = { bgFile = C["media"].blank}
K.ModBackdrop = { bgFile = C["media"].blank, tile = true, tileSize = 16, insets = { left = 8, right = 8, top = 8, bottom = 8}}
K.EdgeBackdrop = { edgeFile = C["media"].blizz, edgeSize = 14, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.BlizBackdrop = { bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11}}
K.ShadowBackdrop = { bgFile = C["media"].blank, edgeFile = C["media"].glow, edgeSize = 4, insets = { left = 4, right = 4, top = 4, bottom = 4 }}

-- Blizz Style
K.SetBlizzBorder = function(f, size, level, alpha, alphaborder) 
	if( f.BlizzBorder ) then return end
	
	local BlizzBorder = CreateFrame("Frame", nil, f)
	BlizzBorder:SetFrameLevel(level or 0)
	BlizzBorder:SetFrameStrata(f:GetFrameStrata())
	BlizzBorder:SetPoint("TOPLEFT", -size, size )
	BlizzBorder:SetPoint("BOTTOMLEFT", -size, -size)
	BlizzBorder:SetPoint("TOPRIGHT", size, size)
	BlizzBorder:SetPoint("BOTTOMRIGHT", size, -size)
	BlizzBorder:SetBackdrop(K.Backdrop)
	BlizzBorder:SetBackdropColor(unpack(C["media"].backdrop_color))
	if C["blizzard"].dark_textures == true then
		BlizzBorder:SetBackdropBorderColor(unpack(C["blizzard"].dark_textures_color));
	else
		BlizzBorder:SetBackdropBorderColor(unpack(C["media"].border_color))
	end
	f.BlizzBorder = BlizzBorder
	return BlizzBorder
end

-- Shadow Style
K.SetShadowBorder = function(f, size, level, alpha, alphaborder) 
	if( f.ShadowBorder ) then return end

	local ShadowBorder = CreateFrame("Frame", nil, f)
	ShadowBorder:SetFrameLevel(level or 0)
	ShadowBorder:SetFrameStrata(f:GetFrameStrata())
	ShadowBorder:SetPoint("TOPLEFT", -size, size )
	ShadowBorder:SetPoint("BOTTOMLEFT", -size, -size)
	ShadowBorder:SetPoint("TOPRIGHT", size, size)
	ShadowBorder:SetPoint("BOTTOMRIGHT", size, -size)
	ShadowBorder:SetBackdrop( { 
		edgeFile = C["media"].glow, edgeSize = K.Scale(3),
		insets = {left = K.Scale(5), right = K.Scale(5), top = K.Scale(5), bottom = K.Scale(5)},
	})
	ShadowBorder:SetBackdropColor(0, 0, 0, 0)
	ShadowBorder:SetBackdropBorderColor(0, 0, 0, 0.8)
	f.ShadowBorder = ShadowBorder
end

K.SetFontString = function( parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString( nil, "OVERLAY")
	fs:SetFont( fontName, fontHeight, fontStyle)
	fs:SetJustifyH( "LEFT")
	fs:SetShadowColor( 0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

-- ShortValue
K.ShortValue = function(v)
	if (v >= 1e6) then
		return gsub(format("%.1fm", v / 1e6), "%.?0+([km])$", "%1")
	elseif (v >= 1e3 or v <= -1e3) then
		return gsub(format("%.1fk", v / 1e3), "%.?0+([km])$", "%1")
	else
		return v
	end
end

-- Rounding
K.Round = function(number, decimals)
	if (not decimals) then
		decimals = 0
	end

	return format(format("%%.%df", decimals), number)
end

-- RGBToHex Color
K.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	
	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

K.CheckChat = function(warning)
	local numParty, numRaid = GetNumPartyMembers(), GetNumRaidMembers()
	if numParty > 0 then
		return "PARTY"
	elseif numRaid > 0 then
		if warning and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant()) then
			return "RAID_WARNING"
		else
			return "RAID"
		end
	elseif numParty > 0 then
		return "PARTY"
	end
	return "SAY"
end

K.CheckRole = function(self, event, unit)
	if event == "UNIT_AURA" and unit ~= "player" then return end
	if (K.Class == "PALADIN" and UnitBuff("player", GetSpellInfo(25780))) and GetCombatRatingBonus(CR_DEFENSE_SKILL) > 100 or 
	(K.Class == "WARRIOR" and GetBonusBarOffset() == 2) or 
	(K.Class == "DEATHKNIGHT" and UnitBuff("player", GetSpellInfo(48263))) or
	(K.Class == "DRUID" and GetBonusBarOffset() == 3) then
		K.Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;

		if ((playerap > playerint) or (playeragi > playerint)) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139))) then
			K.Role = "Melee"
		else
			K.Role = "Caster"
		end
	end
end
local RoleUpdater = CreateFrame("Frame")
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD");
RoleUpdater:RegisterEvent("UNIT_AURA");
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED");
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED");
RoleUpdater:SetScript("OnEvent", K.CheckRole)

local DAY, HOUR, MINUTE = 86400, 3600, 60;
local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5;
local HALFDAYISH, HALFHOURISH, HALFMINUTEISH = DAY/2 + 0.5, HOUR/2 + 0.5, MINUTE/2 + 0.5;

local EXPIRING_FORMAT = K.RGBToHex(1, 0, 0) .. '%.1f|r'
local SECONDS_FORMAT = K.RGBToHex(1, 1, 0) .. '%d|r'
local MINUTES_FORMAT = K.RGBToHex(1, 1, 1) .. '%dm|r'
local HOURS_FORMAT = K.RGBToHex(0.4, 1, 1) .. '%dh|r'
local DAYS_FORMAT = K.RGBToHex(0.4, 0.4, 1) .. '%dh|r'

K.GetTimeInfo = function(s)
	if(s < MINUTEISH) then
		local seconds = tonumber(K.Round(s))
		if(seconds > C["cooldown"].threshold) then
			return SECONDS_FORMAT, seconds, s - (seconds - 0.51)
		else
			return EXPIRING_FORMAT, s, 0.051
		end
		
	elseif(s < HOURISH) then
		local minutes = tonumber(K.Round(s / MINUTE))
		return MINUTES_FORMAT, minutes, minutes > 1 and (s - (minutes * MINUTE - HALFMINUTEISH)) or (s - MINUTEISH)
		
	elseif(s < DAYISH) then
		local hours = tonumber(K.Round(s / HOUR))
		return HOURS_FORMAT, hours, hours > 1 and (s - (hours * HOUR - HALFHOURISH)) or (s - HOURISH)
		
	else
		local days = tonumber(K.Round(s / DAY))
		return DAYS_FORMAT, days, days > 1 and (s - (days * DAY - HALFDAYISH)) or (s - DAYISH)
	end
end

K.RuneColor = {
    [1] = {r = 0.7, g = 0.1, b = 0.1},
    [2] = {r = 0.7, g = 0.1, b = 0.1},
    [3] = {r = 0.4, g = 0.8, b = 0.2},
    [4] = {r = 0.4, g = 0.8, b = 0.2},
    [5] = {r = 0.0, g = 0.6, b = 0.8},
    [6] = {r = 0.0, g = 0.6, b = 0.8},
}

K.ComboColor = {
   [1] = {r = 1.0, g = 1.0, b = 1.0},
   [2] = {r = 1.0, g = 1.0, b = 1.0},
   [3] = {r = 1.0, g = 1.0, b = 1.0},
   [4] = {r = 0.9, g = 0.7, b = 0.0},
   [5] = {r = 1.0, g = 0.0, b = 0.0},
}

-- Add time before calling a function
local TimerParent = CreateFrame("Frame")
K.UnusedTimers = {}

local TimerOnFinished = function(self)
	self.Func(unpack(self.Args))
	tinsert(K.UnusedTimers, self)
end

K.NewTimer = function()
	local Parent = TimerParent:CreateAnimationGroup()
	local Timer = Parent:CreateAnimation("Alpha")
	
	Timer:SetScript("OnFinished", TimerOnFinished)
	Timer.Parent = Parent
	
	return Timer
end

K.Delay = function(delay, func, ...)
	if (type(delay) ~= "number" or type(func) ~= "function") then
		return
	end
	
	local Timer
	
	if K.UnusedTimers[1] then
		Timer = tremove(K.UnusedTimers, 1) -- Recycle a timer
	else
		Timer = K.NewTimer() -- Or make a new one if needed
	end
	
	Timer.Args = {...}
	Timer.Func = func
	Timer:SetDuration(delay)
	Timer.Parent:Play()
end