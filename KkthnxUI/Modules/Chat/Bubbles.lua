local K, C, L, _ = unpack(select(2, ...))
if C.chat.bubbles ~= true then return end

local ChatBubbleSkin = CreateFrame('Frame', nil, UIParent)
local tslu = 0
local numChildren = -1
local bubbles = {}

local function SkinBubble(frame)
	for i=1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:GetObjectType() == 'Texture' then
			region:SetTexture(nil)
		elseif region:GetObjectType() == 'FontString' then
			frame.text = region
		end
	end
	
	frame:SetBackdrop(K.Backdrop)
	frame:SetBackdropColor(0.05, 0.05, 0.05, .9)
	frame:SetBackdropBorderColor(.7, .7, .7, 1)
	
	frame.text:SetFont(C.font.basic_font, C.font.basic_font_size)
	
	tinsert(bubbles, frame)
end

function IsChatBubble(frame)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if (region.GetTexture and region:GetTexture() and type(region:GetTexture() == "string") and
		strlower(region:GetTexture()) == [[interface\tooltips\chatbubble-background]]) then
			return true
		end
	end
	return false
end

ChatBubbleSkin:SetScript('OnUpdate', function(ChatBubbleSkin, elapsed)
	tslu = tslu + elapsed
	if tslu > 0.1 then
		tslu = 0
		local count = WorldFrame:GetNumChildren()
		if count ~= numChildren then
			numChildren = count
			for index = 1, select('#', WorldFrame:GetChildren()) do
				local frame = select(index, WorldFrame:GetChildren())
				if IsChatBubble(frame) then
					SkinBubble(frame)
				end
			end
			numChildren = count
		end
		
		for i, frame in next, bubbles do
			local r, g, b = frame.text:GetTextColor()
			frame:SetBackdropBorderColor(r, g, b)
		end
	end
end)