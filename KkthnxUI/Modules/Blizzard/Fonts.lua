local K, C, L, _ = unpack(select(2, ...))
local LSM = LibStub("LibSharedMedia-3.0")

local GetChatWindowInfo = GetChatWindowInfo;
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

local SetFont = function(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b) end
end

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "KkthnxUI" or addon == "tekticles" then return end

	local NORMAL = C["media"].normal_font
	local COMBAT = LSM:Fetch("font", C["media"].combat_font)
	local BLANK = C["media"].blank_font
	local _, editBoxFontSize, _, _, _, _, _, _, _, _ = GetChatWindowInfo(1)

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
	CHAT_FONT_HEIGHTS = {10, 12, 13, 14, 15, 16, 17, 18, 19, 20}

	UNIT_NAME_FONT = NORMAL
	STANDARD_TEXT_FONT = NORMAL
	NAMEPLATE_FONT = NORMAL
	DAMAGE_TEXT_FONT = COMBAT

	if C["general"].replace_blizz_fonts then
		-- Base fonts
		SetFont(AchievementFont_Small, NORMAL, 12)
		SetFont(FriendsFont_Large, NORMAL, 15, nil, nil, nil, nil, 0, 0, 0, K.mult, -K.mult)
		SetFont(FriendsFont_Normal, NORMAL, 13, nil, nil, nil, nil, 0, 0, 0, K.mult, -K.mult)
		SetFont(FriendsFont_Small, NORMAL, 11, nil, nil, nil, nil, 0, 0, 0, K.mult, -K.mult)
		SetFont(FriendsFont_UserText, NORMAL, 12, nil, nil, nil, nil, 0, 0, 0, K.mult, -K.mult)
		SetFont(GameTooltipHeader, NORMAL, 15, "OUTLINE")
		SetFont(InvoiceFont_Med, NORMAL, 13, nil, 0.15, 0.09, 0.04)
		SetFont(InvoiceFont_Small, NORMAL, 11, nil, 0.15, 0.09, 0.04)
		SetFont(MailFont_Large, NORMAL, 15, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, K.mult, -K.mult)
		SetFont(NumberFont_OutlineThick_Mono_Small, NORMAL, 13, "OUTLINE")
		SetFont(NumberFont_Outline_Huge, NORMAL, 30, "OUTLINE", 30)
		SetFont(NumberFont_Outline_Large, NORMAL, 17, "OUTLINE")
		SetFont(NumberFont_Outline_Med, NORMAL, 15, "OUTLINE")
		SetFont(NumberFont_Shadow_Med, NORMAL, 14)
		SetFont(NumberFont_Shadow_Small, NORMAL, 12)
		SetFont(QuestFont_Large, NORMAL, 16)
		SetFont(QuestFont_Shadow_Huge, NORMAL, 19, nil, nil, nil, nil, 0.54, 0.4, 0.1)
		SetFont(ReputationDetailFont, NORMAL, 12, nil, nil, nil, nil, 0, 0, 0, K.mult, -K.mult)
		SetFont(SpellFont_Small, NORMAL, 11)
		SetFont(SystemFont_InverseShadow_Small, NORMAL, 11)
		SetFont(SystemFont_Large, NORMAL, 17)
		SetFont(SystemFont_Med1, NORMAL, 13)
		SetFont(SystemFont_Med2, NORMAL, 14, nil, 0.15, 0.09, 0.04)
		SetFont(SystemFont_Med3, NORMAL, 15)
		SetFont(SystemFont_OutlineThick_Huge2, NORMAL, 22, "OUTLINE")
		SetFont(SystemFont_OutlineThick_Huge4, NORMAL, 27, "OUTLINE")
		SetFont(SystemFont_OutlineThick_WTF, NORMAL, 31, "OUTLINE", nil, nil, nil, 0, 0, 0, K.mult, -K.mult)
		SetFont(SystemFont_Outline_Small, NORMAL, 13, "OUTLINE")
		SetFont(SystemFont_Shadow_Huge1, NORMAL, 20)
		SetFont(SystemFont_Shadow_Huge3, NORMAL, 25)
		SetFont(SystemFont_Shadow_Large, NORMAL, 17)
		SetFont(SystemFont_Shadow_Med1, NORMAL, 13)
		SetFont(SystemFont_Shadow_Med3, NORMAL, 15)
		SetFont(SystemFont_Shadow_Outline_Huge2, NORMAL, 22, "OUTLINE")
		SetFont(SystemFont_Shadow_Small, NORMAL, 11)
		SetFont(SystemFont_Small, NORMAL, 12)
		SetFont(SystemFont_Tiny, NORMAL, 11)
		SetFont(Tooltip_Med, NORMAL, 13)
		SetFont(Tooltip_Small, NORMAL, 12)

		-- Derived fonts
		SetFont(BossEmoteNormalHuge, NORMAL, 27, "OUTLINE")
		SetFont(CombatTextFont, COMBAT, 100, "OUTLINE")
		SetFont(ErrorFont, NORMAL, 16, nil, 60)
		SetFont(QuestFontNormalSmall, NORMAL, 13, nil, nil, nil, nil, 0.54, 0.4, 0.1)
		SetFont(WorldMapTextFont, NORMAL, 31, "OUTLINE", 40, nil, nil, 0, 0, 0, K.mult, -K.mult)

		-- Channel list
		for i = 1, MAX_CHANNEL_BUTTONS do
			local f = _G["ChannelButton"..i.."Text"]
			f:SetFontObject(GameFontNormalSmallLeft)
		end

		-- Player title
		local function FixTitleFont() for _,butt in pairs(PlayerTitlePickerScrollFrame.buttons) do butt.text:SetFontObject(GameFontHighlightSmallLeft) end end
		hooksecurefunc("PlayerTitleFrame_UpdateTitles", FixTitleFont)
		FixTitleFont()
	end
end)