local K, C, L, _ = unpack(select(2, ...))
if C.combattext.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Blizzard -> http://www.wowhead.com/spell=42208
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
-- General filter outgoing healing
if C.combattext.healing then
	K.healfilter = {}
end

-- General merge outgoing damage
if C.combattext.merge_aoe_spam then
	K.merge = {}
	K.aoespam = {}
	K.aoespam[6603] = 3				-- Auto Attack
	K.aoespam[148008] = 3			-- Essence of Yu'lon
	K.aoespam[148009] = 3			-- Spirit of Chi-Ji
	K.aoespam[149276] = 3			-- Flurry of Xuen
	K.aoespam[147891] = 3			-- Flurry of Xuen
end

-- Class config
if K.Class == "DEATHKNIGHT" then
	if C.combattext.merge_aoe_spam then
		K.aoespam[55095] = 3		-- Frost Fever
		K.aoespam[55078] = 3		-- Blood Plague
		K.aoespam[50842] = 0		-- Blood Boil
		K.aoespam[49184] = 0		-- Howling Blast
		K.aoespam[52212] = 3		-- Death and Decay
		K.aoespam[50401] = 3		-- Razor Frost
		K.aoespam[91776] = 3		-- Claw (Ghoul)
		K.aoespam[49020] = 0		-- Obliterate
		K.aoespam[49143] = 0		-- Frost Strike
		K.aoespam[45462] = 0		-- Plague Strike
		K.aoespam[49998] = 0		-- Death Strike
		K.merge[66198] = 49020		-- Obliterate Off-Hand
		K.merge[66196] = 49143		-- Frost Strike Off-Hand
		K.merge[66216] = 45462		-- Plague Strike Off-Hand
		K.merge[66188] = 49998		-- Death Strike Off-Hand
	end
	if C.combattext.healing then
		K.healfilter[119980] = true	-- Conversion
	end
elseif K.Class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		K.aoespam[774] = 3			-- Rejuvenation
		K.aoespam[48438] = 3		-- Wild Growth
		K.aoespam[8936] = 3			-- Regrowth
		K.aoespam[33763] = 3		-- Lifebloom
		K.aoespam[157982] = 3		-- Tranquility
		K.aoespam[81269] = 3		-- Wild Mushroom
		K.aoespam[124988] = 3		-- Nature's Vigil
		K.aoespam[162359] = 3		-- Genesis
		K.aoespam[144876] = 3		-- Spark of Life (T16)
		-- Damaging spells
		K.aoespam[164812] = 3		-- Moonfire
		K.aoespam[164815] = 3		-- Sunfire
		K.aoespam[42231] = 3		-- Hurricane
		K.aoespam[106998] = 3		-- Astral Storm
		K.aoespam[50288] = 3		-- Starfall
		K.aoespam[61391] = 0		-- Typhoon
		K.aoespam[155722] = 3		-- Rake
		K.aoespam[33917] = 0		-- Mangle
		K.aoespam[106785] = 0		-- Swipe
		K.aoespam[33745] = 3		-- Lacerate
		K.aoespam[77758] = 3		-- Thrash (Bear Form)
		K.aoespam[106830] = 3		-- Thrash (Cat Form)
		K.aoespam[1079] = 3			-- Rip
		K.aoespam[124991] = 3		-- Nature's Vigil
	end
	if C.combattext.healing then
		K.healfilter[145109] = true	-- Ysera's Gift (Self)
		K.healfilter[145110] = true	-- Ysera's Gift
		K.healfilter[68285] = true	-- Leader of the Pack
	end
elseif K.Class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		K.aoespam[2643] = 0			-- Multi-Shot
		K.aoespam[118253] = 3		-- Serpent Sting
		K.aoespam[13812] = 3		-- Explosive Trap
		K.aoespam[53301] = 3		-- Explosive Shot
		K.aoespam[118459] = 3		-- Beast Cleave
		K.aoespam[120699] = 3		-- Lynx Rush
		K.aoespam[120361] = 3		-- Barrage
		K.aoespam[131900] = 3		-- A Murder of Crows
		K.aoespam[3674] = 3			-- Black Arrow
		K.aoespam[121414] = 3		-- Glaive Toss
		K.aoespam[162543] = 3		-- Poisoned Ammo
		K.aoespam[162541] = 3		-- Incendiary Ammo
		K.aoespam[34655] = 3		-- Deadly Poison (Trap)
		K.aoespam[93433] = 3		-- Burrow Attack (Worm)
		K.aoespam[92380] = 3		-- Froststorm Breath (Chimaera)
		K.merge[120761] = 121414	-- Glaive Toss
	end
	if C.combattext.healing then
		K.healfilter[51753] = true	-- Camouflage
	end
