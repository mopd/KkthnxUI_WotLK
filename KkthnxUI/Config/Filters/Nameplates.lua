local K, C, L, _ = unpack(select(2, ...))
if C["nameplate"].enable ~= true then return end

local print = print

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at http://wotlk.openwow.com search for a spell.
--	Example: Necrotic Plague -> http://wotlk.openwow.com/spell=73787
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id)
	if(not name) then
		print("|cff3AA0E9KkthnxUI:|r SpellID is not valid: "..id..". Please check for an updated version, if none exists report to KkthnxUI author.")
		return "Impale";
	else
		return name;
	end
end

K.DebuffWhiteList = {
-- Death Knight
[SpellName (47476)] = true, -- Smothering
[SpellName (51209)] = true, -- Hungering Cold
-- Druid
[SpellName (99)] = true, -- Demoralizing Roar
[SpellName (339)] = true, -- Entangling Roots
[SpellName (2637)] = true, -- Hibernation
[SpellName (5211)] = true, -- Bash
[SpellName (9005)] = true, -- Pounce
[SpellName (22570)] = true, -- Kolechenie
[SpellName (33786)] = true, -- Twister
[SpellName (45334)] = true, -- Feral Charge
-- Hunter
[SpellName (1513)] = true, -- Scare Beast
[SpellName (3355)] = true, -- Freezing Trap Effect
[SpellName (19386)] = true, -- Wyvern Sting
[SpellName (19503)] = true, -- Scatter Shot
[SpellName (24394)] = true, -- Intimidation
[SpellName (34490)] = true, -- Silencing Shot
[SpellName (50245)] = true, -- Thorn
[SpellName (50519)] = true, -- Ultrasound
[SpellName (50541)] = true, -- Snatch
[SpellName (54706)] = true, -- Poisonous poutina
[SpellName (56626)] = true, -- Sting
[SpellName (60210)] = true, -- Freezing Arrow Effect
[SpellName (64803)] = true, -- Entrapment
-- Mage
[SpellName (118)] = true, -- Prevrashenie
[SpellName (122)] = true, -- Frost Nova
[SpellName (18469)] = true, -- Anti Magic -- muteness
[SpellName (31589)] = true, -- Slowing
[SpellName (31661)] = true, -- Dragon's Breath
[SpellName (33395)] = true, -- Cold
[SpellName (44572)] = true, -- Deep Freeze
[SpellName (55080)] = true, -- Destroyed barrier
[SpellName (61305)] = true, -- Transformation
[SpellName (55021)] = true, -- Anti Magic -- muteness
-- Paladin
[SpellName (853)] = true, -- Hammer of Justice
[SpellName (10326)] = true, -- The expulsion of evil
[SpellName (20066)] = true, -- Repentance
[SpellName (31935)] = true, -- Avenger's Shield
-- Priest
[SpellName (605)] = true, -- Mind Control
[SpellName (8122)] = true, -- Psychic Scream
[SpellName (9484)] = true, -- Shackle Undead
[SpellName (15487)] = true, -- Silence
[SpellName (64044)] = true, -- Psychic Horror
-- Rogue
[SpellName (408)] = true, -- Kidney Shot
[SpellName (1330)] = true, -- Garrote -- muteness
[SpellName (1776)] = true, -- Gouge
[SpellName (1833)] = true, -- Cheap Shot
[SpellName (2094)] = true, -- Blinding
[SpellName (6770)] = true, -- Sap
[SpellName (18425)] = true, -- Kick -- muteness
[SpellName (51722)] = true, -- Lay Down Your Arms
-- Shaman
[SpellName (3600)] = true, -- Earthbind
[SpellName (8056)] = true, -- Frost Shock
[SpellName (39796)] = true, -- Stun Stoneclaw
[SpellName (51514)] = true, -- Hex
[SpellName (63685)] = true, -- Freeze
[SpellName (64695)] = true, -- Grip the earth
-- Warlock
[SpellName (710)] = true, -- Exile
[SpellName (5782)] = true, -- Fear
[SpellName (6358)] = true, -- Temptation
[SpellName (6789)] = true, -- Death Coil
[SpellName (17928)] = true, -- Howl of Terror
[SpellName (24259)] = true, -- Spell Lock
[SpellName (30283)] = true, -- Dark Fury
-- Warrior
[SpellName (676)] = true, -- disarmed
[SpellName (7922)] = true, -- and Pounce stun
[SpellName (18498)] = true, -- silence -- muteness
[SpellName (20511)] = true, -- Intimidating Shout
-- Racial
[SpellName (25046)] = true, -- Arcane Torrent
[SpellName (20549)] = true, -- Stomp
-- PVE Debuffs

-- The Lich King
[SpellName (73787)] = true -- Necrotic Plague
}

K.PlateBlacklist = {
	["Army of the Dead Ghoul"] = true,
	["Venomous Snake"] = true,
	["Healing Tide Totem"] = true,
	["Dragonmaw War Banner"] = true
}