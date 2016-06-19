local K, C, L, _ = select(2, ...):unpack()
if C["Auras"].enable ~= true then return end

local _G = _G
local ceil = math.ceil
local match = string.match
local CreateFrame = CreateFrame
local UIParent = UIParent
local hooksecurefunc = hooksecurefunc

local function SecondsToTimeAbbrevHook(seconds)
	if (seconds >= 86400) then
		return "%dd", ceil(seconds / 86400)
	end
	if (seconds >= 3600) then
		return "%dh", ceil(seconds / 3600)
	end
	if (seconds >= 60) then
		return "%dm", ceil(seconds / 60)
	end
	return "%d", seconds
end
SecondsToTimeAbbrev = SecondsToTimeAbbrevHook

local BuffsAnchor = CreateFrame("Frame", "BuffsAnchor", UIParent)
if C["Minimap"].collectbuttons == true then
	BuffsAnchor:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -26, 2)
else
	BuffsAnchor:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -10, 2)
end
BuffsAnchor:SetSize((15 * C["Auras"].buffsize) + 42, (C["Auras"].buffsize * 2) + 3)

-- TemporaryEnchantFrame ...
TempEnchant1:ClearAllPoints()
TempEnchant1:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)

TempEnchant2:ClearAllPoints()
TempEnchant2:SetPoint("TOPRIGHT", TempEnchant1, "TOPLEFT", -C["Auras"].paddingx, 0)

ConsolidatedBuffs:SetSize(20, 20)
ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint("BOTTOM", TempEnchant1, "TOP", 1, 2)

ConsolidatedBuffsIcon:SetAlpha(0)

ConsolidatedBuffsCount:ClearAllPoints()
ConsolidatedBuffsCount:SetPoint("CENTER", ConsolidatedBuffsIcon)
ConsolidatedBuffsCount:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
ConsolidatedBuffsCount:SetShadowOffset(K.Mult, -K.Mult)

ConsolidatedBuffsContainer:SetScale(0.57)
ConsolidatedBuffsTooltip:SetScale(1.2)

local function BuffFrame_SetPoint(self)
	local hasMainHandEnchant, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()
	if (self and self:IsShown()) then
		self:ClearAllPoints()
		if (UnitHasVehicleUI("player")) then
			self:SetPoint("TOPRIGHT", TempEnchant1)
			return
		else
			if (hasMainHandEnchant and hasOffHandEnchant) then
				self:SetPoint("TOPRIGHT", TempEnchant2, "TOPLEFT", -C["Auras"].paddingx, 0)
				return
			elseif (hasMainHandEnchant or hasOffHandEnchant) then
				self:SetPoint("TOPRIGHT", TempEnchant1, "TOPLEFT", -C["Auras"].paddingx, 0)
				return
			elseif (not hasMainHandEnchant and not hasOffHandEnchant) then
				self:SetPoint("TOPRIGHT", TempEnchant1)
				return
			end
		end
	end
end

hooksecurefunc("BuffFrame_UpdatePositions", function()
	if (CONSOLIDATED_BUFF_ROW_HEIGHT ~= 26) then
		CONSOLIDATED_BUFF_ROW_HEIGHT = 26
	end
end)

BuffFrame:SetScript("OnUpdate", function(self, elapsed)
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

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", function()
	local BUFF_PREVIOUS, BUFF_ABOVE
	local numBuffs = 0

	for i = 1, BUFF_ACTUAL_DISPLAY do
		local buff = _G["BuffButton"..i]
		local hasMainHandEnchant, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()

		if (buff.consolidated) then
			if (buff.parent == BuffFrame) then
				buff:SetParent(ConsolidatedBuffsContainer)
				buff.parent = ConsolidatedBuffsContainer
			end
		else
			numBuffs = numBuffs + 1
			index = numBuffs

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
			if (index > 1 and mod(index, C["Auras"].aurasperrow) == 1) then
				if (index == C["Auras"].aurasperrow + 1) then
					buff:SetPoint("TOP", TempEnchant1, "BOTTOM", 0, -C["Auras"].paddingy)
				else
					buff:SetPoint("TOP", BUFF_ABOVE, "BOTTOM", 0, -C["Auras"].paddingy)
				end
				BUFF_ABOVE = buff
			elseif (numBuffs == 1) then
				BuffFrame_SetPoint(buff)
			else
				buff:SetPoint("RIGHT", BUFF_PREVIOUS, "LEFT", -C["Auras"].paddingx, 0)
			end

			BUFF_PREVIOUS = buff
			BUFF_NEW_INDEX = index
		end
	end
end)

