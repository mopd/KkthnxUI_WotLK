local K, C, L, _ = unpack(select(2, ...))

VideoOptionsResolutionPanelUIScaleSlider:Hide()
VideoOptionsResolutionPanelUseUIScale:Hide()

-- Clean up Keys
local HKfont = CreateFont("HotKeyFont")
HKfont:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
HKfont:SetShadowOffset(0, 0)
NumberFontNormalSmallGray:SetFontObject(HKfont)

-- Kill this bullshit.
CharacterModelFrameRotateLeftButton:Kill()
CharacterModelFrameRotateRightButton:Kill()

-- Protection from hidden windows auction at the opening of other windows(by Fernir)
local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("ADDON_LOADED")
eventframe:SetScript("OnEvent", function(self, event, addon)
    if addon == "Blizzard_AuctionUI" then
        AuctionFrame:SetMovable(true)
        AuctionFrame:SetClampedToScreen(true)
        AuctionFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
        AuctionFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)

        local handleAuctionFrame = function(self)
            if AuctionFrame:GetAttribute("UIPanelLayout-enabled") then
                if AuctionFrame:IsVisible() then
                    AuctionFrame.Hide = function() end
                    HideUIPanel(AuctionFrame)
                    AuctionFrame.Hide = nil
                end
                AuctionFrame:SetAttribute("UIPanelLayout-enabled", nil)
            else
                if AuctionFrame:IsVisible() then
                    AuctionFrame.IsShown = function() end
                    ShowUIPanel(AuctionFrame)
                    AuctionFrame.IsShown = nil
                end
            end
        end
        hooksecurefunc("AuctionFrame_Show", handleAuctionFrame)
        hooksecurefunc("AuctionFrame_Hide", handleAuctionFrame)
      
      self:UnregisterEvent"ADDON_LOADED"
      self:SetScript("OnEvent", nil)
    end
end)  

-- Fade in/out world when GameMenu is opened
if C.misc.fadegamemenu == true then
	local GMFade = UIParent:CreateTexture(nil, 'ARTWORK')
	GMFade:SetAllPoints(UIParent)
	GMFade:SetTexture(0, 0, 0)
	GMFade:Hide()
	
	hooksecurefunc(GameMenuFrame, 'Show', function()
		GMFade:SetAlpha(0)
		securecall('UIFrameFadeIn', GMFade, 0.235, GMFade:GetAlpha(), 0.7)
	end)
	
	hooksecurefunc(GameMenuFrame, 'Hide', function()
		securecall('UIFrameFadeOut', GMFade, 0.235, GMFade:GetAlpha(), 0)
	end)
end

-- Better loot filter
if C.misc.betterlootfilter == true then
	local minRarity = 3 --0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary, 6 = Artifact, 7 = Heirloom
	function lootfilter(self,event,msg)
		if not string.match(msg,'Hbattlepet') then
			local itemID = select(3, string.find(msg, "item:(%d+):"))
			local itemRarity = select(3, GetItemInfo(itemID))
			
			if (itemRarity < minRarity) and (string.find(msg, "receives") or string.find(msg, "gets") or string.find(msg, "creates")) then
				return true
			else
				return false
			end
		else
			return false
		end
		
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", lootfilter)
end

--Self
CURRENCY_GAINED = "Currency: %s";
CURRENCY_GAINED_MULTIPLE = "Currency: %s x%d";
CURRENCY_GAINED_MULTIPLE_BONUS = "Currency: %s x%d (Bonus)";
LOOT_ITEM_BONUS_ROLL_SELF = "Loot: %s (Bonus)";
LOOT_ITEM_BONUS_ROLL_SELF_MULTIPLE = "Loot: %sx%d (Bonus)";
LOOT_ITEM_CREATED_SELF = "Create: %s";
LOOT_ITEM_CREATED_SELF_MULTIPLE = "Create: %sx%d";
LOOT_ITEM_PUSHED_SELF = "Loot: %s";
LOOT_ITEM_PUSHED_SELF_MULTIPLE = "Loot: %sx%d";
LOOT_ITEM_REFUND = "Refund: %s";
LOOT_ITEM_REFUND_MULTIPLE = "Refund: %sx%d";
LOOT_ITEM_SELF = "Loot: %s";
LOOT_ITEM_SELF_MULTIPLE = "Loot: %sx%d";

--Other players
LOOT_ITEM = "%s gets: %s";
LOOT_ITEM_BONUS_ROLL = "%s gets: %s (Bonus)";
LOOT_ITEM_BONUS_ROLL_MULTIPLE = "%s gets: %sx%d";
LOOT_ITEM_MULTIPLE = "%s gets: %sx%d";
LOOT_ITEM_PUSHED = "%s gets: %s";
LOOT_ITEM_PUSHED_MULTIPLE = "%s gets: %sx%d";

