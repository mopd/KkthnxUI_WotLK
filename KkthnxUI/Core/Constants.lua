local K, C, L, _ = unpack(KkthnxUI)

-- KkthnxUI Constants
K.Dummy = function() return end
K.Unit = UnitGUID('player')
K.Name = UnitName("player")
_, K.Class = UnitClass("player")
_, K.Race = UnitRace("player")
K.Level = UnitLevel("player")
K.Client = GetLocale()
K.Realm = GetRealmName()
K.Color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[K.Class]
K.Version = GetAddOnMetadata("KkthnxUI", "Version")
K.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
K.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))