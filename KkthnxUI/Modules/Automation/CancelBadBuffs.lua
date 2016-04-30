local K, C, L, _ = unpack(select(2, ...))
if C["automation"].cancel_bad_buffs ~= true then return end

local print = print
local next = next

local CreateFrame = CreateFrame
local GetSpellLink = GetSpellLink
local InCombatLockdown = InCombatLockdown
local UnitBuff = UnitBuff

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(self, event, unit)
	if unit ~= "player" then return end

	if event == "UNIT_AURA" and not InCombatLockdown() then
		for buff, enabled in next, K.BadBuffs do
			if UnitBuff(unit, buff) and enabled then
				CancelUnitBuff(unit, buff)
				print("|cff3AA0E9"..ACTION_SPELL_AURA_REMOVED.."|r "..(GetSpellLink(buff) or ("|cffE8CB3B["..buff.."]|r")).."|cffE8CB3B.|r")
			end
		end
	end
end)