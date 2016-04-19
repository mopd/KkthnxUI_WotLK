-- Initiation / Engine of KkthnxUI
local addon, engine = ...
engine[1] = {}	-- K, Functions
engine[2] = {}	-- C, Config
engine[3] = {}	-- L, Localization

KkthnxUI = engine	-- Allow other addons to use our engine

--[[
	This should be at the top of every file inside of the KkthnxUI AddOn:
	local K, C, L = unpack(select(2, ...))
    
	This is how another addon imports the KkthnxUI engine:
	local K, C, L = unpack(KkthnxUI)
]]