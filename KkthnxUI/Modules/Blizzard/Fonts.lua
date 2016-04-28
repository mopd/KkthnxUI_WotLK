local K, C, L, _ = unpack(select(2, ...))

local CreateFrame = CreateFrame

local KkthnxUIFonts = CreateFrame("Frame", "KkthnxUIFonts", UIParent)

local SetFont = function(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if(sr and sg and sb) then obj:SetShadowColor(sr, sg, sb) end
	if(sox and soy) then obj:SetShadowOffset(sox, soy) end
	if(r and g and b) then obj:SetTextColor(r, g, b)
	elseif(r) then obj:SetAlpha(r) end
end

KkthnxUIFonts:RegisterEvent("ADDON_LOADED")
KkthnxUIFonts:SetScript("OnEvent", function(self, event, addon)
	if(addon ~= "KkthnxUI") then return end

	local NORMAL = C["media"].normal_font
	local COMBAT = C["media"].combat_font
	local NUMBER = C["media"].normal_font

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
	CHAT_FONT_HEIGHTS = { 12, 13, 14, 15, 16, 17, 18, 19, 20 }

	UNIT_NAME_FONT = NORMAL
	NAMEPLATE_FONT = NORMAL
	DAMAGE_TEXT_FONT = COMBAT
	STANDARD_TEXT_FONT = NORMAL

	-- Base fonts in Fonts.xml
	SetFont(AchievementFont_Small, NORMAL, 12)
	SetFont(FriendsFont_Large, NORMAL, 15, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Normal, NORMAL, 13, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Small, NORMAL, 11, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_UserText, NORMAL, 12, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(GameTooltipHeader, NORMAL, 15, "OUTLINE") -- SharedFonts.xml
	SetFont(InvoiceFont_Med, NORMAL, 13, nil, 0.15, 0.09, 0.04)
	SetFont(InvoiceFont_Small, NORMAL, 11, nil, 0.15, 0.09, 0.04)
	SetFont(MailFont_Large, NORMAL, 15, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, 1, -1)
	SetFont(NumberFont_Outline_Huge, NORMAL, 30, "THINOUTLINE", 30)
	SetFont(NumberFont_Outline_Large, NORMAL, 17, "OUTLINE")
	SetFont(NumberFont_Outline_Med, NORMAL, 15, "OUTLINE")
	SetFont(NumberFont_OutlineThick_Mono_Small, NORMAL, 13, "OUTLINE")
	SetFont(NumberFont_Shadow_Med, NORMAL, 14)
	SetFont(NumberFont_Shadow_Small, NORMAL, 12)
	SetFont(QuestFont_Large, NORMAL, 16) -- SharedFonts.xml
	SetFont(QuestFont_Shadow_Huge, NORMAL, 19, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(ReputationDetailFont, NORMAL, 12, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SpellFont_Small, NORMAL, 11)
	SetFont(SystemFont_Huge1, NORMAL, 20)
	SetFont(SystemFont_InverseShadow_Small, NORMAL, 11)
	SetFont(SystemFont_Large, NORMAL, 17)
	SetFont(SystemFont_Med1, NORMAL, 13) -- SharedFonts.xml
	SetFont(SystemFont_Med2, NORMAL, 14, nil, 0.15, 0.09, 0.04)
	SetFont(SystemFont_Med3, NORMAL, 15)
	SetFont(SystemFont_Outline, NORMAL, 13, "OUTLINE")
	SetFont(SystemFont_Outline_Small, NORMAL, 13, "OUTLINE")
	SetFont(SystemFont_OutlineThick_Huge2, NORMAL, 22, "THINOUTLINE")
	SetFont(SystemFont_OutlineThick_Huge4, NORMAL, 27, "THINOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF, NORMAL, 31, "THINOUTLINE", nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SystemFont_Shadow_Huge1, NORMAL, 20) -- SharedFonts.xml
	SetFont(SystemFont_Shadow_Huge3, NORMAL, 25) -- SharedFonts.xml
	SetFont(SystemFont_Shadow_Large, NORMAL, 17) -- SharedFonts.xml
	SetFont(SystemFont_Shadow_Med1, NORMAL, 13) -- SharedFonts.xml
	SetFont(SystemFont_Shadow_Med2, NORMAL, 14) -- SharedFonts.xml
	SetFont(SystemFont_Shadow_Med3, NORMAL, 15)
	SetFont(SystemFont_Shadow_Outline_Huge2, NORMAL, 22, "OUTLINE") -- SharedFonts.xml
	SetFont(SystemFont_Shadow_Small, NORMAL, 11) -- was BOLD, used in dropdown menus -- SharedFonts.xml
	SetFont(SystemFont_Small, NORMAL, 12) -- SharedFonts.xml
	SetFont(SystemFont_Tiny, NORMAL, 11) -- SharedFonts.xml
	SetFont(Tooltip_Med, NORMAL, 13)
	SetFont(Tooltip_Small, NORMAL, 12)
	
	-- Derived fonts in FontStyles.xml
	SetFont(BossEmoteNormalHuge, NORMAL, 27, "THINOUTLINE") -- inherits SystemFont_Shadow_Huge3
	SetFont(CombatTextFont, COMBAT, 26) -- inherits SystemFont_Shadow_Huge3
	SetFont(ErrorFont, NORMAL, 16, nil, 60) -- inherits GameFontNormalLarge
	SetFont(QuestFontNormalSmall, NORMAL, 13, nil, nil, nil, nil, 0.54, 0.4, 0.1) -- inherits GameFontBlack
	SetFont(WorldMapTextFont, NORMAL, 31, "THINOUTLINE", 40, nil, nil, 0, 0, 0, 1, -1) -- inherits SystemFont_OutlineThick_WTF

	SetFont = nil
	self:SetScript("OnEvent", nil)
	self:UnregisterAllEvents()
	self = nil
end)