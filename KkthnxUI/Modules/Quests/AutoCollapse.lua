local K, C, L, _ = unpack(select(2, ...))
if C["automation"].autocollapse ~= true then return end
if IsAddOnLoaded("QuestHelper") then return end

local instance, instanceType = IsInInstance()

-- Auto collapse WatchFrame
local Frame = CreateFrame("Frame")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Frame:RegisterEvent("PLAYER_UPDATE_RESTING")
Frame:SetScript("OnEvent", function(self, event)
	if UnitAffectingCombat("player") then self:RegisterEvent("PLAYER_REGEN_ENABLED") return end
	if IsResting() and not WatchFrame.collapsed then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	elseif instanceType == "party" or instanceType == "pvp" or instanceType == "raid" or instanceType == "arena" then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	elseif WatchFrame.collapsed and not IsResting() then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	end
end)