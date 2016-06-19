local K, C, L, _ = select(2, ...):unpack()
if C["ActionBar"].Enable ~= true then return end

local _G = _G
local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame
local UIParent = UIParent

-- Create bar
local bar = CreateFrame("Frame", "PetHolder", UIParent, "SecureHandlerStateTemplate")
if C["ActionBar"].PetBar_Hide then bar:SetScale(0.000001) bar:SetAlpha(0) PetActionBarAnchor:Hide() return end
bar:SetAllPoints(PetActionBarAnchor)
bar:RegisterEvent("PET_BAR_HIDE")
bar:RegisterEvent("PET_BAR_UPDATE")
bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
bar:RegisterEvent("PET_BAR_UPDATE_USABLE")
bar:RegisterEvent("PLAYER_CONTROL_GAINED")
bar:RegisterEvent("PLAYER_CONTROL_LOST")
bar:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("UNIT_AURA")
bar:RegisterEvent("UNIT_FLAGS")
bar:RegisterEvent("UNIT_PET")
bar:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_LOGIN" then
		K.StylePet()
		--PetActionBar_ShowGrid = K.Noop
		--PetActionBar_HideGrid = K.Noop
		--PetActionBarFrame.showgrid = nil

		PetActionBarFrame:UnregisterEvent("PET_BAR_SHOWGRID")
		PetActionBarFrame:UnregisterEvent("PET_BAR_HIDEGRID")
		PetActionBarFrame.showgrid = 1
		for i = 1, 10 do
			local button = _G["PetActionButton"..i]
			button:ClearAllPoints()
			button:SetParent(PetHolder)
			button:SetSize(C["ActionBar"].Button_Size, C["ActionBar"].Button_Size)
			if i == 1 then
				if C["ActionBar"].PetBar_Horizontal == true then
					button:SetPoint("BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", 0, 0)
				end
			else
				if C["ActionBar"].PetBar_Horizontal == true then
					button:SetPoint("LEFT", _G["PetActionButton"..i-1], "RIGHT", C["ActionBar"].Button_Space, 0)
				else
					button:SetPoint("TOP", _G["PetActionButton"..i-1], "BOTTOM", 0, -C["ActionBar"].Button_Space)
				end
			end
			button:Show()
			self:SetAttribute("addchild", button)
		end
		RegisterStateDriver(self, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")
		hooksecurefunc("PetActionBar_Update", K.PetBarUpdate)
	elseif event == "PET_BAR_UPDATE" or event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED"
	or event == "UNIT_FLAGS" or (event == "UNIT_PET" and arg1 == "player") or (arg1 == "pet" and event == "UNIT_AURA") then
		K.PetBarUpdate()
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		PetActionBar_UpdateCooldowns()
	end
end)