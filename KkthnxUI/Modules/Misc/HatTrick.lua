local K, C, L = unpack(select(2, ...));
if C["misc"].hattrick ~= true then return end

local GameTooltip = GameTooltip

local Helm = CreateFrame("CheckButton", "HelmCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
Helm:ClearAllPoints()
Helm:SetSize(22, 22)
Helm:SetPoint("BOTTOMLEFT", CharacterHeadSlot, "TOPRIGHT", -11, -15)
Helm:SetFrameLevel(PaperDollFrame:GetFrameLevel() + 10)
Helm:SetScript("OnClick", function() ShowHelm(not ShowingHelm()) end)
Helm:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(OPTION_TOOLTIP_SHOW_HELM)
end)
Helm:SetScript("OnLeave", function() GameTooltip:Hide() end)
Helm:SetScript("OnEvent", function() Helm:SetChecked(ShowingHelm()) end)
Helm:RegisterEvent("UNIT_MODEL_CHANGED")
Helm:SetToplevel(true)

local Cloak = CreateFrame("CheckButton", "CloakCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
Cloak:ClearAllPoints()
Cloak:SetSize(22, 22)
Cloak:SetPoint("BOTTOMLEFT", CharacterBackSlot, "TOPRIGHT", -11, -15)
Cloak:SetFrameLevel(PaperDollFrame:GetFrameLevel() + 10)
Cloak:SetScript("OnClick", function() ShowCloak(not ShowingCloak()) end)
Cloak:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(OPTION_TOOLTIP_SHOW_CLOAK)
end)
Cloak:SetScript("OnLeave", function() GameTooltip:Hide() end)
Cloak:SetScript("OnEvent", function() Cloak:SetChecked(ShowingCloak()) end)
Cloak:RegisterEvent("UNIT_MODEL_CHANGED")
Cloak:SetToplevel(true)

Helm:SetChecked(ShowingHelm())
Cloak:SetChecked(ShowingCloak())