local K, C, L, _ = select(2, ...):unpack()
if C["unitframe"].betterpowercolor ~= true then return end

-- If you want to change these look here
-- http://wow.gamepedia.com/Power_colors

-- Also this can help with colors.
-- http://www.color-hex.com/

PowerBarColor["MANA"] = { r = 0.31, g = 0.45, b = 0.63 }
PowerBarColor["RAGE"] = { r = 0.69, g = 0.31, b = 0.31 }
PowerBarColor["FOCUS"] = { r = 0.71, g = 0.43, b = 0.27 }
PowerBarColor["ENERGY"] = { r = 0.65, g = 0.63, b = 0.35 }