-- Shorten gold display
if C.misc.shortengold == true then
	local frame = CreateFrame("FRAME", "DuffedGold")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("MAIL_SHOW")
	frame:RegisterEvent("MAIL_CLOSED")
	
	local function eventHandler(self, event, ...)
		if event == "MAIL_SHOW" then
			COPPER_AMOUNT = "%d Copper"
			SILVER_AMOUNT = "%d Silver"
			GOLD_AMOUNT = "%d Gold"
		else
			COPPER_AMOUNT = "%d|cFF954F28"..COPPER_AMOUNT_SYMBOL.."|r"
			SILVER_AMOUNT = "%d|cFFC0C0C0"..SILVER_AMOUNT_SYMBOL.."|r"
			GOLD_AMOUNT = "%d|cFFF0D440"..GOLD_AMOUNT_SYMBOL.."|r"
		end
		YOU_LOOT_MONEY = "+%s"
		LOOT_MONEY_SPLIT = "+%s"
	end
	frame:SetScript("OnEvent", eventHandler)
end

-- Minimap Farmmode
local farm = false
local minisize = 144
local farmsize = 300
function SlashCmdList.FARMMODE(msg, editbox)
	if farm == false then
		Minimap:SetSize(farmsize, farmsize)
		MinimapAnchor:SetSize(farmsize, farmsize)
		farm = true
		print("Farm Mode : On")
	else
		Minimap:SetSize(minisize, minisize)
		MinimapAnchor:SetSize(minisize, minisize)
		farm = false
		print("Farm Mode : Off")
	end
	
	local defaultBlip = "Interface\\Minimap\\ObjectIcons"
	Minimap:SetBlipTexture(defaultBlip)
end
SLASH_FARMMODE1 = "/farmmode"

--[[
-- Auto repair and sell grey items
local format = string.format
local formatMoney = function(value)
    if value >= 1e4 then
        return format('|cffffd700%dg |r|cffc7c7cf%ds |r|cffeda55f%dc|r', value/1e4, strsub(value, -4) / 1e2, strsub(value, -2))
    elseif value >= 1e2 then
        return format('|cffc7c7cf%ds |r|cffeda55f%dc|r', strsub(value, -4) / 1e2, strsub(value, -2))
    else
        return format('|cffeda55f%dc|r', strsub(value, -2))
    end
end

local itemCount, sellValue = 0, 0

local merchant = CreateFrame('frame')
merchant:RegisterEvent('MERCHANT_SHOW')
merchant:SetScript('OnEvent', function(self, event)
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local item = GetContainerItemLink(bag, slot)
            if item then
                local itemValue = select(11, GetItemInfo(item)) * GetItemCount(item)

                if select(3, GetItemInfo(item)) == 0 then
                    ShowMerchantSellCursor(1)
                    UseContainerItem(bag, slot)

                    itemCount = itemCount + GetItemCount(item)
                    sellValue = sellValue + itemValue
                end
            end
        end
    end

    if sellValue > 0 then
        print(format('|cFF4488FFKkthnx|r|cFFFEB200UI: Sold %d trash item%s for %s', itemCount, itemCount ~= 1 and 's' or '', formatMoney(sellValue)))
        itemCount, sellValue = 0, 0
    end

    if CanMerchantRepair() then
        local cost, needed = GetRepairAllCost()
        if needed then
            local GuildWealth = CanGuildBankRepair() and GetGuildBankWithdrawMoney() > cost
            if GuildWealth and GetNumGroupMembers() > 5 then
                RepairAllItems(1)
                print(format('|cFF4488FFKkthnx|r|cFFFEB200UI: Guild bank repaired for %s.', formatMoney(cost)))
            elseif cost < GetMoney() then
                RepairAllItems()
                print(format('|cFF4488FFKkthnx|r|cFFFEB200UI: Repaired for %s.', formatMoney(cost)))
            else
                print('|cFF4488FFKkthnx|r|cFFFEB200UI: Repairs were unaffordable.')
            end
        end
    end
end)
]]--

-- Collect Garbage
if C.misc.collectgarbage then
	local Garbage = CreateFrame("Frame")
	Garbage:RegisterAllEvents()
	Garbage:SetScript("OnEvent", function(self, event)
		eventcount = eventcount + 1
		
		if (InCombatLockdown() and eventcount > 25000) or (not InCombatLockdown() and eventcount > 10000) or event == "PLAYER_ENTERING_WORLD" then
			collectgarbage("collect")
			eventcount = 0
		end
	end)
end

-- Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

-- Remove Boss Emote spam in BG (by Partha)
if C.misc.bgspam then
	local BGSpam = CreateFrame("Frame")
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame
	
	local function DisableSpam()
		if GetZoneText() == L_ZONE_ARATHIBASIN or GetZoneText() == L_ZONE_GILNEAS then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = false
		end
	end
	
	BGSpam:RegisterEvent("PLAYER_ENTERING_WORLD")
	BGSpam:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	BGSpam:SetScript("OnEvent", DisableSpam)
end