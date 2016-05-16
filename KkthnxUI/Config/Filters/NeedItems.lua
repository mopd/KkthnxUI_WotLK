local K, C, L, _ = select(2, ...):unpack()
if C["loot"].auto_greed ~= true then return end

K.NeedLoot = {
	33865,	-- Amani Hex Stick
	68729,	-- Elementium Lockbox
}