local K, C, L, _ = select(2, ...):unpack()

local unpack = unpack
local _G = _G
local CreateFrame = CreateFrame
local UIParent = UIParent

--	Bottom bars anchor
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", UIParent)
bottombaranchor:CreatePanel("Invisible", 1, 1, unpack(C["position"].bottom_bars))
bottombaranchor:SetWidth((C["actionbar"].button_size * 12) + (C["actionbar"].button_space * 11))
if C["actionbar"].bottombars == 2 then
	bottombaranchor:SetHeight((C["actionbar"].button_size * 2) + C["actionbar"].button_space)
elseif C["actionbar"].bottombars == 3 then
	if C["actionbar"].split_bars == true then
		bottombaranchor:SetHeight((C["actionbar"].button_size * 2) + C["actionbar"].button_space)
	else
		bottombaranchor:SetHeight((C["actionbar"].button_size * 3) + (C["actionbar"].button_space * 2))
	end
else
	bottombaranchor:SetHeight(C["actionbar"].button_size)
end
bottombaranchor:SetFrameStrata("LOW")

--	Right bars anchor
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", UIParent)
rightbaranchor:CreatePanel("Invisible", 1, 1, unpack(C["position"].right_bars))
rightbaranchor:SetHeight((C["actionbar"].button_size * 12) + (C["actionbar"].button_space * 11))
if C["actionbar"].rightbars == 1 then
	rightbaranchor:SetWidth(C["actionbar"].button_size)
elseif C["actionbar"].rightbars == 2 then
	rightbaranchor:SetWidth((C["actionbar"].button_size * 2) + C["actionbar"].button_space)
elseif C["actionbar"].rightbars == 3 then
	rightbaranchor:SetWidth((C["actionbar"].button_size * 3) + (C["actionbar"].button_space * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("LOW")

--	Split bar anchor
if C["actionbar"].split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", UIParent)
	SplitBarLeft:CreatePanel("Invisible", (C["actionbar"].button_size * 3) + (C["actionbar"].button_space * 2), (C["actionbar"].button_size * 2) + C["actionbar"].button_space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -C["actionbar"].button_space, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", UIParent)
	SplitBarRight:CreatePanel("Invisible", (C["actionbar"].button_size * 3) + (C["actionbar"].button_space * 2), (C["actionbar"].button_size * 2) + C["actionbar"].button_space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", C["actionbar"].button_space, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

--	Pet bar anchor
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", UIParent)
if C["actionbar"].petbar_horizontal == true then
	petbaranchor:CreatePanel("Invisible", (C["actionbar"].button_size * 10) + (C["actionbar"].button_space * 9), (C["actionbar"].button_size + C["actionbar"].button_space), unpack(C["position"].pet_horizontal))
elseif C["actionbar"].rightbars > 0 then
	petbaranchor:CreatePanel("Invisible", C["actionbar"].button_size + 3, (C["actionbar"].button_size * 10) + (C["actionbar"].button_space * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
else
	petbaranchor:CreatePanel("Invisible", (C["actionbar"].button_size + C["actionbar"].button_space), (C["actionbar"].button_size * 10) + (C["actionbar"].button_space * 9), unpack(C["position"].right_bars))
end
petbaranchor:SetFrameStrata("LOW")
RegisterStateDriver(petbaranchor, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")

--	Stance bar anchor
local ShiftHolder = CreateFrame("Frame", "ShiftHolder", UIParent)
if C["actionbar"].stancebar_horizontal == true then
	ShiftHolder:SetPoint(unpack(C["position"].stance_bar))
	ShiftHolder:SetWidth((C["actionbar"].button_size * 7) + (C["actionbar"].button_space * 6))
	ShiftHolder:SetHeight(C["actionbar"].button_size)
else
	if (PetActionBarFrame:IsShown() or PetHolder) and C["actionbar"].petbar_horizontal ~= true then
		ShiftHolder:SetPoint("RIGHT", "PetHolder", "LEFT", -C["actionbar"].button_space, (C["actionbar"].button_size / 2) + 1)
	else
		ShiftHolder:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", -C["actionbar"].button_space, (C["actionbar"].button_size / 2) + 1)
	end
	ShiftHolder:SetWidth(C["actionbar"].button_size)
	ShiftHolder:SetHeight((C["actionbar"].button_size * 7) + (C["actionbar"].button_space * 6))
end