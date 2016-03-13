local K, C, L = unpack(select(2, ...));

-- Per Class Config (overwrite general)
-- Class need to be UPPERCASE
if K.Class == "DRUID" then
end
-- Per Character Name Config (overwrite general and class)
-- Name need to be case sensitive
if K.Name == "CharacterName" then
end
-- Per Max Character Level Config (overwrite general, class and name)
if K.Level ~= MAX_PLAYER_LEVEL then
end
-- Magicnachos@Lordaeron Personal Config
if K.Name == "Magicnachos" and K.Realm == "Lordaeron" then
	C["unitframe"].classhealth = true
	C["unitframe"].betterpowercolor = true
	C["unitframe"].classicon = true
	C["unitframe"].smoothbars = true
	C["unitframe"].combatfeedback = true
	C["unitframe"].groupnumber = true
	C["unitframe"].enhancedframes = true
	
	C["tooltip"].healthpos = "HIDE"
	
	C["skins"].skada = true
	C["skins"].dbm = true
	
	C["automation"].declineduel = true
	C["automation"].resurrection = true
	C["automation"].autoinvite = true
end
-- Kkthnx@Lordaeron Personal Config
if K.Name == "Kkthnx" and K.Realm == "Lordaeron" or "Ragnaros" then
	C["unitframe"].classhealth = true
	C["unitframe"].betterpowercolor = true
	C["unitframe"].classicon = true
	C["unitframe"].smoothbars = true
	C["unitframe"].combatfeedback = true
	C["unitframe"].groupnumber = true
	C["unitframe"].enhancedframes = true
	
	C["skins"].skada = true
	C["skins"].dbm = true
	
	C["automation"].declineduel = true
	C["automation"].resurrection = true
	C["automation"].autoinvite = true
end