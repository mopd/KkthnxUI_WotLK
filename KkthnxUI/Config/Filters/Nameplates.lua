local K, C, L = unpack(select(2, ...));
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at http://wotlk.openwow.com search for a spell.
--	Example: Serpent Sting -> http://wotlk.openwow.com/spell=36984
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = select(1, GetSpellInfo(id))
	return name
end

-- Nameplates use these
K.DebuffWhiteList = {
	-- Death Knight
	[SpellName(47481)] = true,	-- Gnaw (Ghoul)
	[SpellName(51209)] = true,	-- Hungering Cold
	[SpellName(47476)] = true,	-- Strangulate
	[SpellName(45524)] = true,	-- Chains of Ice
	[SpellName(55666)] = true,	-- Desecration (no duration, lasts as long as you stand in it)
	[SpellName(58617)] = true,	-- Glyph of Heart Strike
	[SpellName(50436)] = true,	-- Icy Clutch (Chilblains)
	-- Druid
	[SpellName(5211)] = true, 	-- Bash (also Shaman Spirit Wolf ability)
	[SpellName(33786)] = true,	-- Cyclone
	[SpellName(2637)] = true, 	-- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
	[SpellName(22570)] = true,	-- Maim
	[SpellName(9005)] = true, 	-- Pounce
	[SpellName(339)] = true,  	-- Entangling Roots
	[SpellName(19675)] = true,	-- Feral Charge Effect (immobilize with interrupt "spell lockout, not silence",)
	[SpellName(58179)] = true,	-- Infected Wounds
	[SpellName(61391)] = true,	-- Typhoon
	[SpellName(8921)] = true,	-- Moonfire
	[SpellName(5570)] = true,	-- Insect Swarm
	[SpellName(33878)] = true,	-- Mangle
	[SpellName(33745)] = true,	-- Lacerate
	[SpellName(1822)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	-- Hunter
	[SpellName(28822)] = true,	-- Flare
	[SpellName(36984)] = true,	-- Serpent Sting
	[SpellName(56303)] = true,	-- Hunter's Mark
	[SpellName(60210)] = true,	-- Freezing Arrow Effect
	[SpellName(3355)] = true, 	-- Freezing Trap Effect
	[SpellName(24394)] = true,	-- Intimidation
	[SpellName(1513)] = true, 	-- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
	[SpellName(19503)] = true,	-- Scatter Shot
	[SpellName(19386)] = true,	-- Wyvern Sting
	[SpellName(34490)] = true,	-- Silencing Shot
	[SpellName(53359)] = true,	-- Chimera Shot - Scorpid
	[SpellName(19306)] = true,	-- Counterattack
	[SpellName(19185)] = true,	-- Entrapment
	[SpellName(35101)] = true,	-- Concussive Barrage
	[SpellName(5116)] = true, 	-- Concussive Shot
	[SpellName(13810)] = true,	-- Frost Trap Aura (no duration, lasts as long as you stand in it)
	[SpellName(61394)] = true,	-- Glyph of Freezing Trap
	[SpellName(2974)] = true, 	-- Wing Clip
	-- Mage
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(61305)] = true,	-- Polymorph
	[SpellName(18469)] = true,	-- Silenced - Improved Counterspell
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(55080)] = true,	-- Shattered Barrier
	[SpellName(44572)] = true,	-- Deep Freeze
	[SpellName(12355)] = true,	-- Impact
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(64346)] = true,	-- Fiery Payback
	[SpellName(33395)] = true,	-- Freeze (Water Elemental)
	[SpellName(11071)] = true,	-- Frostbite
	[SpellName(11113)] = true,	-- Blast Wave
	[SpellName(6136)] = true,	-- Chilled (generic effect, used by lots of spells "looks weird on Improved Blizzard, might want to comment out",)
	[SpellName(120)] = true, 	-- Cone of Cold
	[SpellName(116)] = true,	-- Frostbolt
	[SpellName(47610)] = true,	-- Frostfire Bolt
	[SpellName(31589)] = true,	-- Slow
	-- Paladin	
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(10326)] = true,	-- Turn Evil
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(2812)] = true, 	-- Holy Wrath (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
	[SpellName(20170)] = true,	-- Stun (Seal of Justice proc)
	[SpellName(63529)] = true,	-- Shield of the Templar
	[SpellName(20184)] = true,	-- Judgement of Justice (100% movement snare; druids and shamans might want this though)
	-- Priest	
	[SpellName(605)] = true,	-- Mind Control
	[SpellName(64044)] = true,	-- Psychic Horror
	[SpellName(8122)] = true,	-- Psychic Scream
	[SpellName(9484)] = true,	-- Shackle Undead
	[SpellName(15487)] = true,	-- Silence
	--[SpellName(64058)] = true,	-- Psychic Horror (duplicate debuff names not allowed atm, need to figure out how to support this later)
	[SpellName(15407)] = true, 	-- Mind Flay
	-- Rogue	
	[SpellName(2094)] = true,	-- Blind
	[SpellName(1776)] = true,	-- Gouge
	[SpellName(6770)] = true,	-- Sap
	[SpellName(18425)] = true,	-- Silenced - Improved Kick
	[SpellName(1833)] = true,	-- Cheap Shot
	[SpellName(408)] = true, 	-- Kidney Shot
	[SpellName(1330)] = true,	 -- Garrote - Silence
	[SpellName(51722)] = true,	-- Dismantle
	[SpellName(31125)] = true,	-- Blade Twisting
	[SpellName(3409)] = true, 	-- Crippling Poison
	[SpellName(26679)] = true,	-- Deadly Throw
	-- Shaman	
	[SpellName(51514)] = true,	-- Hex (although effectively a silence+disarm effect, it is conventionally thought of as a "CC", plus you can trinket out of it)
	[SpellName(3600)] = true,	-- Earthbind (5 second duration per pulse, but will keep re-applying the debuff as long as you stand within the pulse radius)
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(8050)] = true,	-- Flame Shock
	[SpellName(63685)] = true,	-- Freeze
	[SpellName(39796)] = true,	-- Stoneclaw Stun
	[SpellName(64695)] = true,	-- Earthgrab (Storm, Earth and Fire)
	[SpellName(8034)] = true, 	-- Frostbrand Attack
	-- Warlock	
	[SpellName(710)] = true,	-- Banish (works against Warlocks using Metamorphasis and Druids using Tree Form)
	[SpellName(6789)] = true,	-- Death Coil
	[SpellName(5782)] = true,	-- Fear
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(6358)] = true,	-- Seduction
	[SpellName(30283)] = true,	-- Shadowfury
	[SpellName(603)] = true,	-- Bane of Doom
	[SpellName(980)] = true,	-- Bane of Agony
	[SpellName(172)] = true,	-- Corruption
	[SpellName(17800)] = true,	-- Shadow and Flame
	[SpellName(48181)] = true,	-- Haunt
	[SpellName(30108)] = true,	-- Unstable Affliction
	[SpellName(348)] = true,	-- Immolate
	[SpellName(24259)] = true,	-- Spell Lock (Felhunter)
	[SpellName(18118)] = true,	-- Aftermath
	[SpellName(18223)] = true,	-- Curse of Exhaustion
	-- Warrior	
	[SpellName(20511)] = true,	-- Intimidating Shout
	[SpellName(7922)] = true, 	-- Charge Stun
	[SpellName(12809)] = true,	-- Concussion Blow
	[SpellName(20253)] = true,	-- Intercept (also Warlock Felguard ability)
	[SpellName(5246)] = true, 	-- Intimidating Shout
	[SpellName(12798)] = true,	-- Revenge Stun
	[SpellName(46968)] = true,	-- Shockwave
	[SpellName(18498)] = true,	-- Silenced - Gag Order
	[SpellName(676)] = true,	-- Disarm
	[SpellName(58373)] = true,	-- Glyph of Hamstring+*
	[SpellName(23694)] = true,	-- Improved Hamstring
	[SpellName(1715)] = true, 	-- Hamstring
	[SpellName(12323)] = true,	-- Piercing Howl
	-- Racial	
	[SpellName(25046)] = true,	-- Arcane Torrent
	[SpellName(20549)] = true,	-- War Stomp
	-- Others
	[SpellName(30217)] = true,	-- Adamantite Grenade
	[SpellName(67769)] = true,	-- Cobalt Frag Bomb
	[SpellName(30216)] = true,	-- Fel Iron Bomb
	[SpellName(39965)] = true,	-- Frost Grenade
	[SpellName(55536)] = true,	-- Frostweave Net
	[SpellName(13099)] = true,	-- Net-o-Matic
	[SpellName(29703)] = true,	-- Dazed
}

K.PlateBlacklist = {
	--Shaman Totems
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
	
	--Army of the Dead
	["Army of the Dead Ghoul"] = true,
	
	--Hunter Trap
	["Venomous Snake"] = true,
	["Viper"] = true,
	
	--Test
	--["Unbound Seer"] = true,
}