local _HNF = HNF

local entityLastVehicleShowed
local function deleteLastShowedVehicle()
    _HNF.Utils.deleteEntityIfExists(entityLastVehicleShowed)
end
RegisterNetEvent("hnf_garage:DeleteLastShowedVehicle", deleteLastShowedVehicle)
RegisterNetEvent("hnf_garage:ClosedUI", deleteLastShowedVehicle)

RegisterNuiCallback("ShowVehicle", function(selectedVehicle, cb)
    deleteLastShowedVehicle()

    selectedVehicle.spawnLocation = vec4(selectedVehicle.spawnLocation.x, selectedVehicle.spawnLocation.y, selectedVehicle.spawnLocation.z, selectedVehicle.spawnLocation.w)
    entityLastVehicleShowed = _HNF.Utils.spawnLocalVehicle(selectedVehicle.vehicle, selectedVehicle.spawnLocation)
    FreezeEntityPosition(entityLastVehicleShowed, true)
    SetEntityCollision(entityLastVehicleShowed, false, false)

    cb(entityLastVehicleShowed and true)
end)

local function spawnVehicle(selectedVehicle)
    if not _HNF.Utils.antiSpamByTime(1000) then return end

    local dialogResult = lib.alertDialog({
        header = _HNF.Utils.formatMessageNormalized({ message = _HNF.Locale("spawnMessage"), params = {_HNF.Config.charge.spawn.amount} }),
        centered = true,
        cancel = true
    })
    if dialogResult == "cancel" then return end
    if not HNF.Utils.hasRequiredMoney(_HNF.Config.charge.spawn, "dontHaveMoney") or not lib.callback.await("hnf_garage:RemoveAccountMoney", false, _HNF.Config.charge.spawn) then return end

    SendNUIMessage({ action = "startLoad" })
    deleteLastShowedVehicle()

    local spawnLocation = vec4(selectedVehicle.spawnLocation.x, selectedVehicle.spawnLocation.y, selectedVehicle.spawnLocation.z, selectedVehicle.spawnLocation.w)
    return lib.callback.await("hnf_garage:SpawnVehicle", false, selectedVehicle.vehicle, spawnLocation)
end

RegisterNuiCallback("SpawnVehicle", function(selectedVehicle, cb)
    cb(spawnVehicle(selectedVehicle))
end)