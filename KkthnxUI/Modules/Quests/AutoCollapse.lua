local K, C, L, _ = unpack(select(2, ...))
if C["automation"].autocollapse ~= true then return end

if IsAddOnLoaded("QuestHelper") then return end

local CreateFrame = CreateFrame
local IsInInstance = IsInInstance
local InCombatLockdown = InCombatLockdown

-- Auto collapse WatchFrame
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if IsInInstance() then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	elseif WatchFrame.collapsed and not InCombatLockdown() then
		WatchFrame_CollapseExpandButton_OnClick(WatchFrame_CollapseExpandButton)
	end
end)