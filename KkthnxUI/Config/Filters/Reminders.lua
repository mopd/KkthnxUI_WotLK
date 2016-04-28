local K, C, L, _ = unpack(select(2, ...))
if C["reminder"].raid_buffs_enable ~= true then return end
----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Flask of the Winds -> http://www.wowhead.com/spell=79471
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
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