hooksecurefunc("DebuffButton_UpdateAnchors", function(self, index)
	local numBuffs = BUFF_ACTUAL_DISPLAY + BuffFrame.numEnchants

	if (BuffFrame.numConsolidated > 0) then
		numBuffs = numBuffs - BuffFrame.numConsolidated + 1
	end

	local debuffSpace = C["Auras"].buffsize + C["Auras"].paddingy
	local numRows = ceil(numBuffs/C["Auras"].aurasperrow)

	local rowSpacing
	if (numRows and numRows > 1) then
		rowSpacing = -numRows * debuffSpace
	else
		rowSpacing = -debuffSpace
	end

	local buff = _G[self..index]
	buff:ClearAllPoints()

	if (index == 1) then
		buff:SetPoint("TOP", TempEnchant1, "BOTTOM", 0, rowSpacing)
	elseif (index >= 2 and mod(index, C["Auras"].aurasperrow) == 1) then
		buff:SetPoint("TOP", _G[self..(index-C["Auras"].aurasperrow)], "BOTTOM", 0, -C["Auras"].paddingy)
	else
		buff:SetPoint("RIGHT", _G[self..(index-1)], "LEFT", -C["Auras"].paddingx, 0)
	end
end)

for i = 1, 2 do
	local button = _G["TempEnchant"..i]
	button:SetScale(1)
	button:SetSize(C["Auras"].buffsize, C["Auras"].buffsize)

	local icon = _G["TempEnchant"..i.."Icon"]
	icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)

	local duration = _G["TempEnchant"..i.."Duration"]
	duration:ClearAllPoints()
	duration:SetPoint("BOTTOM", button, "BOTTOM", 0, 2)
	duration:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
	duration:SetShadowOffset(K.Mult, -K.Mult)
	duration:SetDrawLayer("OVERLAY")

	local border = _G["TempEnchant"..i.."Border"]
	border:ClearAllPoints()
	border:SetPoint("TOPRIGHT", button, 1, 1)
	border:SetPoint("BOTTOMLEFT", button, -1, -1)
	border:SetTexture(C["Media"].Aura_Textures.."TextureDebuff")
	border:SetTexCoord(0, 1, 0, 1)
	border:SetVertexColor(0.9, 0.25, 0.9)

	button.Shadow = button:CreateTexture("$parentBackground", "BACKGROUND")
	button.Shadow:SetPoint("TOPRIGHT", border, 3.35, 3.35)
	button.Shadow:SetPoint("BOTTOMLEFT", border, -3.35, -3.35)
	button.Shadow:SetTexture(C["Media"].Aura_Textures.."TextureShadow")
	button.Shadow:SetVertexColor(0, 0, 0, 1)
end

hooksecurefunc("AuraButton_Update", function(self, index)
	local button = _G[self..index]
	if (button) then
		if (self:match("Debuff")) then
			button:SetSize(C["Auras"].debuffsize, C["Auras"].debuffsize)
			button:SetScale(1)
		else
			button:SetSize(C["Auras"].buffsize, C["Auras"].buffsize)
			button:SetScale(1)
		end
	end

	local icon = _G[self..index.."Icon"]
	if (icon) then
		icon:SetTexCoord(0.03, 0.97, 0.03, 0.97)
	end

	local duration = _G[self..index.."Duration"]
	if (duration) then
		duration:ClearAllPoints()
		duration:SetPoint("BOTTOM", button, "BOTTOM", 0, 2)
		duration:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
		duration:SetShadowOffset(K.Mult, -K.Mult)
		duration:SetDrawLayer("OVERLAY")
	end

	local count = _G[self..index.."Count"]
	if (count) then
		count:ClearAllPoints()
		count:SetPoint("TOPRIGHT", button)
		count:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
		count:SetShadowOffset(K.Mult, -K.Mult)
		count:SetDrawLayer("OVERLAY")
	end

	local border = _G[self..index.."Border"]
	if (border) then
		border:SetTexture(C["Media"].Aura_Textures.."TextureDebuff")
		border:SetPoint("TOPRIGHT", button, 1, 1)
		border:SetPoint("BOTTOMLEFT", button, -1, -1)
		border:SetTexCoord(0, 1, 0, 1)
	end

	if (button and not border) then
		if (not button.texture) then
			button.texture = button:CreateTexture("$parentOverlay", "ARTWORK")
			button.texture:SetParent(button)
			button.texture:SetTexture(C["Media"].Aura_Textures.."TextureNormal")
			button.texture:SetPoint("TOPRIGHT", button, 1, 1)
			button.texture:SetPoint("BOTTOMLEFT", button, -1, -1)
			button.texture:SetVertexColor(unpack(C["Media"].Border_Color))
		end
	end

	if (button) then
		if (not button.Shadow) then
			button.Shadow = button:CreateTexture("$parentShadow", "BACKGROUND")
			button.Shadow:SetTexture(C["Media"].Aura_Textures.."TextureShadow")
			button.Shadow:SetPoint("TOPRIGHT", button.texture or border, 3.35, 3.35)
			button.Shadow:SetPoint("BOTTOMLEFT", button.texture or border, -3.35, -3.35)
			button.Shadow:SetVertexColor(0, 0, 0, 1)
		end
	end
end)