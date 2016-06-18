local K, C, L, _ = select(2, ...):unpack()
if C["Nameplate"].enable ~= true then return end

local GetSpellInfo = GetSpellInfo
----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at http://wotlk.openwow.com search for a spell.
--	Example: Necrotic Plague> http://wotlk.openwow.com/spell=73787
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
	-- Death Knight
	[SpellName(47476)] = true,
	[SpellName(51209)] = true,
	-- Druid                
	[SpellName(99)] = true,
	[SpellName(339)] = true,
	[SpellName(2637)] = true, 
	[SpellName(5211)] = true, 
	[SpellName(9005)] = true, 
	[SpellName(22570)] = true,
	[SpellName(33786)] = true,
	[SpellName(45334)] = true,
	-- Hunter             
	[SpellName(1513)] = true, 
	[SpellName(3355)] = true, 
	[SpellName(19386)] = true,
	[SpellName(19503)] = true,
	[SpellName(24394)] = true,
	[SpellName(34490)] = true,
	[SpellName(50245)] = true,
	[SpellName(50519)] = true,
	[SpellName(50541)] = true,
	[SpellName(54706)] = true,
	[SpellName(56626)] = true,
	[SpellName(60210)] = true,
	[SpellName(64803)] = true,
	-- Mage                 
	[SpellName(118)] = true,
	[SpellName(122)] = true,
	[SpellName(18469)] = true,
	[SpellName(31589)] = true,
	[SpellName(31661)] = true,
	[SpellName(33395)] = true,
	[SpellName(44572)] = true,
	[SpellName(55080)] = true,
	[SpellName(61305)] = true,
	[SpellName(55021)] = true,
	-- Paladin              
	[SpellName(853)] = true,
	[SpellName(10326)] = true,
	[SpellName(20066)] = true,
	[SpellName(31935)] = true,
	-- Priest                  
	[SpellName(605)] = true,
	[SpellName(8122)] = true, 
	[SpellName(9484)] = true, 
	[SpellName(15487)] = true,
	[SpellName(64044)] = true,
	-- Rogue              
	[SpellName(408)] = true,
	[SpellName(1330)] = true, 
	[SpellName(1776)] = true, 
	[SpellName(1833)] = true, 
	[SpellName(2094)] = true, 
	[SpellName(6770)] = true, 
	[SpellName(18425)] = true,
	[SpellName(51722)] = true,
	-- Shaman                 
	[SpellName(3600)] = true, 
	[SpellName(8056)] = true, 
	[SpellName(39796)] = true,
	[SpellName(51514)] = true,
	[SpellName(63685)] = true,
	[SpellName(64695)] = true,
	-- Warlock          
	[SpellName(710)] = true,
	[SpellName(5782)] = true, 
	[SpellName(6358)] = true, 
	[SpellName(6789)] = true, 
	[SpellName(17928)] = true,
	[SpellName(24259)] = true,
	[SpellName(30283)] = true,
	-- Warrior                   
	[SpellName(676)] = true,
	[SpellName(7922)] = true, 
	[SpellName(18498)] = true,
	[SpellName(20511)] = true,
	-- Racial                 
	[SpellName(25046)] = true,
	[SpellName(20549)] = true,
	--PVE Debuffs   
                              
	-- The Lich King            
	[SpellName(73787)] = true,
                              
	-- Naxxramas              
	[SpellName(27808)] = true,
	[SpellName(28408)] = true,
	[SpellName(32407)] = true,
	-- Ulduar
	[SpellName(66313)] = true,
	[SpellName(63134)] = true,
	[SpellName(62717)] = true,
	[SpellName(63018)] = true,
	[SpellName(64233)] = true,
	[SpellName(63495)] = true,
	-- Trial of the Crusader
	[SpellName(66406)] = true,
	[SpellName(67574)] = true,
	[SpellName(68509)] = true,
	[SpellName(67651)] = true,
	[SpellName(68127)] = true,
	[SpellName(67049)] = true,
	[SpellName(66869)] = true,
	[SpellName(66823)] = true,
	-- Icecrown Citadel
	[SpellName(71224)] = true,
	[SpellName(71822)] = true,
	[SpellName(70447)] = true,
	[SpellName(72293)] = true,
	[SpellName(72448)] = true,
	[SpellName(71473)] = true,
	[SpellName(71624)] = true,
	[SpellName(70923)] = true,
	[SpellName(70588)] = true,
	[SpellName(71738)] = true,
	[SpellName(71733)] = true,
	[SpellName(72108)] = true,
	[SpellName(71289)] = true,
	[SpellName(69762)] = true,
	[SpellName(69651)] = true,
	[SpellName(69065)] = true,
	[SpellName(71218)] = true,
	[SpellName(72442)] = true,
	[SpellName(72769)] = true,
	[SpellName(69279)] = true,
	[SpellName(70949)] = true,
	[SpellName(72151)] = true,
	[SpellName(71474)] = true,
	[SpellName(71340)] = true,
	[SpellName(72985)] = true,
	[SpellName(71267)] = true,
	[SpellName(71264)] = true,
	[SpellName(71807)] = true,
	[SpellName(70873)] = true,
	[SpellName(71283)] = true,
	[SpellName(69766)] = true,
	[SpellName(70126)] = true,
	[SpellName(70157)] = true,
	[SpellName(71056)] = true,
	[SpellName(70106)] = true,
	[SpellName(70128)] = true,
	[SpellName(73785)] = true,
	[SpellName(73779)] = true,
	[SpellName(73800)] = true,
	[SpellName(73797)] = true,
	[SpellName(73708)] = true,
	[SpellName(74322)] = true,
	-- The Ruby Sanctum
	[SpellName(74502)] = true,
	[SpellName(75887)] = true,
	[SpellName(74562)] = true,
	[SpellName(74567)] = true,
	[SpellName(74792)] = true,
	[SpellName(74795)] = true,
	-- Others
	[SpellName(67479)] = true 
}

K.PlateBlacklist = {
	["Army of the Dead Ghoul"] = true,
	["Dragonmaw War Banner"] = true,
	["Healing Tide Totem"] = true,
	["Venomous Snake"] = true,
}