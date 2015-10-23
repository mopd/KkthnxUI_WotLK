local K, C, L, _ = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------

local frf = CreateFrame("FRAME",UIParent)
function FrameRangeFade_OnUpdate(self,...)
--  UnitInRange only works if target or focus is in your party/raid.
		if not UnitInRange("target") and UnitInParty("target") then TargetFrame:SetAlpha(0.5) else if TargetFrame:GetAlpha() < 1 then TargetFrame:SetAlpha(1) end end
		if not UnitInRange("focus") and UnitInParty("focus") then FocusFrame:SetAlpha(0.5) else if FocusFrame:GetAlpha() < 1 then FocusFrame:SetAlpha(1) end end
	if GetNumPartyMembers() == 1 and GetNumRaidMembers() == 0 then
		for i=1,4,1 do
			if not UnitInRange("party"..i) then _G["PartyMemberFrame"..i]:SetAlpha(0.5) else if _G["PartyMemberFrame"..i]:GetAlpha() < 1 then _G["PartyMemberFrame"..i]:SetAlpha(1) end end
			if not UnitInRange("partypet"..i) then _G["PartyMemberFrame"..i.."PetFrame"]:SetAlpha(0.5) else if _G["PartyMemberFrame"..i.."PetFrame"]:GetAlpha() < 1 then _G["PartyMemberFrame"..i.."PetFrame"]:SetAlpha(1) end end
		end
	end
end
frf:SetScript("OnUpdate", FrameRangeFade_OnUpdate)

--[[ test
if GetNumPartyMembers() == 1 then
    DEFAULT_CHAT_FRAME:AddMessage ("I am in some kind of Group.");
else
    DEFAULT_CHAT_FRAME:AddMessage ("I am not in any kind of Group.");
end
]]--