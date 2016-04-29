local K, C, L, _ = unpack(select(2, ...))

local ipairs = ipairs
local print, tostring, select = print, tostring, select
local format, lower = string.format, string.lower

local EnableAddOn, DisableAllAddOns = EnableAddOn, DisableAllAddOns;
local debugprofilestart, debugprofilestop = debugprofilestart, debugprofilestop
local UpdateAddOnCPUUsage, GetAddOnCPUUsage = UpdateAddOnCPUUsage, GetAddOnCPUUsage
local ResetCPUUsage = ResetCPUUsage
local GetAddOnInfo = GetAddOnInfo
local SetCVar = SetCVar
local ReloadUI = ReloadUI
local GetNumPartyMembers, GetNumRaidMembers = GetNumPartyMembers, GetNumRaidMembers
local GetNumQuestLogEntries = GetNumQuestLogEntries
local IsInInstance = IsInInstance
local IsAddOnLoaded = IsAddOnLoaded

-- Misc Slash commands
SlashCmdList.RELOADUI = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

SlashCmdList.RCSLASH = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"

SlashCmdList.TICKET = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"

SlashCmdList.CLEARCOMBAT = function() CombatLogClearEntries() print("|cffffff00CombatLog has been cleared & fixed!!|r") end
SLASH_CLEARCOMBAT1 = "/clc"
SLASH_CLEARCOMBAT2 = "/clfix"

-- Clear all quests in questlog
SlashCmdList.CLEARQUESTS = function()
	for i=1, GetNumQuestLogEntries() do SelectQuestLogEntry(i) SetAbandonQuest() AbandonQuest() end
end
SLASH_CLEARQUESTS1 = "/clearquests"
SLASH_CLEARQUESTS2 = "/cq"

-- Help command
SlashCmdList.UIHELP = function()
	for i, v in ipairs(L_SLASHCMD_HELP) do print("|cffffff00"..("%s"):format(tostring(v)).."|r") end
end
SLASH_UIHELP1 = "/uihelp"
SLASH_UIHELP2 = "/helpui"
SLASH_UIHELP3 = "/kkthnxui"

-- Disband party or raid(by Monolit)
SlashCmdList["GROUPDISBAND"] = function()
	SendChatMessage(L_INFO_DISBAND, "RAID" or "PARTY")
	if UnitInRaid("player") then
		for i = 1, GetNumRaidMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= K.Name then
				UninviteUnit(name)
			end
		end
	else
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if GetPartyMember(i) then
				UninviteUnit(UnitName("party"..i))
			end
		end
	end
	LeaveParty()
end
SLASH_GROUPDISBAND1 = "/rd"

-- Enable LUA error by command
function SlashCmdList.LUAERROR(msg)
	msg = lower(msg)
	if(msg == "on") then
		DisableAllAddOns()
		EnableAddOn("KkthnxUI")
		EnableAddOn("KkthnxUI_Config")
		SetCVar("scriptErrors", 1)
		ReloadUI()
	elseif(msg == "off") then
		SetCVar("scriptErrors", 0)
		print("Lua errors off.")
	else
		print("/luaerror on - /luaerror off")
	end
end
SLASH_LUAERROR1 = "/luaerror"

-- Convert party to raid
SlashCmdList.PARTYTORAID = function()
	if GetNumPartyMembers() > 0 then
		if UnitInRaid("player") and IsGroupLeader() then
			ConvertToParty()
		elseif UnitInParty("player") and IsGroupLeader() then
			ConvertToRaid()
		end
	else
		print("|cffffff00"..ERR_NOT_IN_GROUP.."|r")
	end
end
SLASH_PARTYTORAID1 = "/toraid"
SLASH_PARTYTORAID2 = "/toparty"
SLASH_PARTYTORAID3 = "/convert"

-- Instance teleport
SlashCmdList.INSTTELEPORT = function()
	local inInstance = IsInInstance()
	if inInstance then
		LFGTeleport(true)
	else
		LFGTeleport()
	end
end
SLASH_INSTTELEPORT1 = "/teleport"

-- Spec switching(by Monolit)
SlashCmdList["SPEC"] = function()
	local spec = GetActiveTalentGroup()
	if spec == 1 then SetActiveTalentGroup(2) elseif spec == 2 then SetActiveTalentGroup(1) end
end
SLASH_SPEC1 = "/ss"
SLASH_SPEC2 = "/spec"

-- Deadly Boss Mods Testing.
SlashCmdList.DBMTEST = function() if IsAddOnLoaded("DBM-Core") then DBM:DemoMode() end end
SLASH_DBMTEST1 = "/dbmtest"

