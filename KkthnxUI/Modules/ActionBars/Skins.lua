local K, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or C.actionbar.skinbuttons ~= true then return end

hooksecurefunc('PetActionBar_Update', function()
    for _, name in pairs({
        'PetActionButton',
        'PossessButton',    
        'ShapeshiftButton', 
    }) do
        for i = 1, 12 do
            local button = _G[name..i]
            if (button) then
                button:SetNormalTexture(C.media.abtextures..'textureNormal')

                local icon = _G[name..i..'Icon']
                icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)
                icon:SetPoint('TOPRIGHT', button, 1, 1)
                icon:SetPoint('BOTTOMLEFT', button, -1, -1)
                
                if (not InCombatLockdown()) then
                    local cooldown = _G[name..i..'Cooldown']
                    cooldown:ClearAllPoints()
                    cooldown:SetPoint('BOTTOMLEFT', icon, -1, -1)
                    cooldown:SetPoint('TOPRIGHT', icon, 1, 1)
                end
                
                local normal
                if (name == 'PetActionButton') then 
                    normal = _G[name..i..'NormalTexture2'] 
                else 
                    normal = _G[name..i..'NormalTexture'] 
                end
                normal:ClearAllPoints()
                normal:SetPoint('TOPRIGHT', button, 1, 1)
                normal:SetPoint('BOTTOMLEFT', button, -1, -1)
                normal:SetVertexColor(1, 1, 1, 1)

                local flash = _G[name..i..'Flash']
                flash:SetTexture(flashtex)
                
                button:SetCheckedTexture(C.media.abtextures..'textureChecked')
                button:GetCheckedTexture():SetAllPoints(normal)
                button:GetCheckedTexture():SetDrawLayer('OVERLAY')
                
                button:SetPushedTexture(C.media.abtextures..'texturePushed')
                button:GetPushedTexture():SetAllPoints(normal)
                button:GetPushedTexture():SetDrawLayer('OVERLAY')
                
                button:SetHighlightTexture(C.media.abtextures..'textureHighlight')
                button:GetHighlightTexture():SetAllPoints(normal)
                
                if (not button.Background) then
                    button.Background = button:CreateTexture(nil, 'BACKGROUND')
                    button.Background:SetParent(button)  
                    button.Background:SetPoint('TOPRIGHT', normal, 4, 4)
                    button.Background:SetPoint('BOTTOMLEFT', normal, -4, -4)
                    button.Background:SetTexture(C.media.abtextures..'textureShadow')
                    button.Background:SetVertexColor(0, 0, 0, 1)
                end
            end
        end
    end
end)

-- ActionButton_OnEvent
hooksecurefunc('ActionButton_Update', function(self)
    local isTotemButton = self:GetName():match('MultiCastActionButton') or self:GetName():match('MultiCastSlotButton')
    
    if (isTotemButton) then
        local normal = _G[self:GetName()..'NormalTexture']
        normal:SetAlpha(0)
        normal:SetDrawLayer('BACKGROUND')
    end
    
    if (not isTotemButton) then  
        local button = _G[self:GetName()]
        button:SetNormalTexture(C.media.abtextures..'textureNormal')

        local normal = _G[self:GetName()..'NormalTexture']
        normal:ClearAllPoints()
        normal:SetPoint('TOPRIGHT', button, 1, 1)
        normal:SetPoint('BOTTOMLEFT', button, -1, -1)
        normal:SetVertexColor(1, 1, 1, 1)
        normal:SetDrawLayer('ARTWORK')
        
        local icon = _G[self:GetName()..'Icon']
        icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)
        icon:SetDrawLayer('BORDER')
        
        if (not InCombatLockdown()) then
            local cooldown = _G[self:GetName()..'Cooldown']
            cooldown:ClearAllPoints()
            cooldown:SetPoint('TOPRIGHT', icon, -2, -2.5)
            cooldown:SetPoint('BOTTOMLEFT', icon, 2, 2)
        end
        
        button:SetCheckedTexture(C.media.abtextures..'textureChecked')
        button:GetCheckedTexture():SetAllPoints(normal)
        
        button:SetPushedTexture(C.media.abtextures..'texturePushed')
        button:GetPushedTexture():SetAllPoints(normal)
        
        button:SetHighlightTexture(C.media.abtextures..'textureHighlight')
        button:GetHighlightTexture():SetAllPoints(normal)

        local border = _G[self:GetName()..'Border']
        border:SetAllPoints(normal)
        border:SetDrawLayer('OVERLAY')
        border:SetTexture(C.media.abtextures..'textureHighlight')
        border:SetVertexColor(0, 1, 0)
                    
        local count = _G[self:GetName()..'Count']
        count:SetPoint('BOTTOMRIGHT', button, 0, 1)
        count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
        count:SetVertexColor(1, 1, 1, 1)

        local macroname = _G[self:GetName()..'Name']
        if (not C.actionbar.showmacroname) then
            macroname:SetAlpha(0)
        else
            macroname:SetDrawLayer('OVERLAY')
            macroname:SetWidth(button:GetWidth() + 5)
            macroname:SetFont(C.font.action_bars_font, C.font.action_bars_font_size + 1, C.font.action_bars_font_style)
            macroname:SetVertexColor(1, 1, 1, 1)
        end
        
        if (not button.Background) then
            button.Background = button:CreateTexture(nil, 'BACKGROUND')
            button.Background:SetParent(button)  
            button.Background:SetTexture(C.media.abtextures..'textureBackground')
            button.Background:SetPoint('TOPRIGHT', button, 14, 12)
			button.Background:SetPoint('BOTTOMLEFT', button, -14, -16)
        end
        
        if (not button.Shadow) then
            button.Shadow = button:CreateTexture(nil, 'BACKGROUND')
            button.Shadow:SetParent(button)  
            button.Shadow:SetPoint('TOPRIGHT', normal, 4.5, 4.5)
            button.Shadow:SetPoint('BOTTOMLEFT', normal, -4.5, -4.5)
            button.Shadow:SetTexture(C.media.abtextures..'textureShadow')
            button.Shadow:SetVertexColor(0, 0, 0, 1)
        end
        
        if (IsEquippedAction(self.action)) then
            _G[self:GetName()..'Border']:SetAlpha(1)
        else
            _G[self:GetName()..'Border']:SetAlpha(0)
        end 
    end
