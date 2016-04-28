local K, C, L, _ = unpack(select(2, ...))
if C["skins"].bigwigs ~= true then return end

--	BigWigs skin(by Affli)
-- Init some tables to store backgrounds
local freebg = {}

-- Styling functions
local createbg = function()
	local bg = CreateFrame("Frame")
	K.SetBlizzBorder(bg, 2)
	return bg
end

local function freestyle(bar)
	-- Reparent and hide bar background
	local bg = bar:Get("bigwigs:kkthnxui:bg")
	if bg then
		bg:ClearAllPoints()
		bg:SetParent(UIParent)
		bg:Hide()
		freebg[#freebg + 1] = bg
	end

	-- Reparent and hide icon background
	local ibg = bar:Get("bigwigs:kkthnxui:ibg")
	if ibg then
		ibg:ClearAllPoints()
		ibg:SetParent(UIParent)
		ibg:Hide()
		freebg[#freebg + 1] = ibg
	end

	-- Replace dummies with original method functions
	bar.candyBarBar.SetPoint = bar.candyBarBar.OldSetPoint
	bar.candyBarIconFrame.SetWidth = bar.candyBarIconFrame.OldSetWidth
	bar.SetScale = bar.OldSetScale

	-- Reset Positions
	-- Icon
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:SetPoint("TOPLEFT")
	bar.candyBarIconFrame:SetPoint("BOTTOMLEFT")
	bar.candyBarIconFrame:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	-- Status Bar
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetPoint("TOPRIGHT")
	bar.candyBarBar:SetPoint("BOTTOMRIGHT")

	-- BG
	bar.candyBarBackground:SetAllPoints()

	-- Duration
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("RIGHT", bar.candyBarBar, "RIGHT", -2, 0)

	-- Name
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:SetPoint("LEFT", bar.candyBarBar, "LEFT", 2, 0)
	bar.candyBarLabel:SetPoint("RIGHT", bar.candyBarBar, "RIGHT", -2, 0)
end

local applystyle = function(bar)
	-- General bar settings
	bar:SetHeight(15)
	bar:SetScale(1)
	bar.OldSetScale = bar.SetScale
	bar.SetScale = K.Dummy

	-- Create or reparent and use bar background
	local bg = nil
	if #freebg > 0 then
		bg = table.remove(freebg)
	else
		bg = createbg()
	end
	bg:SetParent(bar)
	bg:ClearAllPoints()
	bg:SetPoint("TOPLEFT", bar, "TOPLEFT", -2, 2)
	bg:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
	bg:SetFrameStrata("BACKGROUND")
	bg:Show()
	bar:Set("bigwigs:kkthnxui:bg", bg)

	-- Create or reparent and use icon background
	local ibg = nil
	if bar.candyBarIconFrame:GetTexture() then
		if #freebg > 0 then
			ibg = table.remove(freebg)
		else
			ibg = createbg()
		end
		ibg:SetParent(bar)
		ibg:ClearAllPoints()
		ibg:SetPoint("TOPLEFT", bar.candyBarIconFrame, "TOPLEFT", -2, 2)
		ibg:SetPoint("BOTTOMRIGHT", bar.candyBarIconFrame, "BOTTOMRIGHT", 2, -2)
		ibg:SetFrameStrata("BACKGROUND")
		ibg:Show()
		bar:Set("bigwigs:kkthnxui:ibg", ibg)
	end

	-- Setup timer and bar name fonts and positions
	bar.candyBarLabel:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
	bar.candyBarLabel:SetShadowOffset(0, 0)
	bar.candyBarLabel:SetJustifyH("LEFT")
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:SetPoint("LEFT", bar, "LEFT", 2, 0)

	bar.candyBarDuration:SetFont(C["font"].basic_font, C["font"].basic_font_size, C["font"].basic_font_style)
	bar.candyBarDuration:SetShadowOffset(0, 0)
	bar.candyBarDuration:SetJustifyH("RIGHT")
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("RIGHT", bar, "RIGHT", 1, 0)

	-- Setup bar positions and look
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetAllPoints(bar)
	bar.candyBarBar.OldSetPoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint = K.Dummy
	bar.candyBarBar:SetStatusBarTexture(C["media"].texture)
	if not bar.data["bigwigs:emphasized"] == true then bar.candyBarBar:SetStatusBarColor(K.Color.r, K.Color.g, K.Color.b, 1) end
	bar.candyBarBackground:SetTexture(C["media"].texture)

	-- Setup icon positions and other things
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", -28, 0)
	bar.candyBarIconFrame:SetSize(21, 21)
	bar.candyBarIconFrame.OldSetWidth = bar.candyBarIconFrame.SetWidth
	bar.candyBarIconFrame.SetWidth = K.Dummy
	bar.candyBarIconFrame:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

local function registerStyle()
	if not BigWigs then return end
	local bars = BigWigs:GetPlugin("Bars", true)
	local prox = BigWigs:GetPlugin("Proximity", true)
	if bars then
		bars:RegisterBarStyle("KkthnxUI", {
			apiVersion = 1,
			version = 1,
			GetSpacing = function(bar) return K.Scale(13) end,
			ApplyStyle = applystyle,
			BarStopped = freestyle,
			GetStyleName = function() return "KkthnxUI" end,
		})
	end
	bars.defaultDB.barStyle = "KkthnxUI"
	if prox and bars.defaultDB.barStyle == "KkthnxUI" then
		hooksecurefunc(prox, "RestyleWindow", function()
			K.AddBorder(BigWigsProximityAnchor, 10, 2)
		end)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon == "BigWigs_Plugins" then
			if BigWigs3DB.namespaces.BigWigs_Plugins_Bars.profiles.Default.InstalledBars ~= C["actionbar"].bottombars then
				StaticPopup_Show("BW_TEST")
			end
			registerStyle()
			f:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

StaticPopupDialogs.BW_TEST = {
	text = L_POPUP_SETTINGS_BW,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		local bars = BigWigs and BigWigs:GetPlugin("Bars")
		if bars then
			bars.db.profile.barStyle = "KkthnxUI"
			bars.db.profile.font = C["font"].basic_font
			bars.db.profile.BigWigsAnchor_width = 185
			bars.db.profile.BigWigsAnchor_x = 38
			bars.db.profile.BigWigsEmphasizeAnchor_width = 185
			bars.db.profile.BigWigsEmphasizeAnchor_x = 420
			bars.db.profile.BigWigsEmphasizeAnchor_y = 248
			bars.db.profile.emphasizeGrowup = true
			bars.db.profile.InstalledBars = C["actionbar"].bottombars
			if C["actionbar"].bottombars == 1 then
				bars.db.profile.BigWigsAnchor_y = 116
			elseif C["actionbar"].bottombars == 2 then
				bars.db.profile.BigWigsAnchor_y = 138
			elseif C["actionbar"].bottombars == 3 then
				bars.db.profile.BigWigsAnchor_y = 159
			end
		end
		local mess = BigWigs and BigWigs:GetPlugin("Messages")
		if mess then
			mess.db.profile.font = "KNORM_Font"
			mess.db.profile.fontSize = 20
			mess.db.profile.BWMessageAnchor_x = 415
			mess.db.profile.BWMessageAnchor_y = 320
			mess.db.profile.BWEmphasizeMessageAnchor_x = 415
			mess.db.profile.BWEmphasizeMessageAnchor_y = 335
			mess.db.profile.BWEmphasizeCountdownMessageAnchor_x = 465
			mess.db.profile.BWEmphasizeCountdownMessageAnchor_y = 370
		end
		local prox = BigWigs and BigWigs:GetPlugin("Proximity")
		if prox then
			prox.db.profile.font = "KNORM_Font"
			prox.db.profile.objects.ability = false
		end
		BigWigs3IconDB.hide = true
		BigWigs:GetPlugin("Super Emphasize").db.profile.font = "KNORM_Font"
		BigWigs:GetPlugin("Alt Power").db.profile.font = "KNORM_Font"
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r")
			print("|cffffff00Reload your UI to apply skin.|r")
		else
			ReloadUI()
		end
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

SlashCmdList.BWTEST = function(msg)
	if msg == "apply" then
		SlashCmdList["BigWigs"]()
		HideUIPanel(InterfaceOptionsFrame)
		StaticPopup_Show("BW_TEST")
	elseif msg == "test" then
		SlashCmdList["BigWigs"]()
		BigWigs:GetPlugin("Proximity").Test(BigWigs:GetPlugin("Proximity"))
		HideUIPanel(InterfaceOptionsFrame)
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
		BigWigs:Test()
	else
		print("|cffffff00Type /bwtest apply to apply BigWigs settings.|r")
		print("|cffffff00Type /bwtest test to launch BigWigs testmode.|r")
	end
end
SLASH_BWTEST1 = "/bwtest"