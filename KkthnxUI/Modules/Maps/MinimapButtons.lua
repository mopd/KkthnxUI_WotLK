local K, C, L = unpack(select(2, ...));
if C["minimap"].enable ~= true or C["minimap"].collectbuttons ~= true then return end

--[[-----------------------------------
Collect minimap buttons in one line
---------------------------------------]]
local BlackList = {
	["MiniMapTracking"] = true,
	["MiniMapVoiceChatFrame"] = true,
	["MiniMapWorldMapButton"] = true,
	["MiniMapLFGFrame"] = true,
	["MinimapZoomIn"] = true,
	["MinimapZoomOut"] = true,
	["MiniMapMailFrame"] = true,
	["BattlefieldMinimap"] = true,
	["MinimapBackdrop"] = true,
	["GameTimeFrame"] = true,
	["TimeManagerClockButton"] = true,
	["FeedbackUIButton"] = true,
	["HelpOpenTicketButton"] = true,
	["MiniMapBattlefieldFrame"] = true,
	["QueueStatusMinimapButton"] = true,
	["MinimapButtonCollectFrame"] = true,
}

local buttons = {}
local button = CreateFrame("Frame", "ButtonCollectFrame", UIParent)
local line = math.ceil(C["minimap"].size / 20)

local function PositionAndStyle()
	button:SetSize(20, 20)
	button:SetPoint(unpack(C["position"].minimap_buttons))
	for i = 1, #buttons do
		buttons[i]:ClearAllPoints()
		if i == 1 then
			buttons[i]:SetPoint("TOP", button, "TOP", 0, 0)
		elseif i == line then
			buttons[i]:SetPoint("TOPRIGHT", buttons[1], "TOPLEFT", -1, 0)
		else
			buttons[i]:SetPoint("TOP", buttons[i-1], "BOTTOM", 0, -1)
		end
		buttons[i].ClearAllPoints = K.Dummy
		buttons[i].SetPoint = K.Dummy
		buttons[i]:SetAlpha(0.1)
		buttons[i]:HookScript("OnEnter", function()
			buttons[i]:FadeIn()
		end)
		buttons[i]:HookScript("OnLeave", function()
			buttons[i]:FadeOut()
		end)
	end
end

local collect = CreateFrame("Frame")
collect:RegisterEvent("PLAYER_ENTERING_WORLD")
collect:SetScript("OnEvent", function(self)
	for i, child in ipairs({Minimap:GetChildren()}) do
		if not BlackList[child:GetName()] then
			if child:GetObjectType() == "Button" and child:GetNumRegions() >= 3 and child:IsShown() then
				child:SetParent(button)
				tinsert(buttons, child)
			end
		end
	end
	if #buttons == 0 then
		button:Hide()
	end
	PositionAndStyle()
end)

--[[-----------------------------------
Skin minimap buttons
---------------------------------------]]
local buttons = {
	"MiniMapBattlefieldFrame",
	"MiniMapTrackingButton",
	"MiniMapMailFrame",
	"HelpOpenTicketButton",
	"GatherMatePin",
	"HandyNotesPin",
	"TimeManagerClockButton"
}

local function SkinButton(f)
	if not f or f:GetObjectType() ~= "Button" then return end
	
	for i, buttons in pairs(buttons) do
		if f:GetName() ~= nil then
			if f:GetName():match(buttons) then return end
		end
	end
	
	f:SetPushedTexture(nil)
	f:SetHighlightTexture(nil)
	f:SetDisabledTexture(nil)
	f:SetSize(20, 20)
	
	for i = 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			local tex = region:GetTexture()
			
			if tex and (tex:find("Border") or tex:find("Background") or tex:find("AlphaMask")) then
				region:SetTexture(nil)
			else
				region:ClearAllPoints()
				region:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
				region:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
				region:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				region:SetDrawLayer("ARTWORK")
				if f:GetName() == "PS_MinimapButton" then
					region.SetPoint = K.Dummy
				end
			end
		end
	end
	
	KkthnxUI.AddBorder(f, 10, 3)
	f:SetBackdrop(K.BasicBackdrop)
	f:SetBackdropColor(0.05, 0.05, 0.05, .9)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		for i = 1, Minimap:GetNumChildren() do
			SkinButton(select(i, Minimap:GetChildren()))
		end
	end
	
	if WIM3MinimapButton and WIM3MinimapButton:GetNumRegions() < 9 then
		KkthnxUI.AddBorder(WIM3MinimapButton, 10, 2)
	end
	self = nil
end)