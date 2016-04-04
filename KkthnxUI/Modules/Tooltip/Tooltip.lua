local K, C, L = unpack(select(2, ...));
if C["tooltip"].enable ~= true then return end

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(200, 40)
anchor:SetPoint(unpack(C["position"].tooltip))

-- Texture tooltips
local tooltips = {
	GameTooltip,
	ItemRefTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ShoppingTooltip1,
	ShoppingTooltip2,
	DropDownList1MenuBackdrop,
	DropDownList2MenuBackdrop,
	FriendsTooltip,
	WorldMapTooltip,
}

for _, tt in pairs(tooltips) do
	tt:SetBackdrop(K.Backdrop)
	tt:HookScript("OnShow", function(self)
		self:SetBackdropColor(0.05, 0.05, 0.05, .9)
		if C["blizzard"].dark_textures == true then
			self:SetBackdropBorderColor(unpack(C["blizzard"].dark_textures_color));
		else
			self:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
		end
		
	end)
end

LFDSearchStatus:SetFrameStrata("TOOLTIP")

-- Hide PVP text
PVP_ENABLED = ""

-- Statusbar
GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:SetPoint("LEFT",4,0)
GameTooltipStatusBar:SetPoint("RIGHT",-4,0)
GameTooltipStatusBar:SetPoint("BOTTOM",GameTooltipStatusBar:GetParent(),"TOP",0,-8)
GameTooltipStatusBar:SetHeight(5)
-- gametooltip statusbar bg
GameTooltipStatusBar.bg = GameTooltipStatusBar:CreateTexture(nil,"BACKGROUND",nil,-8)
GameTooltipStatusBar.bg:SetPoint("TOPLEFT",-0,0)
GameTooltipStatusBar.bg:SetPoint("BOTTOMRIGHT",0,-0)
GameTooltipStatusBar.bg:SetTexture(1,1,1)
GameTooltipStatusBar.bg:SetVertexColor(1/3, 1/3, 1/3)

-- Some tooltip changes
if C["tooltip"].fontoutline == true then
	GameTooltipHeaderText:SetFont(C["font"].tooltip_font, C["font"].tooltip_font_size + 2, C["font"].tooltip_font_style)
	GameTooltipHeaderText:SetShadowOffset(0, 0)
	GameTooltipText:SetFont(C["font"].tooltip_font, C["font"].tooltip_font_size, C["font"].tooltip_font_style)
	GameTooltipText:SetShadowOffset(0, 0)
	GameTooltipTextSmall:SetFont(C["font"].tooltip_font, C["font"].tooltip_font_size - 1, C["font"].tooltip_font_style)
	GameTooltipTextSmall:SetShadowOffset(0, 0)
else
	GameTooltipHeaderText:SetFont(C["font"].tooltip_font, C["font"].tooltip_font_size + 2)
	GameTooltipText:SetFont(C["font"].tooltip_font, C["font"].tooltip_font_size)
	GameTooltipTextSmall:SetFont(C["font"].tooltip_font, C["font"].tooltip_font_size - 1)
end

-- Itemquaility border
if C["tooltip"].qualitybordercolor == true then
	for _, tooltip in pairs({
		GameTooltip,
		ItemRefTooltip,
		
		ShoppingTooltip1,
		ShoppingTooltip2,
		ShoppingTooltip3,
	}) do
		tooltip:HookScript('OnTooltipSetItem', function(self)
			local name, item = self:GetItem()
			if (item) then
				local quality = select(3, GetItemInfo(item))
				if (quality) then
					local r, g, b = GetItemQualityColor(quality)
					self:SetBackdropBorderColor(r, g, b)
				end
			end
		end)
		
		tooltip:HookScript('OnTooltipCleared', function(self)
			--self:SetBackdropBorderColor(.7, .7, .7, 1)
		end)
	end
end

