local K, C, L, _ = unpack(select(2, ...))

-- Per Class Config (overwrites general)
-- Class Type need to be UPPERCASE -- DRUID, MAGE ect ect...
if K.Class == "DRUID" then
end
-- Per Character Name Config (overwrite general and class)
-- Name need to be case sensitive
if K.Name == "CharacterName" then
end
-- Per Max Character Level Config (overwrite general, class and name)
if K.Level ~= MAX_PLAYER_LEVEL then
end
-- Magicnachos Personal Config
if (K.Name == "Magicnachos") and (K.Realm == "Ragnaros" or K.Realm == "Lordaeron") then
	C["actionbar"].micromenumouseover = true
	
	C["automation"].autoinvite = true
	C["automation"].declineduel = true
	C["automation"].sellgrey_n_repair = true
	C["automation"].resurrection = true
	
	C["chat"].spam = true
	
	C["misc"].alreadyknown = true
	
	C["tooltip"].talents = true
	
	C["unitframe"].betterpowercolor = true
	C["unitframe"].classhealth = true
	C["unitframe"].classicon = true
	C["unitframe"].combatfeedback = false
	C["unitframe"].enhancedframes = true
	C["unitframe"].groupnumber = true
	C["unitframe"].outline = true
end
-- Kkthnx Personal Config
if (K.Name == "Kkthnx" or K.Name == "Broflex" or K.Name == "Kkthnxui") and (K.Realm == "Ragnaros" or K.Realm == "Lordaeron" or K.Realm == "Blackrock [PvP only]") then
	C["actionbar"].micromenumouseover = true
	
	C["automation"].autoinvite = true
	C["automation"].declineduel = true
	C["automation"].sellgrey_n_repair = true
	C["automation"].resurrection = true
	
	C["chat"].spam = true
	
	C["filger"].show_tooltip = true
	
	C["general"].translate_message = false
	C["general"].welcome_message = false
	
	C["loot"].auto_confirm_de = true
	C["loot"].auto_greed = true
	
	C["misc"].alreadyknown = true
	
	C["tooltip"].talents = true
	C["tooltip"].title = true
	
	C["unitframe"].betterpowercolor = true
	C["unitframe"].classhealth = true
	C["unitframe"].classicon = true
	C["unitframe"].combatfeedback = false
	C["unitframe"].enhancedframes = true
	C["unitframe"].groupnumber = true
end