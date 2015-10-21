local K, C, L, _ = unpack(select(2, ...))
if C.buffs.enable ~= true then return end

local BuffsAnchor = CreateFrame("Frame", "BuffsAnchor", UIParent)
BuffsAnchor:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -26, 4)
BuffsAnchor:SetSize(C.buffs.buffsize + 5, C.buffs.buffsize + 5)

DAY_ONELETTER_ABBR    = '|cffffffff%dd|r'
HOUR_ONELETTER_ABBR   = '|cffffffff%dh|r'
MINUTE_ONELETTER_ABBR = '|cffffffff%dm|r'
SECOND_ONELETTER_ABBR = '|cffffffff%d|r'

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint("CENTER", BuffsAnchor, "CENTER", 0, 0)
TemporaryEnchantFrame.SetPoint = K.Dummy

TempEnchant2:ClearAllPoints()
TempEnchant2:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -C.buffs.paddingx, 0)

ConsolidatedBuffs:SetHeight(20)
ConsolidatedBuffs:SetWidth(20)

ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint('BOTTOM', TempEnchant1, 'TOP', 0, 5)
ConsolidatedBuffs.SetPoint = K.Dummy

ConsolidatedBuffsIcon:SetAlpha(0)
	
ConsolidatedBuffsCount:ClearAllPoints()
ConsolidatedBuffsCount:SetPoint('CENTER', ConsolidatedBuffsIcon)
ConsolidatedBuffsCount:SetFont(C.font.basic_font, C.font.basic_font_size, C.font.basic_font_style)
ConsolidatedBuffsCount:SetShadowOffset(0, 0)

ConsolidatedBuffsContainer:SetScale(0.57)
ConsolidatedBuffsTooltip:SetScale(1.2)

local BUFF_NEW_INDEX = 1

local function BuffFrame_SetPoint(self)
    local hasMainHandEnchant, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()
    if (self and self:IsShown()) then
        self:ClearAllPoints()
        if (UnitHasVehicleUI('player')) then
            self:SetPoint('TOPRIGHT', TempEnchant1)
            return
        else
            if (hasMainHandEnchant and hasOffHandEnchant) then
                self:SetPoint('TOPRIGHT', TempEnchant2, 'TOPLEFT', -C.buffs.paddingx, 0)
                return
            elseif (hasMainHandEnchant or hasOffHandEnchant) then            
                self:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -C.buffs.paddingx, 0)
                return
            elseif (not hasMainHandEnchant and not hasOffHandEnchant) then
                self:SetPoint('TOPRIGHT', TempEnchant1)
                return
            end
        end
    end
end

hooksecurefunc('BuffFrame_UpdatePositions', function()
    if (CONSOLIDATED_BUFF_ROW_HEIGHT ~= 28) then
        CONSOLIDATED_BUFF_ROW_HEIGHT = 28
    end
end)

BuffFrame:SetScript('OnUpdate', function(self, elapsed)
    self.BuffFrameUpdateTime = self.BuffFrameUpdateTime + elapsed
    if (self.BuffFrameUpdateTime > TOOLTIP_UPDATE_TIME) then
        self.BuffFrameUpdateTime = 0
        if (BuffButton1) then
            if (not BuffButton1:GetParent() == ConsolidatedBuffsContainer) then
                BuffFrame_SetPoint(BuffButton1)
            end
        end
    end
end)

hooksecurefunc('BuffFrame_UpdateAllBuffAnchors', function()  
    local BUFF_PREVIOUS, BUFF_ABOVE
	local numBuffs = 0

	for i = 1, BUFF_ACTUAL_DISPLAY do
		local buff = _G['BuffButton'..i]
        local hasMainHandEnchant, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()

		if (buff.consolidated) then
			if (buff.parent == BuffFrame) then
				buff:SetParent(ConsolidatedBuffsContainer)
				buff.parent = ConsolidatedBuffsContainer
			end
		else
			numBuffs = numBuffs + 1
			index    = numBuffs
            
			if (hasMainHandEnchant and hasOffHandEnchant) then
                index = index + 2
            elseif (hasMainHandEnchant or hasOffHandEnchant) then            
                index = index + 1
            end
            
			if (buff.parent ~= BuffFrame) then
				buff:SetParent(BuffFrame)
                buff.parent = BuffFrame
			end
                
            buff:ClearAllPoints()
            if (index > 1 and mod(index, C.buffs.aurasperrow) == 1) then
                if (index == C.buffs.aurasperrow + 1) then
                    buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, -C.buffs.paddingy)
                else
                    buff:SetPoint('TOP', BUFF_ABOVE, 'BOTTOM', 0, -C.buffs.paddingy)
                end
                BUFF_ABOVE = buff
            elseif (numBuffs == 1) then
                BuffFrame_SetPoint(buff)
            else
                buff:SetPoint('RIGHT', BUFF_PREVIOUS, 'LEFT', -C.buffs.paddingx, 0)
            end
            
            BUFF_PREVIOUS = buff
            BUFF_NEW_INDEX = index
        end
	end
end)

