local K, C, L, _ = unpack(select(2, ...))

-- Chat background
if C.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 2, "TOPLEFT", ChatFrame1, "TOPLEFT", -1, 0)
	chatbd:SetBackdropColor(0, 0, 0, C.chat.background_alpha)

	if C.chat.tabmouseover ~= true then
		local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
		chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 17, "BOTTOM", chatbd, "TOP", 0, 6)
		chattabs:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
	end
end