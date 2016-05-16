local K, C, L, _ = select(2, ...):unpack()

local IsAddOnLoaded = IsAddOnLoaded

-- Prevent users config errors
if C["error"].black == true and C["error"].white == true then
	C["error"].white = false
end

if C["error"].combat == true then
	C["error"].black = false
	C["error"].white = false
end

if C["unitframe"].enable == false or C["actionbar"].enable == false then
	C["actionbar"].bagshide = true
	C["actionbar"].micromenuhide = true
end

if C["unitframe"].percenthealth == true then
	C["unitframe"].classhealth = false
end

if C["unitframe"].enable == false then
	C["filger"].enable = false
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

if IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("RazerNaga") or IsAddOnLoaded("gUI4_ActionBars") then
	C["actionbar"].enable = false
end

if IsAddOnLoaded("XPerl") then
	C["unitframe"].enable = false
end

if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag") then
	C["bag"].enable = false
end

if IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter") or IsAddOnLoaded("BasicChatMods") then
	C["chat"].enable = false
end

if IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("bTooltip") or IsAddOnLoaded("PhoenixTooltip") or IsAddOnLoaded("Icetip") or IsAddOnLoaded("gUI4_Tooltip") or IsAddOnLoaded("rTooltip") then
	C["tooltip"].enable = false
end

if IsAddOnLoaded("GnomishVendorShrinker") or IsAddOnLoaded("AlreadyKnown") then
	C["misc"].alreadyknown = false
end

if IsAddOnLoaded("ChatSounds") then
	C["chat"].whisp_sound = false
end