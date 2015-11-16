local K, C, L = unpack(select(2, ...));

VideoOptionsResolutionPanelUIScaleSlider:Hide()
VideoOptionsResolutionPanelUseUIScale:Hide()

-- Location of Zone text
ZoneTextFrame:ClearAllPoints() 
ZoneTextFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 300);	

-- Location of Subzone Text
SubZoneTextFrame:ClearAllPoints()
SubZoneTextFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 400)

-- Clean up Keys
local HKfont = CreateFont("HotKeyFont")
HKfont:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
HKfont:SetShadowOffset(0, 0)
NumberFontNormalSmallGray:SetFontObject(HKfont)

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