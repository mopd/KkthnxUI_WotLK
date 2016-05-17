local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true or C["actionbar"].selfcast ~= true then return end

local _G = _G
local ipairs = ipairs
local CreateFrame = CreateFrame
local UIParent = UIParent
local InCombatLockdown = InCombatLockdown
local UnitAffectingCombat = UnitAffectingCombat
local IsLoggedIn = IsLoggedIn

local bars = {
	"MainMenuBarArtFrame",
	"MultiBarBottomLeft",
	"MultiBarBottomRight",
	"MultiBarRight",
	"MultiBarLeft",
	"PossessBarFrame",
}

local SelfCast = CreateFrame("frame", "RightClickSelfCast", UIParent)
SelfCast:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function SelfCast:PLAYER_REGEN_ENABLED()
	self:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self.PLAYER_REGEN_ENABLED = nil
end

function SelfCast:PLAYER_LOGIN()

	-- if we load/reload in combat don't try to set secure attributes or we get action_blocked errors
	if InCombatLockdown() or UnitAffectingCombat("player") then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	-- Blizzard bars
	for i, v in ipairs(bars) do
		local bar = _G[v]
		if bar ~= nil then
			bar:SetAttribute("unit2", "player")
		end
	end

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil

end

if IsLoggedIn() then SelfCast:PLAYER_LOGIN() else SelfCast:RegisterEvent("PLAYER_LOGIN") end