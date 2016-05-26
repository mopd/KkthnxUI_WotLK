local K, C, L, _ = select(2, ...):unpack()

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
--[[
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
]]
K.CheckChat = function(warning)
	local numParty, numRaid = GetNumPartyMembers(), GetNumRaidMembers()
	if numParty > 0 then
		return "PARTY"
	elseif numRaid > 0 then -- This might need to be 5?
		return "RAID"
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

K.FormatMoney = function(value)
	if value >= 1e4 then
		return format("|cffffd700%dg |r|cffc7c7cf%ds |r|cffeda55f%dc|r", value/1e4, strsub(value, -4) / 1e2, strsub(value, -2))
	elseif value >= 1e2 then
		return format("|cffc7c7cf%ds |r|cffeda55f%dc|r", strsub(value, -4) / 1e2, strsub(value, -2))
	else
		return format("|cffeda55f%dc|r", strsub(value, -2))
	end
end

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