local K, C, L = unpack(select(2, ...))

-- Border
local sections = { "TOPLEFT", "TOPRIGHT", "TOP", "BOTTOMLEFT", "BOTTOMRIGHT", "BOTTOM", "LEFT", "RIGHT" }

local function SetBorderColor(self, r, g, b, a)
	local t = self.borderTextures
	if t then
		if not r or not g and not b then
			r, g, b = 1, 1, 1
		end
		for _, tex in pairs (t) do
			tex:SetVertexColor(r, g, b, a or 1)
		end
	end
end

local function SetBorderShadowColor(self, r, g, b, a)
	local t = self.borderShadow
	if t then
		if not r or not g and not b then
			r, g, b = 1, 1, 1
		end
		
		for _, tex in pairs (t) do
			tex:SetVertexColor(r, g, b, a or 1)
		end
	end
end

local function SetBorderGlowColor(self, r, g, b, a)
	local t = self.borderGlow
	if t then
		if not r or not g and not b then
			r, g, b = 1, 1, 1
		end
		
		for _, tex in pairs (t) do
			tex:SetVertexColor(r, g, b, a or 1)
		end
	end
end

local function SetBorderSize(self, size)
	local b = self.borderTextures
	if b then
		for _, tex in pairs(b) do
			tex:SetSize(size, size) 
		end
	end
	local g = self.borderGlow
	if g then
		for _, tex in pairs(g) do
			tex:SetSize(size, size) 
		end
	end
	local s = self.borderShadow
	if s then
		for _, tex in pairs(s) do
			tex:SetSize(size, size) 
		end
	end
end

local function GetBorderSize(self)
	if self.borderTextures then
		local size = self.borderTextures.TOPRIGHT:GetSize()
		return size
	end
end

local function SetBorderPadding(self, T, B, L, R)
	local t = self.borderTextures
	if t and T then
		if not R and not B and not B and not L then
			R, B, L = T, T, T
		end
		
		for i = 1, 3 do
			if (i == 2) then
				t = self.borderGlow
			elseif (i == 3) then
				t = self.borderShadow
				local space = (self:GetBorderSize()) / 5.5
				T,B,L,R = T+space,B+space,L+space,R+space
			end
			
			t.TOPLEFT:SetPoint("TOPLEFT", self, -L, T)
			t.TOPRIGHT:SetPoint("TOPRIGHT", self, R, T)
			t.TOP:SetPoint("TOPLEFT", t.TOPLEFT, "TOPRIGHT")
			t.TOP:SetPoint("TOPRIGHT", t.TOPRIGHT, "TOPLEFT")
			t.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, -L, -B)
			t.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, R, -B)
			t.BOTTOM:SetPoint("BOTTOMLEFT", t.BOTTOMLEFT, "BOTTOMRIGHT")
			t.BOTTOM:SetPoint("BOTTOMRIGHT", t.BOTTOMRIGHT, "BOTTOMLEFT")
			t.LEFT:SetPoint("TOPLEFT", t.TOPLEFT, "BOTTOMLEFT")
			t.LEFT:SetPoint("BOTTOMLEFT", t.BOTTOMLEFT, "TOPLEFT")
			t.RIGHT:SetPoint("TOPRIGHT", t.TOPRIGHT, "BOTTOMRIGHT")
			t.RIGHT:SetPoint("BOTTOMRIGHT", t.BOTTOMRIGHT, "TOPRIGHT")
		end
	end
end

function CreateBorder(self, size, padding, layer, shadowLayer)
	if type(self) ~= 'table' or self.borderTextures then return end
	
	if not (self.borderTextures) then
		local b = {}
		local s = {}
		local g = {}
		
		for i = 1, #sections do 
			local t = self:CreateTexture(nil, layer or 'OVERLAY')
			t:SetParent(self)
			t:SetTexture(C.media.bordertextures..'BorderNormal')
			t:SetVertexColor(1, 1, 1, 1)
			b[sections[i]] = t
			
			t = self:CreateTexture(nil, shadowLayer or 'BORDER')
			t:SetParent(self)
			t:SetTexture(C.media.bordertextures..'BorderShadow')
			t:SetVertexColor(0, 0, 0, 1)
			s[sections[i]] = t
			
			t = self:CreateTexture(nil, layer or 'OVERLAY')
			t:SetDrawLayer('OVERLAY', 3)
			t:SetParent(self)
			t:SetTexture(C.media.bordertextures..'BorderGlow')
			t:SetVertexColor(1, 1, 1, 0)
			t:SetBlendMode("ADD")
			g[sections[i]] = t
		end
		
		for _, v in pairs({b,s,g}) do
			v["TOPLEFT"]:SetTexCoord(0, 1/3, 0, 1/3)
			v["TOPRIGHT"]:SetTexCoord(2/3, 1, 0, 1/3)
			v["TOP"]:SetTexCoord(1/3, 2/3, 0, 1/3)
			v["BOTTOMLEFT"]:SetTexCoord(0, 1/3, 2/3, 1)
			v["BOTTOMRIGHT"]:SetTexCoord(2/3, 1, 2/3, 1)
			v["BOTTOM"]:SetTexCoord(1/3, 2/3, 2/3, 1)
			v["LEFT"]:SetTexCoord(0, 1/3, 1/3, 2/3)
			v["RIGHT"]:SetTexCoord(2/3, 1, 1/3, 2/3)
		end
		
		self.borderTextures = b
		self.borderShadow = s
		self.borderGlow = g
		
		self.SetBorderColor = SetBorderColor
		self.SetBorderShadowColor = SetBorderShadowColor
		self.SetBorderGlowColor = SetBorderGlowColor
		self.SetBorderSize = SetBorderSize
		self.GetBorderSize = GetBorderSize
		self.SetBorderPadding = SetBorderPadding
		
		self:SetBorderSize(size or 12)
		self:SetBorderPadding(padding or 3)
	end
end