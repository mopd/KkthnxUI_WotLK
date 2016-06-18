local K, _ = select(2, ...):unpack()

local floor = math.floor
local select = select
local IsAltKeyDown = IsAltKeyDown
local GetItemInfo = GetItemInfo
local GetMerchantItemLink = GetMerchantItemLink
local GetID = GetID
local BuyMerchantItem = BuyMerchantItem

-- Alt+Click to buy a stack
local SavedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
function MerchantItemButton_OnModifiedClick(self, ...)
	if IsAltKeyDown() then
		local itemLink = GetMerchantItemLink(self:GetID())
		if not itemLink then return end

		local maxStack = select(8, GetItemInfo(itemLink))
		if maxStack and maxStack > 1 then
			BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
		end
	end
	SavedMerchantItemButton_OnModifiedClick(self, ...)
end