local K, C, L = unpack(KkthnxUI)
if C.unitframe.enable ~= true then return end

C["filger_position"] = {
	player_buff_icon = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 173},	-- "P_BUFF_ICON"
	player_proc_icon = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 173},	-- "P_PROC_ICON"
	special_proc_icon = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 213},	-- "SPECIAL_P_BUFF_ICON"
	target_debuff_icon = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 213},	-- "T_DEBUFF_ICON"
	target_buff_icon = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 253},	-- "T_BUFF"
	pve_debuff = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 253},			-- "PVE/PVP_DEBUFF"
	pve_cc = {"TOPLEFT", "PlayerFrame", "BOTTOMLEFT", -2, -44},				-- "PVE/PVP_CC"
	cooldown = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 63},		-- "COOLDOWN"
	target_bar = {"BOTTOMLEFT", "TargetFrame", "BOTTOMRIGHT"},	-- "T_DE/BUFF_BAR"
}