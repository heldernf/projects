local _HNF = HNF

local function canParkVehicle(depotVehicleType)
    local vehicleToBePark = cache.vehicle
    if not vehicleToBePark then _HNF.Utils.notify("youNeedToBeInVehicle", "error") return end

    local vehicleProperties = ESX.Game.GetVehicleProperties(vehicleToBePark)
    if not vehicleProperties then _HNF.Utils.informFail({ index = "vehiclePropertiesIsInvalid", params = {vehicleProperties} }) return end

    local isOwnerOfTheCurrentVehicle, vehicleType = lib.callback.await("hnf_garage:isOwnerOfTheVehicle", false, vehicleProperties.plate)
    if not isOwnerOfTheCurrentVehicle then _HNF.Utils.notify("noIsOwnerOfTheVehicle", "error") return end

    if not depotVehicleType or type(depotVehicleType) ~= "string" then _HNF.Utils.informFail({ index = "depotVehicleTypeIsInvalid", params = {depotVehicleType} }) return end
    if depotVehicleType ~= "terrestrial" and depotVehicleType ~= "maritime" and depotVehicleType ~= "aerial" then _HNF.Utils.informFail({ index = "depotVehicleTypeIsInvalid", params = {depotVehicleType} }) return end

    if depotVehicleType ~= vehicleType then _HNF.Utils.notify({ index = "vehicleTypeIsInvalidForGarage", params = {string.lower(_HNF.Locale[depotVehicleType])} }, "error", 5000) return end

    return vehicleToBePark, vehicleProperties
end

local function parkVehicle(depotVehicleType)
    local vehicleToBePark, vehicleProperties = canParkVehicle(depotVehicleType)
    if not vehicleToBePark then return end

    if lib.callback.await("hnf_garage:StoreVehicleInDataBase", false, vehicleProperties) then
        TaskLeaveVehicle(cache.ped, vehicleToBePark, 0)
        -- TODO: FAZER FUNC PARA SABER SE ELE JA SAIU DO VEÍCULO OU NÃO E ENTÃO DELETAR O VEÍCULO
        Wait(2000)
        DeleteEntity(vehicleToBePark)

        _HNF.Utils.notify("storedVehicle", "success")
        return true
    end
end

-- TODO: FAZER O HNF.Utils.waitFinishExecute PARA CASOS COMO O ABAIXO
local parking

local function _parkVehicle(depotVehicleType)
    if parking then return end
    parking = true

    local isParking = _HNF.Utils.pcall(parkVehicle, depotVehicleType)

    parking = false
    return isParking
end
RegisterNetEvent("hnf_garage:ParkVehicle", _parkVehicle)
exports("parkVehicle", _parkVehicle)