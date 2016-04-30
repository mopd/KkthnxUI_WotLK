local K, C, L, _ = unpack(select(2, ...))

local floor = math.floor
local select = select

local IsAltKeyDown = IsAltKeyDown
local GetItemInfo = GetItemInfo
local GetMerchantItemLink = GetMerchantItemLink
local GetMerchantItemInfo = GetMerchantItemInfo
local GetID = GetID
local isUsable = isUsable
local BuyMerchantItem = BuyMerchantItem
local savedMerchantItemButton_OnModifiedClick = savedMerchantItemButton_OnModifiedClick
local MerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick

-- Alt+Click to buy a stack
local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
function MerchantItemButton_OnModifiedClick(self, ...)
	if (IsAltKeyDown()) then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(this:GetID())))
		local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(this:GetID())
		if ( maxStack and maxStack > 1 ) then
			BuyMerchantItem(this:GetID(), floor(maxStack / quantity))
		end
	end
	savedMerchantItemButton_OnModifiedClick(self, ...)
end