-- Command to show frame you currently have mouseovered
SlashCmdList["FRAME"] = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil then FRAME = arg end --Set the global variable FRAME to = whatever we are mousing over to simplify messing with frames that have no name.
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("|cffCC0000----------------------------")
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() and arg:GetParent():GetName() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end

		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f",arg:GetWidth()))
		ChatFrame1:AddMessage("Height: |cffFFD100"..format("%.2f",arg:GetHeight()))
		ChatFrame1:AddMessage("Strata: |cffFFD100"..arg:GetFrameStrata())
		ChatFrame1:AddMessage("Level: |cffFFD100"..arg:GetFrameLevel())

		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f",xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f",yOfs))
		end
		if relativeTo and relativeTo:GetName() then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		ChatFrame1:AddMessage("|cffCC0000----------------------------")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end
SLASH_FRAME1 = "/frame"

--	Frame Stack on Cyrillic
SlashCmdList.FSTACK = function()
	SlashCmdList.FRAMESTACK(0)
end
SLASH_FSTACK1 = "/аыефсл"
SLASH_FSTACK2 = "/fs"
SLASH_FSTACK3 = "/аы"

-- Clear Chat
SlashCmdList.CLEARCHAT = function(cmd)
	cmd = cmd and strtrim(strlower(cmd))
	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame"..i]
		if f:IsVisible() or cmd == "all" then
			f:Clear()
		end
	end
end
SLASH_CLEARCHAT1 = "/cc"
SLASH_CLEARCHAT2 = "/clearchat"

-- Test Blizzard Alert Frames
SlashCmdList.TEST_ACHIEVEMENT = function()
	PlaySound("LFG_Rewards")
	if not AchievementFrame then
		AchievementFrame_LoadUI()
	end
	AchievementAlertFrame_ShowAlert(229)
	AchievementAlertFrame_ShowAlert(1707)
end
SLASH_TEST_ACHIEVEMENT1 = "/testa"

-- Grid on screen
local grid
SlashCmdList.GRIDONSCREEN = function()
	if grid then
		grid:Hide()
		grid = nil
	else
		grid = CreateFrame("Frame", nil, UIParent)
		grid:SetAllPoints(UIParent)
		local width = GetScreenWidth() / 128
		local height = GetScreenHeight() / 72
		for i = 0, 128 do
			local texture = grid:CreateTexture(nil, "BACKGROUND")
			if i == 64 then
				texture:SetTexture(1, 0, 0, 0.8)
			else
				texture:SetTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", i * width - 1, 0)
			texture:SetPoint("BOTTOMRIGHT", grid, "BOTTOMLEFT", i * width, 0)
		end
		for i = 0, 72 do
			local texture = grid:CreateTexture(nil, "BACKGROUND")
			if i == 36 then
				texture:SetTexture(1, 0, 0, 0.8)
			else
				texture:SetTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", 0, -i * height)
			texture:SetPoint("BOTTOMRIGHT", grid, "TOPRIGHT", 0, -i * height - 1)
		end
	end
end
SLASH_GRIDONSCREEN1 = "/align"
SLASH_GRIDONSCREEN2 = "/grid"

-- Obatin CPU Impact for KkthnxUI (From ElvUI)
local num_frames = 0;
local function OnUpdate()
	num_frames = num_frames + 1;
end
local f = CreateFrame("Frame")
f:Hide()
f:SetScript("OnUpdate", OnUpdate)

local toggleMode = false;
SlashCmdList.GETCPUIMPACT = function()
	if(not toggleMode) then
		ResetCPUUsage()
		num_frames = 0;
		debugprofilestart()
		f:Show()
		toggleMode = true;
		print("|cffffff00CPU Impact being calculated, type /cpuimpact to get results when you are ready.|r")
	else
		f:Hide()
		local ms_passed = debugprofilestop()
		UpdateAddOnCPUUsage()

		print("|cffffff00Consumed " .. (GetAddOnCPUUsage("KkthnxUI") / num_frames) .. " milliseconds per frame. Each frame took " .. (ms_passed / num_frames) .. " to render.|r")
		toggleMode = false;
	end
end
SLASH_GETCPUIMPACT1 = "/cpuimpact"
SLASH_GETCPUIMPACT2 = "/cpu"

-- Reduce video settings to optimize performance (by eP)
SlashCmdList["BOOST"] = function()
	SetCVar("ffx", 0)
	SetCVar("hwPCF", 1)
	SetCVar("shadowLOD", 0)
	SetCVar("timingmethod", 1)
	SetCVar("showfootprints", 0)
	SetCVar("showfootprintparticles", 0)
	SetCVar("farclip", 600)
	SetCVar("groundeffectdensity", 16)
	SetCVar("groundeffectdist", 1)
	SetCVar("skycloudlod", 1)
	SetCVar("extshadowquality", 0)
	SetCVar("environmentDetail", 0.5)
	SetCVar("m2Faster", 1)
end
SLASH_BOOST1 = "/boost"