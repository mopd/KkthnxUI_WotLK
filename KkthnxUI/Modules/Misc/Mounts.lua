local K, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
-- Universal Mount macro : 
-- /script Mountz ("your_ground_mount","your_flying_mount")
-- (by ALZA or maybe by Monolit?)
----------------------------------------------------------------------------------------
function Mountz(groundmount, flyingmount)
    local num = GetNumCompanions("MOUNT")
    if not num or IsMounted() then
        Dismount()
        return
    end
    if CanExitVehicle() then 
        VehicleExit()
        return
    end
    local x, y = GetPlayerMapPosition("player")
    local wgtime = GetWintergraspWaitTime()
    local flyablex = (IsFlyableArea() and (not (GetZoneText() == L_ZONE_DALARAN or (GetZoneText() == L_ZONE_WINTERGRASP and wgtime == nil)) or GetSubZoneText() == L_ZONE_KRASUS or (GetSubZoneText() == L_ZONE_UNDERBELLY and ((x*100)<32)) or (GetSubZoneText() == L_ZONE_VC and (x*100)<33))) and (UnitLevel("player")>67 or (GetCurrentMapContinent()==3 and UnitLevel("player")>59))
    if IsAltKeyDown() then
        flyablex = not flyablex
    end
    for i = 1, num, 1 do
        local _, info = GetCompanionInfo("MOUNT", i)
        if flyingmount and info == flyingmount and flyablex then
            CallCompanion("MOUNT", i)
            return
        elseif groundmount and info == groundmount and not flyablex then
            CallCompanion("MOUNT", i)
            return
        end
    end
end