end)   

hooksecurefunc('ActionButton_ShowGrid', function(self)
    _G[self:GetName()..'NormalTexture']:SetVertexColor(1, 1, 1, 1) 
    
    if (IsEquippedAction(self.action)) then
        _G[self:GetName()..'Border']:SetAlpha(1)
    else
        _G[self:GetName()..'Border']:SetAlpha(0)
    end
end)

hooksecurefunc('ActionButton_UpdateUsable', function(self)
    _G[self:GetName()..'NormalTexture']:SetVertexColor(1, 1, 1, 1) 
    
	local isUsable, notEnoughMana = IsUsableAction(self.action)
	if (isUsable) then
		_G[self:GetName()..'Icon']:SetVertexColor(1, 1, 1)
	elseif (notEnoughMana) then
		_G[self:GetName()..'Icon']:SetVertexColor(0.3, 0.3, 1)
	else
		_G[self:GetName()..'Icon']:SetVertexColor(0.35, 0.35, 0.35)
	end
end)

hooksecurefunc('ActionButton_UpdateHotkeys', function(self)
    local hotkey = _G[self:GetName()..'HotKey']
    
    if (not C.actionbar.showhotkeys) then
        hotkey:SetText(C.actionbar.range)
        hotkey:Hide()
    end
    
    if (C.actionbar.showhotkeys or C.actionbar.outofrangecolor == 'hotkey') then
        hotkey:ClearAllPoints()
        hotkey:SetPoint('TOPRIGHT', self, 0, -3)
        hotkey:SetDrawLayer('OVERLAY')
        hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size + 1, C.font.action_bars_font_style)
        hotkey:SetVertexColor(0.6, 0.6, 0.6)
    end
end)

-- Create a new original function, 
-- Its easier and do use less cpu cycles than a hooksecuredfunc (!)
function ActionButton_OnUpdate(self, elapsed)
	if (ActionButton_IsFlashing(self)) then
		local flashtime = self.flashtime
		flashtime = flashtime - elapsed
		
		if (flashtime <= 0) then
			local overtime = - flashtime
			if (overtime >= ATTACK_BUTTON_FLASH_TIME) then
				overtime = 0
			end
			flashtime = ATTACK_BUTTON_FLASH_TIME - overtime

			local flashTexture = _G[self:GetName()..'Flash']
			if (flashTexture:IsShown()) then
				flashTexture:Hide()
			else
				flashTexture:Show()
			end
		end
		
		self.flashtime = flashtime
	end

	local rangeTimer = self.rangeTimer
	if (rangeTimer) then
		rangeTimer = rangeTimer - elapsed
		if (rangeTimer <= 0) then
            
            if (C.actionbar.outofrangecolor == 'icon') then
                local isInRange = false
                if (ActionHasRange(self.action) and IsActionInRange(self.action) == 0) then
                    _G[self:GetName()..'Icon']:SetVertexColor(0.9, 0, 0)
                    isInRange = true
                end
                    
                if (self.isInRange ~= isInRange) then
                    self.isInRange = isInRange
                    ActionButton_UpdateUsable(self)
                end
                rangeTimer = TOOLTIP_UPDATE_TIME
            end
            
            if (C.actionbar.outofrangecolor == 'hotkey') then
                local rangeTimer = self.rangeTimer;
                if (rangeTimer) then
                    rangeTimer = rangeTimer - elapsed;

                    if (rangeTimer <= 0) then
                        local hotkey = _G[self:GetName()..'HotKey']
                        local valid = IsActionInRange(self.action)
                        if (hotkey:GetText() == RANGE_INDICATOR or hotkey:GetText() == C.actionbar.range) then
                            hotkey:SetText(C.actionbar.range)
                            if (valid == 0) then
                                hotkey:Show()
                                hotkey:SetVertexColor(0.9, 0, 0)
                            elseif (valid == 1) then
                                hotkey:Show()
                                hotkey:SetVertexColor(0.6, 0.6, 0.6)
                            else
                                hotkey:Hide()
                            end
                        else
                            if (valid == 0) then
                                hotkey:SetVertexColor(0.9, 0, 0)
                            else
                                hotkey:SetVertexColor(0.6, 0.6, 0.6)
                            end
                        end
                        rangeTimer = TOOLTIP_UPDATE_TIME
                    end
                    
                    self.rangeTimer = rangeTimer
                end
            end
		end
		self.rangeTimer = rangeTimer
	end
end