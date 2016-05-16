local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true or C["actionbar"].skinbuttons ~= true then return end

local _G = _G
local pairs = pairs
local match = string.match
local unpack = unpack
local InCombatLockdown = InCombatLockdown
local hooksecurefunc = hooksecurefunc
local GetName = GetName

local function IsTotemButton(self)
	local totemButton = self:GetName():match("MultiCast")
	if (totemButton) then
		return true
	else
		return false
	end
end

hooksecurefunc("PetActionBar_Update", function()
	for _, name in pairs({
		"PetActionButton",
		"PossessButton",
		"ShapeshiftButton",
	}) do
		for i = 1, 12 do
			local button = _G[name..i]
			if (button) then
				button:SetNormalTexture(C["media"].abtextures.."textureNormal")

				local icon = _G[name..i.."Icon"]
				icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
				icon:SetPoint("TOPRIGHT", button, 1, 1)
				icon:SetPoint("BOTTOMLEFT", button, -1, -1)

				if (not InCombatLockdown()) then
					local cooldown = _G[name..i.."Cooldown"]
					cooldown:ClearAllPoints()
					cooldown:SetPoint("BOTTOMLEFT", icon, -1, -1)
					cooldown:SetPoint("TOPRIGHT", icon, 1, 1)
				end

				local normal = _G[name..i.."NormalTexture2"] or _G[name..i.."NormalTexture"]
				normal:ClearAllPoints()
				normal:SetPoint("TOPRIGHT", button, 1, 1)
				normal:SetPoint("BOTTOMLEFT", button, -1, -1)
				normal:SetVertexColor(unpack(C["media"].border_color))

				local flash = _G[name..i.."Flash"]
				flash:SetTexture(flashtex)

				button:SetCheckedTexture(C["media"].abtextures.."textureChecked")
				button:GetCheckedTexture():SetAllPoints(normal)
				button:GetCheckedTexture():SetDrawLayer("OVERLAY")

				button:SetPushedTexture(C["media"].abtextures.."texturePushed")
				button:GetPushedTexture():SetAllPoints(normal)
				button:GetPushedTexture():SetDrawLayer("OVERLAY")

				button:SetHighlightTexture(C["media"].abtextures.."textureHighlight")
				button:GetHighlightTexture():SetAllPoints(normal)

				if (not button.Shadow) then
					button.Shadow = button:CreateTexture(nil, "BACKGROUND")
					button.Shadow:SetParent(button)
					button.Shadow:SetPoint("TOPRIGHT", normal, 4, 4)
					button.Shadow:SetPoint("BOTTOMLEFT", normal, -4, -4)
					button.Shadow:SetTexture(C["media"].abtextures.."textureShadow")
					button.Shadow:SetVertexColor(0, 0, 0, 1)
				end
			end
		end
	end
end)

hooksecurefunc("ActionButton_Update", function(self)
	ActionButton_UpdateHotkeys(self, self.buttonType) -- Do we need to force this to be safe?

	if (IsTotemButton(self)) then
		for _, icon in pairs({
			self:GetName(),
			"MultiCastRecallSpellButton",
			"MultiCastSummonSpellButton",
		}) do
			local button = _G[icon]

			_G[icon.."NormalTexture"]:SetTexture(nil)

			if (not button.Shadow) then
				button.Shadow = button:CreateTexture(nil, "BACKGROUND")
				button.Shadow:SetParent(button)
				button.Shadow:SetPoint("TOPRIGHT", button, 4.5, 4.5)
				button.Shadow:SetPoint("BOTTOMLEFT", button, -4.5, -4.5)
				button.Shadow:SetTexture(C["media"].abtextures.."textureShadow")
				button.Shadow:SetVertexColor(0, 0, 0, 0.85)
			end
		end
	else
		local button = _G[self:GetName()]
		button:SetNormalTexture(C["media"].abtextures.."textureNormal")

		if (not button.Background) then
			local normal = _G[self:GetName().."NormalTexture"]
			if (normal) then
				normal:ClearAllPoints()
				normal:SetPoint("TOPRIGHT", button, 1, 1)
				normal:SetPoint("BOTTOMLEFT", button, -1, -1)
				normal:SetVertexColor(unpack(C["media"].border_color))
			end

			local icon = _G[self:GetName().."Icon"]
			icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
			icon:SetDrawLayer("BORDER")

			if (not InCombatLockdown()) then
				local cooldown = _G[self:GetName().."Cooldown"]
				cooldown:ClearAllPoints()
				cooldown:SetPoint("TOPRIGHT", icon, -2, -2.5)
				cooldown:SetPoint("BOTTOMLEFT", icon, 2, 2)
			end

			button:SetCheckedTexture(C["media"].abtextures.."textureChecked")
			button:GetCheckedTexture():SetAllPoints(normal)

			button:SetPushedTexture(C["media"].abtextures.."texturePushed")
			button:GetPushedTexture():SetAllPoints(normal)

			button:SetHighlightTexture(C["media"].abtextures.."textureHighlight")
			button:GetHighlightTexture():SetAllPoints(normal)

			local border = _G[self:GetName().."Border"]
			if (border) then
				border:SetAllPoints(normal)
				border:SetTexture(C["media"].abtextures.."textureHighlight")
				border:SetVertexColor(0, 1, 0)
			end

			local count = _G[self:GetName().."Count"]
			if (count) then
				count:SetPoint("BOTTOMRIGHT", button, 0, 1)
				count:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
				count:SetShadowOffset(K.mult, -K.mult)
				count:SetVertexColor(1, 1, 1, 1)
			end

			local macroname = _G[self:GetName().."Name"]
			if (macroname) then
				if (not C["actionbar"].showmacroname) then
					macroname:SetAlpha(0)
				else
					macroname:SetWidth(button:GetWidth() + 4)
					macroname:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size - 1, C["font"].action_bars_font_style)
					macroname:SetShadowOffset(K.mult, -K.mult)
					macroname:SetVertexColor(1, 0.82, 0, 1)
				end
			end

			if (not button.Background) then
				button.Background = button:CreateTexture(nil, "BACKGROUND")
				button.Background:SetParent(button)
				button.Background:SetTexture(C["media"].abtextures.."textureBackground")
				button.Background:SetPoint("TOPRIGHT", button, 14, 12)
				button.Background:SetPoint("BOTTOMLEFT", button, -14, -16)
			end

			if (not button.Shadow) then
				button.Shadow = button:CreateTexture(nil, "BACKGROUND")
				button.Shadow:SetParent(button)
				button.Shadow:SetPoint("TOPRIGHT", normal, 4.5, 4.5)
				button.Shadow:SetPoint("BOTTOMLEFT", normal, -4.5, -4.5)
				button.Shadow:SetTexture(C["media"].abtextures.."textureShadow")
				button.Shadow:SetVertexColor(0, 0, 0, 1)
			end

			local border = _G[self:GetName().."Border"]
			if (border) then
				if (IsEquippedAction(self.action)) then
					_G[self:GetName().."Border"]:SetAlpha(1)
				else
					_G[self:GetName().."Border"]:SetAlpha(0)
				end
			end
		end
	end
end)

hooksecurefunc("ActionButton_ShowGrid", function(self)
	local normal = _G[self:GetName().."NormalTexture"]
	if (normal) then
		normal:SetVertexColor(unpack(C["media"].border_color))
	end
end)