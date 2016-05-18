local K, C, L, _ = select(2, ...):unpack()

-- Application Programming Interface for KkthnxUI (API)
local getmetatable = getmetatable
local type = type
local match = string.match
local floor = math.floor
local unpack, select = unpack, select
local CreateFrame = CreateFrame
local UIFrameFadeIn, UIFrameFadeOut = UIFrameFadeIn, UIFrameFadeOut

K.mult = 768 / match(GetCVar("gxResolution"), "%d+x(%d+)") / C["general"].uiscale
K.Scale = function(x) return K.mult * floor(x / K.mult + .5) end
K.noscalemult = K.mult * C["general"].uiscale

-- Backdrops
K.Backdrop = {bgFile = C["media"].blank, edgeFile = C["media"].blizz, edgeSize = 14, insets = {left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.BasicBackdrop = {bgFile = C["media"].blank, tile = true, tileSize = 16, insets = {left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.BlizBackdrop = {bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = {left = 11, right = 12, top = 12, bottom = 11}}
K.EdgeBackdrop = {edgeFile = C["media"].blizz, edgeSize = 14, insets = {left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.ModBackdrop = {bgFile = C["media"].blank, tile = true, tileSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}
K.ShadowBackdrop = {bgFile = C["media"].blank, edgeFile = C["media"].glow, edgeSize = 4, insets = {left = 4, right = 4, top = 4, bottom = 4}}
K.SimpleBackdrop = {bgFile = C["media"].blank}

-- Backdrop
local function CreateBackdrop(f, size)
	if f.backdrop then return end

	local backdrop = CreateFrame("Frame", "$parentBackdrop", f)
	backdrop:SetPoint("TOPLEFT", -size, size)
	backdrop:SetPoint("BOTTOMLEFT", -size, -size)
	backdrop:SetPoint("TOPRIGHT", size, size)
	backdrop:SetPoint("BOTTOMRIGHT", size, -size)
	backdrop:CreateBlizzBorder(2)

	if f:GetFrameLevel() - 1 >= 0 then
		backdrop:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		backdrop:SetFrameLevel(0)
	end

	f.backdrop = backdrop
end

-- Create a Blizzard-like border
local function CreateBlizzBorder(f, size, level, alpha, alphaborder)
	if f.BlizzBorder then return end

	local border = CreateFrame("Frame", "$parentBackdrop", f)
	border:SetPoint("TOPLEFT", -size, size)
	border:SetPoint("BOTTOMLEFT", -size, -size)
	border:SetPoint("TOPRIGHT", size, size)
	border:SetPoint("BOTTOMRIGHT", size, -size)
	border:SetBackdrop(K.Backdrop)
	border:SetBackdropColor(unpack(C["media"].backdrop_color))
	border:SetBackdropBorderColor(unpack(C["media"].border_color))

	if f:GetFrameLevel() - 1 >= 0 then
		border:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		border:SetFrameLevel(0)
	end

	f.border = border
end

-- Who doesn't like shadows! More shadows!
local function CreateShadow(f, size)
	if f.shadow then return end

	local shadow = CreateFrame("Frame", "$parentBackdrop", f)
	shadow:SetPoint("TOPLEFT", -size, size)
	shadow:SetPoint("BOTTOMLEFT", -size, -size)
	shadow:SetPoint("TOPRIGHT", size, size)
	shadow:SetPoint("BOTTOMRIGHT", size, -size)
	shadow:SetBackdrop({
		edgeFile = C["media"].glow, edgeSize = K.Scale(3),
		insets = {left = K.Scale(5), right = K.Scale(5), top = K.Scale(5), bottom = K.Scale(5)},
	})
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.8)

	if f:GetFrameLevel() - 1 >= 0 then
		shadow:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		shadow:SetFrameLevel(0)
	end

	f.shadow = shadow
end

local function CreateOverlay(f)
	if f.overlay then return end

	local overlay = f:CreateTexture("$parentOverlay", "BORDER", f)
	overlay:SetPoint("TOPLEFT", 2, -2)
	overlay:SetPoint("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(C["media"].blank)
	overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	f.overlay = overlay
end

local function CreateBorder(f, i, o)
	if i then
		if f.iborder then return end
		local border = CreateFrame("Frame", "$parentInnerBorder", f)
		border:SetPoint("TOPLEFT", K.mult, -K.mult)
		border:SetPoint("BOTTOMRIGHT", -K.mult, K.mult)
		border:SetBackdrop({
			edgeFile = C["media"].blank, edgeSize = K.mult,
			insets = {left = K.mult, right = K.mult, top = K.mult, bottom = K.mult}
		})
		border:SetBackdropBorderColor(unpack(C["media"].backdrop_color))
		f.iborder = border
	end

	if o then
		if f.oborder then return end
		local border = CreateFrame("Frame", "$parentOuterBorder", f)
		border:SetPoint("TOPLEFT", -K.mult, K.mult)
		border:SetPoint("BOTTOMRIGHT", K.mult, -K.mult)
		border:SetFrameLevel(f:GetFrameLevel() + 1)
		border:SetBackdrop({
			edgeFile = C["media"].blank, edgeSize = K.mult,
			insets = {left = K.mult, right = K.mult, top = K.mult, bottom = K.mult}
		})
		border:SetBackdropBorderColor(unpack(C["media"].backdrop_color))
		f.oborder = border
	end
end

-- Get Template
local function GetTemplate(t)
	borderr, borderg, borderb, bordera = unpack(C["media"].border_color)
	backdropr, backdropg, backdropb, backdropa = unpack(C["media"].backdrop_color)
end

local function SetTemplate(f, t)
	GetTemplate(t)

	f:SetBackdrop({
		bgFile = C["media"].blank, edgeFile = C["media"].blank, edgeSize = K.mult,
		insets = {left = -K.mult, right = -K.mult, top = -K.mult, bottom = -K.mult}
	})

	if t == "Transparent" then
		backdropa = C["media"].backdrop_color[4]
		f:CreateBorder(true, true)
	elseif t == "Overlay" then
		backdropa = 1
		f:CreateOverlay()
	else
		backdropa = C["media"].backdrop_color[4]
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
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
		K.AddBorder(f, 10)
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function Kill(object)
    if object.UnregisterAllEvents then
        object:UnregisterAllEvents()
    end
    object.Show = K.Dummy
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

local function FontString(parent, name, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString( nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(K.mult, -K.mult)

	if not name then
		parent.text = fs
	else
		parent[name] = fs
	end

	return fs
end

-- Fade In/Out Functions
local function FadeIn(f) UIFrameFadeIn(f, 0.4, f:GetAlpha(), 1.0) end
local function FadeOut(f) UIFrameFadeOut(f, 0.8, f:GetAlpha(), 0.1) end

-- Merge KkthnxUI API with WoWs API
local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.CreateBlizzBorder then mt.CreateBlizzBorder = CreateBlizzBorder end
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.CreatePanel then mt.CreatePanel = CreatePanel end
	if not object.CreateShadow then mt.CreateShadow = CreateShadow end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
	if not object.FontString then mt.FontString = FontString end
	if not object.Kill then mt.Kill = Kill end
	if not object.SetTemplate then mt.SetTemplate = SetTemplate end
	if not object.StripTextures then mt.StripTextures = StripTextures end
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