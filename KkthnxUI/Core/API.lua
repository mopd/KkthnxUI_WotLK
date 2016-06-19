local K, C, _ = select(2, ...):unpack()

-- Application Programming Interface for KkthnxUI (API)
local getmetatable = getmetatable
local type = type
local match = string.match
local floor = math.floor
local unpack, select = unpack, select
local CreateFrame = CreateFrame
local UIFrameFadeIn, UIFrameFadeOut = UIFrameFadeIn, UIFrameFadeOut

local backdropr, backdropg, backdropb, backdropa, borderr, borderg, borderb = 0, 0, 0, 0.9, 1, 1, 1

K.Mult = 768 / match(GetCVar("gxResolution"), "%d+x(%d+)") / C["General"].uiscale
K.Scale = function(x) return K.Mult * floor(x / K.Mult + .5) end
K.NoScaleMult = K.Mult * C["General"].uiscale

local function SetOutside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	assert(anchor)
	if obj:GetPoint() then obj:ClearAllPoints() end

	obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
	obj:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

local function SetInside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	assert(anchor)
	if obj:GetPoint() then obj:ClearAllPoints() end

	obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	obj:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

-- Backdrop
local function CreateBackdrop(f, size)
	if f.backdrop then return end
	size = size or 2

	local b = CreateFrame("Frame", nil, f)
	b:SetOutside(f, size, size)
	b:SetBackdrop(K.Backdrop)
	b:SetBackdropColor(unpack(C["Media"].Backdrop_Color))
	b:SetBackdropBorderColor(unpack(C["Media"].Border_Color))

	if(f:GetFrameLevel() - 1 >= 0) then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end

	f.backdrop = b
end

-- Who doesn't like shadows! More shadows!
local function CreatePixelShadow(f, size)
	if f.shadow then return end
	size = size or 2

	borderr, borderg, borderb = 0, 0, 0
	backdropr, backdropg, backdropb = 0, 0, 0

	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetOutside(f, size, size)
	shadow:SetBackdrop(K.ShadowBackdrop)
	shadow:SetBackdropColor(backdropr, backdropg, backdropb, 0)
	shadow:SetBackdropBorderColor(borderr, borderg, borderb, 0.9)
	f.shadow = shadow
end

local function CreateBlizzShadow(f, size)
	if f.shadow then return end
	size = size or 5

	borderr, borderg, borderb = 0, 0, 0
	backdropr, backdropg, backdropb = 0, 0, 0

	local shadow = f:CreateTexture(nil, "BACKGROUND")
	shadow:SetParent(f)
	shadow:SetOutside(f, size, size)
	shadow:SetTexture(C["Media"].AB_Textures.."textureShadow")
	shadow:SetVertexColor(borderr, borderg, borderb, 0.9)
	f.shadow = shadow
end

-- Create Panel
local function CreatePanel(f, t, w, h, a1, p, a2, x, y)
	local r, g, b = K.Color.r, K.Color.g, K.Color.b
	f:SetFrameLevel(1)
	f:SetSize(w, h)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)

	if t == "CreateBackdrop" then
		backdropa = C["Media"].Overlay_Color[4]
		f:CreateBackdrop()
	elseif t == "CreateBorder" then
		f:SetBackdrop(K.SimpleBackdrop)
		backdropa = C["Media"].Overlay_Color[4]
		CreateBorder(f)
	elseif t == "SimpleBackdrop" then
		f:SetBackdrop(K.SimpleBackdrop)
		backdropa = C["Media"].Overlay_Color[4]
		bordera = 0
	elseif t == "Invisible" then
		backdropa = 0
		bordera = 0
	else
		backdropa = C["Media"].Overlay_Color[4]
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function Kill(object)
    if object.UnregisterAllEvents then
        object:UnregisterAllEvents()
    end
    object.Show = K.Noop
    object:Hide()
end

-- StripTextures
local function StripTextures(Object, Kill, Text)
    for i = 1, Object:GetNumRegions() do
        local Region = select(i, Object:GetRegions())
        if Region:GetObjectType() == "Texture" then
            if Kill then
                Region:Kill()
            else
                Region:SetTexture(nil)
            end
        end
    end
end

local function FontTemplate(fs, font, fontSize, fontStyle)
	fs.font = font
	fs.fontSize = fontSize
	fs.fontStyle = fontStyle

	if not font then font = C["Media"].Font end
	if not fontSize then fontSize = 12 end
	if fontStyle == "OUTLINE" then
		if (fontSize > 12 and not fs.fontSize) then
			fontStyle = "OUTLINE"
			fontSize = 12
		end
	end

	fs:SetFont(font, fontSize, fontStyle)
	if fontStyle then
		fs:SetShadowColor(0, 0, 0, 0.2)
	else
		fs:SetShadowColor(0, 0, 0, 1)
	end
	fs:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
end

local function StyleButton(button, noHover, noPushed, noChecked)
	if button.SetHighlightTexture and not button.hover and not noHover then
		local hover = button:CreateTexture()
		hover:SetTexture(1, 1, 1, 0.3)
		hover:SetInside()
		button.hover = hover
		button:SetHighlightTexture(hover)
	end

	if button.SetPushedTexture and not button.pushed and not noPushed then
		local pushed = button:CreateTexture()
		pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		pushed:SetInside()
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end

	if button.SetCheckedTexture and not button.checked and not noChecked then
		local checked = button:CreateTexture()
		checked:SetTexture(1, 1, 1)
		checked:SetInside()
		checked:SetAlpha(0.3)
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetInside()
	end
end

-- Merge KkthnxUI API with WoWs API
local function AddAPI(object)
	local mt = getmetatable(object).__index
	if not object.SetOutside then mt.SetOutside = SetOutside end
	if not object.SetInside then mt.SetInside = SetInside end
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.CreatePanel then mt.CreatePanel = CreatePanel end
	if not object.CreatePixelShadow then mt.CreatePixelShadow = CreatePixelShadow end
	if not object.CreateBlizzShadow then mt.CreateBlizzShadow = CreateBlizzShadow end
	if not object.StyleButton then mt.StyleButton = StyleButton end
	if not object.FontTemplate then mt.FontTemplate = FontTemplate end
	if not object.Kill then mt.Kill = Kill end
	if not object.StripTextures then mt.StripTextures = StripTextures end
end

local Handled = {["Frame"] = true}
local Object = CreateFrame("Frame")
AddAPI(Object)
AddAPI(Object:CreateTexture())
AddAPI(Object:CreateFontString())

Object = EnumerateFrames()
while Object do
	if not Handled[Object:GetObjectType()] then
		AddAPI(Object)
		Handled[Object:GetObjectType()] = true
	end

	Object = EnumerateFrames(Object)
end