﻿local K, C, L, _ = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Based on Doom Cooldown Pulse, editor Affli
----------------------------------------------------------------------------------------
--if not SettingsCF["cooldown"].pulse_enable == true then return end

--local K.noscalemult = SettingsDB.mult * SettingsCF["general"].uiscale
local fadeInTime, fadeOutTime, maxAlpha, animScale, iconSize, holdTime
local cooldowns, animating, watching = { }, { }, { }
local GetTime = GetTime

local DCP = CreateFrame("frame")
DCP:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

local DCPT = DCP:CreateTexture(nil,"ARTWORK")
DCPT:SetTexCoord(0.1, 0.9, 0.1, 0.9)

DCPT:SetPoint("TOPLEFT", DCP, "TOPLEFT", K.noscalemult * 2, -K.noscalemult * 2)
DCPT:SetPoint("BOTTOMRIGHT", DCP, "BOTTOMRIGHT", -K.noscalemult * 2, K.noscalemult * 2)
K.CreateBackdrop(DCP)
DCP:SetBackdropColor(0.05, 0.05, 0.05, 1)
DCP:SetBackdropBorderColor(.7, .7, .7, 1)

-----------------------
-- Utility Functions --
-----------------------
local function tcount(tab)
	local n = 0
	for _ in pairs(tab) do
		n = n + 1
	end
	return n
end

local function GetPetActionIndexByName(name)
	for i = 1, NUM_PET_ACTION_SLOTS, 1 do
		if (GetPetActionInfo(i) == name) then
			return i
		end
	end
	return nil
end

local function RefreshLocals()
	fadeInTime = 0.5
	fadeOutTime = 0.7
	maxAlpha = 1
	animScale = 1.5
	iconSize = 40 -- Change to C.misc.pulsecdisize
	holdTime = 0
end

--------------------------
-- Cooldown / Animation --
--------------------------
local elapsed = 0
local runtimer = 0
local function OnUpdate(_,update)
	elapsed = elapsed + update
	if (elapsed > 0.05) then
		for i,v in pairs(watching) do
			if (GetTime() >= v[1] + 0.5) then
				local start, duration, enabled, texture, isPet
				if (v[2] == "spell") then
					texture = GetSpellTexture(v[3])
					start, duration, enabled = GetSpellCooldown(v[3])
				elseif (v[2] == "item") then
					texture = v[3]
					start, duration, enabled = GetItemCooldown(i)
				elseif (v[2] == "pet") then
					texture = select(3,GetPetActionInfo(v[3]))
					start, duration, enabled = GetPetActionCooldown(v[3])
					isPet = true
				end
				if (enabled ~= 0) then
					if (duration and duration > 2.0 and texture) then
						cooldowns[i] = { start, duration, texture, isPet }
					end
				end
				if (not (enabled == 0 and v[2] == "spell")) then
					watching[i] = nil
				end
			end
		end
		for i,v in pairs(cooldowns) do
			local remaining = v[2]-(GetTime()-v[1])
			if (remaining <= 0) then
				tinsert(animating, {v[3],v[4]})
				cooldowns[i] = nil
			end
		end
        
		elapsed = 0
		if (#animating == 0 and tcount(watching) == 0 and tcount(cooldowns) == 0) then
			DCP:SetScript("OnUpdate", nil)
			return
		end
	end
    
	if (#animating > 0) then
		runtimer = runtimer + update
		if (runtimer > (fadeInTime + holdTime + fadeOutTime)) then
			tremove(animating,1)
			runtimer = 0
			DCPT:SetTexture(nil)
			DCPT:SetVertexColor(1,1,1)
			DCP:SetBackdropBorderColor(0,0,0,0)
			DCP:SetBackdropColor(0,0,0,0)
		else
			if (not DCPT:GetTexture()) then
				DCPT:SetTexture(animating[1][1])
				if animating[1][2] then
					DCPT:SetVertexColor(1,1,1)
				end
			end
			local alpha = maxAlpha
			if (runtimer < fadeInTime) then
				alpha = maxAlpha * (runtimer / fadeInTime)
			elseif (runtimer >= fadeInTime + holdTime) then
				alpha = maxAlpha - ( maxAlpha * ((runtimer - holdTime - fadeInTime) / fadeOutTime))
			end
			DCP:SetAlpha(alpha)
			local scale = iconSize+(iconSize*((animScale-1)*(runtimer/(fadeInTime+holdTime+fadeOutTime))))
			DCP:SetWidth(scale)
			DCP:SetHeight(scale)
			DCP:SetBackdropColor(0.05, 0.05, 0.05, 1)
			DCP:SetBackdropBorderColor(.7, .7, .7, 1)
		end
	end
end

--------------------
-- Event Handlers --
--------------------
function DCP:ADDON_LOADED(addon)
	RefreshLocals()
	self:SetPoint(unpack(C["position"].pulsecooldown))
	self:UnregisterEvent("ADDON_LOADED")
end
DCP:RegisterEvent("ADDON_LOADED")

function DCP:UNIT_SPELLCAST_SUCCEEDED(unit,spell,rank)
	if (unit == "player") then
		watching[spell] = {GetTime(),"spell",spell.."("..rank..")"}
		if (not self:IsMouseEnabled()) then
			self:SetScript("OnUpdate", OnUpdate)
		end
	end
end
DCP:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

function DCP:COMBAT_LOG_EVENT_UNFILTERED(...)
	local _,event,_,_,sourceFlags,_,_,_,spellID = ...
	if (event == "SPELL_CAST_SUCCESS") then
		if (bit.band(sourceFlags,COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags,COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
			local name = GetSpellInfo(spellID)
			local index = GetPetActionIndexByName(name)
			if (index and not select(7,GetPetActionInfo(index))) then
				watching[name] = {GetTime(),"pet",index}
			elseif (not index and name) then
				watching[name] = {GetTime(),"spell",name}
			else
				return
			end
			if (not self:IsMouseEnabled()) then
				self:SetScript("OnUpdate", OnUpdate)
			end
		end
	end
end
PetActionButton1:HookScript("OnShow", function() DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end)
PetActionButton1:HookScript("OnHide", function() DCP:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end)

function DCP:PLAYER_ENTERING_WORLD()
	local inInstance,instanceType = IsInInstance()
	if (inInstance and instanceType == "arena") then
		self:SetScript("OnUpdate", nil)
		wipe(cooldowns)
		wipe(watching)
	end
end
DCP:RegisterEvent("PLAYER_ENTERING_WORLD")

hooksecurefunc("UseAction", function(slot)
	local actionType,itemID = GetActionInfo(slot)
	if (actionType == "item") then
		local texture = GetActionTexture(slot)
		watching[itemID] = {GetTime(),"item",texture}
	end
end)

hooksecurefunc("UseInventoryItem", function(slot)
	local itemID = GetInventoryItemID("player", slot);
	if (itemID) then
		local texture = GetInventoryItemTexture("player", slot)
		watching[itemID] = {GetTime(),"item",texture}
	end
end)

hooksecurefunc("UseContainerItem", function(bag,slot)
	local itemID = GetContainerItemID(bag, slot)
	if (itemID) then
		local texture = select(10, GetItemInfo(itemID))
		watching[itemID] = {GetTime(),"item",texture}
	end
end)