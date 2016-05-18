local K, C, L, _ = select(2, ...):unpack()
if C["automation"].sellgrey_n_repair ~= true then return end

local format = string.format
local format, strsub = string.format, string.sub
local select = select
local CanGuildBankRepair = CanGuildBankRepair
local CanMerchantRepair = CanMerchantRepair
local CreateFrame = CreateFrame
local GetContainerItemLink, GetContainerNumSlots = GetContainerItemLink, GetContainerNumSlots
local GetGuildBankWithdrawMoney = GetGuildBankWithdrawMoney
local GetItemInfo, GetItemCount = GetItemInfo, GetItemCount
local GetMoney = GetMoney
local GetNumPartyMembers = GetNumPartyMembers
local GetRepairAllCost = GetRepairAllCost
local RepairAllItems = RepairAllItems
local UseContainerItem = UseContainerItem

-- Auto repair and sell grey items
local formatMoney = function(value)
	if value >= 1e4 then
		return format("|cffffd700%dg |r|cffc7c7cf%ds |r|cffeda55f%dc|r", value/1e4, strsub(value, -4) / 1e2, strsub(value, -2))
	elseif value >= 1e2 then
		return format("|cffc7c7cf%ds |r|cffeda55f%dc|r", strsub(value, -4) / 1e2, strsub(value, -2))
	else
		return format("|cffeda55f%dc|r", strsub(value, -2))
	end
end

local itemCount, sellValue = 0, 0

local SellGreyNRepair = CreateFrame("frame")
SellGreyNRepair:RegisterEvent("MERCHANT_SHOW")
SellGreyNRepair:SetScript("OnEvent", function(self, event)
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
		K.Print(format("Sold %d trash item%s for %s", itemCount, itemCount ~= 1 and "s" or "", formatMoney(sellValue)))
		itemCount, sellValue = 0, 0
	end

	if CanMerchantRepair() then
		local cost, needed = GetRepairAllCost()
		if needed then
			local GuildWealth = CanGuildBankRepair() and GetGuildBankWithdrawMoney() > cost
			if GuildWealth and GetNumPartyMembers() > 5 then
				RepairAllItems(1)
				K.Print(format("Guild bank repaired for %s.", GetCoinTextureString(cost)))
			elseif cost < GetMoney() then
				RepairAllItems()
				K.Print(format("Repaired for %s.", GetCoinTextureString(cost)))
			else
				K.Print("Repairs were unaffordable.")
			end
		end
	end
end)