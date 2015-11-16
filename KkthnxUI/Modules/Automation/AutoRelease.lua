local K, C, L = unpack(select(2, ...));
if C["automation"].resurrection ~= true then return end

-- Auto resurrection
local WINTERGRASP
WINTERGRASP = L_ZONE_WINTERGRASP

local autoreleasepvp = CreateFrame("frame")
autoreleasepvp:RegisterEvent("PLAYER_DEAD")
autoreleasepvp:SetScript("OnEvent", function(self, event)
	local soulstone = GetSpellInfo(20707)
	if (K.Class ~= "SHAMAN") or not (soulstone and UnitBuff("player", soulstone)) then
		if (tostring(GetZoneText()) == WINTERGRASP) then
			RepopMe()
		end
		if MiniMapBattlefieldFrame.status == "active" then
			RepopMe()
		end
	end
end)