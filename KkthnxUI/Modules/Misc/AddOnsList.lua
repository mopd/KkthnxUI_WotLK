local K, C, L, _ = unpack(select(2, ...))

local loadf = CreateFrame("frame", "aLoadFrame", UIParent)
loadf:SetWidth(400)
loadf:SetHeight(450)
loadf:SetPoint("CENTER")
loadf:EnableMouse(true)
loadf:SetMovable(true)
loadf:SetUserPlaced(true)
loadf:SetClampedToScreen(true)
loadf:SetScript("OnMouseDown", function(self) self:StartMoving() end)
loadf:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
loadf:SetFrameStrata("DIALOG")
tinsert(UISpecialFrames, "aLoadFrame")

local stylef = function(f)
CreateStyle(f, 4)
end

local RLButton = function(text,parent)
	local result = CreateFrame("Button", "btn_"..parent:GetName(), parent, "UIPanelButtonTemplate")
	result:SetText(text)
	return result
end

local CloseButton = function(text,parent)
	local result = CreateFrame("Button", "btn2_"..parent:GetName(), parent, "UIPanelButtonTemplate")
	result:SetText(text)
	return result
end

stylef(loadf)
loadf:Hide()
loadf:SetScript("OnHide", function(self) end)
loadf:SetResizable(false)
loadf:SetBackdropColor(0.05, 0.05, 0.05, .9)
K.CreateBackdrop(loadf)

local title = loadf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOPLEFT", 10, -8)
title:SetText("AddOn Manager")

local scrollf = CreateFrame("ScrollFrame", "aload_Scroll", loadf, "UIPanelScrollFrameTemplate")
local mainf = CreateFrame("frame", "aloadmainf", scrollf)

scrollf:SetPoint("TOPLEFT", loadf, "TOPLEFT", 10, -30)
scrollf:SetPoint("BOTTOMRIGHT", loadf, "BOTTOMRIGHT", -28, 40)
scrollf:SetScrollChild(mainf)

local reloadb = RLButton(SAVE, loadf)
reloadb:SetWidth(105)
reloadb:SetHeight(20)
reloadb:SetPoint("BOTTOMRIGHT", loadf, "BOTTOM", -2, 9)
reloadb:SetScript("OnClick", function() ReloadUI() end)

local closeb = CloseButton(CLOSE, loadf)
closeb:SetWidth(105)
closeb:SetHeight(20)
closeb:SetPoint("TOPLEFT" , reloadb, "TOPRIGHT", 4, 0)
closeb:SetScript("OnClick", function() loadf:Hide() end)

local makeList = function()
	local self = mainf
	stylef(scrollf)
   self:SetPoint("TOPLEFT")
   self:SetWidth(scrollf:GetWidth())
   self:SetHeight(scrollf:GetHeight())
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
			
			bf:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", })
			bf:SetBackdropColor(0,0,0,0)
	
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
local enableAllButton = CreateFrame("Button", "$parentEnableAllButton", loadf, "UIPanelButtonTemplate");
enableAllButton:SetSize(105, 20);
enableAllButton:SetPoint("TOP" , reloadb, "BOTTOM", 0, -4)
enableAllButton:SetText("Enable All");

enableAllButton:SetScript("OnClick", function()
	EnableAllAddOns();
	makeList();
end);

local disableAllButton = CreateFrame("Button", "$parentDisableAllButton", loadf, "UIPanelButtonTemplate");
disableAllButton:SetSize(105, 20);
disableAllButton:SetPoint("TOP" , closeb, "BOTTOM", 0, -4)
disableAllButton:SetText("Disable All");

disableAllButton:SetScript("OnClick", function()
	DisableAllAddOns();
	makeList();
end);

-- Slash command
SLASH_ALOAD1 = "/addons"
SLASH_ALOAD2 = "/alist"
SlashCmdList.ALOAD = function(msg)
   loadf:Show()
end

local showb = CreateFrame("Button", "GameMenuButtonAddonManager", GameMenuFrame, "GameMenuButtonTemplate")
showb:SetText(ADDONS)
showb:SetPoint("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -1)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + showb:GetHeight())
GameMenuButtonSoundOptions:SetPoint("TOP", showb, "BOTTOM", 0, -1)

showb:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	loadf:Show()
end)

if not IsAddOnLoaded("KkthnxUI_Config") then return end
local guib = CreateFrame("Button", "GameMenuButtonSettingsGUI", GameMenuFrame, "GameMenuButtonTemplate")
guib:SetText("|cFF4488FFKkthnx|r|cFFffd100UI|r")
guib:SetPoint("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -23)

GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + guib:GetHeight())
GameMenuButtonSoundOptions:SetPoint("TOP", guib, "BOTTOM", 0, -1)

guib:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not UIConfig or not UIConfig:IsShown() then
		CreateUIConfig()
	else
		UIConfig:Hide()
	end
end)