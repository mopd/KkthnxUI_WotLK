local K, C, L = unpack(select(2, ...));

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Flask of the Winds -> http://www.wowhead.com/spell=79471
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C["reminder"].raid_buffs_enable == true then
	K.RaidBuffsReminder = {
		Flask = {
			53758,	-- Flask of Stoneblood
			53755,	-- Flask of the Frost Wyrm
			54212,	-- Flask of Pure Mojo
			53760,	-- Flask of Endless Rage
			17627,	-- Flask of Distilled Wisdom
		},
		BattleElixir = {
			-- Scrolls
			43464,	-- Scroll of Agility VIII
			43467,	-- Scroll of Protection VII
			37092,	-- Scroll of Intellect VIII
			37098,	-- Scroll of Spirit VIII
			37094,	-- Scroll of Stamina VIII
			43466,	-- Scroll of Strength VIII
			-- Elixirs
			33721,	-- Spellpower Elixir
			53746,	-- Wrath Elixir
			28497,	-- Elixir of Mighty Agility
			53748,	-- Elixir of Mighty Strength
			60346,	-- Elixir of Lightning Speed
			60344,	-- Elixir of Expertise
			60341,	-- Elixir of Deadly Strikes
			60345,	-- Elixir of Armor Piercing
			60340,	-- Elixir of Accuracy
			53749,	-- Guru's Elixir
		},
		GuardianElixir = {
			60343,	-- Elixir of Mighty Defense
			53751,	-- Elixir of Mighty Fortitude
			53764,	-- Elixir of Mighty Mageblood
			60347,	-- Elixir of Mighty Thoughts
			53763,	-- Elixir of Protection
			53747,	-- Elixir of Spirit
		},
		Food = {
			57325,	-- 80 AP
			57327,	-- 46 SP
			57329,	-- 40 CS
			57332,	-- 40 Haste
			57334,	-- 20 MP5
			57356,	-- 40 EXP
			57358,	-- 40 ARP
			57360,	-- 40 Hit
			57365,	-- 40 Spirit
			57367,	-- 40 AGI
			57371,	-- 40 STR
			59230,	-- 40 DODGE
			57399,	-- 80AP, 46SP (fish feast)
			57363,	-- Track Humanoids
			57373,	-- Track Beasts
			65247,	-- Pet 40 STR
		},
	}
end

