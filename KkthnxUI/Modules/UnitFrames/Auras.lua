local K, C, L = unpack(select(2, ...));
if C["unitframe"].enable ~= true then return end

-- AURAS
local function TargetAuraColour(self)
	-- buffs
	for i = 1, MAX_TARGET_BUFFS do
		local bframe = _G[self:GetName().."Buff"..i]
		local bframecd = _G[self:GetName().."Buff"..i.."Cooldown"]
		local bframecount = _G[self:GetName().."Buff"..i.."Count"]
		if bframe then
			bframe:SetScale(1)
			K.AddBorder(bframe, 8, 1)
			bframe:SetBorderColor(.7, .7, .7, 1)
			
			bframecd:ClearAllPoints()
			bframecd:SetPoint("TOPLEFT", bframe, 1.5, -1.5)
			bframecd:SetPoint("BOTTOMRIGHT", bframe, -1.5, 1.5)
			
			bframecount:ClearAllPoints()
			bframecount:SetPoint("CENTER", bframe, "BOTTOM", 0, 0)
			bframecount:SetJustifyH"CENTER"
			bframecount:SetFont(C["font"].basic_font, C["font"].basic_font_size - 1, C["font"].basic_font_style)
			bframecount:SetDrawLayer("OVERLAY", 7)
		end
	end
	-- debuffs
	for i = 1, MAX_TARGET_DEBUFFS do
		local dframe = _G[self:GetName().."Debuff"..i]
		local dframecd = _G[self:GetName().."Debuff"..i.."Cooldown"]
		local dframecount = _G[self:GetName().."Debuff"..i.."Count"]
		if dframe then
			K.AddBorder(dframe, 8, 1)
			
			-- border colour
			local dname = UnitDebuff(self.unit, i)
			local _, _, _, _, dtype = UnitDebuff(self.unit, i)
			if dname then
				local colour = DebuffTypeColor[dtype] or DebuffTypeColor.none
				local auborder = _G[self:GetName().."Debuff"..i.."Border"]
				auborder:Hide()
				dframe:SetBorderColor(colour.r, colour.g, colour.b)
			else
				dframe:SetBorderColor(.7, .7, .7, 1)
			end
			
			if dframecd then -- pet doesn"t show cd?
				dframecd:ClearAllPoints()
				dframecd:SetPoint("TOPLEFT", dframe, 1.5, -1.5)
				dframecd:SetPoint("BOTTOMRIGHT", dframe, -1.5, 1.5)
			end
			
			if dframecount then -- ToT doesn"t show stacks
				dframecount:ClearAllPoints()
				dframecount:SetPoint("CENTER", dframe, "BOTTOM")
				dframecount:SetJustifyH"CENTER"
				dframecount:SetFont(C["font"].basic_font, C["font"].basic_font_size - 1, C["font"].basic_font_style)
			end
		end
	end
end

-- reposition
local function TargetAuraPosit(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
	if beauty then
		local AURA_OFFSET_Y = C["unitframe"].auraoffsety
		local LARGE_AURA_SIZE = C["unitframe"].largeaura
		local SMALL_AURA_SIZE = C["unitframe"].smallaura
		local AURA_ROW_WIDTH = 100
		local NUM_TOT_AURA_ROWS = 2
		local size
		local offsetY = AURA_OFFSET_Y
		local rowWidth = 0
		local firstBuffOnRow = 1
		
		for i = 1, numAuras do
			if largeAuraList[i] then
				size = LARGE_AURA_SIZE
			else
				size = SMALL_AURA_SIZE
			end
			
			if i == 1 then
				rowWidth = size
				self.auraRows = self.auraRows + 1
			else
				rowWidth = rowWidth + size + offsetX
			end
			
			if rowWidth > maxRowWidth then
				-- x & y
				updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX + 2, offsetY + 2, mirrorAurasVertically)
				
				rowWidth = size
				self.auraRows = self.auraRows + 1
				firstBuffOnRow = i
				offsetY = AURA_OFFSET_Y
				
				if self.auraRows > NUM_TOT_AURA_ROWS then maxRowWidth = AURA_ROW_WIDTH end
			else
				updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX + 2, offsetY + 2, mirrorAurasVertically)
			end
		end
	end
