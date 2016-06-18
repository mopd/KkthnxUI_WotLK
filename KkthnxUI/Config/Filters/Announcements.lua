local K, C, _ = select(2, ...):unpack()

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://wotlk.openwow.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C["Announcements"].Spells == true then
	K.AnnounceSpells = {
		--19801,	-- Tranquilizing Shot
		--20484,	-- Rebirth
		--20707,	-- Soulstone
		--2908,		-- Soothe
		--31821,	-- Devotion Aura
		--34477,	-- Misdirection
		--57934,	-- Tricks of the Trade
		--61999,	-- Raise Ally
		--633,	-- Lay on Hands
		-- Priest | Resurrection
		2006,
		2010,
		10880,
		10881,
		20770,
		25435,
		48171,
	}
end

if C["Announcements"].Say_Sapped == true then
	K.SappedSpells = {
		11297, -- Rank 3 Sap
		2070, -- Rank 2 Sap
		30980, -- http://wotlk.openwow.com/spell=30980
		51724, -- Rank 4 Sap
		6770, -- Rank 1 Sap
	}
end

if C["PulseCD"].enable == true then
	K.pulse_ignored_spells = {
		--GetSpellInfo(6807),	-- Maul
		--GetSpellInfo(35395),	-- Crusader Strike
	}
end