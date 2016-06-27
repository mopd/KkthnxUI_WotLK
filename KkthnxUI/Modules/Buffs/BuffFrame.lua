local K, C, L, _ = select(2, ...):unpack()
if C["Auras"].enable ~= true then return end

local mainhand, _, _, offhand = GetWeaponEnchantInfo()

local rowbuffs
if K.ScreenWidth <= 1440 then 
	rowbuffs = 12
else
	rowbuffs = 16
end

local BuffsAnchor = CreateFrame("Frame", "BuffsAnchor", UIParent)
BuffsAnchor:SetPoint(unpack(C.position.player_buffs))
BuffsAnchor:SetSize((15 * C["Auras"].aurasize) + 42, (C["Auras"].aurasize * 2) + 3)

ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint("LEFT", Minimap, "LEFT", K.Scale(0), K.Scale(0))
ConsolidatedBuffs:SetSize(16, 16)
ConsolidatedBuffsIcon:SetTexture(nil)
ConsolidatedBuffs.SetPoint = K.Noop

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, K.Scale(-16))
TemporaryEnchantFrame.SetPoint = K.Noop

TempEnchant1:ClearAllPoints()
TempEnchant2:ClearAllPoints()
TempEnchant1:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT")
TempEnchant2:SetPoint("RIGHT", TempEnchant1, "LEFT", K.Scale(-4), 0)

for i = 1, 2 do
	local f = CreateFrame("Frame", nil, _G["TempEnchant"..i])
	f:CreatePanel("CreateBackdrop", C["Auras"].aurasize, C["Auras"].aurasize, "CENTER", _G["TempEnchant"..i], "CENTER", 0, 0)
	_G["TempEnchant"..i.."Border"]:SetOutside()	
	_G["TempEnchant"..i.."Icon"]:SetTexCoord(unpack(K.TexCoords))
	_G["TempEnchant"..i.."Icon"]:SetPoint("TOPLEFT", _G["TempEnchant"..i], K.Scale(2), K.Scale(-2))
	_G["TempEnchant"..i.."Icon"]:SetPoint("BOTTOMRIGHT", _G["TempEnchant"..i], K.Scale(-2), K.Scale(2))
	_G["TempEnchant"..i]:SetSize(C["Auras"].aurasize, C["Auras"].aurasize)
	_G["TempEnchant"..i.."Duration"]:ClearAllPoints()
	_G["TempEnchant"..i.."Duration"]:SetPoint("BOTTOM", 0, K.Scale(-13))
	_G["TempEnchant"..i.."Duration"]:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)
	_G["TempEnchant"..i.."Duration"]:SetShadowOffset(0, -0)
end

local function StyleBuffs(buttonName, index, debuff)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]
	if icon and not _G[buttonName..index.."Panel"] then
		icon:SetTexCoord(unpack(K.TexCoords))
		icon:SetInside()

		buff:SetSize(C["Auras"].aurasize, C["Auras"].aurasize)
		if not buff.shadow then
			buff:CreateBlizzShadow(5)
		end

		duration:ClearAllPoints()
		duration:SetPoint("BOTTOM", 0, K.Scale(-13))
		duration:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)
		duration:SetShadowOffset(0, -0)

		count:ClearAllPoints()
		count:SetPoint("TOPLEFT", K.Scale(1), K.Scale(-2))
		count:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)

		local panel = CreateFrame("Frame", buttonName..index.."Panel", buff)
		panel:CreatePanel("CreateBackdrop", C["Auras"].aurasize, C["Auras"].aurasize, "CENTER", buff, "CENTER", 0, 0)
		panel:SetFrameLevel(buff:GetFrameLevel() - 1)
		panel:SetFrameStrata(buff:GetFrameStrata())
	end
	if border then border:Hide() end
end

local function UpdateBuffAnchors()
	buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff
	local numBuffs = 0
	for index = 1, BUFF_ACTUAL_DISPLAY do
		local buff = _G[buttonName..index]
		StyleBuffs(buttonName, index, false)
		
		_G[buttonName..index.."Panel"].backdrop:SetBackdropBorderColor(unpack(C["Media"].Border_Color))

		if(buff.consolidated) then
			if(buff.parent == BuffFrame) then
				buff:SetParent(ConsolidatedBuffsContainer)
				buff.parent = ConsolidatedBuffsContainer
			end
		else
			numBuffs = numBuffs + 1
			index = numBuffs
			buff:ClearAllPoints()
			if((index > 1) and (mod(index, rowbuffs) == 1)) then
				if(index == rowbuffs + 1) then
					buff:SetPoint("TOPRIGHT", BuffsAnchor, K.Scale(-184), K.Scale(-92))
				else
					buff:SetPoint("TOPRIGHT", BuffsAnchor, K.Scale(-184), K.Scale(-22))
				end
				aboveBuff = buff
			elseif ( index == 1 ) then
				if mainhand and offhand and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant2, "LEFT", K.Scale(-4), 0)
				elseif ((mainhand and not offhand) or (offhand and not mainhand)) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant1, "LEFT", K.Scale(-4), 0)
				else
					buff:SetPoint("TOPRIGHT", BuffsAnchor, K.Scale(-1), K.Scale(-1))
				end
			else
				buff:SetPoint("RIGHT", previousBuff, "LEFT", K.Scale(-4), 0)
			end
			previousBuff = buff
		end
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	local debuff = _G[buttonName..index]
	StyleBuffs(buttonName, index, true)
	local dtype = select(5, UnitDebuff("player",index))
	local color
	if (dtype ~= nil) then
		color = DebuffTypeColor[dtype]
	else
		color = DebuffTypeColor["none"]
	end
	_G[buttonName..index.."Panel"].backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
	debuff:ClearAllPoints()
	if index == 1 then
		debuff:SetPoint("TOPRIGHT", BuffsAnchor, K.Scale(-1), K.Scale(-161))
	else
		debuff:SetPoint("RIGHT", _G[buttonName..(index-1)], "LEFT", K.Scale(-4), 0)
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function() mainhand, _, _, offhand = GetWeaponEnchantInfo() end)
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_EVENTERING_WORLD")

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)