elseif K.Class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		K.aoespam[44457] = 3		-- Living Bomb
		K.aoespam[44461] = 3		-- Living Bomb (AoE)
		K.aoespam[2120] = 3			-- Flamestrike
		K.aoespam[12654] = 3		-- Ignite
		K.aoespam[11366] = 3		-- Pyroblast
		K.aoespam[31661] = 0		-- Dragon's Breath
		K.aoespam[42208] = 3		-- Blizzard
		K.aoespam[122] = 0			-- Frost Nova
		K.aoespam[1449] = 0			-- Arcane Explosion
		K.aoespam[83853] = 3		-- Combustion
		K.aoespam[120] = 0			-- Cone of Cold
		K.aoespam[114923] = 3		-- Nether Tempest
		K.aoespam[114954] = 3		-- Nether Tempest (AoE)
		K.aoespam[7268] = 3			-- Arcane Missiles
		K.aoespam[113092] = 0		-- Frost Bomb
		K.aoespam[44425] = 0		-- Arcane Barrage
		K.aoespam[84721] = 3		-- Frozen Orb
		K.aoespam[148022] = 3		-- Icicle (Mastery)
		K.aoespam[31707] = 3		-- Waterbolt (Pet)
		K.aoespam[30455] = 0		-- Ice Lance
		K.aoespam[115611] = 6		-- Temporal Ripples
		K.aoespam[157981] = 1		-- Blast Wave
		K.aoespam[157997] = 1		-- Ice Nova
		K.aoespam[157980] = 1		-- Supernova
		K.aoespam[135029] = 3		-- Water Jet (Pet)
	end
elseif K.Class == "MONK" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		K.aoespam[119611] = 3		-- Renewing Mist
		K.aoespam[132120] = 3		-- Enveloping Mist
		K.aoespam[115175] = 3		-- Soothing Mist
		K.aoespam[125953] = 3		-- Soothing Mist (Statue)
		K.aoespam[126890] = 3		-- Eminence
		K.aoespam[117640] = 3		-- Spinning Crane Kick
		K.aoespam[132463] = 3		-- Chi Wave
		K.aoespam[130654] = 3		-- Chi Burst
		K.aoespam[124081] = 3		-- Zen Sphere
		K.aoespam[124101] = 3		-- Zen Sphere: Detonate
		K.aoespam[116670] = 0		-- Uplift
		K.merge[159621] = 126890	-- Eminence
		-- Damaging spells
		K.aoespam[117952] = 3		-- Crackling Jade Lightning
		K.aoespam[117418] = 3		-- Fists of Fury
		K.aoespam[128531] = 3		-- Blackout Kick (DoT)
		K.aoespam[121253] = 0		-- Keg Smash
		K.aoespam[115181] = 0		-- Breath of Fire
		K.aoespam[123725] = 3		-- Breath of Fire (DoT)
		K.aoespam[107270] = 3		-- Spinning Crane Kick
		K.aoespam[123586] = 3		-- Flying Serpent Kick
		K.aoespam[132467] = 3		-- Chi Wave
		K.aoespam[148135] = 3		-- Chi Burst
		K.aoespam[124098] = 3		-- Zen Sphere
		K.aoespam[125033] = 3		-- Zen Sphere: Detonate
	end
elseif K.Class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		K.aoespam[20167] = 3		-- Seal of Insight
		K.aoespam[123530] = 3		-- Battle Insight
		K.aoespam[53652] = 3		-- Beacon of Light
		K.aoespam[85222] = 0		-- Light of Dawn
		K.aoespam[82327] = 0		-- Holy Radiance
		K.aoespam[121129] = 0		-- Daybreak
		K.aoespam[114163] = 3		-- Eternal Flame
		K.aoespam[114852] = 0		-- Holy Prism
		K.aoespam[119952] = 3		-- Arcing Light
		K.aoespam[114917] = 3		-- Stay of Execution
		K.aoespam[144581] = 3		-- Blessing of the Guardians (T16)
		-- Damaging spells
		K.aoespam[81297] = 3		-- Consecration
		K.aoespam[119072] = .5		-- Holy Wrath
		K.aoespam[53385] = 0		-- Divine Storm
		K.aoespam[122032] = 0		-- Exorcism (Glyph)
		K.aoespam[31803] = 3		-- Censure
		K.aoespam[42463] = 3		-- Seal of Truth
		K.aoespam[101423] = 3		-- Seal of Righteousness
		K.aoespam[88263] = 0		-- Hammer of the Righteous
		K.aoespam[96172] = 3		-- Hand of Light (Mastery)
		K.aoespam[31935] = .5		-- Avenger's Shield
		K.aoespam[114871] = 0		-- Holy Prism
		K.aoespam[114919] = 3		-- Arcing Light
		K.aoespam[114916] = 3		-- Execution Sentence
		K.aoespam[86704] = 0		-- Ancient Fury
		K.merge[53595] = 88263		-- Hammer of the Righteous
	end
	if C.combattext.healing then
		K.healfilter[115547] = true	-- Glyph of Avenging Wrath
	end