hooksecurefunc('DebuffButton_UpdateAnchors', function(self, index)
    local BUFF_NEW_SPACE, BUFF_NEW_ROW, BUFF_NUM_ROWS, BUFF_NUM_BUFFS

    BUFF_NEW_SPACE = 31 + C.buffs.paddingy
    BUFF_NUM_BUFFS = (BUFF_NEW_INDEX > 0 and BUFF_NEW_INDEX) or 1
    BUFF_NUM_ROWS  = ceil(BUFF_NUM_BUFFS/C.buffs.aurasperrow)
    
    if (BUFF_NUM_ROWS and BUFF_NUM_ROWS > 1) then
        BUFF_NEW_ROW = -BUFF_NUM_ROWS * BUFF_NEW_SPACE
    else
        BUFF_NEW_ROW = -BUFF_NEW_SPACE
    end
    
    local buff = _G[self..index]
    buff:ClearAllPoints()
    if (index == 1) then
        buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, BUFF_NEW_ROW)
	elseif (index >= 2 and mod(index, C.buffs.aurasperrow) == 1) then
		buff:SetPoint('TOP', _G[self..(index-C.buffs.aurasperrow)], 'BOTTOM', 0, -C.buffs.paddingy)
	else
		buff:SetPoint('RIGHT', _G[self..(index-1)], 'LEFT', -C.buffs.paddingx, 0)
	end
end)

for i = 1, 2 do
    local button = _G['TempEnchant'..i]
    button:SetScale(1.0)
    button:SetWidth(C.buffs.buffsize)
    button:SetHeight(C.buffs.buffsize)

    local icon = _G['TempEnchant'..i..'Icon']
    icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)

    local duration = _G['TempEnchant'..i..'Duration']
    duration:ClearAllPoints()
    duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -2)
    duration:SetFont(C.font.basic_font, C.font.basic_font_size, C.font.basic_font_style)
    duration:SetShadowOffset(0, 0)
    duration:SetDrawLayer('OVERLAY')

    local border = _G['TempEnchant'..i..'Border']
    border:ClearAllPoints()
    border:SetPoint('TOPRIGHT', button, 1, 1)
    border:SetPoint('BOTTOMLEFT', button, -1, -1)    
    border:SetTexture(C.media.auratextures..'TextureDebuff')
    border:SetTexCoord(0, 1, 0, 1)
    border:SetVertexColor(0.9, 0.25, 0.9)

    button.Shadow = button:CreateTexture('$parentBackground', 'BACKGROUND')
    button.Shadow:SetPoint('TOPRIGHT', border, 3.35, 3.35)
    button.Shadow:SetPoint('BOTTOMLEFT', border, -3.35, -3.35)
    button.Shadow:SetTexture(C.media.auratextures..'TextureNormal')
    button.Shadow:SetVertexColor(0, 0, 0, 1)
end

hooksecurefunc('AuraButton_Update', function(self, index)
    local button = _G[self..index]
    if (button) then
        button:SetWidth(C.buffs.buffsize)
        button:SetHeight(C.buffs.buffsize)
        button:SetScale(1.0)
    end
        
    local icon = _G[self..index..'Icon']
    if (icon) then
        icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)
    end
        
    local duration = _G[self..index..'Duration']
    if (duration) then
        duration:ClearAllPoints()
        duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -2)
        duration:SetFont(C.font.basic_font, C.font.basic_font_size, C.font.basic_font_style)
        duration:SetShadowOffset(0, 0)
        duration:SetDrawLayer('OVERLAY')
    end

    local count = _G[self..index..'Count']
    if (count) then
        count:ClearAllPoints()
        count:SetPoint('TOPRIGHT', button)
        count:SetFont(C.font.basic_font, C.font.basic_font_size, C.font.basic_font_style)
        count:SetShadowOffset(0, 0)
        count:SetDrawLayer('OVERLAY')
    end
        
    local border = _G[self..index..'Border']
    if (border) then
        border:SetTexture(C.media.auratextures..'TextureDebuff')
        border:SetPoint('TOPRIGHT', button, 1, 1)
        border:SetPoint('BOTTOMLEFT', button, -1, -1)
        border:SetTexCoord(0, 1, 0, 1)
    end
    
    if (button and not border) then
        if (not button.texture) then
            button.texture = button:CreateTexture('$parentOverlay', 'ARTWORK')
            button.texture:SetParent(button)
            button.texture:SetTexture(C.media.auratextures..'TextureNormal')
            button.texture:SetPoint('TOPRIGHT', button, 1, 1)
            button.texture:SetPoint('BOTTOMLEFT', button, -1, -1)
            button.texture:SetVertexColor(0.7, 0.7, 0.7, 1)
        end
    end
    
    if (button) then
        if (not button.Shadow) then
            button.Shadow = button:CreateTexture('$parentShadow', 'BACKGROUND')
            button.Shadow:SetTexture(C.media.auratextures..'TextureShadow')
            button.Shadow:SetPoint('TOPRIGHT', button.texture or border, 3.35, 3.35)
            button.Shadow:SetPoint('BOTTOMLEFT', button.texture or border, -3.35, -3.35)
            button.Shadow:SetVertexColor(0, 0, 0, 1)
        end
    end
end)