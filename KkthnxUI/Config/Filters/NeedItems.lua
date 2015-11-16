local K, C, L = unpack(select(2, ...));
if C["loot"].auto_greed ~= true then return end

K.NeedLoot = {
	33865,	-- Amani Hex Stick
}