-- Unit tooltip styling
Tooltip = CreateFrame("Frame", "Tooltip", UIParent)
Tooltip:RegisterEvent("ADDON_LOADED")
Tooltip:SetScript("OnEvent", function(self, event, addon)
	if addon == "QuestHelper" then self.QH_found = true end
	if addon ~= "KkthnxUI" then return end
	
	local function GameTooltipDefault(tooltip, parent)
		if C["tooltip"].cursor == true then
			tooltip:SetOwner(parent, "ANCHOR_CURSOR")
		else
			tooltip:SetOwner(parent, "ANCHOR_NONE")
			tooltip:ClearAllPoints()
			tooltip:SetPoint("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
			tooltip.default = 1;
		end
	end
	hooksecurefunc("GameTooltip_SetDefaultAnchor", GameTooltipDefault)
	
	if C["tooltip"].shiftmodifer == true then
		local ShiftShow = function()
			if IsShiftKeyDown() then
				GameTooltip:Show()
			else
				if not HoverBind.enabled then
					GameTooltip:Hide()
				end
			end
		end
		GameTooltip:SetScript("OnShow", ShiftShow)
		local EventShow = function()
			if arg1 == "LSHIFT" and arg2 == 1 then
				GameTooltip:Show()
			elseif arg1 == "LSHIFT" and arg2 == 0 then
				GameTooltip:Hide()
			end
		end
		local sh = CreateFrame("Frame")
		sh:RegisterEvent("MODIFIER_STATE_CHANGED")
		sh:SetScript("OnEvent", EventShow)
	else
		if C["tooltip"].cursor == true then
			hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
				if InCombatLockdown() and C["tooltip"].hide_combat and not IsShiftKeyDown() then
					self:Hide()
				else
					self:SetOwner(parent, "ANCHOR_CURSOR_RIGHT", 20, 20)
				end
			end)
		else
			hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self)
				if InCombatLockdown() and C["tooltip"].hide_combat and not IsShiftKeyDown() then
					self:Hide()
				else
					self:SetPoint("BOTTOMRIGHT", TooltipAnchor, "BOTTOMRIGHT", 0, 0)
				end
			end)
		end
	end
	
	if C["tooltip"].healthvalue == true then
		GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
			if not value then
				return
			end
			local min, max = self:GetMinMaxValues()
			if (value < min) or (value > max) then
				return
			end
			self:SetStatusBarColor(0, 1, 0)
			local unit = select(2, GameTooltip:GetUnit())
			if unit then
				min, max = UnitHealth(unit), UnitHealthMax(unit)
				if not self.text then
					self.text = self:CreateFontString(nil, "OVERLAY")
					self.text:SetPoint("CENTER", GameTooltipStatusBar, 0, 10)
					if C["tooltip"].fontoutline == true then
						self.text:SetFont(C["media"].normal_font, 11, "OUTLINE")
						self.text:SetShadowColor(0, 0, 0, 0)
						self.text:SetShadowOffset(0, -0)
					else
						self.text:SetFont(C["media"].normal_font, 11)
						self.text:SetShadowColor(0, 0, 0, 1)
						self.text:SetShadowOffset(1, -1)
					end
				end
				self.text:Show()
				local hp = K.ShortValue(min).." / "..K.ShortValue(max)
				self.text:SetText(hp)
			end
		end)
	end	
	
	local OnTooltipSetUnit = function(self)
		local lines = self:NumLines()
		local name, unit = self:GetUnit()
		
		if not unit then return end
		
		local race = UnitRace(unit)
		local level = UnitLevel(unit)
		local levelColor = GetQuestDifficultyColor(level)
		local classification = UnitClassification(unit)
		local creatureType = UnitCreatureType(unit)
		
		if level and level == -1 then
			if classification == "worldboss" then
				level = "|cffff0000|r"..BOSS
			else
				level = "|cffff0000??|r"
			end
		end
		
		if classification == "rareelite" then classification = " R+"
		elseif classification == "rare" then classification = " R"
		elseif classification == "elite" then classification = "+"
	else classification = "" end
		
		if not C["tooltip"].title then _G["GameTooltipTextLeft1"]:SetText(name) end
		
		if(UnitIsPlayer(unit)) then
			if(GetGuildInfo(unit)) then
				_G["GameTooltipTextLeft2"]:SetFormattedText("%s", GetGuildInfo(unit))
				_G["GameTooltipTextLeft2"]:SetTextColor(0, 1, 1)
			end
			
			local n = GetGuildInfo(unit) and 3 or 2
			-- thx TipTac for the fix above with color blind enabled
			if GetCVar("colorblindMode") == "1" then n = n + 1 end
			_G["GameTooltipTextLeft"..n]:SetFormattedText("|cff%02x%02x%02x%s|r %s", levelColor.r*255, levelColor.g*255, levelColor.b*255, level, race)
			
		else
			for i = 2, lines do
				local line = _G["GameTooltipTextLeft"..i]
				if not line or not line:GetText() then return end -- damn QuestHelper!
				if (level and line:GetText():find("^"..LEVEL)) or (creatureType and line:GetText():find("^"..creatureType)) then
					local r, g, b = GameTooltip_UnitColor(unit)
					line:SetFormattedText("|cff%02x%02x%02x%s%s|r %s", levelColor.r*255, levelColor.g*255, levelColor.b*255, level, classification, creatureType or "")
					break
				end
			end
		end
		
		if C["tooltip"].target == true and UnitExists(unit.."target") then
			local r, g, b = GameTooltip_UnitColor(unit.."target")
			local text = ""
			
			if UnitIsEnemy("player", unit.."target") then
				r, g, b = 1, 0, 0
			elseif not UnitIsFriend("player", unit.."target") then
				r, g, b = 1, 1, 0
			end
			
			if UnitName(unit.."target") == UnitName("player") then
				text = "|cfffed100"..STATUS_TEXT_TARGET..":|r ".."|cffff0000> "..UNIT_YOU.." <|r"
			else
				text = "|cfffed100"..STATUS_TEXT_TARGET..":|r "..UnitName(unit.."target")
			end
			
			self:AddLine(text, r, g, b)
		end
	end
	
	GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
