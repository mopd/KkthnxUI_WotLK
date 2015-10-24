local K, C, L, _ = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------

local frf = CreateFrame("FRAME",UIParent)
function FrameRangeFade_OnUpdate(self,...)
	-- UnitInRange only works if target or focus is in your party/raid.
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

local lastMessage
local function repeatMessageFilter(self, event, text, sender)
	if sender == K.Name or UnitIsInMyGuild(sender) then return end
	if not self.repeatMessages or self.repeatCount > 100 then
		self.repeatCount = 0
		self.repeatMessages = {}
	end
	lastMessage = self.repeatMessages[sender]
	if lastMessage == text then
		return true
	end
	self.repeatMessages[sender] = text
	self.repeatCount = self.repeatCount + 1
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", repeatMessageFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", repeatMessageFilter)

-- More shit to put in here.. I really need to sort my code.

lpanels = {
	profile = {}, temp = {},
	cinfo = {
		n = strlower(UnitName("player")),
		r = strlower(gsub(GetRealmName(), " ", "")),
		c = strlower(select(2, UnitClass("player")))
	},
	defaults = {
		parent = "UIParent", strata = "BACKGROUND",
		anchor_to = "BOTTOMLEFT", anchor_from = "BOTTOMLEFT",
		x_off = 0, y_off = 0, height = 0, width = 0,
		text = {
			string = "", font = "Fonts/FRIZQT__.TTF", size = 12,
			justify_h = "CENTER", justify_v = "MIDDLE",
			anchor_to = "CENTER", anchor_from = "CENTER",
			x_off = 0, y_off = 0, color = "1 1 1", alpha = 1,
			shadow = {color = "0 0 0", alpha = 1, y = -0.75, x = 0.75},
		}
	},
	events = {"OnEvent", "OnUpdate", "OnResize", "OnClick", "OnDoubleClick", "OnMouseUp", "OnMouseDown", "OnEnter", "OnLeave", "OnHide", "OnShow"},
	defaultv = {"anchor_to", "x_off", "y_off", "width", "height", "strata"},
}

function lpanels:CreateLayout(name, layout)
	if name and layout then
		self.profile[name] = layout or {}
	end
end

-- LitePanels configuration file
-- BACKUP THIS FILE BEFORE UPDATING!
lpanels:CreateLayout("Load For All", {

-- AFK panel
{	name = "AFK", anchor_to = "TOP", y_off = -210,
	width = 180, height = 100,
	text = {
			{	string = L_PANELS_AFK, anchor_to = "TOP", y_off = -10,
				shadow = 0, outline = 3, font = C.font.stats_font, size = C.font.stats_font_size,
			},
			{	string = function()
					if afk_timer then
						local secs = mod(time() - afk_timer, 60)
						local mins = floor((time() - afk_timer) / 60)
					return format("%s:%02.f", mins, secs)
					end
				end, update = 0.1,
				shadow = 0, outline = 3, font = C.font.stats_font, size = C.font.stats_font_size * 2,
				anchor_to = "CENTER", y_off = 6, color = "1 0.1 0.1"
			},
			{	string = L_PANELS_AFK_RCLICK, anchor_to = "BOTTOM", y_off = 24,
				shadow = 0, outline = 3, font = C.font.stats_font, size = C.font.stats_font_size,
			},
			{	string = L_PANELS_AFK_LCLICK, anchor_to = "BOTTOM", y_off = 10,
				shadow = 0, outline = 3, font = C.font.stats_font, size = C.font.stats_font_size,
			}
		},
		OnLoad = function(self)
			self:RegisterEvent("PLAYER_FLAGS_CHANGED")
			self:SetBackdrop(K.Backdrop)
			self:SetBackdropColor(0.05, 0.05, 0.05, .9)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self:Hide()
		end,
		OnEvent = function(self)
			if UnitIsAFK("player") and not afk_timer then
				self.text2:SetText("0:00")
				afk_timer = time()
				self:Show()
			elseif not UnitIsAFK("player") then
				self:Hide()
				afk_timer = nil
			end
		end,
		OnClick = function(self, b)
			self:Hide()
			if b == "LeftButton" then SendChatMessage("", "AFK") end
		end,
		OnEnter = function(self) self:SetBackdropBorderColor(K.Color.r, K.Color.g, K.Color.b) end,
		OnLeave = function(self) self:SetBackdropBorderColor(1, 0, 0, 1) end
	},
})

lpanels:ApplyLayout(nil, "Load For All")