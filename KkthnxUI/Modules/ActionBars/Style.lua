local K, C, L = unpack(select(2, ...));
if C["actionbar"].enable ~= true or C["actionbar"].skinbuttons ~= true then return end
local replace = string.gsub

hooksecurefunc('PetActionBar_Update', function()
	for _, name in pairs({
		'PetActionButton',
		'PossessButton',
		'ShapeshiftButton',
	}) do
		for i = 1, 12 do
			local button = _G[name..i]
			if (button) then
				button:SetNormalTexture(C["media"].abtextures..'textureNormal')
				
				if (not InCombatLockdown()) then
					local cooldown = _G[name..i..'Cooldown']
					cooldown:ClearAllPoints()
					cooldown:SetPoint('TOPRIGHT', button, -2, -2)
					cooldown:SetPoint('BOTTOMLEFT', button, 1, 1)
					-- cooldown:SetDrawEdge(true)
				end
				
				if (not button.Shadow) then
					local normal = _G[name..i..'NormalTexture2'] or _G[name..i..'NormalTexture']
					normal:ClearAllPoints()
					normal:SetPoint('TOPRIGHT', button, 1.5, 1.5)
					normal:SetPoint('BOTTOMLEFT', button, -1.5, -1.5)
					normal:SetVertexColor(1, 1, 1, 1)
					
					local icon = _G[name..i..'Icon']
					icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
					icon:SetPoint('TOPRIGHT', button, 1, 1)
					icon:SetPoint('BOTTOMLEFT', button, -1, -1)
					
					local flash = _G[name..i..'Flash']
					flash:SetTexture(flashtex)
					
					button:SetCheckedTexture(C["media"].abtextures..'textureChecked')
					button:GetCheckedTexture():SetAllPoints(normal)
					-- button:GetCheckedTexture():SetDrawLayer('OVERLAY')
					
					button:SetPushedTexture(C["media"].abtextures..'texturePushed')
					button:GetPushedTexture():SetAllPoints(normal)
					-- button:GetPushedTexture():SetDrawLayer('OVERLAY')
					
					button:SetHighlightTexture(C["media"].abtextures..'textureHighlight')
					button:GetHighlightTexture():SetAllPoints(normal)
					
					local buttonBg = _G[name..i..'FloatingBG']
					if (buttonBg) then
						buttonBg:ClearAllPoints()
						buttonBg:SetPoint('TOPRIGHT', button, 5, 5)
						buttonBg:SetPoint('BOTTOMLEFT', button, -5, -5)
						buttonBg:SetTexture(C["media"].abtextures..'textureShadow')
						buttonBg:SetVertexColor(0, 0, 0, 1)
						button.Shadow = true
					else
						button.Shadow = button:CreateTexture(nil, 'BACKGROUND')
						button.Shadow:SetParent(button)
						button.Shadow:SetPoint('TOPRIGHT', normal, 4, 4)
						button.Shadow:SetPoint('BOTTOMLEFT', normal, -4, -4)
						button.Shadow:SetTexture(C["media"].abtextures..'textureShadow')
						button.Shadow:SetVertexColor(0, 0, 0, 1)
					end
				end
			end
		end
	end
end)
-- Force an update for StanceButton for those who doesn't have pet bar
securecall('PetActionBar_Update')

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
		button:SetNormalTexture(C["media"].abtextures..'textureNormal')
		
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
		
		button:SetCheckedTexture(C["media"].abtextures..'textureChecked')
		button:GetCheckedTexture():SetAllPoints(normal)
		
		button:SetPushedTexture(C["media"].abtextures..'texturePushed')
		button:GetPushedTexture():SetAllPoints(normal)
		
		button:SetHighlightTexture(C["media"].abtextures..'textureHighlight')
		button:GetHighlightTexture():SetAllPoints(normal)
		
		local border = _G[self:GetName()..'Border']
		border:SetAllPoints(normal)
		border:SetDrawLayer('OVERLAY')
		border:SetTexture(C["media"].abtextures..'textureHighlight')
		border:SetVertexColor(0, 1, 0)
		
		local count = _G[self:GetName()..'Count']
		count:SetPoint('BOTTOMRIGHT', button, 0, 1)
		count:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
		count:SetVertexColor(1, 1, 1, 1)
		
		local macroname = _G[self:GetName()..'Name']
		if (not C["actionbar"].showmacroname) then
			macroname:SetAlpha(0)
		else
			macroname:SetDrawLayer('OVERLAY')
			macroname:SetWidth(button:GetWidth() + 5)
			macroname:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size - 1, C["font"].action_bars_font_style)
			macroname:SetVertexColor(1, 1, 1, 1)
		end
		
		if (not button.Background) then
			button.Background = button:CreateTexture(nil, 'BACKGROUND')
			button.Background:SetParent(button) 
			button.Background:SetTexture(C["media"].abtextures..'textureBackground')
			button.Background:SetPoint('TOPRIGHT', button, 14, 12)
			button.Background:SetPoint('BOTTOMLEFT', button, -14, -16)
		end
		
		if (not button.Shadow) then
			button.Shadow = button:CreateTexture(nil, 'BACKGROUND')
			button.Shadow:SetParent(button) 
			button.Shadow:SetPoint('TOPRIGHT', normal, 4.5, 4.5)
			button.Shadow:SetPoint('BOTTOMLEFT', normal, -4.5, -4.5)
			button.Shadow:SetTexture(C["media"].abtextures..'textureShadow')
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

