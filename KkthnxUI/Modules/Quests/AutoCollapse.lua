local K, C, L = unpack(select(2, ...));
if C["automation"].autocollapse ~= true then return end

if IsAddOnLoaded("QuestHelper") then return end

-- Auto collapse WatchFrame
local frame = CreateFrame("Frame")
local resting = IsResting()
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_UPDATE_RESTING")
frame:SetScript("OnEvent", function(self, event)
	if IsInInstance() then
		WatchFrameCollapseExpandButton:Click()
	elseif WatchFrame.collapsed and not InCombatLockdown() then
		WatchFrameCollapseExpandButton:Click()
	elseif IsResting() then
		WatchFrameCollapseExpandButton:Click()
		print(frame)
	end
end)