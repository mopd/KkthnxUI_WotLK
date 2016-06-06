local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true then return end

--	Pet and shapeshift bars style function
K.ShiftBarUpdate = function()
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		button = _G["ShapeshiftButton"..i]
		icon = _G["ShapeshiftButton"..i.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			icon:SetTexture(texture)

			cooldown = _G["ShapeshiftButton"..i.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end

			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)

			if isActive then
				ShapeshiftBarFrame.lastSelected = button:GetID()
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0)
			else
				icon:SetVertexColor(0.4, 0.4, 0.4)
			end
		end
	end
end

K.PetBarUpdate = function()
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = 'PetActionButton'..i
		local button = _G[buttonName]
		local icon = _G[buttonName..'Icon']
		local autoCast = _G[buttonName..'AutoCastable']
		local shine = _G[buttonName..'Shine']	
		local checked = button:GetCheckedTexture()
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)

		if not isToken then
			icon:SetTexture(texture)
			button.tooltipName = name
		else
			icon:SetTexture(_G[texture])
			button.tooltipName = _G[name]
		end
		
		button.isToken = isToken
		button.tooltipSubtext = subtext	
		
		if isActive and name ~= 'PET_ACTION_FOLLOW' then
			button:SetChecked(1)
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(button)
			end
		else
			button:SetChecked(0)
			if IsPetAttackAction(i) then
				PetActionButton_StopFlash(button)
			end
		end
		
		if autoCastAllowed then
			autoCast:Show()
		else
			autoCast:Hide()
		end
		
		if autoCastEnabled then
			AutoCastShine_AutoCastStart(shine)
		else
			AutoCastShine_AutoCastStop(shine)
		end
		
		button:SetAlpha(1)
		
		if texture then
			if GetPetActionSlotUsable(i) then
				SetDesaturation(icon, nil)
			else
				SetDesaturation(icon, 1)
			end
			icon:Show()
		else
			icon:Hide()
		end
		
		if not PetHasActionBar() and texture and name ~= 'PET_ACTION_FOLLOW' then
			PetActionButton_StopFlash(button)
			SetDesaturation(icon, 1)
			button:SetChecked(0)
		end
		
		checked:SetAlpha(0.9)
	end
end