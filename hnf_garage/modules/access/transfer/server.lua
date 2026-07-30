local _HNF = HNF

local function targetPlayerExist(targetId)
    local xPlayer = ESX.GetPlayerFromId(targetId)
    return xPlayer?.spawned and xPlayer or false
end

lib.callback.register("hnf_garage:TransferVehicle", function(source, targetId, vehicleData)
    local xPlayerTarget = targetPlayerExist(targetId)
    if not xPlayerTarget then return false, _HNF.Locale("targetIdNotIsOnline") end

    _HNF.Utils.startLoadInUI(source)

    local transfered, message = lib.callback.await("hnf_garage:AskTargetPlayerToTransferVehicle", targetId, vehicleData)
    if not transfered then return transfered, message end

    local affectedRows = MySQL.update.await("UPDATE owned_vehicles SET `owner` = ? WHERE `plate` = ?", { xPlayerTarget.identifier, vehicleData.plate })
    if affectedRows > 0 then
        TriggerClientEvent("hnf_garage:DeleteLastShowedVehicle", source)
        return transfered, message
    end
end)