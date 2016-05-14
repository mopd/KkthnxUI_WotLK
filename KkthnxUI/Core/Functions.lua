local K, C, L, _ = unpack(select(2, ...))

local format, find, gsub = string.format, string.find, string.gsub
local print = print
local tonumber, type = tonumber, type
local unpack, select = unpack, select
local CreateFrame = CreateFrame
local GetCombatRatingBonus = GetCombatRatingBonus
local GetSpecialization, GetActiveSpecGroup = GetSpecialization, GetActiveSpecGroup
local GetSpellInfo = GetSpellInfo
local IsInInstance, GetNumPartyMembers, GetNumRaidMembers = IsInInstance, GetNumPartyMembers, GetNumRaidMembers
local RequestBattlefieldScoreData = RequestBattlefieldScoreData
local UnitStat, UnitAttackPower, UnitBuff = UnitStat, UnitAttackPower, UnitBuff
local tinsert, tremove = tinsert, tremove

K.Print = function(...)
	print("|cff2eb6ffKkthnxUI|r:", ...)
end

K.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(K.mult, -K.mult)

	return fs
end

-- ShortValue
K.ShortValue = function(v)
	if abs(v) >= 1e9 then
		return format("%.1fG", v / 1e9)
	elseif abs(v) >= 1e6 then
		return format("%.1fM", v / 1e6)
	elseif abs(v) >= 1e3 then
		return format("%.1fk", v / 1e3)
	else
		return format("%d", v)
	end
end

-- Rounding
K.Round = function(num, idp)
	if(idp and idp > 0) then
		local mult = 10 ^ idp
		return floor(num * mult + 0.5) / mult
	end
	return floor(num + 0.5)
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
		local base, posBuff, negBuff = UnitAttackPower("player")
		local playerap = base + posBuff + negBuff

		if ((playerap > playerint) or (playeragi > playerint)) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139))) then
			K.Role = "Melee"
		else
			K.Role = "Caster"
		end
	end
end
local RoleUpdater = CreateFrame("Frame")
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("UNIT_AURA")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:SetScript("OnEvent", K.CheckRole)

K.ShortenString = function(string, numChars, dots)
	local bytes = string:len()
	if (bytes <= numChars) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == numChars) then break end
		end

		if (len == numChars and pos <= bytes) then
			return string:sub(1, pos - 1)..(dots and '...' or '')
		else
			return string
		end
	end
end

local DAY, HOUR, MINUTE = 86400, 3600, 60
local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5
local HALFDAYISH, HALFHOURISH, HALFMINUTEISH = DAY/2 + 0.5, HOUR/2 + 0.5, MINUTE/2 + 0.5
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
local waitTable = {}
local waitFrame
K.Delay = function(delay, func, ...)
	if(type(delay) ~= "number" or type(func) ~= "function") then
		return false
	end
	if(waitFrame == nil) then
		waitFrame = CreateFrame("Frame", "WaitFrame", UIParent)
		waitFrame:SetScript("onUpdate", function (self, elapse)
			local count = #waitTable
			local i = 1
			while(i <= count) do
				local waitRecord = tremove(waitTable,i)
				local d = tremove(waitRecord,1)
				local f = tremove(waitRecord,1)
				local p = tremove(waitRecord,1)
				if(d > elapse) then
					tinsert(waitTable, i, {d-elapse, f, p})
					i = i + 1
				else
					count = count - 1
					f(unpack(p))
				end
			end
		end)
	end
	tinsert(waitTable, {delay, func, {...}})
	return true
end

-- Money text formatting, code taken from Scrooge by thelibrarian ( http://www.wowace.com/addons/scrooge/ )
local COLOR_COPPER = "|cffeda55f"
local COLOR_SILVER = "|cffc7c7cf"
local COLOR_GOLD = "|cffffd700"
local ICON_COPPER = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
local ICON_SILVER = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
local ICON_GOLD = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
K.FormatMoney = function(amount, style, textonly)
	local coppername = textonly and L_COPPER_ABBREV or ICON_COPPER
	local silvername = textonly and L_SILVER_ABBREV or ICON_SILVER
	local goldname = textonly and L_GOLD_ABBREV or ICON_GOLD

	local value = abs(amount)
	local gold = floor(value / 10000)
	local silver = floor(mod(value / 100, 100))
	local copper = floor(mod(value, 100))

	if not style or C["general"].money_format == "SMART" then
		local str = ""
		if gold > 0 then
			str = format("%d%s%s", gold, goldname, (silver > 0 or copper > 0) and " " or "")
		end
		if silver > 0 then
			str = format("%s%d%s%s", str, silver, silvername, copper > 0 and " " or "")
		end
		if copper > 0 or value == 0 then
			str = format("%s%d%s", str, copper, coppername)
		end
		return str
	end

	if C["general"].money_format == "FULL" then
		if gold > 0 then
			return format("%d%s %d%s %d%s", gold, goldname, silver, silvername, copper, coppername)
		elseif silver > 0 then
			return format("%d%s %d%s", silver, silvername, copper, coppername)
		else
			return format("%d%s", copper, coppername)
		end
	elseif C["general"].money_format == "SHORT" then
		if gold > 0 then
			return format("%.1f%s", amount / 10000, goldname)
		elseif silver > 0 then
			return format("%.1f%s", amount / 100, silvername)
		else
			return format("%d%s", amount, coppername)
		end
	elseif C["general"].money_format == "SHORTINT" then
		if gold > 0 then
			return format("%d%s", gold, goldname)
		elseif silver > 0 then
			return format("%d%s", silver, silvername)
		else
			return format("%d%s", copper, coppername)
		end
	elseif C["general"].money_format == "CONDENSED" then
		if gold > 0 then
			return format("%s%d|r.%s%02d|r.%s%02d|r", COLOR_GOLD, gold, COLOR_SILVER, silver, COLOR_COPPER, copper)
		elseif silver > 0 then
			return format("%s%d|r.%s%02d|r", COLOR_SILVER, silver, COLOR_COPPER, copper)
		else
			return format("%s%d|r", COLOR_COPPER, copper)
		end
	end

	-- Shouldn't be here punt
	return self:FormatMoney(amount, "SMART")
end