local K, C, L = unpack(select(2, ...));
if C["nameplate"].enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at http://wotlk.openwow.com search for a spell.
--	Example: Serpent Sting -> http://wotlk.openwow.com/spell=36984
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName( id )
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo( id ) 	
	return name
end

K.PlateBlacklist = {
	["Earth Elemental Totem"] = true,
	["Fire Elemental Totem"] = true,
	["Fire Resistance Totem"] = true,
	["Flametongue Totem"] = true,
	["Frost Resistance Totem"] = true,
	["Healing Stream Totem"] = true,
	["Magma Totem"] = true,
	["Mana Spring Totem"] = true,
	["Nature Resistance Totem"] = true,
	["Searing Totem"] = true,
	["Stoneclaw Totem"] = true,
	["Stoneskin Totem"] = true,
	["Strength of Earth Totem"] = true,
	["Windfury Totem"] = true,
	["Totem of Wrath"] = true,
	["Wrath of Air Totem"] = true,

	["Army of the Dead Ghoul"] = true,

	["Venomous Snake"] = true,
	["Viper"] = true,
}

K.ChannelTicks = {
	[SpellName( 689 )] = 3,
	[SpellName( 5740 )] = 4,
	[SpellName( 755 )] = 3,

	[SpellName( 44203 )] = 4,
	[SpellName( 16914 )] = 10,

	[SpellName( 15407 )] = 3,
	[SpellName( 48045 )] = 5,
	[SpellName( 47540 )] = 2,

	[SpellName( 5143 )] = 5,
	[SpellName( 10 )] = 5,
	[SpellName( 12051 )] = 4,
}

K.DebuffWhiteList = {
	[SpellName( 47476 )] = true,
	[SpellName( 49203 )] = true,

	[SpellName( 33786 )] = true,
	[SpellName( 2637 )] = true,
	[SpellName( 339 )] = true,

	[SpellName( 3355 )] = true,
	[SpellName( 1513 )] = true,
	[SpellName( 19503 )] = true,
	[SpellName( 34490 )] = true,

	[SpellName( 31661 )] = true,
	[SpellName( 61305 )] = true,
	[SpellName( 18469 )] = true,
	[SpellName( 122 )] = true,
	[SpellName( 55080 )] = true,

	[SpellName( 20066 )] = true,
	[SpellName( 10326 )] = true,
	[SpellName( 853 )] = true,

	[SpellName( 605 )] = true,
	[SpellName( 64044 )] = true,
	[SpellName( 8122 )] = true,
	[SpellName( 9484 )] = true,
	[SpellName( 15487 )] = true,

	[SpellName( 2094 )] = true,
	[SpellName( 1776 )] = true,
	[SpellName( 6770 )] = true,
	[SpellName( 18425 )] = true,

	[SpellName( 51514 )] = true,
	[SpellName( 3600 )] = true,
	[SpellName( 8056 )] = true,
	[SpellName( 63685 )] = true,
	[SpellName( 39796 )] = true,

	[SpellName( 710 )] = true,
	[SpellName( 6789 )] = true,
	[SpellName( 5782 )] = true,
	[SpellName( 5484 )] = true,
	[SpellName( 6358 )] = true,
	[SpellName( 30283 )] = true,

	[SpellName( 20511 )] = true,

	[SpellName( 25046 )] = true,
	[SpellName( 20549 )] = true,
}