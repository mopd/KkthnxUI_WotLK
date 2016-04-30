local K, C, L, _ = unpack(select(2, ...))

local unpack = unpack

local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame
local PlaySound, PlaySoundFile = PlaySound, PlaySoundFile
local MAX_BATTLEFIELD_QUEUES = MAX_BATTLEFIELD_QUEUES
local GetBattlefieldStatus = GetBattlefieldStatus
local ShowReadyCheckHook = ShowReadyCheckHook
local UnitIsAFK = UnitIsAFK
local LFDParentFrame = LFDParentFrame
local GetZoneText = GetZoneText
local GetLFGDungeonRewards = GetLFGDungeonRewards
local GetLFGDungeonInfo = GetLFGDungeonInfo
local GetLFGRandomDungeonInfo = GetLFGRandomDungeonInfo
local GetNumRandomDungeons = GetNumRandomDungeons
local RaidBossEmoteFrame = RaidBossEmoteFrame
local DressUpFrame = DressUpFrame
local UIErrorsFrame = UIErrorsFrame
local isHoliday = isHoliday
local IsVisible = IsVisible
local AuctionFrame = AuctionFrame
local SetClampedToScreen = SetClampedToScreen

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint(unpack(C["position"].ticket))

-- Force readycheck warning
local ShowReadyCheckHook = function(self, initiator)
	if initiator ~= "player" then
		PlaySound("ReadyCheck", "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

-- Force other warning
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("BATTLEFIELD_MGR_ENTRY_INVITE")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("RESURRECT_REQUEST")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status = GetBattlefieldStatus(i)
			if status == "confirm" then
				PlaySound("PVPTHROUGHQUEUE", "Master")
				break
			end
			i = i + 1
		end
	elseif event == "BATTLEFIELD_MGR_ENTRY_INVITE" then
		PlaySound("PVPTHROUGHQUEUE", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" then
		PlaySound("ReadyCheck", "Master")
	elseif event == "RESURRECT_REQUEST" then
		PlaySoundFile("Sound\\Spells\\Resurrection.wav", "Master")
	end
end)

-- Misclicks for some popups
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
StaticPopupDialogs.CONFIRM_BATTLEFIELD_ENTRY.button2 = nil

-- Spin camera while afk(by Telroth and Eclipse)
if C["misc"].afk_spin_camera == true then
	local SpinCam = CreateFrame("Frame")

	local OnEvent = function(self, event, unit)
		if event == "PLAYER_FLAGS_CHANGED" then
			if unit == "player" then
				if UnitIsAFK(unit) then
					SpinStart()
				else
					SpinStop()
				end
			end
		elseif event == "PLAYER_LEAVING_WORLD" then
			SpinStop()
		end
	end
	SpinCam:RegisterEvent("PLAYER_ENTERING_WORLD")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", OnEvent)

	function SpinStart()
		spinning = true
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		UIParent:Show()
	end
end

-- Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

-- Remove Boss Emote spam during BG(ArathiBasin SpamFix by Partha)
if C["misc"].hide_bg_spam == true then
	local Fixer = CreateFrame("Frame")
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame

	local function DisableSpam()
		if GetZoneText() == L_ZONE_ARATHIBASIN then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = false
		end
	end

	Fixer:RegisterEvent("PLAYER_ENTERING_WORLD")
	Fixer:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	Fixer:SetScript("OnEvent", DisableSpam)
end

-- Undress button in auction dress-up frame(by Nefarion)
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetHeight(22)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(self, button)
	if button == "RightButton" then
		self.model:UndressSlot(19)
	else
		self.model:Undress()
	end
	PlaySound("gsTitleOptionOK")
end)
strip.model = DressUpModel

strip:RegisterEvent("AUCTION_HOUSE_SHOW")
strip:RegisterEvent("AUCTION_HOUSE_CLOSED")
strip:SetScript("OnEvent", function(self)
	if AuctionFrame:IsVisible() and self.model ~= SideDressUpModel then
		self:SetParent(SideDressUpModel)
		self:ClearAllPoints()
		self:SetPoint("TOP", SideDressUpModelResetButton, "BOTTOM", 0, -3)
		self.model = SideDressUpModel
	elseif self.model ~= DressUpModel then
		self:SetParent(DressUpModel)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
		self.model = DressUpModel
	end
end)

-- Force quit
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

-- Old achievements filter
function AchievementFrame_GetCategoryNumAchievements_OldIncomplete(categoryID)
	local numAchievements, numCompleted = GetCategoryNumAchievements(categoryID)
	return numAchievements - numCompleted, 0, numCompleted
end

function old_nocomplete_filter_init()
	AchievementFrameFilters = {
		{text = ACHIEVEMENTFRAME_FILTER_ALL, func = AchievementFrame_GetCategoryNumAchievements_All},
		{text = ACHIEVEMENTFRAME_FILTER_COMPLETED, func = AchievementFrame_GetCategoryNumAchievements_Complete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE, func = AchievementFrame_GetCategoryNumAchievements_Incomplete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE.." ("..ALL.." )", func = AchievementFrame_GetCategoryNumAchievements_OldIncomplete}
	}
end

local filter = CreateFrame("Frame")
filter:RegisterEvent("ADDON_LOADED")
filter:SetScript("OnEvent", function(self, event, addon, ...)
	if addon == "Blizzard_AchievementUI" then
		if AchievementFrame then
			old_nocomplete_filter_init()
			filter:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

-- Change UIErrorsFrame strata
UIErrorsFrame:SetFrameLevel(0)

-- Protection from hidden windows auction at the opening of other windows(by Fernir)
local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("ADDON_LOADED")
eventframe:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AuctionUI" then
		AuctionFrame:SetMovable(true)
		AuctionFrame:SetClampedToScreen(true)
		AuctionFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
		AuctionFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)

		local handleAuctionFrame = function(self)
			if AuctionFrame:GetAttribute("UIPanelLayout-enabled") then
				if AuctionFrame:IsVisible() then
					AuctionFrame.Hide = function() end
					HideUIPanel(AuctionFrame)
					AuctionFrame.Hide = nil
				end
				AuctionFrame:SetAttribute("UIPanelLayout-enabled", nil)
			else
				if AuctionFrame:IsVisible() then
					AuctionFrame.IsShown = function() end
					ShowUIPanel(AuctionFrame)
					AuctionFrame.IsShown = nil
				end
			end
		end
		hooksecurefunc("AuctionFrame_Show", handleAuctionFrame)
		hooksecurefunc("AuctionFrame_Hide", handleAuctionFrame)

		self:UnregisterEvent"ADDON_LOADED"
		self:SetScript("OnEvent", nil)
	end
end)