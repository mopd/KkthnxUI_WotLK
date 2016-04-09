local K, C, L = unpack(select(2, ...));

-- Get Template
local function GetTemplate(t)
	borderr, borderg, borderb, bordera = unpack(C["media"].border_color)
	backdropr, backdropg, backdropb, backdropa = unpack(C["media"].backdrop_color)
end

-- Create Panel
local function CreatePanel(f, t, w, h, a1, p, a2, x, y)
	GetTemplate(t)
	
	f:SetWidth(w)
	f:SetHeight(h)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop(backdrop)
	
	if t == "Invisible" then
		backdropa = 0
		bordera = 0
	else
		backdropa = C["media"].backdrop_color[4]
		K.AddBorder(f)
	end
	
	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

K.HiddenFrame = CreateFrame("Frame");
K.HiddenFrame:Hide();
local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
		object:SetParent(K.HiddenFrame)
	else
		object.Show = object.Hide
	end
	
	object:Hide()
end

-- StripTextures
local function StripTextures(object, kill)
	for i=1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region and region:GetObjectType() == "Texture" then
			if kill and type(kill) == 'boolean' then
				region:Kill()
			elseif region:GetDrawLayer() == kill then
				region:SetTexture(nil)
			elseif kill and type(kill) == 'string' and region:GetTexture() ~= kill then
				region:SetTexture(nil)
			else
				region:SetTexture(nil)
			end
		end
	end
end

local function FontString( parent, name, fontName, fontHeight, fontStyle )
	local fs = parent:CreateFontString( nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor( 0, 0, 0 )
	fs:SetShadowOffset(K.mult, -K.mult)
	
	if not name then
		parent.text = fs
	else
		parent[name] = fs
	end
	
	return fs
end

-- Fade In/Out Functions
local function FadeIn(f) UIFrameFadeIn(f, .4, f:GetAlpha(), 1) end
local function FadeOut(f) UIFrameFadeOut(f, .8, f:GetAlpha(), .1) end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.SetOutside then mt.SetOutside = SetOutside end
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.CreatePanel then mt.CreatePanel = CreatePanel end
	if not object.Kill then mt.Kill = Kill end
	if not object.StripTextures then mt.StripTextures = StripTextures end
	if not object.FontString then mt.FontString = FontString end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end
	
	object = EnumerateFrames(object)
end