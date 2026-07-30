local _HNF = HNF

local function recoverVehicle(vehicleData)
    if not HNF.Utils.hasRequiredMoney(_HNF.Config.charge.recover, "dontHaveMoney") then return end
    if not lib.callback.await("hnf_garage:RemoveAccountMoney", false, _HNF.Config.charge.recover) then return end

    if lib.callback.await("hnf_garage:StoreVehicleInDataBase", false, vehicleData.vehicle) then
        return lib.callback.await("hnf_garage:GetVehicleMode", false, vehicleData.vehicle.plate)
    end
end

RegisterNuiCallback("RecoverVehicle", function(vehicleData, cb)
    local dialogResult = lib.alertDialog({
        header = _HNF.Utils.formatMessageNormalized({ message = _HNF.Locale("insuranceQuestion"), params = {_HNF.Config.charge.recover.amount} }),
        content = _HNF.Locale("insuranceDescription"),
        centered = true,
        cancel = true
    })

    local newVehicleMode
    if dialogResult == "confirm" then newVehicleMode = recoverVehicle(vehicleData) end

    cb(newVehicleMode or false)
end)