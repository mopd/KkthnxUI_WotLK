local K, C, L, _ = select(2, ...):unpack()
if C["nameplate"].enable ~= true then return end

local GetSpellInfo = GetSpellInfo
----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at http://wotlk.openwow.com search for a spell.
--	Example: Necrotic Plague -> http://wotlk.openwow.com/spell=73787
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id)
	if(not name) then
		K.Print(" SpellID is not valid: "..id..". Please check for an updated version, if none exists report this to Kkthnx.")
		return "Impale"
	else
		return name
	end
end

K.DebuffWhiteList = {
	-- Death Knight
	[SpellName(47476)] = true, -- Smothering
	[SpellName(51209)] = true, -- Hungering Cold
	-- Druid
	[SpellName(22570)] = true, -- Kolechenie
	[SpellName(2637)] = true, -- Hibernation
	[SpellName(33786)] = true, -- Twister
	[SpellName(339)] = true, -- Entangling Roots
	[SpellName(45334)] = true, -- Feral Charge
	[SpellName(5211)] = true, -- Bash
	[SpellName(9005)] = true, -- Pounce
	[SpellName(99)] = true, -- Demoralizing Roar
	-- Hunter
	[SpellName(1513)] = true, -- Scare Beast
	[SpellName(19386)] = true, -- Wyvern Sting
	[SpellName(19503)] = true, -- Scatter Shot
	[SpellName(24394)] = true, -- Intimidation
	[SpellName(3355)] = true, -- Freezing Trap Effect
	[SpellName(34490)] = true, -- Silencing Shot
	[SpellName(50245)] = true, -- Thorn
	[SpellName(50519)] = true, -- Ultrasound
	[SpellName(50541)] = true, -- Snatch
	[SpellName(54706)] = true, -- Poisonous poutina
	[SpellName(56626)] = true, -- Sting
	[SpellName(60210)] = true, -- Freezing Arrow Effect
	[SpellName(64803)] = true, -- Entrapment
	-- Mage
	[SpellName(118)] = true, -- Prevrashenie
	[SpellName(122)] = true, -- Frost Nova
	[SpellName(18469)] = true, -- Anti Magic -- muteness
	[SpellName(31589)] = true, -- Slowing
	[SpellName(31661)] = true, -- Dragon's Breath
	[SpellName(33395)] = true, -- Cold
	[SpellName(44572)] = true, -- Deep Freeze
	[SpellName(55021)] = true, -- Anti Magic -- muteness
	[SpellName(55080)] = true, -- Destroyed barrier
	[SpellName(61305)] = true, -- Transformation
	-- Paladin
	[SpellName(10326)] = true, -- The expulsion of evil
	[SpellName(20066)] = true, -- Repentance
	[SpellName(31935)] = true, -- Avenger's Shield
	[SpellName(853)] = true, -- Hammer of Justice
	-- Priest
	[SpellName(15487)] = true, -- Silence
	[SpellName(605)] = true, -- Mind Control
	[SpellName(64044)] = true, -- Psychic Horror
	[SpellName(8122)] = true, -- Psychic Scream
	[SpellName(9484)] = true, -- Shackle Undead
	-- Rogue
	[SpellName(1330)] = true, -- Garrote -- muteness
	[SpellName(1776)] = true, -- Gouge
	[SpellName(1833)] = true, -- Cheap Shot
	[SpellName(18425)] = true, -- Kick -- muteness
	[SpellName(2094)] = true, -- Blinding
	[SpellName(408)] = true, -- Kidney Shot
	[SpellName(51722)] = true, -- Lay Down Your Arms
	[SpellName(6770)] = true, -- Sap
	-- Shaman
	[SpellName(3600)] = true, -- Earthbind
	[SpellName(39796)] = true, -- Stun Stoneclaw
	[SpellName(51514)] = true, -- Hex
	[SpellName(63685)] = true, -- Freeze
	[SpellName(64695)] = true, -- Grip the earth
	[SpellName(8056)] = true, -- Frost Shock
	-- Warlock
	[SpellName(17928)] = true, -- Howl of Terror
	[SpellName(24259)] = true, -- Spell Lock
	[SpellName(30283)] = true, -- Dark Fury
	[SpellName(5782)] = true, -- Fear
	[SpellName(6358)] = true, -- Temptation
	[SpellName(6789)] = true, -- Death Coil
	[SpellName(710)] = true, -- Exile
	-- Warrior
	[SpellName(18498)] = true, -- silence -- muteness
	[SpellName(20511)] = true, -- Intimidating Shout
	[SpellName(676)] = true, -- disarmed
	[SpellName(7922)] = true, -- and Pounce stun
	-- Racial
	[SpellName(20549)] = true, -- Stomp
	[SpellName(25046)] = true, -- Arcane Torrent
	-- PVE Debuffs

	-- The Lich King
	[SpellName(73787)] = true, -- Necrotic Plague
}

K.PlateBlacklist = {
	["Army of the Dead Ghoul"] = true,
	["Dragonmaw War Banner"] = true,
	["Healing Tide Totem"] = true,
	["Venomous Snake"] = true,
}