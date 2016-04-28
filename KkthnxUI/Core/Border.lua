local K, C, L, _ = unpack(select(2, ...))

local pairs, type = pairs, type;
local unpack = unpack;

local sections = {"TOPLEFT", "TOP", "TOPRIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT", "LEFT", "RIGHT"}

local function SetBorderColor(self, r, g, b, a)
	local t = self.BorderTextures
	if not t then return end
	
	for _, tex in pairs(t) do
		if C["blizzard"].dark_textures == true then
			tex:SetVertexColor(unpack(C["blizzard"].dark_textures_color));
		else
			tex:SetVertexColor(r or 1, g or 1, b or 1, a or 1)
		end
	end
end

local function GetBorderColor(self)
	return self.BorderTextures and self.BorderTextures.TOPLEFT:GetVertexColor()
end

local function SetBorderSize(self, size, offset)
	local t = self.BorderTextures
	if not t then return end
	
	offset = offset or 0
	
	for _, tex in pairs(t) do
		tex:SetSize(size, size)
	end
	
	local d = K.Round(size * 5/12)
	local parent = t.TOPLEFT:GetParent()
	
	t.TOPLEFT:SetPoint("TOPLEFT", parent, -d - offset, d + offset)
	t.TOPRIGHT:SetPoint("TOPRIGHT", parent, d + offset, d + offset)
	t.BOTTOMLEFT:SetPoint("BOTTOMLEFT", parent, -d - offset, -d - offset)
	t.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", parent, d + offset, -d - offset)
	
	t.TOPLEFT.offset = offset
end

local function GetBorderSize(self)
	local t = self.BorderTextures
	if not t then return end
	
	return t.TOPLEFT:GetWidth(), t.TOPLEFT.offset
end

function K.AddBorder(object, size, offset)
	if type(object) ~= "table" or not object.CreateTexture or object.BorderTextures then return end
	
	local t = {}
	
	for i = 1, #sections do
		local x = object:CreateTexture(nil, "OVERLAY", nil, 1)
		x:SetTexture("Interface\\AddOns\\KkthnxUI\\Media\\Border\\Border")
		
		if C["blizzard"].dark_textures == true then
			x:SetVertexColor(unpack(C["blizzard"].dark_textures_color));
		else
			x:SetVertexColor(r or 1, g or 1, b or 1, a or 1)
		end
		
		t[sections[i]] = x
	end
	
	t.TOPLEFT:SetTexCoord(0, 12/64, 0, 12/64)
	t.TOP:SetTexCoord(12/64, 52/64, 0, 12/64)
	t.TOPRIGHT:SetTexCoord(52/64, 1, 0, 12/64)
	t.RIGHT:SetTexCoord(52/64, 1, 12/64, 52/64)
	t.BOTTOMRIGHT:SetTexCoord(52/64, 1, 52/64, 1)
	t.BOTTOM:SetTexCoord(12/64, 52/64, 52/64, 1)
	t.BOTTOMLEFT:SetTexCoord(0, 12/64, 52/64, 1)
	t.LEFT:SetTexCoord(0, 12/64, 12/64, 52/64)
	
	t.TOP:SetPoint("TOPLEFT", t.TOPLEFT, "TOPRIGHT")
	t.TOP:SetPoint("TOPRIGHT", t.TOPRIGHT, "TOPLEFT")
	
	t.BOTTOM:SetPoint("BOTTOMLEFT", t.BOTTOMLEFT, "BOTTOMRIGHT")
	t.BOTTOM:SetPoint("BOTTOMRIGHT", t.BOTTOMRIGHT, "BOTTOMLEFT")
	
	t.LEFT:SetPoint("TOPLEFT", t.TOPLEFT, "BOTTOMLEFT")
	t.LEFT:SetPoint("BOTTOMLEFT", t.BOTTOMLEFT, "TOPLEFT")
	
	t.RIGHT:SetPoint("TOPRIGHT", t.TOPRIGHT, "BOTTOMRIGHT")
	t.RIGHT:SetPoint("BOTTOMRIGHT", t.BOTTOMRIGHT, "TOPRIGHT")
	
	object.BorderTextures = t
	
	object.SetBorderColor = SetBorderColor
	object.SetBorderSize = SetBorderSize
	
	object.GetBorderColor = GetBorderColor
	object.GetBorderSize = GetBorderSize
	
	object:SetBorderSize(size or 8, offset or 0)
end