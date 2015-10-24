local K, C, L, _ = unpack(select(2, ...))
if C.tooltip.spellid ~= true then return end

-- Function to show spell ID in tooltips
local function SpellIDonTip(unit, target, index)
	local spellid = select(11, UnitAura(target, index));
	if spellid then
		GameTooltip:AddLine("|cFF4488FFSpellID:|r " .. spellid)
		GameTooltip:Show();
	end
end

-- Add spell ID to tooltip when icons in the buff frame are hovered
hooksecurefunc(GameTooltip, 'SetUnitAura', SpellIDonTip) 

-- Add spell ID to tooltip when icons in the target frame are hovered
hooksecurefunc(GameTooltip, 'SetUnitBuff', SpellIDonTip)