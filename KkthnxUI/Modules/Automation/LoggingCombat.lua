local K, C, L, _ = unpack(select(2, ...))
if C["automation"].logging_combat ~= true then return end

local IsInInstance = IsInInstance
local CreateFrame = CreateFrame

-- Auto enables combat log text file in raid instances(EasyLogger by Sildor)
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
	local _, instanceType = IsInInstance()
	if instanceType and instanceType == "raid" then
		if not LoggingCombat() then
			LoggingCombat(1)
			K.Print("|cffffff00"..COMBATLOGENABLED.."|r")
		end
	else
		if LoggingCombat() then
			LoggingCombat(0)
			K.Print("|cffffff00"..COMBATLOGDISABLED.."|r")
		end
	end
end)