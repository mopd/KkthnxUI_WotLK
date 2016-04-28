local K, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("QuestHelper") then return end

-- Move WatchFrame
local frame = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
frame:SetPoint(unpack(C["position"].quest))
frame:SetHeight(150)
frame:SetWidth(224)

WatchFrame:ClearAllPoints()
WatchFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
WatchFrame:SetHeight(K.ScreenHeight / 1.6)

hooksecurefunc(WatchFrame, "SetPoint", function(_, _, parent)
	if parent ~= frame then
		WatchFrame:ClearAllPoints()
		WatchFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
	end
end)
WatchFrameHeader:SetAlpha(0)

-- Skin WatchFrame item buttons
hooksecurefunc("WatchFrameItem_UpdateCooldown", function(self)
	if not self.skinned and not InCombatLockdown() then
		local icon = _G[self:GetName().."IconTexture"]
		local border = _G[self:GetName().."NormalTexture"]
		local count = _G[self:GetName().."Count"]

		self:SetSize(C["blizzard"].questbuttonsize, C["blizzard"].questbuttonsize)
		K.AddBorder(self, 10)
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", self, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", self, -2, 2)

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 0, 2)
		count:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
		count:SetShadowOffset(K.mult, -K.mult)

		border:SetTexture(nil)

		self.skinned = true
	end
end)

-- Auto collapse WatchFrame after UI Reload
if C["automation"].auto_collapse_reload then
	local ReloadCollapse = CreateFrame("Frame")
	ReloadCollapse:RegisterEvent("PLAYER_ENTERING_WORLD")
	ReloadCollapse:SetScript("OnEvent", function(self, event)
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	end)
end

-- Difficulty color for WatchFrame lines
hooksecurefunc("WatchFrame_Update", function()
	local numQuestWatches = GetNumQuestWatches()

	for i = 1, numQuestWatches do
		local questIndex = GetQuestIndexForWatch(i)
		if questIndex then
			local title, level = GetQuestLogTitle(questIndex)
			local col = GetQuestDifficultyColor(level)

			for j = 1, #WATCHFRAME_QUESTLINES do
				if WATCHFRAME_QUESTLINES[j].text:GetText() == title then
					WATCHFRAME_QUESTLINES[j].text:SetTextColor(col.r, col.g, col.b)
					WATCHFRAME_QUESTLINES[j].col = col
				end
			end
			for k = 1, #WATCHFRAME_ACHIEVEMENTLINES do
				WATCHFRAME_ACHIEVEMENTLINES[k].col = nil
			end
		end
	end
end)


hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
	i = self.startLine
	if not (self.lines[i] and self.lines[i].col) then return end
	if onEnter then
		self.lines[i].text:SetTextColor(1, 0.8, 0)
	else
		self.lines[i].text:SetTextColor(self.lines[i].col.r, self.lines[i].col.g, self.lines[i].col.b)
	end
end)