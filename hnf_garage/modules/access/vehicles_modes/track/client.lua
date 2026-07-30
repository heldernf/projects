local _HNF = HNF

local lastBlip

local function removeBlipIfExist(targetBlip)
    if DoesBlipExist(targetBlip) then RemoveBlip(targetBlip) end
end

local function setVehicleLocationInTheMapsPlayer(vehicleLocation)
    removeBlipIfExist(lastBlip)

    local blip = _HNF.Config.blips.track
    blip.position = vehicleLocation
    local createdBlip = _HNF.Utils.createBlip(blip)
    SetBlipRoute(createdBlip, 4)

    lastBlip = createdBlip
    CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(cache.ped)
            if #(playerCoords.xy - blip.position.xy) < 15.0 then
                RemoveBlip(createdBlip)
                break
            end
            Wait(1000)
        end
    end)

    CreateThread(function()
        Wait(_HNF.Config.trackTime)
        removeBlipIfExist(lastBlip)
    end)
end

local function trackVehicle(plate)
    if not _HNF.Utils.antiSpamByTime(_HNF.Config.trackTime) then
        return false, _HNF.Utils.formatMessageNormalized({ message = _HNF.Locale("trackTimeInformation"), params = {_HNF.Config.trackTime / 1000} })
    end

    local locationVehicleTracked = lib.callback.await("hnf_garage:CheckIfVehicleIsSpawned", false, plate)
    if not locationVehicleTracked then
        local vehicleMode = lib.callback.await("hnf_garage:GetVehicleMode", false, plate)
        return vehicleMode, _HNF.Locale("isNoLongerTracking")
    end

    setVehicleLocationInTheMapsPlayer(locationVehicleTracked)

    return true, _HNF.Locale("trackedSuccessfuly")
end

RegisterNuiCallback("TrackVehicle", function(plate, cb)
    local result, message = trackVehicle(plate)
    cb({result = result, message = message})
end)