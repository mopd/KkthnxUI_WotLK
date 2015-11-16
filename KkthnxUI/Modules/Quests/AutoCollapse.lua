local K, C, L = unpack(select(2, ...))
if C.automation.autocollapse ~= true then return end

if IsAddOnLoaded("QuestHelper") then return end

----------------------------------------------------------------------------------------
--	Auto collapse WatchFrame in instance
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if IsInInstance() then
		WatchFrameCollapseExpandButton:Click()
	elseif WatchFrame.collapsed and not InCombatLockdown() then
		WatchFrameCollapseExpandButton:Click()
	end
end)