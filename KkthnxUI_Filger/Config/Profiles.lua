local K, C, L = unpack(KkthnxUI)
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	KkthnxUI_Filger personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if K.Name == "MegaChar" then
--		C["filger_settings"].show_tooltip = true
--		C["filger_position"].player_buff_icon = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 2, 173}
--		add("T_DEBUFF_ICON", {spellID = 115767, unitID = "target", caster = "player", filter = "DEBUFF"})
-- end
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Function for insert spell
----------------------------------------------------------------------------------------
local add = function(place, spell)
	for class, _ in pairs(C["filger_spells"]) do
		if class == K.Class then
			for i = 1, #C["filger_spells"][class], 1 do
				if C["filger_spells"][class][i]["Name"] == place then
					table.insert(C["filger_spells"][class][i], spell)
				end
			end
		end
	end
end

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

-- Kkthnx@Stormreaver KkthnxUI Personal Config
if K.Name == "Microlite" or "Kkthnx" and K.Realm == "Stormreaver" or "Sargeras" then
	C["filger_settings"].show_tooltip = true
end