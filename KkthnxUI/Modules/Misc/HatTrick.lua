local K, C, L = unpack(select(2, ...));
if C["misc"].hattrick ~= true then return end

-- I hate that I have to do this, but Blizz's option frame fucks up the setting unless it was set from their option frame
local ShowCloak, ShowHelm, noop = ShowCloak, ShowHelm, function() end
_G.ShowCloak, _G.ShowHelm = noop, noop

for k, v in next, {InterfaceOptionsDisplayPanelShowCloak, InterfaceOptionsDisplayPanelShowHelm} do
	v:SetButtonState('DISABLED', true)
end

local helm = CreateFrame('CheckButton', 'HelmToggle', PaperDollFrame, 'UIRadioButtonTemplate')
helm:SetPoint('TOPLEFT', CharacterHeadSlot, 'TOPRIGHT', 2, 3)
helm:SetChecked(ShowingHelm())
helm:SetToplevel()
helm:RegisterEvent('PLAYER_FLAGS_CHANGED')
helm:SetScript('OnClick', function() ShowHelm(not ShowingHelm()) end)
helm:SetScript('OnEvent', function(self, event, unit)
	if(unit == 'player') then
		self:SetChecked(ShowingHelm())
	end
end)

local cloak = CreateFrame('CheckButton', 'CloakToggle', PaperDollFrame, 'UIRadioButtonTemplate')
cloak:SetPoint('TOPLEFT', CharacterBackSlot, 'TOPRIGHT', 2, 3)
cloak:SetChecked(ShowingCloak())
cloak:SetToplevel()
cloak:RegisterEvent('PLAYER_FLAGS_CHANGED')
cloak:SetScript('OnClick', function() ShowCloak(not ShowingCloak()) end)
cloak:SetScript('OnEvent', function(self, event, unit)
	if(unit == 'player') then
		self:SetChecked(ShowingCloak())
	end
end)