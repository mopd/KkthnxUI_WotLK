local K, C, L = unpack(select(2, ...));
if C["misc"].hattrick ~= true then return end

local f = CreateFrame('Frame')

f.Head = CreateFrame('Button', nil, CharacterHeadSlot)
f.Head:SetFrameStrata('HIGH')
f.Head:SetSize(16, 32)
f.Head:SetPoint('LEFT', CharacterHeadSlot, 'CENTER', 9, 0)

f.Head:SetScript('OnClick', function()
    ShowHelm(not ShowingHelm())
end)

f.Head:SetScript('OnEnter', function(self)
    GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 13, -10)
    GameTooltip:AddLine(SHOW_HELM)
    GameTooltip:Show()
end)

f.Head:SetScript('OnLeave', function()
    GameTooltip:Hide()
end)

f.Head:SetNormalTexture('Interface\\AddOns\\KkthnxUI\\Media\\Textures\\textureNormal')
f.Head:SetHighlightTexture('Interface\\AddOns\\KkthnxUI\\Media\\Textures\\textureHighlight')
f.Head:SetPushedTexture('Interface\\AddOns\\KkthnxUI\\Media\\Textures\\texturePushed')

CharacterHeadSlotPopoutButton:SetScript('OnShow', function()
    f.Head:ClearAllPoints()
    f.Head:SetPoint('RIGHT', CharacterHeadSlot, 'CENTER', -9, 0)
end)

CharacterHeadSlotPopoutButton:SetScript('OnHide', function()
    f.Head:ClearAllPoints()
    f.Head:SetPoint('LEFT', CharacterHeadSlot, 'CENTER', 9, 0)
end)

f.Cloak = CreateFrame('Button', nil, CharacterBackSlot)
f.Cloak:SetFrameStrata('HIGH')
f.Cloak:SetSize(16, 32)
f.Cloak:SetPoint('LEFT', CharacterBackSlot, 'CENTER', 9, 0)

f.Cloak:SetScript('OnClick', function()
    ShowCloak(not ShowingCloak())
end)

f.Cloak:SetScript('OnEnter', function(self)
    GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 13, -10)
    GameTooltip:AddLine(SHOW_CLOAK)
    GameTooltip:Show()
end)

f.Cloak:SetScript('OnLeave', function()
    GameTooltip:Hide()
end)

f.Cloak:SetNormalTexture('Interface\\AddOns\\KkthnxUI\\Media\\Textures\\textureNormal')
f.Cloak:SetHighlightTexture('Interface\\AddOns\\KkthnxUI\\Media\\Textures\\textureHighlight')
f.Cloak:SetPushedTexture('Interface\\AddOns\\KkthnxUI\\Media\\Textures\\texturePushed')

CharacterBackSlotPopoutButton:SetScript('OnShow', function()
    f.Cloak:ClearAllPoints()
	f.Cloak:SetPoint('RIGHT', CharacterBackSlot, 'CENTER', -9, 0)
end)

CharacterBackSlotPopoutButton:SetScript('OnHide', function()
    f.Cloak:ClearAllPoints()
    f.Cloak:SetPoint('LEFT', CharacterBackSlot, 'CENTER', 9, 0)
end)