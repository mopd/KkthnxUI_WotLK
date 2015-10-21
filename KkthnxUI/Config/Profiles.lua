local K, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
-- KkthnxUI personal configuration file
-- BACKUP THIS FILE BEFORE UPDATING!
-- ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if K.name == "MegaChar" then
-- C["chat"].width = 100500
-- C["tooltip"].cursor = false
-- C["unitframe_class_bar"].totem = false
-- C["position"].tooltip = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5}
-- C["position"].bottom_bars = {"BOTTOM", UIParent, "BOTTOM", 2, 8}
-- C["position"].unitframes.tank = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 68}
-- end
----------------------------------------------------------------------------------------

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

-- Magicnachos@Stormreaver KkthnxUI Personal Config
if K.Name == "Magicnachos" and K.Realm == "Stormreaver" then
	C["chat"].outline = true
	C["chat"].fontsize = 14
end

if K.Name == "Microlite" or "Kkthnx" and K.Realm == "Stormreaver" or "Sargeras" then
end