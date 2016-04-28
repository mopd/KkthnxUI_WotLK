local K, C, L, _ = unpack(select(2, ...))
if C["announcements"].spells ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=35079
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
K.AnnounceSpells = {
	35079,	-- Misdirection
	55625,	-- Tranquilizing Shot
	57934,	-- Tricks of the Trade
	633,	-- Lay on Hands
	20484,	-- Rebirth
	61999,	-- Raise Ally
	20707,	-- Soulstone Resurrection
}