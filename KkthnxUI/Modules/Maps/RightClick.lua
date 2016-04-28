local K, C, L, _ = unpack(select(2, ...))
if C["minimap"].enable ~= true then return end

-- Right click menu
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1,
		func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1,
		func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON, notCheckable = 1,
		func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end if not GlyphFrame then LoadAddOn("Blizzard_GlyphUI") end PlayerTalentFrame_Toggle() end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1,
		func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON, notCheckable = 1,
		func = function() ToggleFrame(QuestLogFrame) end},
	{text = SOCIAL_BUTTON, notCheckable = 1,
		func = function() ToggleFriendsFrame(1) end},
	{text = PLAYER_V_PLAYER, notCheckable = 1,
		func = function() ToggleFrame(PVPFrame) end},
	{text = ACHIEVEMENTS_GUILD_TAB, notCheckable = 1,
		func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() GuildFrame_TabClicked(GuildFrameTab2) end end},
	{text = LFG_TITLE, notCheckable = 1,
		func = function() ToggleFrame(LFDParentFrame) end},
	{text = LOOKING_FOR_RAID, notCheckable = 1,
		func = function() ToggleFrame(LFRParentFrame) end},
	{text = HELP_BUTTON, notCheckable = 1,
		func = function() ToggleHelpFrame() end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1,
		func = function() if not CalendarFrame then LoadAddOn("Blizzard_Calendar") end Calendar_Toggle() end},
}

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = Minimap:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU")
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU")
		end
	elseif button == "MiddleButton" then
		if position:match("LEFT") then
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", 0, 0, "MENU", 2)
		else
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)