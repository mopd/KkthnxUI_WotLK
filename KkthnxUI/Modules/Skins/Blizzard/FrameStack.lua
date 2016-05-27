local K, C, L, _ = select(2, ...):unpack()
if C["tooltip"].enable ~= true then return end

-- FrameStackTooltip skin(by Elv22)
local frame = CreateFrame("Frame", nil, K.UIParent)
frame:SetScript("OnUpdate", function(self, elapsed)
	if IsAddOnLoaded("Aurora") then return end

	if self.elapsed and self.elapsed > 0.1 then
		if FrameStackTooltip then
			FrameStackTooltip:SetBackdrop(K.Backdrop)
			FrameStackTooltip:SetBackdropColor(unpack(C["media"].backdrop_color))
			FrameStackTooltip:SetBackdropBorderColor(unpack(C["media"].border_color))
			FrameStackTooltip.SetBackdropColor = K.Dummy
			FrameStackTooltip.SetBackdropBorderColor = K.Dummy
			self.elapsed = nil
			self:SetScript("OnUpdate", nil)
		end
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
end)