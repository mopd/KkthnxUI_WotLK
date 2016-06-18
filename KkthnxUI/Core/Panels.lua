local K, C, L, _ = select(2, ...):unpack()

local unpack = unpack
local _G = _G
local CreateFrame = CreateFrame
local UIParent = UIParent

--	Bottom bars anchor
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", UIParent)
bottombaranchor:CreatePanel("Invisible", 1, 1, unpack(C["position"].bottom_bars))
bottombaranchor:SetWidth((C["ActionBar"].Button_Size * 12) + (C["ActionBar"].Button_Space * 11))
if C["ActionBar"].BottomBars == 2 then
	bottombaranchor:SetHeight((C["ActionBar"].Button_Size * 2) + C["ActionBar"].Button_Space)
elseif C["ActionBar"].BottomBars == 3 then
	if C["ActionBar"].SplitBars == true then
		bottombaranchor:SetHeight((C["ActionBar"].Button_Size * 2) + C["ActionBar"].Button_Space)
	else
		bottombaranchor:SetHeight((C["ActionBar"].Button_Size * 3) + (C["ActionBar"].Button_Space * 2))
	end
else
	bottombaranchor:SetHeight(C["ActionBar"].Button_Size)
end
bottombaranchor:SetFrameStrata("LOW")

--	Right bars anchor
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", UIParent)
rightbaranchor:CreatePanel("Invisible", 1, 1, unpack(C["position"].right_bars))
rightbaranchor:SetHeight((C["ActionBar"].Button_Size * 12) + (C["ActionBar"].Button_Space * 11))
if C["ActionBar"].RightBars == 1 then
	rightbaranchor:SetWidth(C["ActionBar"].Button_Size)
elseif C["ActionBar"].RightBars == 2 then
	rightbaranchor:SetWidth((C["ActionBar"].Button_Size * 2) + C["ActionBar"].Button_Space)
elseif C["ActionBar"].RightBars == 3 then
	rightbaranchor:SetWidth((C["ActionBar"].Button_Size * 3) + (C["ActionBar"].Button_Space * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("LOW")

--	Split bar anchor
if C["ActionBar"].SplitBars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", UIParent)
	SplitBarLeft:CreatePanel("Invisible", (C["ActionBar"].Button_Size * 3) + (C["ActionBar"].Button_Space * 2), (C["ActionBar"].Button_Size * 2) + C["ActionBar"].Button_Space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -C["ActionBar"].Button_Space, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", UIParent)
	SplitBarRight:CreatePanel("Invisible", (C["ActionBar"].Button_Size * 3) + (C["ActionBar"].Button_Space * 2), (C["ActionBar"].Button_Size * 2) + C["ActionBar"].Button_Space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", C["ActionBar"].Button_Space, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

--	Pet bar anchor
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", UIParent)
if C["ActionBar"].PetBar_Horizontal == true then
	petbaranchor:CreatePanel("Invisible", (C["ActionBar"].Button_Size * 10) + (C["ActionBar"].Button_Space * 9), (C["ActionBar"].Button_Size + C["ActionBar"].Button_Space), unpack(C["position"].pet_horizontal))
elseif C["ActionBar"].RightBars > 0 then
	petbaranchor:CreatePanel("Invisible", C["ActionBar"].Button_Size + 3, (C["ActionBar"].Button_Size * 10) + (C["ActionBar"].Button_Space * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
else
	petbaranchor:CreatePanel("Invisible", (C["ActionBar"].Button_Size + C["ActionBar"].Button_Space), (C["ActionBar"].Button_Size * 10) + (C["ActionBar"].Button_Space * 9), unpack(C["position"].right_bars))
end
petbaranchor:SetFrameStrata("LOW")
RegisterStateDriver(petbaranchor, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")

--	Stance bar anchor
local ShiftHolder = CreateFrame("Frame", "ShiftHolder", UIParent)
if C["ActionBar"].StanceBar_Horizontal == true then
	ShiftHolder:SetPoint(unpack(C["position"].stance_bar))
	ShiftHolder:SetWidth((C["ActionBar"].Button_Size * 7) + (C["ActionBar"].Button_Space * 6))
	ShiftHolder:SetHeight(C["ActionBar"].Button_Size)
else
	if (PetActionBarFrame:IsShown() or PetHolder) and C["ActionBar"].PetBar_Horizontal ~= true then
		ShiftHolder:SetPoint("RIGHT", "PetHolder", "LEFT", -C["ActionBar"].Button_Space, (C["ActionBar"].Button_Size / 2) + 1)
	else
		ShiftHolder:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", -C["ActionBar"].Button_Space, (C["ActionBar"].Button_Size / 2) + 1)
	end
	ShiftHolder:SetWidth(C["ActionBar"].Button_Size)
	ShiftHolder:SetHeight((C["ActionBar"].Button_Size * 7) + (C["ActionBar"].Button_Space * 6))
end