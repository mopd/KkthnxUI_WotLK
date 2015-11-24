local K, C, L = unpack(select(2, ...));
if C["misc"].hattrick ~= true then return end

local function createButton(icon_on, icon_off, help, getf, setf, ...)
	local HatTrick = CreateFrame("BUTTON", nil, CharacterModelFrame)
	
	-- setup
	local hilite = HatTrick:CreateTexture(nil, "HIGHLIGHT")
	hilite:SetAllPoints()
	hilite:SetTexture("Interface\\Common\\UI-ModelControlPanel")
	hilite:SetTexCoord(0.57812500, 0.82812500, 0.00781250, 0.13281250)
	
	HatTrick:SetWidth(32)
	HatTrick:SetHeight(32)
	HatTrick:SetPoint(...)
	
	-- update
	local function update()
		if getf() then
			HatTrick:SetNormalTexture(icon_on)
		else
			HatTrick:SetNormalTexture(icon_off)
		end
	end
	
	HatTrick:RegisterEvent("PLAYER_FLAGS_CHANGED")
	HatTrick:RegisterEvent("PLAYER_ENTERING_WORLD")
	HatTrick:SetScript("OnEvent", update)
	
	-- click
	HatTrick:SetScript("OnClick", function()
		setf(not getf())
		update()
	end)
	
	-- hover
	HatTrick:SetScript("OnEnter", function()
		HatTrick:SetAlpha(1)
		GameTooltip:SetOwner(HatTrick, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(help, nil, nil, nil, nil, 1)
	end)
	HatTrick:SetScript("OnLeave", function()
		HatTrick:SetAlpha(0.5)
		GameTooltip_Hide()
	end)
	HatTrick:SetAlpha(0.5)
	
	CharacterModelFrame:HookScript("OnEnter", function()
		HatTrick:Show()
	end)
	CharacterModelFrame:HookScript("OnLeave", function(self)
		if not self:IsMouseOver() then
			HatTrick:SetAlpha(0.5)
		end
	end)
	
	update()
end

createButton(
"Interface\\AddOns\\KkthnxUI\\Media\\Textures\\HelmShow",
"Interface\\AddOns\\KkthnxUI\\Media\\Textures\\HelmHide",
SHOW_HELM,
function() return ShowingHelm() end,
function(value) ShowHelm(value) end,
"BOTTOMLEFT", 5, 26
)

createButton(
"Interface\\AddOns\\KkthnxUI\\Media\\Textures\\CloakShow",
"Interface\\AddOns\KkthnxUI\\Media\\Textures\\CloakHide",
SHOW_CLOAK,
function() return ShowingCloak() end,
function(value) ShowCloak(value) end,
"BOTTOMRIGHT", -5, 26
)