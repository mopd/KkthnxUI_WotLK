local K, C, L, _ = select(2, ...):unpack()
if C["loot"].betterlootfilter ~= true then return end

local select = select
local find = string.find
local match = string.match
local GetItemInfo = GetItemInfo

-- Better loot filter
local minRarity = 3 -- 0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary, 6 = Artifact, 7 = Heirloom
function lootfilter(self, event, msg)
	if not match(msg,"Hbattlepet") then
		local itemID = select(3, find(msg, "item:(%d+):"))
		local itemRarity = select(3, GetItemInfo(itemID))

		if (itemRarity < minRarity) and (find(msg, "receives") or find(msg, "gets") or find(msg, "creates")) then
			return true
		else
			return false
		end
	else
		return false
	end

end
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", lootfilter)