end)

function GameTooltip_UnitColor(unit)
	local r, g, b
	
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) or UnitIsDead(unit) then
		r, g, b = 0.6, 0.6, 0.6
	else
		local reaction = UnitReaction(unit, "player")
		if reaction then
			r, g, b = FACTION_BAR_COLORS[reaction].r, FACTION_BAR_COLORS[reaction].g, FACTION_BAR_COLORS[reaction].b
		else
			r, g, b = 1, 1, 1
		end
	end
	
	return r, g, b
end

-- Target Talents(TipTacTalents by Aezay)
if C["tooltip"].talents == true then
	local gtt = GameTooltip;
	local GetTalentTabInfo = GetTalentTabInfo;
	
	-- Locals
	local ttt = CreateFrame("Frame", "TipTacTalents");
	local cache = {};
	local current = {};
	local TALENTS_PREFIX = TALENTS..":|cffffffff ";
	local CACHE_SIZE = 25;		-- Change cache size here (Default 25)
	
	-- Allow these to be accessed through other addons
	ttt.cache = cache;
	ttt.current = current;
	
	-- GatherTalents
	local function GatherTalents(isInspect)
		-- Inspect functions will always use the active spec when not inspecting
		local group = GetActiveTalentGroup(isInspect);
		-- Get points per tree, and set "maxTree" to the tree with most points
		local maxTree, _ = 1;
		for i = 1, 3 do
			_, _, current[i] = GetTalentTabInfo(i,isInspect,nil,group);
			if (current[i] > current[maxTree]) then
				maxTree = i;
			end
		end
		current.tree = GetTalentTabInfo(maxTree,isInspect,nil,group);
		-- Customise output. Use TipTac setting if it exists, otherwise just use formatting style one.
		local talentFormat = (TipTac_Config and TipTac_Config.talentFormat or 1);
		if (current[maxTree] == 0) then
			current.format = L_TOOLTIP_NO_TALENT;
		elseif (talentFormat == 1) then
			current.format = current.tree.." ("..current[1].."/"..current[2].."/"..current[3]..")";
		elseif (talentFormat == 2) then
			current.format = current.tree;
		elseif (talentFormat == 3) then
			current.format = current[1].."/"..current[2].."/"..current[3];
		end
		-- Set the tips line output, for inspect, only update if the tip is still showing a unit!
		if (not isInspect) then
			gtt:AddLine(TALENTS_PREFIX..current.format);
		elseif (gtt:GetUnit()) then
			for i = 2, gtt:NumLines() do
				if ((_G["GameTooltipTextLeft"..i]:GetText() or ""):match("^"..TALENTS_PREFIX)) then
					_G["GameTooltipTextLeft"..i]:SetFormattedText("%s%s",TALENTS_PREFIX,current.format);
					-- Do not call Show() if the tip is fading out, this only works with TipTac, if TipTacTalents are used alone, it might still bug the fadeout
					if (not gtt.fadeOut) then
						gtt:Show();
					end
					break;
				end
			end
		end
		-- Organise Cache
		local cacheSize = (TipTac_Config and TipTac_Config.talentCacheSize or CACHE_SIZE);
		for i = #cache, 1, -1 do
			if (current.name == cache[i].name) then
				tremove(cache,i);
				break;
			end
		end
		if (#cache > cacheSize) then
			tremove(cache,1);
		end
		-- Cache the new entry
		if (cacheSize > 0) then
			cache[#cache + 1] = CopyTable(current);
		end
	end
	
	-- OnEvent
	ttt:SetScript("OnEvent",function(self,event)
		self:UnregisterEvent("INSPECT_TALENT_READY");
		if (gtt:GetUnit() == current.name) then
			GatherTalents(1);
		end
	end);
	
	-- HOOK: OnTooltipSetUnit
	gtt:HookScript("OnTooltipSetUnit",function(self,...)
		-- Get the unit -- Check the UnitFrame unit if this tip is from a concated unit, such as "targettarget".
		local _, unit = self:GetUnit();
		if (not unit) then
			local mFocus = GetMouseFocus();
			if (mFocus) and (mFocus.unit) then
				unit = mFocus.unit;
			end
		end
		-- Only for players over level 9 -- Ignore PvP flagged people, unless they are friendly
		if (UnitIsPlayer(unit)) and (UnitLevel(unit) > 9 or UnitLevel(unit) == -1) and (CanInspect(unit)) then
			wipe(current);
			current.name = UnitName(unit);
			-- Player
			if (UnitIsUnit(unit,"player")) then
				GatherTalents();
				-- Others
			else
				local allowInspect = (not InspectFrame or not InspectFrame:IsShown()) and (not Examiner or not Examiner:IsShown());
				if (allowInspect) then
					ttt:RegisterEvent("INSPECT_TALENT_READY");
					NotifyInspect(unit);
				end
				for _, entry in ipairs(cache) do
					if (current.name == entry.name) then
						self:AddLine(TALENTS_PREFIX..entry.format);
						current.tree = entry.tree;
						current.format = entry.format;
						current[1], current[2], current[3] = entry[1], entry[2], entry[3];
						return;
					end
				end
				if (allowInspect) then
					self:AddLine(TALENTS_PREFIX..L_TOOLTIP_LOADING);
				end
			end
		end
	end);
end

-- Your achievement status in tooltip(Enhanced Achievements by Syzgyn)
if C["tooltip"].achievements == true then
	local colors = {
		["GREEN"] = {
			["r"] = 0.25,
			["g"] = 0.75,
			["b"] = 0.25,
		},
		["GRAY"] = {
			["r"] = 0.5,
			["g"] = 0.5,
			["b"] = 0.5,
		},
	}
	
	local function hookSetHyperlink(tooltip, refString)
		local achievementID, numCriteria, GUID, name, completed, quantity, reqQuantity, month, day, year
		local output = {[0] = {}, [1] = {}}
		if select(3, string.find(refString, "(%a-):")) ~= "achievement" then return end
		
		achievementID = select(3, string.find(refString, ":(%d+):"))
		numCriteria = GetAchievementNumCriteria(achievementID)
		GUID = select(3, string.find(refString, ":%d+:(.-):"))
		
		if GUID == string.sub(UnitGUID("player"), 3) then 
			tooltip:Show()
			return 
		end
		
		tooltip:AddLine(" ")
		_,_,_,completed, month, day, year = GetAchievementInfo(achievementID)
		
		if completed then
			if year < 10 then year = "0" .. year end
			
			tooltip:AddLine(L_TOOLTIP_ACH_COMPLETE .. month .. "/" .. day .. "/" .. year, 0,1,0)
		elseif numCriteria == 0 then
			tooltip:AddLine(L_TOOLTIP_ACH_INCOMPLETE)
		else
			tooltip:AddLine(L_TOOLTIP_ACH_STATUS)
			for i=1, numCriteria, 2 do
				for a=0, 1 do
					output[a].text = nil
					output[a].color = nil
					if i+a <= numCriteria then
						name,_,completed,quantity,reqQuantity = GetAchievementCriteriaInfo(achievementID, i+a)
						if completed then
							output[a].text = name
							output[a].color = "GREEN"
						else
							if quantity < reqQuantity and reqQuantity > 1 then
								output[a].text = name .. " (" .. quantity .. "/" .. reqQuantity .. ")"
								output[a].color = "GRAY"
							else
								output[a].text = name
								output[a].color = "GRAY"
							end
						end
					else
						output[a].text = nil
					end
				end
				if output[1].text == nil then
					tooltip:AddLine(output[0].text, colors[output[0].color].r, colors[output[0].color].g, colors[output[0].color].b)
				else
					tooltip:AddDoubleLine(output[0].text, output[1].text, colors[output[0].color].r, colors[output[0].color].g, colors[output[0].color].b, colors[output[1].color].r, colors[output[1].color].g, colors[output[1].color].b)
				end
				output = {[0] = {}, [1] = {}}
			end
		end
		tooltip:Show()
	end
	
	hooksecurefunc(ItemRefTooltip, "SetHyperlink", hookSetHyperlink)
end

-- Adds guild rank to tooltips(GuildRank by Meurtcriss)
if C["tooltip"].rank == true then
	local GTT = GameTooltip
	-- HOOK: OnTooltipSetUnit
	GTT:HookScript("OnTooltipSetUnit",function(self,...)
		-- Get the unit
		local _, unit = self:GetUnit()
		if not unit then
			local mFocus = GetMouseFocus()
			if mFocus and mFocus.unit then
				unit = mFocus.unit
			end
		end
		-- Get and display guild rank
		if UnitIsPlayer(unit) then
			local guildName, guildRank = GetGuildInfo(unit)
			if guildName then
				self:AddLine(RANK..": |cFFFFFFFF"..guildRank.."|r")
			end
		end
	end)
end

-- Hide tooltips in combat for action bars, pet bar and shapeshift bar
if C["tooltip"].hidebuttons == true then
	local CombatHideActionButtonsTooltip = function(self)
		if not IsShiftKeyDown() then
			self:Hide()
		end
	end
	
	hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
end

-- Arena function(ArenaExp by Fernir)
if C["tooltip"].arenaexperience == true then
	local isGTTActive = false
	local GTT = _G["GameTooltip"]
	-- settings start 
	local needStatistic = {
		370, -- Highest 2 man personal rating
		595, -- Highest 3 man personal rating
		596, -- Highest 5 man personal rating
	}
	local needAchievements = {
		401, -- 2000 arena rating in 2x2
		404, -- 2000 arena rating in 5x5
		405, -- 2000 arena rating in 3x3
		1161, -- 2200 arena rating in 5x5
		1159, -- 2200 arena rating in 2x2
		1160, -- 2200 arena rating in 3x3
		2091, -- gladiator
	}
	--settings end 
	
	strGradient = function(val, low, high)
		local percent, r, g
		if (high > low) then 
			percent = val/(high-low)
		else 
			percent = 1-val/(low-high) 
		end
		if (percent > 1) then percent = 1 end
		if (percent < 0) then percent = 0 end
		if (percent < 0.5) then 
			r, g = 1, 2*percent
		else
			r, g = (1-percent)*2, 1
		end
		return format("|cff%02x%02x%02x%s|r", r*255, g*255, 0, val) 
	end 
	
	
	local skillf = CreateFrame("frame")
	skillf:RegisterEvent("ADDON_LOADED")
	skillf:SetScript("OnEvent",function(self,event,...)
		if event == "ADDON_LOADED" then
			if arg1 == ... then
				skillf:UnregisterEvent("ADDON_LOADED")
				GTT:HookScript("OnTooltipSetUnit", function()
					if InCombatLockdown() and InCombatLockdown() == 1 then return end
					if AchievementFrame and AchievementFrame:IsShown() then return end
					
					self.unit = select(2, GTT:GetUnit())
					if not UnitIsPlayer(self.unit) then return end
					
					if _G.GearScore then
						_G.GearScore:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
					end
					ClearAchievementComparisonUnit()
					skillf:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
					SetAchievementComparisonUnit(self.unit)
				end)
				GTT:HookScript("OnTooltipCleared", function()
					if skillf:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") and skillf:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") then
						skillf:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
					end
					isGTTActive = false
				end)
			end
		elseif event == "INSPECT_ACHIEVEMENT_READY" then
			if not GetComparisonAchievementPoints() then return end
			
			isGTTActive = false
			
			for indx, Achievement in pairs(needAchievements) do
				local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText = GetAchievementInfo(Achievement)
				if GetAchievementComparisonInfo(Achievement) then
					GTT:AddLine(Name)
					GTT:AddTexture(Image)
					isGTTActive = true
				end
			end
			
			for indx, Achievement in pairs(needStatistic) do
				if GetComparisonStatistic(Achievement) ~= "--" then
					GTT:AddDoubleLine(select(2,GetAchievementInfo(Achievement)), strGradient(tonumber(GetComparisonStatistic(Achievement)), 0, 2200))
					isGTTActive = true
				end
			end
			
			if isGTTActive then GTT:Show() end
			
			if _G.GearScore then
				_G.GearScore:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
			end
			
			skillf:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
			ClearAchievementComparisonUnit()
		end
	end)
end

-- Fix compare tooltips(by Elv22)
hooksecurefunc("GameTooltip_ShowCompareItem", function(self, shift)
	if not self then
		self = GameTooltip
	end
	local item, link = self:GetItem()
	if not link then return end
	
	local shoppingTooltip1, shoppingTooltip2, shoppingTooltip3 = unpack(self.shoppingTooltips)
	
	local item1 = nil
	local item2 = nil
	local item3 = nil
	local side = "left"
	if shoppingTooltip1:SetHyperlinkCompareItem(link, 1, shift, self) then
		item1 = true
	end
	if shoppingTooltip2:SetHyperlinkCompareItem(link, 2, shift, self) then
		item2 = true
	end
	if shoppingTooltip3:SetHyperlinkCompareItem(link, 3, shift, self) then
		item3 = true
	end
	
	-- Find correct side
	local rightDist = 0
	local leftPos = self:GetLeft()
	local rightPos = self:GetRight()
	if not rightPos then
		rightPos = 0
	end
	if not leftPos then
		leftPos = 0
	end
	
	rightDist = GetScreenWidth() - rightPos
	
	if leftPos and (rightDist < leftPos) then
		side = "left"
	else
		side = "right"
	end
	
	-- See if we should slide the tooltip
	if self:GetAnchorType() and self:GetAnchorType() ~= "ANCHOR_PRESERVE" then
		local totalWidth = 0
		
		if item1 then
			totalWidth = totalWidth + shoppingTooltip1:GetWidth()
		end
		if item2 then
			totalWidth = totalWidth + shoppingTooltip2:GetWidth()
		end
		if item3 then
			totalWidth = totalWidth + shoppingTooltip3:GetWidth()
		end
		
		if side == "left" and totalWidth > leftPos then
			self:SetAnchorType(self:GetAnchorType(), totalWidth - leftPos, 0)
		elseif side == "right" and (rightPos + totalWidth) > GetScreenWidth() then
			self:SetAnchorType(self:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0)
		end
	end
	
	-- Anchor the compare tooltips
	if item3 then
		shoppingTooltip3:SetOwner(self, "ANCHOR_NONE")
		shoppingTooltip3:ClearAllPoints()
		if side and side == "left" then
			shoppingTooltip3:SetPoint("TOPRIGHT", self, "TOPLEFT", -3, -10)
		else
			shoppingTooltip3:SetPoint("TOPLEFT", self, "TOPRIGHT", 3, -10)
		end
		shoppingTooltip3:SetHyperlinkCompareItem(link, 3, shift, self)
		shoppingTooltip3:Show()
	end
	
	if item1 then
		if item3 then
			shoppingTooltip1:SetOwner(shoppingTooltip3, "ANCHOR_NONE")
		else
			shoppingTooltip1:SetOwner(self, "ANCHOR_NONE")
		end
		shoppingTooltip1:ClearAllPoints()
		if side and side == "left" then
			if item3 then
				shoppingTooltip1:SetPoint("TOPRIGHT", shoppingTooltip3, "TOPLEFT", -3, 0)
			else
				shoppingTooltip1:SetPoint("TOPRIGHT", self, "TOPLEFT", -3, -10)
			end
		else
			if item3 then
				shoppingTooltip1:SetPoint("TOPLEFT", shoppingTooltip3, "TOPRIGHT", 3, 0)
			else
				shoppingTooltip1:SetPoint("TOPLEFT", self, "TOPRIGHT", 3, -10)
			end
		end
		shoppingTooltip1:SetHyperlinkCompareItem(link, 1, shift, self)
		shoppingTooltip1:Show()
		
		if item2 then
			shoppingTooltip2:SetOwner(shoppingTooltip1, "ANCHOR_NONE")
			shoppingTooltip2:ClearAllPoints()
			if side and side == "left" then
				shoppingTooltip2:SetPoint("TOPRIGHT", shoppingTooltip1, "TOPLEFT", -3, 0)
			else
				shoppingTooltip2:SetPoint("TOPLEFT", shoppingTooltip1, "TOPRIGHT", 3, 0)
			end
			shoppingTooltip2:SetHyperlinkCompareItem(link, 2, shift, self)
			shoppingTooltip2:Show()
		end
	end
end)

-- Proper color for world objects tooltip
local function BackdropFix(self)
	if self:GetAnchorType() == "ANCHOR_CURSOR" and self:IsOwned(UIParent) and not self:GetUnit() then
		self:SetBackdropColor(0.05, 0.05, 0.05, .9)
	end
end

if C["tooltip"].cursor ~= true and C["tooltip"].shiftmodifer ~= true then 
	GameTooltip:HookScript("OnUpdate", BackdropFix)
end