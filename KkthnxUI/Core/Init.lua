-- Initiation / Engine of KkthnxUI
local addon, engine = ...
engine[1] = {}	-- K, Functions
engine[2] = {}	-- C, Config
engine[3] = {}	-- L, Localization

KkthnxUI = engine	-- Allow other addons to use our engine

local K, C, L = unpack(select(2, ...));

-- Constants
K["Dummy"] = function() return end
K["Unit"] = UnitGUID('player')
K["Name"] = select(1, UnitName("player"))
K["Class"] = select(2, UnitClass("player"))
K["Race"] = select(2, UnitRace("player"))
K["Level"] = UnitLevel("player")
K["Client"] = GetLocale()
K["Realm"] = GetRealmName()
K["Resolution"] = GetCVar("gxResolution")
K["Color"] = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[K.Class]
K["Version"] = GetAddOnMetadata("KkthnxUI", "Version")
K["ScreenHeight"] = tonumber(string.match(K.Resolution, "%d+x(%d+)"))
K["ScreenWidth"] = tonumber(string.match(K.Resolution, "(%d+)x+%d"))
K["Patch"], K["Buildtext"], K["Releasedate"], K["Toc"] = GetBuildInfo()