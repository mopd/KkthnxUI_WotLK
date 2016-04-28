local K, C, L, _ = unpack(select(2, ...))
if K.Class ~= "PALADIN" or K.Level < 3 then return end

--	By Foof and Tohveli 
local spells = (UnitFactionGroup("player") == "Horde") and {
	[1] = {20165,20165},
	[2] = {20166,20166},
	[3] = {20164,20164},
	[4] = {21084,21084},
	[5] = {20375,20375},
	[6] = {53736,53736},
	} or { -- ALLIANCE
	[1] = {20165,20165},
	[2] = {20166,20166},
	[3] = {20164,20164},
	[4] = {21084,21084},
	[5] = {20375,20375},
	[6] = {31801,31801}, 
};

local f = CreateFrame("Frame", "SealMenu", UIParent)
f:CreatePanel2("Invisible", C.minimap.size, #spells * 20 + 4, "TOPRIGHT", Minimap, "BOTTOMLEFT", -4, -4)
tinsert(UISpecialFrames, "SealMenu")

for i, spell in pairs(spells) do
	local seal = GetSpellInfo(spell[1])
	
	local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
	b:CreatePanel2("Transparent", C.minimap.size, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropColor(unpack(C["media"].backdrop_color))
	
	local l = b:CreateFontString(nil, "OVERLAY", nil)
	l:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
	l:SetText(seal)
	b:SetFontString(l)
	
	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", seal)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", GetSpellInfo(spell[2]))
end
f:Hide()

local b = CreateFrame("Button", nil, UIParent)
--K.SetBlizzBorder(b, 2)
b:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
b:SetWidth(30)
b:SetHeight(12)
b:SetAlpha(0.1)

local bt = b:CreateFontString(nil, 'OVERLAY')
bt:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
bt:SetText("SM")
bt:SetTextColor(K.Color.r, K.Color.g, K.Color.b)
bt:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 1, -1)

b:SetScript("OnClick", function(self)
	if _G["SealMenu"]:IsShown() then
		_G["SealMenu"]:Hide()
	else
		_G["SealMenu"]:Show()
	end
end)

b:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	b:FadeIn()
	GameTooltip:SetOwner(b, "ANCHOR_BOTTOMLEFT")
	GameTooltip:SetText("Toggles SealMenu")
end)

b:SetScript("OnLeave", function()
	b:FadeOut()
	GameTooltip:Hide()
end)

f:RegisterEvent("UNIT_SPELLCAST_SENT")
f:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)