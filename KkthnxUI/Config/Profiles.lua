local K, C, L, _ = select(2, ...):unpack()

-- Per Class Config (overwrites general)
-- Class Type need to be UPPERCASE -- DRUID, MAGE ect ect...
if K.Class == "DRUID" then
end

if K.Role == "Tank" then
	C["nameplate"].enhance_threat = true
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
	C["automation"].autoinvite = true
	C["automation"].declineduel = true
	C["automation"].resurrection = true
	C["automation"].sellgrey_n_repair = true

	C["chat"].spam = true

	C["general"].chatbubble_nobackdrop = true
	C["general"].translate_message = false
	C["general"].welcome_message = false

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
if (K.Name == "Kkthnx" or K.Name == "Rollndots" or K.Name == "Broflex" or K.Name == "Kkthnxui") and (K.Realm == "Ragnaros" or K.Realm == "Lordaeron" or K.Realm == "Blackrock [PvP only]") then
	C["announcements"].interrupt = true
	C["announcements"].spells = true
	C["announcements"].spells_from_all = true
	
	C["automation"].autoinvite = true
	C["automation"].declineduel = true
	C["automation"].logging_combat = true
	C["automation"].resurrection = true
	C["automation"].screenshot = true
	C["automation"].sellgrey_n_repair = true
	
	C["buffs"].cast_by = true
	
	C["chat"].damage_meter_spam = true
	C["chat"].spam = true
	
	C["filger"].show_tooltip = true
	
	C["general"].translate_message = false
	C["general"].welcome_message = false
	
	C["loot"].auto_confirm_de = true
	C["loot"].auto_greed = true
	
	C["misc"].afk_spin_camera = true
	C["misc"].alreadyknown = true
	C["misc"].armory_link = true
	C["misc"].hide_bg_spam = true
	
	C["tooltip"].health_value = true
	C["tooltip"].instance_lock = true
	C["tooltip"].item_count = true
	C["tooltip"].item_icon = true
	C["tooltip"].quality_border_color = true
	C["tooltip"].raid_icon = true
	C["tooltip"].spell_id = true
	C["tooltip"].talents = true
	C["tooltip"].title = true
	C["tooltip"].unit_role = true
	C["tooltip"].who_targetting = true
	
	C["unitframe"].betterpowercolor = true
	C["unitframe"].classhealth = true
	C["unitframe"].classicon = true
	C["unitframe"].combatfeedback = false
	C["unitframe"].enhancedframes = true
	C["unitframe"].groupnumber = true
end