end

-- debuff reposition
local function TargetDebuffPosit(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
	local dbuff = _G[debuffName..index]
	local isFriend = UnitIsFriend("player", self.unit)
	local AURA_START_X = 3
	local AURA_START_Y = 32
	local AURA_OFFSET_Y = 3
	
	-- for mirroring vertically
	local point, relativePoint
	local startY, auraOffsetY
	if mirrorVertically then
		point = "BOTTOM"
		relativePoint = "TOP"
		startY = -15
		if self.threatNumericIndicator:IsShown() then
			startY = startY + self.threatNumericIndicator:GetHeight()
		end
		offsetY = - offsetY
		auraOffsetY = -AURA_OFFSET_Y
	else
		point = "TOP"
		relativePoint="BOTTOM"
		startY = AURA_START_Y
		auraOffsetY = AURA_OFFSET_Y
	end
	
	if index == 1 then
		if isFriend and numBuffs > 0 then
			-- unit is friendly and there are buffs...debuffs start on bottom
			dbuff:SetPoint(point.."LEFT", self.buffs, relativePoint.."LEFT", 0, -offsetY)
		else
			-- unit is not friendly or there are no buffs...debuffs start on top
			-- we nudge this down a bit because of !beautycase
			dbuff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY - 3)
		end
		self.debuffs:SetPoint(point.."LEFT", dbuff, point.."LEFT", 0, 0)
		self.debuffs:SetPoint(relativePoint.."LEFT", dbuff, relativePoint.."LEFT", 0, -auraOffsetY)
		if isFriend or (not isFriend and numBuffs==0) then
			self.spellbarAnchor = dbuff
		end
	elseif anchorIndex ~= (index - 1) then
		-- anchor index is not the previous index...must be a new row
		dbuff:SetPoint(point.."LEFT", _G[debuffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY)
		self.debuffs:SetPoint(relativePoint.."LEFT", dbuff, relativePoint.."LEFT", 0, -auraOffsetY)
		if isFriend or (not isFriend and numBuffs == 0) then
			self.spellbarAnchor = dbuff
		end
	else
		-- anchor index is the previous index
		-- we tighten up the spacing between debuffs by -1px due to !bc
		dbuff:SetPoint(point.."LEFT", _G[debuffName..(index - 1)], point.."RIGHT", offsetX - 1, 0)
	end
end

-- party auras
for i = 1, MAX_PARTY_MEMBERS do
	_G["PartyMemberFrame"..i]:HookScript("OnEvent", function(self, event, unit)
		if event == "UNIT_AURA" then
			if unit ~= "party"..i then return end
			for k = 1, 4 do
				local _, _, _, _, dtype = UnitDebuff(unit, k)
				local debuff = _G["PartyMemberFrame"..i.."Debuff"..k]
				local border = _G["PartyMemberFrame"..i.."Debuff"..k.."Border"]
				local colour = DebuffTypeColor[dtype] or DebuffTypeColor.none
				if not debuff.skinned then
					K.AddBorder(debuff, 10, 1)
					border:Hide()
				end
				debuff:SetBorderColor(colour.r, colour.g, colour.b)
				debuff:ClearAllPoints()
				debuff:SetPoint("BOTTOM", _G["PartyMemberFrame"..i], -10, 1)
			end
		end
	end)
end

do
	hooksecurefunc("RefreshDebuffs", TargetAuraColour)
	hooksecurefunc("TargetFrame_UpdateAuras", TargetAuraColour)
	hooksecurefunc("TargetFrame_UpdateAuraPositions", TargetAuraPosit)
	hooksecurefunc("TargetFrame_UpdateDebuffAnchor", TargetDebuffPosit)
end