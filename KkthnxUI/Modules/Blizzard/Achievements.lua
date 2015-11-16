local K, C, L = unpack(select(2, ...))
if C.blizzard.moveachievements ~= true then return end
----------------------------------------------------------------------------------------
--	Based on AchievementMover
----------------------------------------------------------------------------------------
local AchievementAnchor = CreateFrame("Frame", "AchievementAnchor", UIParent)
AchievementAnchor:SetWidth(DungeonCompletionAlertFrame1:GetWidth() - 36)
AchievementAnchor:SetHeight(DungeonCompletionAlertFrame1:GetHeight() - 4)
AchievementAnchor:SetPoint(unpack(C.position.achievements))

-- Achievement frame
local function Reanchor()
	local one, two, lfg = AchievementAlertFrame1, AchievementAlertFrame2, DungeonCompletionAlertFrame1
	if one then
		one:ClearAllPoints()
		one:SetPoint("TOP", AchievementAnchor, "TOP", 0, -20)
	end
	if two then
		two:ClearAllPoints()
		two:SetPoint("TOP", one, "BOTTOM", 0, -10)      
	end
	if lfg:IsShown() then
		lfg:ClearAllPoints()
		if one then
			if two then
				lfg:SetPoint("TOP", two, "BOTTOM", 0, -10)
			else
				lfg:SetPoint("TOP", one, "BOTTOM", 0, -10)
			end
		else
			lfg:SetPoint("TOP", UIParent, "TOP", 0, -20)
		end
	end
end

local achframe = CreateFrame("Frame", nil, UIParent)
achframe:RegisterEvent("VARIABLES_LOADED")
achframe:SetScript("OnEvent", function()
	AlertFrame_FixAnchors = Reanchor
end)