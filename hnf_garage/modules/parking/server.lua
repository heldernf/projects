lib.callback.register("hnf_garage:isOwnerOfTheVehicle", function(source, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    plate = plate:gsub("^%s*(.-)%s*$", "%1")
    local vehicleType = MySQL.prepare.await("SELECT `type` FROM `owned_vehicles` WHERE `owner` = ? AND `plate` = ?", { xPlayer.identifier, plate })
    return vehicleType and true, vehicleType
end)

lib.callback.register("hnf_garage:StoreVehicleInDataBase", function(source, vehicleProperties)
    local xPlayer = ESX.GetPlayerFromId(source)

    vehicleProperties.plate = vehicleProperties.plate:gsub("^%s*(.-)%s*$", "%1")
    local affectedRows = MySQL.update.await("UPDATE `owned_vehicles` SET `stored` = ?, `vehicle` = ? WHERE `owner` = ? AND `plate` = ?", { 1, json.encode(vehicleProperties), xPlayer.identifier, vehicleProperties.plate})

    return affectedRows > 0
end)