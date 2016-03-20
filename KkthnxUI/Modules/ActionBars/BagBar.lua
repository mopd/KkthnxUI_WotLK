local K, C, L = unpack(select(2, ...));
if C["actionbar"].enable ~= true or C["actionbar"].bagsbar ~= true then return end

local BagsBar = CreateFrame("Frame", "BagHolder", UIParent)
BagsBar:SetWidth(198)
BagsBar:SetHeight(39)
BagsBar:SetPoint(unpack(C["position"].bagsbar))
BagsBar:Show()

local BagButtons = {
	MainMenuBarBackpackButton,
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
	KeyRingButton,
} 

local function MoveBagButtons()
	for _, f in pairs(BagButtons) do
		f:SetParent(BagsBar)
	end
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", -1, 2)
end 
MoveBagButtons();

local function showhidebags(alpha)
	for _, frame in pairs(BagButtons) do
		frame:SetAlpha(alpha)
	end
end

if C["actionbar"].bagsmouseover == true and C["actionbar"].bagshide ~= true then
	BagsBar:EnableMouse(true)
	BagsBar:SetScript("OnEnter", function(self) showhidebags(1) end)
	BagsBar:SetScript("OnLeave", function(self) showhidebags(0) end) 
	for _, f in pairs(BagButtons) do
		f:SetAlpha(0)
		f:HookScript("OnEnter", function(self) showhidebags(1) end)
		f:HookScript("OnLeave", function(self) showhidebags(0) end)
	end 
end

if C["actionbar"].bagshide == true then
	BagsBar:SetScale(0.001)
	BagsBar:SetAlpha(0)
end