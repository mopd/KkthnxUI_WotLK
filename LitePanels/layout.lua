local K, C, L, _ = unpack(KkthnxUI)
----------------------------------------------------------------------------------------
--	LitePanels configuration file
--	BACKUP YOUR CHANGES TO THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
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