----------------------------------------------------------------------------------------
--[[------------------------------------------------------------------------------------
	Spell Reminder Arguments
	Type of Check:
		spells - List of spells in a group, if you have anyone of these spells the icon will hide.
	Spells only Requirements:
		negate_spells - List of spells in a group, if you have anyone of these spells the icon will immediately hide and stop running the spell check (these should be other peoples spells)
		personal - like a negate_spells but only for your spells
		reversecheck - only works if you provide a role or a spec, instead of hiding the frame when you have the buff, it shows the frame when you have the buff
		negate_reversecheck - if reversecheck is set you can set a spec to not follow the reverse check
	Requirements:
		role - you must be a certain role for it to display (Tank, Melee, Caster)
		spec - you must be active in a specific spec for it to display (1, 2, 3) note: spec order can be viewed from top to bottom when you open your talent pane
		level - the minimum level you must be (most of the time we don't need to use this because it will register the spell learned event if you don't know the spell, but in some cases it may be useful)
	Additional Checks: (Note we always run a check when gaining/losing an aura)
		instance - check when entering a party/raid instance
		pvp - check when entering a bg/arena
		combat - check when entering combat
	For every group created a new frame is created, it's a lot easier this way.
]]--------------------------------------------------------------------------------------
if C["reminder"].solo_buffs_enable == true then
	K.ReminderSelfBuffs = {
		PRIEST = {
			[1] = {	-- Inner Fire/Will group
				["spells"] = {
					588,	-- Inner Fire
					73413,	-- Inner Will
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true
			},
		},
		HUNTER = {
			[1] = {	-- Aspects group
				["spells"] = {
					13165,	-- Aspect of the Hawk
					20043,	-- Aspect of the Wild
					61846,	-- Aspect of the Dragonhawk
					13163,	-- Aspect of the Monkey
					34074,	-- Aspect of the Viper
				},
				["instance"] = true,
				["personal"] = true,
			},
		},
		MAGE = {
			[1] = {	-- Armors group
				["spells"] = {
					30482,	-- Molten Armor
					7302,	-- Frost Armor
					6117,	-- Mage Armor
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Intellect group
				["spells"] = {
					1459,	-- Arcane Brilliance
					61316,	-- Dalaran Brilliance
				},
				["combat"] = true,
				["instance"] = true,
				["level"] = 58,
			},
		},
		WARLOCK = {
			[1] = {	-- Armors group
				["spells"] = {
					28176,	-- Fel Armor
					687,	-- Demon Armor
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = { -- Buffs group
				["spells"] = {
					85768,	-- Dark Intent
				},
				["instance"] = true,
				["level"] = 83,
			},
		},
		PALADIN = {
			[1] = {	-- Seals group
				["spells"] = {
					31801,	-- Seal of Truth
					21084,	-- Seal of Righteousness
					20164,	-- Seal of Justice
					20165,	-- Seal of Insight
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Righteous Fury group
				["spells"] = {
					25780,	-- Righteous Fury
				},
				["role"] = "Tank",
				["instance"] = true,
				["reversecheck"] = true,
				["negate_reversecheck"] = 1,	-- Holy paladins use RF sometimes
			},
			[3] = {	-- Auras group
				["spells"] = {
					465,	-- Devotion Aura
					7294,	-- Retribution Aura
					19746,	-- Concentration Aura
					19891,	-- Resistance Aura
				},
				["instance"] = true,
				["personal"] = true,
			},
			[4] = {	-- Blessings group
				["spells"] = {
					20217,	-- Blessing of Kings
					19740,	-- Blessing of Might
				},
				["combat"] = true,
			},
		},
		SHAMAN = {
			[1] = {	-- Shields group
				["spells"] = {
					52127,	-- Water Shield
					324,	-- Lightning Shield
					974,	-- Earth Shield
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Weapons enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 10,
			},
		},
		WARRIOR = {
			[1] = {	-- Commanding Shout group
				["spells"] = {
					469,	-- Commanding Shout
				},
				["negate_spells"] = {
					6307,	-- Blood Pact
					90364,	-- Qiraji Fortitude
					72590,	-- Drums of Fortitude
					21562,	-- Fortitude
					6673,	-- Battle Shout
				},
				["combat"] = true,
				["role"] = "Tank",
			},
			[2] = {	-- Battle Shout group
				["spells"] = {
					6673,	-- Battle Shout
				},
				["negate_spells"] = {
					8076,	-- Strength of Earth
					57330,	-- Horn of Winter
					93435,	-- Roar of Courage(hunter pet)
					469,	-- Commanding Shout
				},
				["combat"] = true,
				["role"] = "Melee",
			},
		},
		DEATHKNIGHT = {
			[1] = {	-- Horn of Winter group
				["spells"] = {
					57330,	-- Horn of Winter
				},
				["negate_spells"] = {
					8076,	-- Strength of Earth
					6673,	-- Battle Shout
					93435,	-- Roar of Courage(hunter pet)
				},
				["combat"] = true,
			},
			[2] = {	-- Blood Presence group
				["spells"] = {
					48263,	-- Blood Presence
				},
				["role"] = "Tank",
				["instance"] = true,
				["reversecheck"] = true,
			},
		},
		ROGUE = { 
			[1] = {	-- Weapons enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 10,
			},
		},
		DRUID = {
			[1] = {	-- Mark of the Wild group
				["spells"] = {
					1126,	-- Mark of the Wild
				},
				["negate_spells"] = {
					20217,	-- Blessing of Kings
				},
				["combat"] = true,
			},
		},
	}
end