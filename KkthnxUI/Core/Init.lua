-- Initiation / Engine of KkthnxUI
local addon, engine = ...
engine[1] = {}	-- K, Functions
engine[2] = {}	-- C, Config
engine[3] = {}	-- L, Localization

KkthnxUI = engine	-- Allow other addons to use our engine

--[[
	This SHOULD be at the top of EVERY FILE INSIDE of the KkthnxUI AddOn:
	local K, C, L, _ = unpack(select(2, ...))

	This is how OTHER ADDONS import the KkthnxUI engine:
	local K, C, L, _ = unpack(KkthnxUI)
]]