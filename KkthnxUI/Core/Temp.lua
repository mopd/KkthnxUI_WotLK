local K, C, L = unpack(select(2, ...));

local BORDER_SIZE  = 12/18 -- PERCENT
local BORDER_COLOR = { r = 1, g = 1, b = 1, a = 1 }
local BORDER_LAYER = "ARTWORK"

--[[ KkthnxBorder ]]
local BORDER_TEXTURE = "Interface\\AddOns\\KkthnxUI\\Media\\Border\\NewBorder.tga"
local TEXTURE_SIZE   = 64
local CORNER_SIZE    = 12
local OFFSET_SIZE    = 9

-- GTFO.
local ADDON, Addon = ...
_G[ADDON] = Addon

local function noop() end

local function tcopy(src, dst, overwrite)
	if type(src) ~= "table" then
		return {}
	end
	if type(dst) ~= "table" then
		dst = {}
	end
	for k, v in pairs(src) do
		if type(v) == "table" then
			dst[k] = tcopy(v)
		elseif overwrite or type(v) ~= type(dst[k]) then
			dst[k] = v
		end
	end
	return dst
end

local frames = {}
local points = { "TOPLEFT", "TOP", "TOPRIGHT", "RIGHT", "BOTTOMRIGHT", "BOTTOM", "BOTTOMLEFT", "LEFT" }

local prototype = {
	__KkthnxBorder = {
		textures = {},
		insets = {},
		color = {},
	}
}

------------------------------------------------------------------------
--	BORDER
------------------------------------------------------------------------

function Addon.AddBorder(f, size, inset, bgControl, ...)
	--print("AddBorder", tostring(type(f) == "table" and f.GetName and f:GetName() or f))
	if type(f) == "string" then
		f = _G[f]
	end
	assert(type(f) == "table" and type(rawget(f, 0)) == "userdata", "AddBorder: arg1 must be a frame")
	assert(type(f.CreateTexture) == "function", "AddBorder: arg1 is missing a 'CreateTexture' method")
	assert(type(f.IsForbidden) ~= "function" or not f:IsForbidden(), "AddBorder: " .. (f:GetName() or UNKNOWN) .. " is a forbidden frame!")
	if f.__KkthnxBorder then return end
	
	tcopy(prototype, f, true)
	
	local t = f.__KkthnxBorder.textures
	for i = 1, #points do
		local point = points[i]
		local tx = f:CreateTexture(nil, BORDER_LAYER, 100)
		tx:SetTexture(BORDER_TEXTURE)
		t[i], t[point] = tx, tx
	end
	
	local ONETHIRD = CORNER_SIZE / TEXTURE_SIZE
	local TWOTHIRDS = (TEXTURE_SIZE - CORNER_SIZE) / TEXTURE_SIZE
	
	t.TOPLEFT:SetTexCoord(0, ONETHIRD, 0, ONETHIRD)
	t.TOP:SetTexCoord(ONETHIRD, TWOTHIRDS, 0, ONETHIRD)
	t.TOPRIGHT:SetTexCoord(TWOTHIRDS, 1, 0, ONETHIRD)
	t.RIGHT:SetTexCoord(TWOTHIRDS, 1, ONETHIRD, TWOTHIRDS)
	t.BOTTOMRIGHT:SetTexCoord(TWOTHIRDS, 1, TWOTHIRDS, 1)
	t.BOTTOM:SetTexCoord(ONETHIRD, TWOTHIRDS, TWOTHIRDS, 1)
	t.BOTTOMLEFT:SetTexCoord(0, ONETHIRD, TWOTHIRDS, 1)
	t.LEFT:SetTexCoord(0, ONETHIRD, ONETHIRD, TWOTHIRDS)
	
	t.TOP:SetPoint("TOPLEFT", t.TOPLEFT, "TOPRIGHT")
	t.TOP:SetPoint("TOPRIGHT", t.TOPRIGHT, "TOPLEFT")
	
	t.BOTTOM:SetPoint("BOTTOMLEFT", t.BOTTOMLEFT, "BOTTOMRIGHT")
	t.BOTTOM:SetPoint("BOTTOMRIGHT", t.BOTTOMRIGHT, "BOTTOMLEFT")
	
	t.LEFT:SetPoint("TOPLEFT", t.TOPLEFT, "BOTTOMLEFT")
	t.LEFT:SetPoint("BOTTOMLEFT", t.BOTTOMLEFT, "TOPLEFT")
	
	t.RIGHT:SetPoint("TOPRIGHT", t.TOPRIGHT, "BOTTOMRIGHT")
	t.RIGHT:SetPoint("BOTTOMRIGHT", t.BOTTOMRIGHT, "TOPRIGHT")
	
	if f.SetScale then
		hooksecurefunc(f, "SetScale", f.OnSetScale)
	end
	
	prototype.SetBorderSize(f, size, inset)
	prototype.SetBorderColor(f)
	
	if f.SetBackdropBorderColor then
		local backdrop = f:GetBackdrop()
		if type(backdrop) == "table" then
			local r, g, b, a = f:GetBackdropColor()
			backdrop.edgeFile = nil
			if backdrop.insets then
				backdrop.insets.top = 0
				backdrop.insets.right = 0
				backdrop.insets.bottom = 0
				backdrop.insets.left = 0
			end
			f:SetBackdrop(backdrop)
			f:SetBackdropColor(r, g, b, a)
		end
		
		if bgControl == true then
			f.SetBackdrop = noop
			f.SetBackdropColor = noop
			f.SetBackdropBorderColor = noop
		elseif bgControl == nil then
			f.GetBackdropBorderColor = f.GetBorderColor
			f.SetBackdropBorderColor = f.SetBorderColor
			-- false: do not touch methods, for use on secure stuff
		end
	end
	
	do
		local icon = f.Icon or f.icon
		if type(icon) == "table" and icon.SetTexCoord then
			icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		end
	end
	
	tinsert(frames, f)