hooksecurefunc('ActionButton_UpdateHotkeys', function(self, actionButtonType)
	local hotkey = _G[self:GetName() .. 'HotKey']
	local text = hotkey:GetText()
	
	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", 0, K.Scale(-3))
	hotkey:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size + 1, C["font"].action_bars_font_style)
	hotkey.ClearAllPoints = K.Dummy
	hotkey.SetPoint = K.Dummy
	--hotkey:SetShadowColor(0, 0, 0)
	--hotkey:SetShadowOffset(1.25, -1.25)
	
	if not (C["actionbar"].showhotkeys) == true then
		hotkey:SetText("")
		hotkey:Hide()
		hotkey.Show = K.Dummy
	end
	
	text = replace(text, '(s%-)', 'S')
	text = replace(text, '(a%-)', 'A')
	text = replace(text, '(c%-)', 'C')
	text = replace(text, '(Mouse Button )', 'M')
	text = replace(text, '(Middle Mouse)', 'M3')
	text = replace(text, '(Num Pad )', 'N')
	text = replace(text, '(Page Up)', 'PU')
	text = replace(text, '(Page Down)', 'PD')
	text = replace(text, '(Spacebar)', 'SpB')
	text = replace(text, '(Insert)', 'Ins')
	text = replace(text, '(Home)', 'Hm')
	text = replace(text, '(Delete)', 'Del')
	
	if hotkey:GetText() == _G['RANGE_INDICATOR'] then
		hotkey:SetText('')
	else
		hotkey:SetText(text)
	end
end)

if C["actionbar"].removetextures then
	MainMenuBarRightEndCap:Kill();
	MainMenuBarLeftEndCap:Kill();
	MainMenuBarTexture0:Kill();
	MainMenuBarTexture1:Kill();
	MainMenuXPBarTexture0:Kill();
	MainMenuXPBarTexture1:Kill();
	
	for i = 1, 19 do -- Remove EXP Dividers
		local texture = _G["MainMenuXPBarDiv"..i]
		if texture then
			texture:Kill()
		end
	end
end

-- Show empty buttons
if C["actionbar"].enable == true then
	if C["actionbar"].showgrid == true then
		ActionButton_HideGrid = K.Dummy
		for i = 1, 12 do
			local button = _G[format("ActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("BonusActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarBottomRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarBottomLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
		end
	end
end