local function checkIfVehicleIsSpawned(plate)
    for _, entity in pairs(GetAllVehicles()) do
        if GetVehicleNumberPlateText(entity):gsub("^%s*(.-)%s*$", "%1") == plate then
            return GetEntityCoords(entity)
        end
    end
end
lib.callback.register("hnf_garage:CheckIfVehicleIsSpawned", function(_, plate) return checkIfVehicleIsSpawned(plate) end)

lib.callback.register("hnf_garage:GetVehicleMode", function(source, plate)
    plate = plate:gsub("^%s*(.-)%s*$", "%1")
    local vehicleData = MySQL.query.await("SELECT `vehicle`, `stored`, `billPrice` FROM `owned_vehicles` WHERE `plate` = ?", { plate })
    if #vehicleData == 0 then return end

    local vehicle = json.decode(vehicleData[1].vehicle)
    local vehicleDisplayName = lib.callback.await("hnf_garage:GetVehicleDisplayName", source, vehicle.model)

    local vehicleMode = "spawn"
    if vehicleDisplayName == "CARNOTFOUND" then
        vehicleMode = "notFound"
    elseif vehicleData[1].stored == 0 then
        vehicleMode = checkIfVehicleIsSpawned(plate) and "track" or "recover"
    elseif vehicleData[1].stored == 1 then
        if vehicleData[1].billPrice > 0 then
            vehicleMode = "fine"
        else
            vehicleMode = "spawn"
        end
    end

    return vehicleMode, vehicleDisplayName
end)