local _HNF = HNF

local function plateHasBeenApplied(vehicleEntity, plate)
    local timeout = GetGameTimer() + 1000
    while timeout >= GetGameTimer() do
        local vehicleSpawnedPlate = GetVehicleNumberPlateText(vehicleEntity):gsub("%s+", "")
        if vehicleSpawnedPlate == plate:gsub("%s+", "") then return true end
        Wait(0)
    end
end

lib.callback.register("hnf_garage:SpawnVehicle", function(source, vehicle, coords)
    local p = promise:new()

    ESX.OneSync.SpawnVehicle(vehicle.model, coords.xyz, coords.w, vehicle, function(netId)
        Wait(250)
        local vehicleEntity = NetworkGetEntityFromNetworkId(netId)

        if plateHasBeenApplied(vehicleEntity, vehicle.plate) then 
            local affectedRows = MySQL.update.await("UPDATE `owned_vehicles` SET `stored` = ? WHERE `plate` = ?", { 0, vehicle.plate })
            if affectedRows == 0 then
                _HNF.Utils.deleteEntityIfExists(vehicleEntity)
            else
                TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicleEntity, -1)
            end

            p:resolve(affectedRows > 0)
        else
            _HNF.Utils.deleteEntityIfExists(vehicleEntity)
            p:resolve(false)
        end
    end)

    return Citizen.Await(p)
end)