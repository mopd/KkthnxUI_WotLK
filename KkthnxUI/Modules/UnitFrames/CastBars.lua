local K, C, L = unpack(select(2, ...));
if C["unitframe"].enable ~= true then return end

local d = {};
local find = string.find;
local floor = math.floor;

-- Anchor
local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C["unitframe"].cbscale, CastingBarFrame:GetHeight() * 2)
PlayerCastbarAnchor:SetPoint(unpack(C["position"].playercastbar))

-- Player Castbar
hooksecurefunc(CastingBarFrame, "Show", function()
	CastingBarFrame:SetScale(C["unitframe"].cbscale)
	CastingBarFrame:ClearAllPoints()
	CastingBarFrame:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3)
	CastingBarFrame.SetPoint = K.Dummy
	-- Icon
	CastingBarFrameIcon:Show()
	CastingBarFrameIcon:SetSize(30, 30)
	CastingBarFrameIcon:ClearAllPoints()
	CastingBarFrameIcon:SetPoint("CENTER", CastingBarFrame, "TOP", 0, 24)
	CastingBarFrameIcon.SetPoint = K.Dummy
end)

-- Target Castbar
hooksecurefunc(TargetFrameSpellBar, "Show", function()
	TargetFrameSpellBar:SetScale(C["unitframe"].cbscale)
	TargetFrameSpellBar:ClearAllPoints()
	TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, 150)
	TargetFrameSpellBar.SetPoint = K.Dummy
end)

-- Player Casting Timer
CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil)
CastingBarFrame.timer:SetFont(C["font"].basic_font, C["font"].basic_font_size + 1)
CastingBarFrame.timer:SetShadowOffset(1, -1)
CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, -2)
CastingBarFrame.update = .1
-- Target Casting Timer
TargetFrameSpellBar.timer = TargetFrameSpellBar:CreateFontString(nil)
TargetFrameSpellBar.timer:SetFont(C["font"].basic_font, C["font"].basic_font_size + 1)
TargetFrameSpellBar.timer:SetShadowOffset(1, -1)
TargetFrameSpellBar.timer:SetPoint("TOP", TargetFrameSpellBar, "BOTTOM", 0, -2)
TargetFrameSpellBar.update = .1

-- Casting Bar Update
hooksecurefunc("CastingBarFrame_OnUpdate", function(self, elapsed)
	if not self.timer then return end
	if CastingBarFrame:IsShown() then
		CastingBarFrame:SetStatusBarColor(K.Color.r,K.Color.g,K.Color.b)
	end
	if self.update and self.update < elapsed then
		if self.casting then
			self.timer:SetText(format("%2.1f/%1.1f", max(self.maxValue - self.value, 0), self.maxValue))
		elseif self.channeling then
			self.timer:SetText(format("%.1f", max(self.value, 0)))
		else
			self.timer:SetText("")
		end
		self.update = .1
	else
		self.update = self.update - elapsed
	end
end)