local K, C, L = unpack(select(2, ...))
--if C["misc"].profession_tabs ~= true then return end

local TradeTabs = CreateFrame("Frame", "TradeTabs")

local tradeSpells = {
	28596, -- Alchemy
	29844, -- Blacksmithing
	33359, -- Cooking
	28029, -- Enchanting
	30350, -- Engineering
	27028, -- First Aid
	45357, -- Inscription
	28897, -- Jewel Crafting
	32549, -- Leatherworking
	2656, -- Smelting
	26790, -- Tailoring
}

function TradeTabs:OnEvent(event, ...)
	self:UnregisterEvent(event)
	if not IsLoggedIn() then
		self:RegisterEvent("PLAYER_LOGIN")
	elseif InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		self:Initialize()
	end
end


function TradeTabs:Initialize()
	if self.initialized then return end -- Shouldn't need this, but I'm paranoid
	
	for i=1, #tradeSpells do
		tradeSpells[GetSpellInfo(tradeSpells[i])] = true
	end
	
	local spells = {}
	
	for i=1, MAX_SPELLS do
		local n = GetSpellName(i, "spell")
		if tradeSpells[n] then
			spells[n] = i
		end
	end
	
	local parent = TradeSkillFrame
	if SkilletFrame then
		parent = SkilletFrame
		self:UnregisterAllEvents()
	end
	
	local prev
	for spell, spellid in pairs(spells) do
		local tab = self:CreateTab(spell, spellid, parent)
		local point, relPoint, x, y = "TOPLEFT", "BOTTOMLEFT",0,-17
		if not prev then
			prev, relPoint, x, y = parent,"TOPRIGHT", -32, -64
			if parent == SkilletFrame then x = 0 end -- Special case. ew
		end
		tab:SetPoint(point,prev,relPoint,x,y)
		prev = tab
	end
	self.initialized = true
end

local function onEnter(self)
	GameTooltip:SetOwner(self,"ANCHOR_RIGHT") GameTooltip:SetText(self.tooltip)
	self:GetParent():LockHighlight()
end

local function onLeave(self)
	GameTooltip:Hide()
	self:GetParent():UnlockHighlight()
end

local function updateSelection(self)
	if IsCurrentSpell(self.spellID,"spell") then
		self:SetChecked(true)
		self.clickStopper:Show()
	else
		self:SetChecked(false)
		self.clickStopper:Hide()
	end
end

local function createClickStopper(button)
	local f = CreateFrame("Frame", nil, button)
	f:SetAllPoints(button)
	f:EnableMouse(true)
	f:SetScript("OnEnter", onEnter)
	f:SetScript("OnLeave", onLeave)
	button.clickStopper = f
	f.tooltip = button.tooltip
	f:Hide()
end


function TradeTabs:CreateTab(spell,spellID,parent)
	local button = CreateFrame("CheckButton", nil, parent, "SpellBookSkillLineTabTemplate, SecureActionButtonTemplate")
	button.tooltip = spell
	button:Show()
	button:SetAttribute("type", "spell")
	button:SetAttribute("spell", spell)
	button.spellID = spellID
	button:SetNormalTexture(GetSpellTexture(spellID, "spell"))
	
	button:SetScript("OnEvent", updateSelection)
	button:RegisterEvent("TRADE_SKILL_SHOW")
	button:RegisterEvent("TRADE_SKILL_CLOSE")
	button:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")
	
	createClickStopper(button)
	updateSelection(button)
	return button
end

TradeTabs:RegisterEvent("ADDON_LOADED")
TradeTabs:RegisterEvent("TRADE_SKILL_SHOW")
TradeTabs:SetScript("OnEvent", TradeTabs.OnEvent)