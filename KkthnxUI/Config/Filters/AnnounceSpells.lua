local K, C, L = unpack(select(2, ...))
if C["announcements"].spells ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
K.AnnounceSpells = {
	34477,	-- Misdirection
	19801,	-- Tranquilizing Shot
	57934,	-- Tricks of the Trade
	633,	-- Lay on Hands
	20484,	-- Rebirth
	6199,	-- Raise Ally
	95750,	-- Soulstone Resurrection
}