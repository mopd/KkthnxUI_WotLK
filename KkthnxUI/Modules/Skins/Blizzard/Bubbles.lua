local K, C, L, _ = unpack(select(2, ...))
if C["skins"].chatbubble ~= true then return end
if IsAddOnLoaded("BossEncounter2") == true then return end --> i don't know wtf this addon is doing but it broke my bubble script.

local next = next
local select, unpack, type = select, unpack, type
local strlower = strlower
local CreateFrame = CreateFrame

local chatbubblehook = CreateFrame("Frame", nil, UIParent)
local tslu = 0
local numkids = 0
local bubbles = {}

local function skinbubble(frame)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		elseif region:GetObjectType() == "FontString" then
			frame.text = region
		end
	end

	if C["general"].chatbubble_nobackdrop == false then
		frame:SetBackdrop(K.Backdrop)
		frame:SetBackdropColor(unpack(C["media"].backdrop_color))
		frame:SetBackdropBorderColor(unpack(C["media"].border_color))
		frame:SetClampedToScreen(false)
		frame:SetFrameStrata("BACKGROUND")
		frame.text:SetFont(C["font"].basic_font, C["general"].chatbubble_fontsize)
		frame.text:SetShadowOffset(K.mult * UIParent:GetScale(), -K.mult * UIParent:GetScale())
	else
		frame:SetBackdrop(nil)
		frame.text:SetFont(C["font"].basic_font, C["general"].chatbubble_fontsize)
		frame.text:SetShadowOffset(K.mult * UIParent:GetScale(), -K.mult * UIParent:GetScale())
		frame:SetClampedToScreen(false)
		frame:SetFrameStrata("BACKGROUND")
	end
	frame.isBubblePowered = true

	tinsert(bubbles, frame)
end

local function ischatbubble(frame)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if (region.GetTexture and region:GetTexture() and type(region:GetTexture() == "string") and strlower(region:GetTexture()) == [[interface\tooltips\chatbubble-background]]) then return true end
	end
	return false
end

chatbubblehook:SetScript("OnUpdate", function(chatbubblehook, elapsed)
	tslu = tslu + elapsed

	if tslu > .1 then
		tslu = 0

		local newnumkids = WorldFrame:GetNumChildren()
		if newnumkids ~= numkids then
			for i = numkids + 1, newnumkids do
				local frame = select(i, WorldFrame:GetChildren())

				if ischatbubble(frame) then
					skinbubble(frame)
				end
			end
			numkids = newnumkids
		end

		for i, frame in next, bubbles do
			local r, g, b = frame.text:GetTextColor()
			frame:SetBackdropBorderColor(r, g, b)
		end
	end
end)