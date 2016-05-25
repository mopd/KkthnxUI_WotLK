local K, C, L, _ = select(2, ...):unpack()

local IsAddOnLoaded = IsAddOnLoaded

-- Prevent users config errors
if C["actionbar"].rightbars > 3 then
	C["actionbar"].rightbars = 3
end

if C["actionbar"].bottombars > 3 then
	C["actionbar"].bottombars = 3
end

if C["actionbar"].bottombars == 3 and C["actionbar"].rightbars == 3 then
	C["actionbar"].bottombars = 3
	C["actionbar"].rightbars = 2
end

if C["actionbar"].split_bars == true then
	C["actionbar"].bottombars = 3
	C["actionbar"].rightbars = 2
end

if C["actionbar"].bottombars < 1 then
	C["actionbar"].bottombars = 1
end

if C["actionbar"].petbar_horizontal == true then
	C["actionbar"].stancebar_horizontal = false
end

if C["unitframe"].percenthealth == true then
	C["unitframe"].classhealth = false
end

if C["unitframe"].enable == false then
	C["filger"].enable = false
end

if C["error"].black == true and C["error"].white == true then
	C["error"].white = false
end

if C["error"].combat == true then
	C["error"].black = false
	C["error"].white = false
end

-- Auto-overwrite script config is X addon is found
if IsAddOnLoaded("SexyMap") or IsAddOnLoaded("wMinimap") or IsAddOnLoaded("Carbonite") then
	C["minimap"].enable = false
end

if IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") then
	C["unitframe"].enable = false
	C["unitframe"].enhancedframes = false
end

if IsAddOnLoaded("QuestHelper") then -- This is a temp fix until I figure out what to blacklist from shitty questhelper.
	C["skins"].minimap_buttons = false
end

if IsAddOnLoaded("mapster") then
	C["map"].enable = false
end

if IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("RazerNaga") then
	C["actionbar"].enable = false
end

if (select(4, GetAddOnInfo("KkthnxUI_OldBars")))  then -- Could this be a better way to check for other addons?
	C["actionbar"].enable = false
end

if IsAddOnLoaded("XPerl") or IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") then
	C["unitframe"].enable = false
end

if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag") then
	C["bag"].enable = false
end

if IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter") then
	C["chat"].enable = false
end

if IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft") or IsAddOnLoaded("dNamePlates") or IsAddOnLoaded("caelNamePlates") then
	C["nameplate"].enable = false
end

if IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("bTooltip") or IsAddOnLoaded("PhoenixTooltip") or IsAddOnLoaded("Icetip") or IsAddOnLoaded("rTooltip") then
	C["tooltip"].enable = false
end

if IsAddOnLoaded("TipTacTalents") then
	C["tooltip"].talents = false
end

if IsAddOnLoaded("GnomishVendorShrinker") or IsAddOnLoaded("AlreadyKnown") then
	C["misc"].alreadyknown = false
end

if IsAddOnLoaded("BadBoy") then
	C["chat"].spam = false
end

if IsAddOnLoaded("ChatSounds") then
	C["chat"].whisp_sound = false
end