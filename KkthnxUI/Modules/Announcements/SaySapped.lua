local K, C, L, _ = unpack(select(2, ...))
if C["announcements"].saysapped ~= true then return end

local SendChatMessage = SendChatMessage
local CreateFrame = CreateFrame

-- Say Sapped
local SaySapped = CreateFrame("Frame")
SaySapped:SetScript("OnEvent", function()
	if ((arg7 == K.Name)
	and (arg2 == "SPELL_AURA_APPLIED" or arg2 == "SPELL_AURA_REFRESH")
	and (arg9 == 51724 or arg9 == 11297 or arg9 == 2070 or arg9 == 6770))
	then
		SendChatMessage("Sapped", "SAY")
	end
end)

SaySapped:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")