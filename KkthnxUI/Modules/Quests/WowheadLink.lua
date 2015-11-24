local K, C, L = unpack(select(2, ...));
if IsAddOnLoaded("QuestHelper") then return end

-- Add quest/achievement OpenWow link
local linkQuest
local linkAchievement
--[[
if K.Client == "ruRU" then
	linkQuest = "http://ru.OpenWow.com/quest=%d"
	linkAchievement = "http://ru.OpenWow.com/achievement=%d"
elseif K.Client == "frFR" then
	linkQuest = "http://fr.OpenWow.com/quest=%d"
	linkAchievement = "http://fr.OpenWow.com/achievement=%d"
elseif K.Client == "deDE" then
	linkQuest = "http://de.OpenWow.com/quest=%d"
	linkAchievement = "http://de.OpenWow.com/achievement=%d"
elseif K.Client == "esES" or K.Client == "esMX" then
	linkQuest = "http://es.OpenWow.com/quest=%d"
	linkAchievement = "http://es.OpenWow.com/achievement=%d"
elseif K.Client == "ptBR" or K.Client == "ptPT" then
	linkQuest = "http://pt.OpenWow.com/quest=%d"
	linkAchievement = "http://pt.OpenWow.com/achievement=%d"
else
]]--
	linkQuest = "http://wotlk.openwow.com/quest=%d"
	linkAchievement = "http://wotlk.openwow.com/achievement=%d"
--end

StaticPopupDialogs.WATCHFRAME_URL = {
	text = L_WATCH_OPENWOW_LINK,
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 900,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	preferredIndex = 3,
}

local tblDropDown = {}
hooksecurefunc("WatchFrameDropDown_Initialize", function(self)
	if self.type == "QUEST" then
		tblDropDown = {
			text = L_WATCH_OPENWOW_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, watchId)
				local logId = GetQuestIndexForWatch(watchId)
				local _, _, _, _, _, _, _, _, questId = GetQuestLogTitle(logId)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkQuest:format(questId))
				inputBox.editBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	elseif self.type == "ACHIEVEMENT" then
		tblDropDown = {
			text = L_WATCH_OPENWOW_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, id)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkAchievement:format(id))
				inputBox.editBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	end
end)
UIDropDownMenu_Initialize(WatchFrameDropDown, WatchFrameDropDown_Initialize, "MENU")

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		hooksecurefunc("AchievementButton_OnClick", function(self)
			if self.id and IsControlKeyDown() then
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkAchievement:format(self.id))
				inputBox.editBox:HighlightText()
			end
		end)
	end
end)