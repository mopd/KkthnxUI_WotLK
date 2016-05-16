local K, C, L, _ = select(2, ...):unpack()

local collectgarbage = collectgarbage
local UnitIsAFK = UnitIsAFK
local CreateFrame = CreateFrame

-- Collect garbage
local CollectGarbage = CreateFrame("Frame")
function CollectGarbage:OnEvent(event, unit)
	if (event == "PLAYER_ENTERING_WORLD") then
		collectgarbage("collect")

		self:UnregisterEvent(event)
	else
		if (unit ~= "player") then
			return
		end

		if UnitIsAFK(unit) then
			collectgarbage("collect")
		end
	end
end

CollectGarbage:SetScript("OnEvent", CollectGarbage.OnEvent)
CollectGarbage:RegisterEvent("PLAYER_FLAGS_CHANGED")
CollectGarbage:RegisterEvent("PLAYER_ENTERING_WORLD")