elseif K.Class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		K.aoespam[47750] = 3		-- Penance
		K.aoespam[23455] = 0		-- Holy Nova
		K.aoespam[139] = 3			-- Renew
		K.aoespam[596] = 0			-- Prayer of Healing
		K.aoespam[64844] = 3		-- Divine Hymn
		K.aoespam[32546] = 3		-- Binding Heal
		K.aoespam[77489] = 3		-- Echo of Light
		K.aoespam[34861] = 0		-- Circle of Healing
		K.aoespam[33110] = 3		-- Prayer of Mending
		K.aoespam[88686] = 3		-- Holy Word: Sanctuary
		K.aoespam[81751] = 3		-- Atonement
		K.aoespam[120692] = 3		-- Halo
		K.aoespam[121148] = 3		-- Cascade
		K.aoespam[110745] = 3		-- Divine Star
		K.merge[94472] = 81751		-- Atonement
		-- Damaging spells
		K.aoespam[47666] = 3		-- Penance
		K.aoespam[132157] = 0		-- Holy Nova
		K.aoespam[589] = 3			-- Shadow Word: Pain
		K.aoespam[34914] = 3		-- Vampiric Touch
		K.aoespam[2944] = 3			-- Devouring Plague
		K.aoespam[15407] = 3		-- Mind Flay
		K.aoespam[49821] = 3		-- Mind Sear
		K.aoespam[14914] = 3		-- Holy Fire
		K.aoespam[129250] = 3		-- Power Word: Solace
		K.aoespam[120696] = 3		-- Halo
		K.aoespam[127628] = 3		-- Cascade
		K.aoespam[122128] = 3		-- Divine Star
		K.aoespam[129197] = 3		-- Insanity
		K.aoespam[148859] = 3		-- Shadowy Apparition
		K.merge[158831] = 2944		-- Devouring Plague
	end
	if C.combattext.healing then
		K.healfilter[127626] = true	-- Devouring Plague
		K.healfilter[15290] = true	-- Vampiric Embrace
	end
elseif K.Class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		K.aoespam[51723] = 0		-- Fan of Knives
		K.aoespam[122233] = 3		-- Crimson Tempest (DoT)
		K.aoespam[2818] = 3			-- Deadly Poison
		K.aoespam[8680] = 3			-- Wound Poison
		K.aoespam[22482] = 3		-- Blade Flurry
		K.aoespam[16511] = 3		-- Hemorrhage
		K.aoespam[5374] = 0			-- Mutilate
		K.merge[27576] = 5374		-- Mutilate Off-Hand
		K.merge[113780] = 2818		-- Deadly Poison
		K.merge[168908] = 16511		-- Hemorrhage
		K.merge[121411] = 122233	-- Crimson Tempest
	end
	if C.combattext.healing then
		K.healfilter[112974] = true	-- Leeching Poison
	end
