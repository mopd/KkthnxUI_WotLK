local K, C, L = unpack(select(2, ...));
if C["loot"].betterlf == true then
	
	-- Better loot filter
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
end