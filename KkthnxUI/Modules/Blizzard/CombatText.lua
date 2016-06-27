local K, C, _ = select(2, ...):unpack()

SystemFont_Shadow_Huge3:SetFont(C["Media"].Combat_Font, C["Media"].Combat_Font_Size, C["Media"].Combat_Font_Style)
SystemFont_Shadow_Huge3:SetShadowOffset(K.Mult, -K.Mult)
SystemFont_Shadow_Huge3:SetShadowColor(0, 0, 0, 0.8)

COMBAT_TEXT_HEIGHT = C["Media"].Combat_Font_Size
COMBAT_TEXT_CRIT_MAXHEIGHT = 24
COMBAT_TEXT_CRIT_MINHEIGHT = C["Media"].Combat_Font_Size
COMBAT_TEXT_SCROLLSPEED = 3

hooksecurefunc("CombatText_UpdateDisplayedMessages", function()
  if COMBAT_TEXT_FLOAT_MODE == "1" then
    COMBAT_TEXT_LOCATIONS.startY = 584
    COMBAT_TEXT_LOCATIONS.endY = 809
  end
end)