elseif K.Class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		K.aoespam[73921] = 3		-- Healing Rain
		K.aoespam[52042] = 3		-- Healing Stream Totem
		K.aoespam[1064] = 3			-- Chain Heal
		K.aoespam[61295] = 3		-- Riptide
		K.aoespam[98021] = 3		-- Spirit Link
		K.aoespam[114911] = 3		-- Ancestral Guidance
		K.aoespam[114942] = 3		-- Healing Tide
		K.aoespam[114083] = 3		-- Restorative Mists
		-- Damaging spells
		K.aoespam[421] = 1			-- Chain Lightning
		K.aoespam[8349] = 0			-- Fire Nova
		K.aoespam[77478] = 3		-- Earhquake
		K.aoespam[51490] = 0		-- Thunderstorm
		K.aoespam[8187] = 3			-- Magma Totem
		K.aoespam[8050] = 3			-- Flame Shock
		K.aoespam[25504] = 3		-- Windfury Attack
		K.aoespam[10444] = 3		-- Flametongue Attack
		K.aoespam[3606] = 3			-- Searing Bolt
		K.aoespam[170379] = 3		-- Molten Earth
		K.aoespam[114074] = 1		-- Lava Beam
		K.aoespam[32175] = 0		-- Stormstrike
		K.aoespam[114089] = 3		-- Windlash
		K.aoespam[115357] = 0		-- Windstrike
		K.merge[168477] = 421		-- Chain Lightning (Multi)
		K.merge[168489] = 114074	-- Lava Beam (Multi)
		K.merge[32176] = 32175		-- Stormstrike Off-Hand
		K.merge[114093] = 114089	-- Windlash Off-Hand
		K.merge[115360] = 115357	-- Windstrike Off-Hand
	end
elseif K.Class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		K.aoespam[27243] = 3		-- Seed of Corruption
		K.aoespam[27285] = 3		-- Seed of Corruption (AoE)
		K.aoespam[87385] = 3		-- Seed of Corruption (Soulburn)
		K.aoespam[146739] = 3		-- Corruption
		K.aoespam[30108] = 3		-- Unstable Affliction
		K.aoespam[348] = 3			-- Immolate
		K.aoespam[980] = 3			-- Agony
		K.aoespam[80240] = 3		-- Havoc
		K.aoespam[42223] = 3		-- Rain of Fire
		K.aoespam[689] = 3			-- Drain Life
		K.aoespam[5857] = 3			-- Hellfire
		K.aoespam[129476] = 3		-- Immolation Aura
		K.aoespam[103103] = 3		-- Drain Soul
		K.aoespam[86040] = 3		-- Hand of Gul'dan
		K.aoespam[124915] = 3		-- Chaos Wave
		K.aoespam[47960] = 3		-- Shadowflame
		K.aoespam[30213] = 3		-- Legion Strike (Felguard)
		K.aoespam[89753] = 3		-- Felstorm (Felguard)
		K.aoespam[20153] = 3		-- Immolation (Infrenal)
		K.aoespam[114654] = 0		-- Incinerate
		K.aoespam[108685] = 0		-- Conflagrate
		K.aoespam[22703] = 0		-- Infernal Awakening
		K.aoespam[171017] = 0		-- Meteor Strike (Infrenal)
		K.aoespam[104318] = 3		-- Fel Firebolt
		K.aoespam[3110] = 3			-- Firebolt (Imp)
		K.merge[157736] = 348		-- Immolate
		K.merge[108686] = 348		-- Immolate
		K.merge[131737] = 980		-- Agony (Drain Soul)
		K.merge[131740] = 146739	-- Corruption (Drain Soul)
		K.merge[131736] = 30108		-- Unstable Affliction (Drain Soul)
	end
	if C.combattext.healing then
		K.healfilter[63106] = true	-- Siphon Life
		K.healfilter[89653] = true	-- Drain Life
		K.healfilter[108359] = true	-- Dark Regeneration
	end
elseif K.Class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		K.aoespam[46968] = 0		-- Shockwave
		K.aoespam[6343] = 0			-- Thunder Clap
		K.aoespam[1680] = 0			-- Whirlwind
		K.aoespam[115767] = 3		-- Deep Wounds
		K.aoespam[50622] = 3		-- Bladestorm
		K.aoespam[52174] = 0		-- Heroic Leap
		K.aoespam[118000] = 0		-- Dragon Roar
		K.aoespam[76858] = 3		-- Opportunity Strike
		K.aoespam[113344] = 3		-- Bloodbath
		K.aoespam[96103] = 0		-- Raging Blow
		K.aoespam[6572] = 0			-- Revenge
		K.aoespam[5308] = 0			-- Execute
		K.aoespam[772] = 3			-- Rend
		K.merge[44949] = 1680		-- Whirlwind Off-Hand
		K.merge[85384] = 96103		-- Raging Blow Off-Hand
		K.merge[95738] = 50622		-- Bladestorm Off-Hand
		K.merge[163558] = 5308		-- Execute Off-Hand
		K.merge[94009] = 772		-- Rend
	end
	if C.combattext.healing then
		K.healfilter[117313] = true	-- Bloodthirst Heal
		K.healfilter[55694] = true	-- Enraged Regeneration
		K.healfilter[159363] = true	-- Blood Craze
	end
end