local K, C, L, _ = select(2, ...):unpack()
if C["unitframe"].betterpowercolor ~= true then return end

local PowerBarColor = PowerBarColor

-- If you want to change these look here
-- http://wow.gamepedia.com/Power_colors

-- Also this can help with colors.
-- http://www.color-hex.com/
PowerBarColor["RAGE"] = {r = 0.78, g = 0.25, b = 0.25}
PowerBarColor["FOCUS"] = {r = 0.71, g = 0.43, b = 0.27}
PowerBarColor["MANA"] = {r = 0.31, g = 0.45, b = 0.63}
PowerBarColor["ENERGY"] = {r = 0.65, g = 0.63, b = 0.35}
PowerBarColor["RUNIC_POWER"] = {r = 0, g = 0.82, b = 1}