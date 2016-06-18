local K, C, L, _ = select(2, ...):unpack()

-- Per Class Config (overwrites general)
-- Class Type need to be UPPERCASE -- DRUID, MAGE ect ect...
if K.Class == "DRUID" then
end

if K.Role == "Tank" then
end

-- Per Character Name Config (overwrite general and class)
-- Name need to be case sensitive
if K.Name == "CharacterName" then
end

-- Per Max Character Level Config (overwrite general, class and name)
if K.Level ~= MAX_PLAYER_LEVEL then
end

-- Magicnachos Personal Config
if K.Name == "Magicnachos" or K.Name == "Bootyshorts" and K.Realm == "Icecrown" then
	C["Automation"].autoinvite = true
	C["Automation"].declineduel = true
	C["Automation"].resurrection = true
	C["Automation"].sellgrey_n_repair = true

	C["Chat"].spam = true

	C["General"].chatbubble_nobackdrop = true
	C["General"].translate_message = false
	C["General"].welcome_message = false

	C["Misc"].alreadyknown = true

	C["Tooltip"].talents = true

	C["Unitframe"].betterpowercolor = true
	C["Unitframe"].classhealth = true
	C["Unitframe"].classicon = true
	C["Unitframe"].combatfeedback = false
	C["Unitframe"].enhancedframes = true
	C["Unitframe"].groupnumber = true
	C["Unitframe"].outline = true
end

-- Kkthnx Personal Config
if K.Name == "Kkthnx" or K.Name == "Rollndots" or K.Name == "Safeword" or K.Name == "Broflex" or K.Name == "Broflexin" and K.Realm == "Icecrown" then
	C["Announcements"].interrupt = true
	C["Announcements"].Spells = true
	C["Announcements"].Spells_From_All = true

	C["Automation"].autoinvite = true
	C["Automation"].declineduel = true
	C["Automation"].logging_combat = true
	C["Automation"].resurrection = true
	C["Automation"].screenshot = true
	C["Automation"].sellgrey_n_repair = true

	C["Auras"].cast_by = true

	C["Chat"].damage_meter_spam = true
	C["Chat"].spam = true
	C["Chat"].filter = true

	C["Filger"].show_tooltip = true

	C["General"].chatbubble_nobackdrop = true
	C["General"].translate_message = false
	C["General"].welcome_message = false

	C["Loot"].auto_confirm_de = true
	C["Loot"].auto_greed = true

	C["Misc"].afk_spin_camera = true
	C["Misc"].alreadyknown = true
	C["Misc"].armory_link = true
	C["Misc"].hide_bg_spam = true

	C["Tooltip"].health_value = true
	C["Tooltip"].instance_lock = true
	C["Tooltip"].item_count = true
	C["Tooltip"].item_icon = true
	C["Tooltip"].quality_Border_Color = true
	C["Tooltip"].raid_icon = true
	C["Tooltip"].spell_id = true
	C["Tooltip"].talents = true
	C["Tooltip"].title = true
	C["Tooltip"].who_targetting = true

	C["Unitframe"].betterpowercolor = true
	C["Unitframe"].classhealth = true
	C["Unitframe"].classicon = true
	C["Unitframe"].combatfeedback = true
	C["Unitframe"].enhancedframes = true
	C["Unitframe"].groupnumber = true
end