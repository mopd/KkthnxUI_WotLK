local K, C, L = unpack(select(2, ...));
if C["skins"].weakauras ~= true then return end

--	WeakAuras skin
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("WeakAuras") then return end

	local function Skin_WeakAuras(frame)
		if not frame.border then
			K.AddBorder(frame, 10, 2.5)
		end

		if frame.icon then
			frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			frame.icon.SetTexCoord = K.Dummy
		end

		if frame.bar then
			frame.bar.fg:SetTexture(C["media"].texture)
			frame.bar.bg:SetTexture(C["media"].texture)
		end

		if frame.stacks then
			frame.stacks:SetFont(C["font"].filger_font, select(2, frame.stacks:GetFont()), C["font"].filger_font_style)
		end

		if frame.timer then
			frame.timer:SetFont(C["font"].filger_font, select(2, frame.timer:GetFont()), C["font"].filger_font_style)
		end

		if frame.text then
			frame.text:SetFont(C["font"].filger_font, select(2, frame.text:GetFont()), C["font"].filger_font_style)
		end
	end

	for weakAura, _ in pairs(WeakAuras.regions) do
		if WeakAuras.regions[weakAura].regionType == "icon" or WeakAuras.regions[weakAura].regionType == "aurabar" then
			Skin_WeakAuras(WeakAuras.regions[weakAura].region)
		end
	end
end)