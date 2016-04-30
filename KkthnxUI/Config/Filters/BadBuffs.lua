local K, C, L, _ = unpack(select(2, ...))
if C["automation"].cancel_bad_buffs ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.openwow.com, search for a spell.
--	Example: Mohawked! -> http://wotlk.openwow.com/spell=58493
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
K.BadBuffs = {
	[GetSpellInfo(58493)] = true,	-- Mohawked!
	[GetSpellInfo(44212)] = true,	-- Jack-o'-Lanterned!
	[GetSpellInfo(61716)] = true,	-- Rabbit Costume
	[GetSpellInfo(24732)] = true,	-- Bat Costume
	[GetSpellInfo(24735)] = true,	-- Ghost Costume
	[GetSpellInfo(24712)] = true,	-- Leper Gnome Costume
	[GetSpellInfo(24710)] = true,	-- Ninja Costume
	[GetSpellInfo(24709)] = true,	-- Pirate Costume
	[GetSpellInfo(24723)] = true,	-- Skeleton Costume
	[GetSpellInfo(24740)] = true,	-- Wisp Costume
	[GetSpellInfo(61781)] = true,	-- Turkey Feathers
	[GetSpellInfo(61734)] = true,	-- Noblegarden Bunny
}