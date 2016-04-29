local K, C, L, _ = unpack(select(2, ...))
if K.Class ~= "HUNTER" then return end

-- By Foof and Tohveli
local spells = {
	[1] = {61846,61846}, -- Aspect of the Dragonhawk
	[2] = {13163,13163}, -- Aspect of the Monkey
	[3] = {13165,13165}, -- Aspect of the Hawk
	[4] = {13161,13161}, -- Aspect of the Beast
	[5] = {13159,13159}, -- Aspect of the Pack
	[6] = {20043,20043}, -- Aspect of the Wild
	[7] = {34074,34074}, -- Aspect of the Viper
}

local f = CreateFrame("Frame", "AspectMenu", UIParent)
f:CreatePanel2("Invisible", C.minimap.size, #spells * 20 + 4, "TOPRIGHT", Minimap, "BOTTOMLEFT", -4, -4)
tinsert(UISpecialFrames, "AspectMenu")

for i, spell in pairs(spells) do
	local aspect = GetSpellInfo(spell[1])

	local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
	b:CreatePanel2("Transparent", C.minimap.size, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropColor(unpack(C["media"].backdrop_color))

	local l = b:CreateFontString(nil, "OVERLAY", nil)
	l:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
	l:SetText(aspect)
	b:SetFontString(l)

	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", aspect)
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
bt:SetText("AM")
bt:SetTextColor(K.Color.r, K.Color.g, K.Color.b)
bt:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 1, -1)

b:SetScript("OnClick", function(self)
	if _G["AspectMenu"]:IsShown() then
		_G["AspectMenu"]:Hide()
	else
		_G["AspectMenu"]:Show()
	end
end)

b:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	b:FadeIn()
	GameTooltip:SetOwner(b, "ANCHOR_BOTTOMLEFT")
	GameTooltip:SetText("Toggles AspectMenu")
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

-- Pet Happiness Chat Reminder
if K.Level < 10 then
	local PetHappiness = CreateFrame("Frame")
	PetHappiness.happiness = GetPetHappiness()

	local OnEvent = function(self, event, ...)
		local happiness = GetPetHappiness()
		local hunterPet = select(2, HasPetUI())
		local unit, power = ...

		if (event == "UNIT_POWER" and unit == "pet" and power == "HAPPINESS" and happiness and hunterPet and self.happiness ~= happiness) then
			self.happiness = happiness
			if (happiness == 1) then
				DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_UNHAPPY, 1, 0, 0)
			elseif (happiness == 2) then
				DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_CONTENT, 1, 1, 0)
			elseif (happiness == 3) then
				DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_HAPPY, 0, 1, 0)
			end
		elseif (event == "UNIT_PET") then
			self.happiness = happiness
			if (happiness == 1) then
				DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_UNHAPPY, 1, 0, 0)
			end
		end
	end
	PetHappiness:RegisterEvent("UNIT_POWER")
	PetHappiness:RegisterEvent("UNIT_PET")
	PetHappiness:SetScript("OnEvent", OnEvent)
end