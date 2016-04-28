local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true or C["actionbar"].micromenu ~= true then return end

local unpack, pairs = unpack, pairs

local CreateFrame = CreateFrame
local UIParent = UIParent
local hooksecurefunc = hooksecurefunc

local MicroMenu = CreateFrame("Frame", "MicroMenuHolder", UIParent)
MicroMenu:SetWidth(253)
MicroMenu:SetHeight(37)
MicroMenu:SetPoint(unpack(C["position"].micromenu))
MicroMenu:Show()

local MicroButtons = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	SocialsMicroButton,
	PVPMicroButton,
	LFDMicroButton,
	MainMenuMicroButton,
	HelpMicroButton,
}

local function MoveMicroButtons(skinName)
	for _, f in pairs(MicroButtons) do
		f:SetParent(MicroMenu)
    end
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("BOTTOMLEFT", -1, 0)
	SocialsMicroButton:ClearAllPoints()
	SocialsMicroButton:SetPoint("LEFT", QuestLogMicroButton, "RIGHT", -3, 0)
end
hooksecurefunc("VehicleMenuBar_MoveMicroButtons", MoveMicroButtons); 
MoveMicroButtons()

local function showhidemicro(alpha)
	for _, frame in pairs(MicroButtons) do
		frame:SetAlpha(alpha)
	end
end

if C["actionbar"].micromenumouseover == true and C["actionbar"].micromenuhide ~= true then
	MicroMenu:EnableMouse(true)
	MicroMenu:SetScript("OnEnter", function(self) showhidemicro(1) end)
	MicroMenu:SetScript("OnLeave", function(self) showhidemicro(0) end)  
	for _, f in pairs(MicroButtons) do
		f:SetAlpha(0)
		f:HookScript("OnEnter", function(self) showhidemicro(1) end)
		f:HookScript("OnLeave", function(self) showhidemicro(0) end)
	end
end

if C["actionbar"].micromenuhide == true then
	MicroMenu:SetScale(0.001)
	MicroMenu:SetAlpha(0)
end