local K, C, L, _ = unpack(select(2, ...))

C["position"] = {
	["achievements"] = {"TOP", UIParent, "TOP", 0, -21},
	["bgscore"] = {"BOTTOMLEFT", ActionButton12, "BOTTOMRIGHT", 100, -2},
	["capturebar"] = {"TOP", UIParent, "TOP", 0, 3},
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 5},
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -238, 700},
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},
	["bn_popup"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 21, 20},
	["minimap"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -7, -7},
	["statsframe"] = {"TOP", Minimap, "BOTTOM", 0, -8},
	["locframe"] = {"TOP", Minimap, "TOP", 0, 2},
	["minimap_buttons"] = {"TOPRIGHT", Minimap, "TOPLEFT", -3, 2},
	["quest"] = {"RIGHT", UIParent, "RIGHT", -182.00, 193.00},
	["tooltip"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -3, 3},
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},
	["playerframe"] = {"CENTER", UIParent, "CENTER", -210, -160},
	["playercastbar"] = {"CENTER", UIParent, "CENTER", 0, -160},
	["targetframe"] = {"CENTER", UIParent, "CENTER", 210, -160},
	["pulsecooldown"] = {"CENTER", UIParent, "CENTER", 0, 0},
}