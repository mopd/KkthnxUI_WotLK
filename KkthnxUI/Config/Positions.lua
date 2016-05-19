local K, C, L, _ = select(2, ...):unpack()

C["position"] = {
	["achievements"] = {"TOP", UIParent, "TOP", 0, -22},
	["bag"] = {"RIGHT", UIParent, "RIGHT", -140, -20},
	["bank"] = {"LEFT", UIParent, "LEFT", 23, 150},
	["bgscore"] = {"BOTTOMLEFT", "ActionButton12", "BOTTOMRIGHT", 100, 0},
	["bn_popup"] = {"BOTTOMLEFT", ChatFrame1, "TOPLEFT", 4, 54},
	["capturebar"] = {"TOP", UIParent, "TOP", 0, -170},
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 5},
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -238, 700},
	["locframe"] = {"TOP", "Minimap", "BOTTOM", 0, -2},
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},
	["micromenu"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 9000, 9000},
	["minimap"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -7, -7},
	["minimap_buttons"] = {"TOPRIGHT", "Minimap", "TOPLEFT", -3, 2},
	["partyframe"] = {"LEFT", UIParent, "LEFT", 120, 125},
	["playercastbar"] = {"CENTER", UIParent, "CENTER", 0, -146},
	["playerframe"] = {"CENTER", UIParent, "CENTER", -210, -160},
	["powerbar"] = {"CENTER", UIParent, "CENTER", 0, -180},
	["quest"] = {"RIGHT", UIParent, "RIGHT", -120, 200},
	["statsframe"] = {"TOP", "Minimap", "BOTTOM", 0, -24},
	["targetcastbar"] = {"CENTER", UIParent, "CENTER", 0, 200},
	["targetframe"] = {"CENTER", UIParent, "CENTER", 210, -160},
	["ticket"] = {"TOPLEFT", UIParent, "TOPLEFT", 0, -1},
	["tooltip"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -3, 3},
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},
	["vehicle"] = {"BOTTOM", Minimap, "TOP", 0, 30},
	["vehicle"] = {"TOP", Minimap, "BOTTOM", 0, -27},
	["worldmap"] = {"CENTER", UIParent, "CENTER", 0, 70},
	-- Filger positions
	filger = {
		["cooldown"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 63, 17},
		["player_buff_icon"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 173},
		["player_proc_icon"] = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 173},
		["pve_cc"] = {"TOPLEFT", "PlayerFrame", "BOTTOMLEFT", -2, -44},
		["pve_debuff"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 253},
		["special_proc_icon"] = {"BOTTOMRIGHT", "PlayerFrame", "TOPRIGHT", 2, 213},
		["target_bar"] = {"BOTTOMLEFT", "TargetFrame", "BOTTOMRIGHT", 9, -41},
		["target_buff_icon"] = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 253},
		["target_debuff_icon"] = {"BOTTOMLEFT", "TargetFrame", "TOPLEFT", -2, 213},
	},
}