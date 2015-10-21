local K, C, L, _ = unpack(select(2, ...))

local function SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[K.Class]
	self:SetBackdropColor(K.Color.r, K.Color.g, K.Color.b, 0.1)
	self:SetBackdropBorderColor(K.Color.r, K.Color.g, K.Color.b)
end

local function SetOriginalBackdrop(self)
	self:SetBackdropColor(0.05, 0.05, 0.05, 1)
	self:SetBackdropBorderColor(.7, .7, .7, 1)
end

local loadf = CreateFrame("Frame", "aLoadFrame", UIParent)
loadf:SetWidth(400)
loadf:SetHeight(400)
loadf:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 312)
loadf:EnableMouse(true)
loadf:SetMovable(true)
loadf:SetUserPlaced(true)
loadf:SetClampedToScreen(true)
loadf:SetScript("OnMouseDown", function(self) self:StartMoving() end)
loadf:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
loadf:SetFrameStrata("DIALOG")
tinsert(UISpecialFrames, "aLoadFrame")
loadf:SetBackdrop(K.Backdrop)
loadf:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
loadf:SetBackdropBorderColor(.7, .7, .7, 1)
loadf:Hide()

local title = loadf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", 0, -8)
title:SetText('|cFF4488FFKkthnx|r|cFFFEB200UI|r Addon List')

local scrollf = CreateFrame("ScrollFrame", "aLoadScroll", loadf, "UIPanelScrollFrameTemplate")
local mainf = CreateFrame("Frame", nil, scrollf)

scrollf:SetPoint("TOPLEFT", loadf, "TOPLEFT", 10, -30)
scrollf:SetPoint("BOTTOMRIGHT", loadf, "BOTTOMRIGHT", -28, 40)
scrollf:SetScrollChild(mainf)
scrollf:SetFrameStrata("FULLSCREEN")
K.CreateBackdrop(scrollf)

local reloadb = CreateFrame("Button", nil, loadf, "UIPanelButtonTemplate")
reloadb:SetWidth(150)
reloadb:SetHeight(22)
reloadb:SetPoint("BOTTOM", 0, 10)
reloadb:SetText(L_ALOAD_RL)
reloadb:SetScript("OnClick", function() ReloadUI() end)
reloadb:SetNormalTexture("")
reloadb:SetHighlightTexture("")
reloadb:SetPushedTexture("")
reloadb:SetBackdrop(K.Backdrop)
reloadb:SetBackdropColor(0.05, 0.05, 0.05, 1)
reloadb:SetBackdropBorderColor(.7, .7, .7, 1)
reloadb:HookScript("OnEnter", SetModifiedBackdrop)
reloadb:HookScript("OnLeave", SetOriginalBackdrop)

local closeb = CreateFrame("Button", nil, loadf, "UIPanelCloseButton")
closeb:SetPoint("TOPRIGHT", loadf, "TOPRIGHT", 2, 0)
closeb:SetScript("OnClick", function()
	loadf:Hide()
end)

local makeList = function()
	local self = mainf
	scrollf:SetBackdropColor(0.05, 0.05, 0.05, 1)
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
			local bf = _G[v.."_cbf"] or CreateFrame("Button", v.."_cbf", self)
			if i == 1 then
				bf:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
				bf:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, -20)
			else
				bf:SetPoint("TOPLEFT", oldb, "BOTTOMLEFT", 0, 0)
				bf:SetPoint("BOTTOMRIGHT", oldb, "BOTTOMRIGHT", 0, -20)
			end
			
			bf:EnableMouse(true)
			
			bf:SetBackdrop({
				bgFile = "Interface\\Buttons\\WHITE8x8",
			})
			bf:SetBackdropColor(0.05, 0.05, 0.05, 1)
	
			local maketool = function(self, v)
				local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(self, ANCHOR_TOPRIGHT)
				
				local s = title.."|n"
				if notes then s = s.."|cffffffff"..notes.."|r|n" end
				if (GetAddOnDependencies(v)) then
					s ="|cffff4400Dependencies: "
					for i = 1, select("#", GetAddOnDependencies(v)) do
						s = s..select(i, GetAddOnDependencies(v))
						if (i > 1) then s=s..", " end
					end
					s = s.."|r"
				end
				GameTooltip:AddLine(s,_,_,_,1)
				GameTooltip:Show()
			end
			
			bf:SetScript("OnEnter", function(self)
				self:SetBackdropColor(K.Color.r, K.Color.g, K.Color.b, .25)
				maketool(self, v)
			end)
			
			bf:SetScript("OnLeave", function(self)
				self:SetBackdropColor(0.05, 0.05, 0.05, 1)
				GameTooltip:Hide()
			end)
			
			oldb = bf

			local cb = _G[v.."_cb"] or CreateFrame("CheckButton", v.."_cb", bf, "OptionsCheckButtonTemplate")
			cb:SetWidth(24)
			cb:SetHeight(24)
			cb:SetScript("OnClick", function()
				local _, _, _, enabled = GetAddOnInfo(name)
				if enabled then
					DisableAddOn(name)
				else
					EnableAddOn(name)
				end
			end)
			cb:SetChecked(enabled)
			cb:SetPoint("LEFT", 4, 0)

			cb:SetScript("OnEnter", function()
				bf:SetBackdropColor(K.Color.r, K.Color.g, K.Color.b, .25)
				maketool(cb, v)
			end)
			
			cb:SetScript("OnLeave", function()
				bf:SetBackdropColor(0.05, 0.05, 0.05, 1)
				GameTooltip:Hide()
			end)
			
			local fs = _G[v.."_fs"] or bf:CreateFontString(v.."_fs", "OVERLAY", "GameFontNormal")
			fs:SetText(title)
			
			fs:SetJustifyH("LEFT")
			fs:SetPoint("TOPLEFT", cb, "TOPRIGHT", 0, 0)
			fs:SetPoint("BOTTOMRIGHT", bf, "BOTTOMRIGHT", 0, 0)
			
			bf:SetScript("OnClick", function(self)
				cb:Click()
			end)
		end
	end
end

makeList()

-- Slash command
SLASH_ALOAD1 = "/aload"
SLASH_ALOAD2 = "/al"
SlashCmdList["ALOAD"] = function (msg)
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
guib:SetText("|cFF4488FFKkthnx|r|cFFFEB200UI|r")
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