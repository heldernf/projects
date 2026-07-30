lib.callback.register("hnf_garage:GetOwnedVehiclesImpounded", function(source, vehicleType)
    
end)

lib.callback.register("hnf_garage:GetOwnedVehiclesByType", function(source, vehicleType)
    local xPlayer = ESX.GetPlayerFromId(source)

    local vehicles = MySQL.query.await("SELECT `vehicle`, `plate` FROM `owned_vehicles` WHERE `owner` = ? AND `type` = ?", { xPlayer.identifier, vehicleType })

    for i, v in pairs(vehicles) do
        vehicles[i].vehicle = json.decode(vehicles[i].vehicle)
    end

    return #vehicles > 0 and vehicles or false
end)