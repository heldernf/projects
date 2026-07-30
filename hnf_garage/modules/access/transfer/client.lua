local _HNF = HNF

local function giveOptionsToPlayer(vehicleData)
    local waitingForResponse = true
    SetTimeout(_HNF.Config.timeToAcceptOrDeclineVehicleTransfer, function()
        waitingForResponse = false
    end)

    local message =_HNF.Utils.formatMessageNormalized({ message = _HNF.Locale("askToTargetIdTransferVehicle"), params = {vehicleData.label, vehicleData.plate} })
    while waitingForResponse do
        ESX.ShowHelpNotification(message, true, true)
        if IsControlJustReleased(0, 246) then return true, _HNF.Locale("transferAccepted")
        elseif IsControlJustReleased(0, 303) then return false, _HNF.Locale("transferDeclined") end
        Wait(0)
    end

    return false, _HNF.Locale("transferTimeout")
end

local transferInProgress
lib.callback.register("hnf_garage:AskTargetPlayerToTransferVehicle", function(vehicleData)
    if transferInProgress then return false, _HNF.Locale("hasTransferInProgress") end
    transferInProgress = true

    local result, message = giveOptionsToPlayer(vehicleData)

    transferInProgress = false
    return result, message
end)

local function transferVehicle(data)
    if data.targetId == GetPlayerServerId(PlayerId()) then return false, _HNF.Locale("canNotTransferToSelf") end

    local canTransfer, message = lib.callback.await("hnf_garage:TransferVehicle", false, data.targetId, data.vehicle)
    return canTransfer, message
end

RegisterNuiCallback("TransferVehicle", function(data, cb)
    local canTransfer, message = transferVehicle(data)
    cb({canTransfer = canTransfer, message = message})
end)