end

------------------------------------------------------------------------

function prototype:OnSetScale(scale)
	return prototype.SetBorderSize(self, self.__KkthnxBorder.size)
end

------------------------------------------------------------------------

function prototype:GetBorderSize()
	local border = self.__KkthnxBorder
	local insets = border.insets
	return border.size, insets.left, insets.right, insets.top, insets.bottom
end

function prototype:SetBorderSize(size, dL, dR, dT, dB)
	local border = self.__KkthnxBorder
	local insets = border.insets
	--print("SetBorderSize", size, dL, dR, dT, dB)
	
	if not size then
		size = BORDER_SIZE
	elseif size > 1 then
		size = (size / CORNER_SIZE)
	end
	border.size = size
	--print(" scale:", size)
	
	size = size * CORNER_SIZE
	--print(" size:", size)
	
	if not dL then
		dL, dR, dT, dB = insets.left or 0, insets.right or 0, insets.top or 0, insets.bottom or 0
	else
		dR = dR or dL
		dT = dT or dL
		dB = dB or dT
	end
	insets.left, insets.right, insets.top, insets.bottom = dL, dR, dT, dB
	
	local scale = self:GetEffectiveScale() / UIParent:GetScale()
	if scale ~= 1 then
		size = floor(size * (1 / scale) + 0.5)
	end
	
	local t = border.textures
	for i = 1, #t do
		t[i]:SetSize(size, size)
	end
	
	local offset = floor(size * (OFFSET_SIZE / CORNER_SIZE) + 0.5)
	dL = offset - dL
	dR = offset - dR
	dT = offset - dT
	dB = offset - dB
	
	t.TOPLEFT:SetPoint("TOPLEFT", self, -dL, dT)
	t.TOPRIGHT:SetPoint("TOPRIGHT", self, dR, dT)
	t.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, -dL, -dB)
	t.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, dR, -dB)
end

------------------------------------------------------------------------

function prototype:GetBorderInsets()
	local border = self.__KkthnxBorder
	local insets = border.insets
	return insets.left, insets.right, insets.top, insets.bottom
end

function prototype:SetBorderInsets(dL, dR, dT, dB)
	local border = self.__KkthnxBorder
	return prototype.SetBorderSize(self, nil, dL, dR, dT, dB)
end

------------------------------------------------------------------------

function prototype:GetBorderAlpha()
	local border = self.__KkthnxBorder
	return border.color.a
end

function prototype:SetBorderAlpha(a)
	local border = self.__KkthnxBorder
	
	if not a then
		a = BORDER_COLOR.a
	end
	border.color.a = a
	
	local t = border.textures
	for i = 1, #t do
		t[i]:SetAlpha(a)
	end
end

------------------------------------------------------------------------

function prototype:GetBorderColor()
	local border = self.__KkthnxBorder
	local color = border.color
	return color.r, color.g, color.b, color.a
end

function prototype:SetBorderColor(r, g, b, a)
	local border = self.__KkthnxBorder
	local color = border.color
	
	if not r or not g or not b then
		r, g, b = BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b
	end
	if not tonumber(a) then -- Bagnon passes results of GetItemQualityColor directly -_-
		a = color.a or BORDER_COLOR.a
	end
	color.r, color.g, color.b, color.a = r, g, b, a
	
	local t = border.textures
	for i = 1, #t do
		t[i]:SetVertexColor(r, g, b)
		t[i]:SetAlpha(a)
	end
end

------------------------------------------------------------------------

function prototype:GetBorderLayer()
	local border = self.__KkthnxBorder
	return border.layer or BORDER_LAYER
end

function prototype:SetBorderLayer(layer)
	local border = self.__KkthnxBorder
	
	if not layer then
		layer = BORDER_LAYER
	end
	border.layer = layer
	
	local t = border.textures
	for i = 1, #t do
		t[i]:SetDrawLayer(layer)
	end
end

------------------------------------------------------------------------

function prototype:GetBorderParent()
	local border = self.__KkthnxBorder
	return border.parent or self
end

function prototype:SetBorderParent(parent)
	local border = self.__KkthnxBorder
	
	if not parent then
		parent = self
	end
	border.parent = parent
	
	local t = border.textures
	for i = 1, #t do
		t[i]:SetParent(parent)
	end
end

------------------------------------------------------------------------

function prototype:WithBorder(method, ...)
	local textures = self.__KkthnxBorder.textures
	for i = 1, #textures do
		local tx = textures[i]
		local re = tx[method](tx, ...)
		if re then
			return re
		end
	end
end

------------------------------------------------------------------------
--	GLOBALIZATION
------------------------------------------------------------------------

function Addon.WithAllBorders(func, ...)
	if type(func) == "string" then
		func = prototype[func]
	end
	if type(func) == "function" then
		for i = 1, #frames do
			func(frames[i], ...)
		end
	end
end

Addon.noop = noop

------------------------------------------------------------------------