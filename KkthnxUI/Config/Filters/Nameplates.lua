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
	-- DRUID
	
	-- Moonfire
	[SpellName(48463)] = true,
	-- Insect Swarm
	[SpellName(48468)] = true,
	-- Faerie Fire
	[SpellName(770)] = true,
	-- Entangling Roots
	[SpellName(26989)] = true,
	-- Earth and Moon
	[SpellName(48511)] = true,
	-- Rake
	[SpellName(59886)] = true,
	-- Rip
	[SpellName(49800)] = true,
	-- Lacerate
	[SpellName(48568)] = true,
	-- Pounce Bleed
	[SpellName(49804)] = true,
	-- Mangle (Cat)
	[SpellName(48566)] = true,
	-- Mangle (Bear)
	[SpellName(48564)] = true,
	
	[SpellName(99)] = true,
	
	-- Entangling Roots
	[SpellName(53308)] = true,
	-- Cyclone
	[SpellName(33786)] = true,
	-- Hibernate
	[SpellName(2637)] = true,
	
	-- HUNTER
	
	-- Hunter's Mark
	[SpellName(1130)] = true,
	-- Serpent Sting
	[SpellName(49001)] = true,
	-- Scorpid Sting
	[SpellName(3043)] = true,
	-- Black Arrow
	[SpellName(63672)] = true,
	-- Explosive Shot
	[SpellName(60053)] = true,
	-- Wyvern Sting
	[SpellName(49012)] = true,
	-- Silencing Shot
	[SpellName(34490)] = true,
	
	-- MAGE
	
	-- Arcane Blast
	[SpellName(36032)] = true,
	-- Improved Scorch
	[SpellName(22959)] = true,
	-- Slow
	[SpellName(31589)] = true,
	-- Ignite
	[SpellName(12848)] = true,
	-- Living Bomb
	[SpellName(55360)] = true,
	-- Arcane Blast
	[SpellName(36032)] = true,
	-- Frostbite
	[SpellName(11071)] = true,
	-- Winter's Chill
	[SpellName(28593)] = true,
	[SpellName(118)] = true,
	
	-- WARRIOR
	
	-- Hamstring
	[SpellName(1715)] = true,
	-- Rend
	[SpellName(47465)] = true,
	-- Sunder Armor
	[SpellName(7386)] = true,
	-- Expose Armor
	[SpellName(48669)] = true,
	-- Thunder Clap
	[SpellName(6343)] = true,
	-- Infected Wounds
	[SpellName(48485)] = true,
	-- Frost Fever
	[SpellName(55095)] = true,
	-- Demoralizing Shout
	[SpellName(1160)] = true,
	-- Demoralizing Roar
	[SpellName(48560)] = true,
	-- Curse of Weakness
	[SpellName(50511)] = true,
	
	-- SHAMMY
	-- Storm Strike
	[SpellName(17364)] = true,
	-- Earth Shock
	[SpellName(49231)] = true,
	-- Frost Shock
	[SpellName(49236)] = true,
	-- Flame Shock
	[SpellName(49233)] = true,
	-- Hex
	[SpellName(51514)] = true,
	
	-- PALADIN
	[SpellName(10308)] = true,  -- Hammer of Justice
	[SpellName(20271)] = true,  -- Judgement of Light
	[SpellName(53407)] = true,  -- Judgement of Justice
	[SpellName(20186)] = true,  -- Judgement of Wisdom
	[SpellName(54499)] = true,  -- Heart of the Crusader
	[SpellName(53742)] = true,  -- Blood Corruption
	
	-- PRIEST
	[SpellName(589)] = true, -- Shadow Word: Pain
	[SpellName(2944)] = true, -- Devouring Plague
	[SpellName(34914)] = true , -- Vampiric Touch
	[SpellName(10955)] = true, -- Shackle undead
	[SpellName(10890)] = true, -- Fear
	
	--WARLOCK
	-- Curse of the Elements
	[SpellName(47865)] = true,
	-- Ebon Plaguebringer
	[SpellName(51161)] = true,
	-- Earth and Moon
	[SpellName(48511)] = true,
	-- Curse of Tongues
	[SpellName(11719)] = true,
	-- Curse of Exhaustion
	[SpellName(18223)] = true,
	-- Curse of Weakness
	[SpellName(50511)] = true,
	-- Corruption
	[SpellName(172)] = true,
	-- Immolate
	[SpellName(348)] = true,
	-- Curse of Agony
	[SpellName(980)] = true,
	-- Curse of Doom
	[SpellName(47867)] = true,
	-- Unstable Affliction
	[SpellName(47843)] = true,
	-- Haunt
	[SpellName(59164)] = true,
	-- Seed of Corruption
	[SpellName(27243)] = true,
	-- Curse of Weakness
	[SpellName(702)] = true,
	-- Curse of Tongues
	[SpellName(1714)] = true,
	-- Curse of Exhaustion
	[SpellName(18223)] = true,
	-- Fear
	[SpellName(6215)] = true,
	-- Howl of Terror
	[SpellName(5484)] = true,
	-- Death Coil
	[SpellName(6789)] = true,
	-- Banish
	[SpellName(710)] = true,
	-- Enslave Demon
	[SpellName(1098)] = true,
	-- Demon Charge
	[SpellName(54785)] = true,
	-- Fear
	[SpellName(5782)] = true,
	-- Banish
	[SpellName(710)] = true,
	
	--ROGUE
	-- Rupture
	[SpellName(48672)] = true,
	-- Garrote
	[SpellName(48676)] = true,
	-- Kidney shot
	[SpellName(408)] = true,
	-- Gouge
	[SpellName(1776)] = true,
	-- Cheap shot
	[SpellName(1833)] = true,
	-- Blind
	[SpellName(2094)] = true,
	-- Sap
	[SpellName(6770)] = true,
	-- Expose Armor
	[SpellName(8647)] = true,
	-- Dismantle
	[SpellName(51722)] = true,
	-- Deadly Poison
	[SpellName(57973)] = true,
	-- Wound Poison
	[SpellName(57978)] = true,
	-- Crippling Poison
	[SpellName(3408)] = true,
	-- Mind-numbing Poison
	[SpellName(5761)] = true,
	-- Blind
	[SpellName(2094)] = true,
	
	--DEATHKNIGHT
	-- Bloodlust
	[SpellName(2825)] = true,
	-- Heroism
	[SpellName(32182)] = true,
	-- Hyperspeed Accelerators
	[SpellName(54999)] = true,
	-- Blood Plague
	[SpellName(59879)] = true,
	-- Frost Fever
	[SpellName(59921)] = true,
	-- Unholy Blight
	[SpellName(49194)] = true,
	-- Summon Gargoyle
	[SpellName(49206)] = true,
	
	-- ALL
	-- Death Knight
	-- Gnaw (Ghoul)
	[SpellName(47481)] = true,
	-- Strangulate
	[SpellName(47476)] = true,
	-- Chains of Ice
	[SpellName(45524)] = true,
	-- Desecration (no duration, lasts as long as you stand in it)
	[SpellName(55741)] = true,
	-- Glyph of Heart Strike
	[SpellName(58617)] = true,
	-- Icy Clutch (Chilblains)
	[SpellName(50436)] = true,
	-- Hungering Cold
	[SpellName(51209)] = true,
	
	-- Druid
	-- Cyclone
	[SpellName(33786)] = true,
	-- Hibernate
	[SpellName(2637)] = true,
	-- Bash
	[SpellName(5211)] = true,
	-- Maim
	[SpellName(22570)] = true,
	-- Pounce
	[SpellName(9005)] = true,
	-- Entangling Roots
	[SpellName(339)] = true,
	-- Feral Charge Effect
	[SpellName(45334)] = true,
	-- Infected Wounds
	[SpellName(58179)] = true,
	
	-- Hunter
	-- Freezing Trap Effect
	[SpellName(3355)] = true,
	-- Freezing Arrow Effect
	[SpellName(60210)] = true,
	-- Scare Beast
	[SpellName(1513)] = true,
	-- Scatter Shot
	[SpellName(19503)] = true,
	-- Chimera Shot - Scorpid
	[SpellName(53359)] = true,
	-- Snatch (Bird of Prey)
	[SpellName(50541)] = true,
	-- Silencing Shot
	[SpellName(34490)] = true,
	-- Intimidation
	[SpellName(24394)] = true,
	-- Sonic Blast (Bat)
	[SpellName(50519)] = true,
	-- Ravage (Ravager)
	[SpellName(50518)] = true,
	-- Concussive Barrage
	[SpellName(35101)] = true,
	-- Concussive Shot
	[SpellName(5116)] = true,
	-- Frost Trap Aura
	[SpellName(13810)] = true,
	-- Glyph of Freezing Trap
	[SpellName(61394)] = true,
	-- Wing Clip
	[SpellName(2974)] = true,
	-- Counterattack
	[SpellName(19306)] = true,
	-- Entrapment
	[SpellName(19185)] = true,
	-- Pin (Crab)
	[SpellName(50245)] = true,
	-- Venom Web Spray (Silithid)
	[SpellName(54706)] = true,
	-- Web (Spider)
	[SpellName(4167)] = true,
	-- Froststorm Breath (Chimera)
	[SpellName(51209)] = true,
	-- Tendon Rip (Hyena)
	[SpellName(51209)] = true,
	
	-- Mage
	-- Dragon's Breath
	[SpellName(31661)] = true,
	-- Polymorph
	[SpellName(118)] = true,
	-- Silenced - Improved Counterspell
	[SpellName(18469)] = true,
	-- Deep Freeze
	[SpellName(44572)] = true,
	-- Freeze (Water Elemental)
	[SpellName(33395)] = true,
	-- Frost Nova
	[SpellName(122)] = true,
	-- Shattered Barrier
	[SpellName(55080)] = true,
	-- Chilled
	[SpellName(6136)] = true,
	-- Cone of Cold
	[SpellName(120)] = true,
	-- Slow
	[SpellName(31589)] = true,
	
	-- Paladin
	-- Repentance
	[SpellName(20066)] = true,
	-- Turn Evil
	[SpellName(10326)] = true,
	-- Shield of the Templar
	[SpellName(63529)] = true,
	-- Hammer of Justice
	[SpellName(853)] = true,
	-- Holy Wrath
	[SpellName(2812)] = true,
	-- Stun (Seal of Justice proc)
	[SpellName(20170)] = true,
	-- Avenger's Shield
	[SpellName(31935)] = true,
	
	-- Priest
	-- Psychic Horror
	[SpellName(64058)] = true,
	-- Mind Control
	[SpellName(605)] = true,
	-- Psychic Horror
	[SpellName(64044)] = true,
	-- Psychic Scream
	[SpellName(8122)] = true,
	-- Silence
	[SpellName(15487)] = true,
	-- Mind Flay
	[SpellName(15407)] = true,
	
	-- Rogue
	-- Dismantle
	[SpellName(51722)] = true,
	-- Blind
	[SpellName(2094)] = true,
	-- Gouge
	[SpellName(1776)] = true,
	-- Sap
	[SpellName(6770)] = true,
	-- Garrote - Silence
	[SpellName(1330)] = true,
	-- Silenced - Improved Kick
	[SpellName(18425)] = true,
	-- Cheap Shot
	[SpellName(1833)] = true,
	-- Kidney Shot
	[SpellName(408)] = true,
	-- Blade Twisting
	[SpellName(31125)] = true,
	-- Crippling Poison
	[SpellName(3409)] = true,
	-- Deadly Throw
	[SpellName(26679)] = true,
	
	-- Shaman
	-- Hex
	[SpellName(51514)] = true,
	-- Earthgrab
	[SpellName(64695)] = true,
	-- Freeze
	[SpellName(63685)] = true,
	-- Stoneclaw Stun
	[SpellName(39796)] = true,
	-- Earthbind
	[SpellName(3600)] = true,
	-- Frost Shock
	[SpellName(8056)] = true,
	
	-- Warlock
	-- Banish
	[SpellName(710)] = true,
	-- Death Coil
	[SpellName(6789)] = true,
	-- Fear
	[SpellName(5782)] = true,
	-- Howl of Terror
	[SpellName(5484)] = true,
	-- Seduction (Succubus)
	[SpellName(6358)] = true,
	-- Spell Lock (Felhunter)
	[SpellName(24259)] = true,
	-- Shadowfury
	[SpellName(30283)] = true,
	-- Intercept (Felguard)
	[SpellName(30153)] = true,
	-- Aftermath
	[SpellName(18118)] = true,
	-- Curse of Exhaustion
	[SpellName(18223)] = true,
	
	-- Warrior
	-- Intimidating Shout
	[SpellName(20511)] = true,
	-- Disarm
	[SpellName(676)] = true,
	-- Silenced (Gag Order)
	[SpellName(18498)] = true,
	-- Charge Stun
	[SpellName(7922)] = true,
	-- Concussion Blow
	[SpellName(12809)] = true,
	-- Intercept
	[SpellName(20253)] = true,
	-- Revenge Stun
	[SpellName(12798)] = true,
	-- Shockwave
	[SpellName(46968)] = true,
	-- Glyph of Hamstring
	[SpellName(58373)] = true,
	-- Improved Hamstring
	[SpellName(23694)] = true,
	-- Hamstring
	[SpellName(1715)] = true,
	-- Piercing Howl
	[SpellName(12323)] = true,
	
	-- Racials
	-- War Stomp
	[SpellName(20549)] = true,
	
	-- Mark of the Fallen Champion
	[SpellName(72293)] = true,
	-- Inoculated (Festergut)
	[SpellName(72103)] = true,
	-- Mutated Infection (Rotface)
	[SpellName(71224)] = true,
	-- Unbound Plague (Professor Putricide)
	[SpellName(72856)] = true,
	-- Gas Variable (Professor Putricide)
	[SpellName(70353)] = true,
	-- Ooze Variable (Professor Putricide)
	[SpellName(70352)] = true,
	-- Pact of the Darkfallen (Bloodqueen Lana'thel)
	[SpellName(71340)] = true,
	-- Swarming Shadows (Bloodqueen Lana'thel)
	[SpellName(71861)] = true,
	-- Essence of the Blood Queen (Bloodqueen Lana'thel)
	[SpellName(71473)] = true,
	-- Frost Bomb (Sindragosa)
	[SpellName(71053)] = true,
	-- Instability (Sindragosa)
	[SpellName(69766)] = true,
	-- Unchained Magic (Sindragosa)
	[SpellName(69762)] = true,
	-- Mystic Buffet (Sindragosa)
	[SpellName(70128)] = true,
	-- Necrotic Plague (Arthas - The Lich King)
	[SpellName(73912)] = true,
}

K.PlateBlacklist = {
	["Army of the Dead Ghoul"] = true,
	["Dragonmaw War Banner"] = true,
	["Healing Tide Totem"] = true,
	["Venomous Snake"] = true,
}