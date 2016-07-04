local K, C, L, _ = select(2, ...):unpack()
if C["Nameplate"].enable ~= true then return end

local GetSpellInfo = GetSpellInfo
----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at http://wotlk.openwow.com search for a spell.
--	Example: Necrotic Plague> http://wotlk.openwow.com/spell=73787
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id)
	if(not name) then
		print(" SpellID is not valid: "..id..". Please check for an updated version, if none exists report this to Kkthnx.")
		return "Impale"
	else
		return name
	end
end

K.DebuffWhiteList = {
	-- Death Knight
	[SpellName(49203)] = true,
	[SpellName(47476)] = true,
	-- Druid
	[SpellName(33786)] = true,
	[SpellName(2637)] = true,
	[SpellName(339)] = true,
	[SpellName(8921)] = true,
	[SpellName(5570)] = true,
	[SpellName(58180)] = true,
	[SpellName(33878)] = true,
	[SpellName(33745)] = true,
	[SpellName(1822)] = true,
	[SpellName(1079)] = true,
	-- Hunter
	[SpellName(3355)] = true,
	[SpellName(1513)] = true,
	[SpellName(19503)] = true,
	[SpellName(34490)] = true,
	-- Mage
	[SpellName(31661)] = true,
	[SpellName(61305)] = true,
	[SpellName(18469)] = true,
	[SpellName(122)] = true,
	[SpellName(55080)] = true,
	-- Paladin
	[SpellName(20066)] = true,
	[SpellName(10326)] = true,
	[SpellName(853)] = true,
	-- Priest
	[SpellName(605)] = true,
	[SpellName(64044)] = true,
	[SpellName(8122)] = true,
	[SpellName(9484)] = true,
	[SpellName(15487)] = true,
	-- Rogue
	[SpellName(2094)] = true,
	[SpellName(1776)] = true,
	[SpellName(6770)] = true,
	[SpellName(18425)] = true,
	-- Shaman
	[SpellName(51514)] = true,
	[SpellName(3600)] = true,
	[SpellName(8056)] = true,
	[SpellName(8050)] = true,
	[SpellName(63685)] = true,
	[SpellName(39796)] = true,
	-- Warlock
	[SpellName(710)] = true,
	[SpellName(6789)] = true,
	[SpellName(5782)] = true,
	[SpellName(5484)] = true,
	[SpellName(6358)] = true,
	[SpellName(30283)] = true,
	[SpellName(603)] = true,
	[SpellName(980)] = true,
	[SpellName(172)] = true,
	[SpellName(17800)] = true,
	[SpellName(48181)] = true,
	[SpellName(30108)] = true,
	[SpellName(348)] = true,
	-- Warrior
	[SpellName(20511)] = true,
	-- Racial
	[SpellName(25046)] = true,
	[SpellName(20549)] = true,
}

K.PlateBlacklist = {
	["Army of the Dead Ghoul"] = true,
	["Dragonmaw War Banner"] = true,
	["Healing Tide Totem"] = true,
	["Venomous Snake"] = true,
}