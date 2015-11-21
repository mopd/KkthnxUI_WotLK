local K, C, L = unpack(select(2, ...));

local AddonManager = CreateFrame("frame", "Addons", UIParent)
AddonManager:SetWidth(450)
AddonManager:SetHeight(450)
AddonManager:SetPoint("CENTER")
AddonManager:EnableMouse(true)
AddonManager:SetMovable(true)
AddonManager:SetUserPlaced(true)
AddonManager:SetClampedToScreen(true)
AddonManager:SetScript("OnMouseDown", function(self) self:StartMoving() end)
AddonManager:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
AddonManager:SetFrameStrata("DIALOG")
tinsert(UISpecialFrames, "Addons")

local RLButton = function(text,parent)
	local result = CreateFrame("Button", "btn_", parent, "UIPanelButtonTemplate")
	result:SetText("ReloadUI")
	return result
end

local CloseButton = function(text,parent)
	local result = CreateFrame("Button", "btn2_"..parent:GetName(), parent, "UIPanelButtonTemplate")
	result:SetText(text)
	return result
end

AddonManager:Hide()
AddonManager:SetScript("OnHide", function(self) end)
AddonManager:SetBackdropColor(0.05, 0.05, 0.05, .9)
CreateStyle(AddonManager, 2)

local title = AddonManager:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", 0, -8)
title:SetText("|cffff8000AddonManager|r")

local ScrollFrame = CreateFrame("ScrollFrame", "AddonsScrollFrame", AddonManager, "UIPanelScrollFrameTemplate")
local MainAddonFrame = CreateFrame("frame", "AddonsFrame", ScrollFrame)

ScrollFrame:SetPoint("TOPLEFT", AddonManager, "TOPLEFT", 10, -30)
ScrollFrame:SetPoint("BOTTOMRIGHT", AddonManager, "BOTTOMRIGHT", -28, 40)
ScrollFrame:SetScrollChild(MainAddonFrame)

local reloadb = RLButton(SAVE, AddonManager)
reloadb:SetWidth(105)
reloadb:SetHeight(20)
reloadb:SetPoint("BOTTOMRIGHT", AddonManager, "BOTTOM", -2, 9)
reloadb:SetScript("OnClick", function() ReloadUI() end)

local closeb = CloseButton(CLOSE, AddonManager)
closeb:SetWidth(105)
closeb:SetHeight(20)
closeb:SetPoint("TOPLEFT" , reloadb, "TOPRIGHT", 4, 0)
closeb:SetScript("OnClick", function() AddonManager:Hide() end)

local makeList = function()
	local self = MainAddonFrame
	K.CreateBackdrop(ScrollFrame)
    self:SetPoint("TOPLEFT")
    self:SetWidth(ScrollFrame:GetWidth())
    self:SetHeight(ScrollFrame:GetHeight())
	self.addons = {}
	for i=1, GetNumAddOns() do
		self.addons[i] = select(1, GetAddOnInfo(i))
	end
	table.sort(self.addons)

	local oldb

	for i,v in pairs(self.addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)

		if name then
			local bf = _G[v.."_cbf"] or CreateFrame("CheckButton", v.."_cbf", self, "OptionsCheckButtonTemplate")
			bf:EnableMouse(true)
			bf.title = title.."|n"
			if notes then bf.title = bf.title.."|cffffffff"..notes.."|r|n" end
			if (GetAddOnDependencies(v)) then
				bf.title = "|cffff4400Dependencies: |r"
				for i=1, select("#", GetAddOnDependencies(v)) do
					bf.title = bf.title..select(i,GetAddOnDependencies(v))
					if (i>1) then bf.title=bf.title..", " end
				end
				bf.title = bf.title.."|r"
			end
				
			if i==1 then
				bf:SetPoint("TOPLEFT",self, "TOPLEFT", 10, -10)
			else
				bf:SetPoint("TOP", oldb, "BOTTOM", 0, 6)
			end
	
			bf:SetScript("OnEnter", function(self)
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(self, ANCHOR_TOPRIGHT)
				GameTooltip:AddLine(self.title)
				GameTooltip:Show()
			end)
			
			bf:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)
			
			bf:SetScript("OnClick", function()
				local _, _, _, enabled = GetAddOnInfo(name)
				if enabled then
					DisableAddOn(name)
				else
					EnableAddOn(name)
				end
			end)
			bf:SetChecked(enabled)
			
			_G[v.."_cbfText"]:SetText(title) 
			oldb = bf
		end
	end
end

makeList()

-- Credits to Bunny67
local enableAllButton = CreateFrame("Button", "$parentEnableAllButton", AddonManager, "UIPanelButtonTemplate");
enableAllButton:SetSize(105, 20);
enableAllButton:SetPoint("RIGHT" , reloadb, "LEFT", 0, 0)
enableAllButton:SetText("Enable All");

enableAllButton:SetScript("OnClick", function()
	EnableAllAddOns();
	makeList();
end);

local disableAllButton = CreateFrame("Button", "$parentDisableAllButton", AddonManager, "UIPanelButtonTemplate");
disableAllButton:SetSize(105, 20);
disableAllButton:SetPoint("LEFT" , closeb, "RIGHT", 0, 0)
disableAllButton:SetText("Disable All");

disableAllButton:SetScript("OnClick", function()
	DisableAllAddOns();
	makeList();
end);

-- Slash command
SLASH_ALOAD1 = "/addons"
SlashCmdList.ALOAD = function(msg)
   AddonManager:Show()
end

local showb = CreateFrame("Button", "GameMenuButtonAddonManager", GameMenuFrame, "GameMenuButtonTemplate")
showb:SetText("Addons")
showb:SetPoint("TOP", "GameMenuFrame", "TOP", 0, -49)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + showb:GetHeight())
	
showb:SetScript("OnClick", function()
	HideUIPanel(GameMenuFrame)
	AddonManager:Show()
end)