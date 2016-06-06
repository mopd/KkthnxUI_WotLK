local K, C, _ = select(2, ...):unpack()

local function SpellName(id)
	local name = GetSpellInfo(id)
	return name
end
----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://wotlk.openwow.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C["announcements"].spells == true then
	K.AnnounceSpells = {
		[SpellName(19801)] = true, -- Tranquilizing Shot
		[SpellName(20484)] = true, -- Rebirth
		[SpellName(20707)] = true, -- Soulstone
		[SpellName(2908)] = true, -- Soothe
		[SpellName(31821)] = true, -- Devotion Aura
		[SpellName(34477)] = true, -- Misdirection
		[SpellName(57934)] = true, -- Tricks of the Trade
		[SpellName(61999)] = true, -- Raise Ally
		[SpellName(633)] = true -- Lay on Hands
	}
end

if C["announcements"].say_sapped == true then
	K.SappedSpells = {
		[SpellName(11297)] = true, -- Rank 3 Sap
		[SpellName(2070)] = true, -- Rank 2 Sap
		[SpellName(30980)] = true, -- http://wotlk.openwow.com/spell=30980
		[SpellName(51724)] = true, -- Rank 4 Sap
		[SpellName(6770)] = true, -- Rank 1 Sap
	}
end