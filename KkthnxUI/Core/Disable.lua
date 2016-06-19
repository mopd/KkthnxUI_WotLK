local K, C, L, _ = select(2, ...):unpack()

local IsAddOnLoaded = IsAddOnLoaded

-- Prevent users config errors
if C["ActionBar"].RightBars > 3 then
	C["ActionBar"].RightBars = 3
end

if C["ActionBar"].BottomBars > 3 then
	C["ActionBar"].BottomBars = 3
end

if C["ActionBar"].BottomBars == 3 and C["ActionBar"].RightBars == 3 then
	C["ActionBar"].BottomBars = 3
	C["ActionBar"].RightBars = 2
end

if C["ActionBar"].SplitBars == true then
	C["ActionBar"].BottomBars = 3
	C["ActionBar"].RightBars = 2
end

if C["ActionBar"].BottomBars < 1 then
	C["ActionBar"].BottomBars = 1
end

if C["ActionBar"].PetBar_Horizontal == true then
	C["ActionBar"].StanceBar_Horizontal = false
end

if C["Unitframe"].percent_health == true then
	C["Unitframe"].classhealth = false
end

if C["Unitframe"].enable == false then
	C["Filger"].enable = false
end

-- Auto-overwrite script config is X addon is found
if IsAddOnLoaded("SexyMap") or IsAddOnLoaded("wMinimap") then
	C["Minimap"].enable = false
end

if IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") then
	C["Unitframe"].enable = false
	C["Unitframe"].enhancedframes = false
end

if IsAddOnLoaded("QuestHelper") then -- This is a temp fix until I figure out what to blacklist from shitty questhelper.
	C["Skins"].minimap_buttons = false
end

if IsAddOnLoaded("mapster") then
	C["map"].enable = false
end

if IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("RazerNaga") then
	C["ActionBar"].Enable = false
end

if (select(4, GetAddOnInfo("KkthnxUI_OldBars")))  then -- Could this be a better way to check for other addons?
	C["ActionBar"].Enable = false
end

if IsAddOnLoaded("XPerl") or IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") then
	C["Unitframe"].enable = false
end

if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag") then
	C["Bag"].enable = false
end

if IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter") then
	C["Chat"].enable = false
end

if IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft") or IsAddOnLoaded("dNamePlates") or IsAddOnLoaded("caelNamePlates") then
	C["Nameplate"].enable = false
end

if IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("bTooltip") or IsAddOnLoaded("PhoenixTooltip") or IsAddOnLoaded("Icetip") or IsAddOnLoaded("rTooltip") then
	C["Tooltip"].enable = false
end

if IsAddOnLoaded("TipTacTalents") then
	C["Tooltip"].talents = false
end

if IsAddOnLoaded("GnomishVendorShrinker") or IsAddOnLoaded("AlreadyKnown") then
	C["Misc"].alreadyknown = false
end

if IsAddOnLoaded("BadBoy") then
	C["Chat"].spam = false
end

if IsAddOnLoaded("ChatSounds") then
	C["Chat"].Whisp_Sound = false
end