function HNF.Utils.createBlip(blip)
    local createdBlip = AddBlipForCoord(blip.position.x, blip.position.y, blip.position.z)
    SetBlipSprite(createdBlip, blip.sprite)
    SetBlipDisplay(createdBlip, 4)
    SetBlipScale(createdBlip, blip.size)
    SetBlipColour(createdBlip, blip.color)
    SetBlipAsShortRange(createdBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(blip.name)
    EndTextCommandSetBlipName(createdBlip)
    return createdBlip
end

function HNF.Utils.hideTextUIIfDisplayed(textToHide)
    local isOpen, text = lib.isTextUIOpen()

    if isOpen and text == textToHide then
        lib.hideTextUI()
    end
end

function HNF.Utils.spawnLocalVehicle(vehicle, location)
    local promise = promise:new()

    ESX.Game.SpawnLocalVehicle(vehicle.model, location.xyz, location.w, function(vehicleEntity)
        ESX.Game.SetVehicleProperties(vehicleEntity, vehicle)
        promise:resolve(vehicleEntity)
    end)

    return Citizen.Await(promise)
end

local antiSpamTimers = {}
function HNF.Utils.antiSpamByTime(waitTime)
    local callingFunction = debug.getinfo(2, "n").name or "unknown"

    if antiSpamTimers[callingFunction] then return end
    antiSpamTimers[callingFunction] = true

    CreateThread(function()
        Wait(waitTime or 500)
        antiSpamTimers[callingFunction] = nil
    end)

    return true
end

function HNF.Utils.stopPlayer()
    CreateThread(function()
        ClearPedTasksImmediately(cache.ped)

        local stoping = true
        SetTimeout(100, function()
            stoping = false
        end)

        while stoping do
            DisableAllControlActions(0)
            Wait(0)
        end
    end)
end

function HNF.Utils.setEntityAtCoords(entity, coords)
    if coords.xyz then SetEntityCoords(entity, coords.xyz) end
    if coords.w then SetEntityHeading(entity, coords.w) end
end

function HNF.Utils.setSelfInFreeDimension()
    return lib.callback.await("hnf_garage:utils:setPlayerInFreeDimension", false)
end

function HNF.Utils.returnSelfToDefaultDimension()
    return lib.callback.await("hnf_garage:utils:returnPlayerToDefaultDimension", false)
end

function HNF.Utils.createCamera(coords, transitionTime)
    local camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(camera, coords)
    RenderScriptCams(true, not not transitionTime, transitionTime, true, true)
    return camera
end

function HNF.Utils.destroyCamera(camera, transitionTime)
    RenderScriptCams(false, not not transitionTime, transitionTime, true, true)
    DestroyCam(camera, false)
end

function HNF.Utils.getPositionAroundCenter(center, radius, angle)
    local x = center.x + radius * math.cos(math.rad(angle))
    local y = center.y + radius * math.sin(math.rad(angle))
    return vector2(x, y)
end

function HNF.Utils.haveThisMoney(data)
    return lib.callback.await("hnf_garage:HaveThisMoney", false, data)
end

function HNF.Utils.removeAccountMoney(data)
    return lib.callback.await("hnf_garage:RemoveAccountMoney", false, data)
end

function HNF.Utils.formatMessageNormalized(data)
    data.message = data.message and data.message or ""
    data.params = type(data.params) == "table" and data.params or {}

    local _, amountPorcentS = string.gsub(data.message, "%%s", "")
    if amountPorcentS > 0 and #data.params == 0 then
        for i = 1, amountPorcentS do
            data.params[i] = "nil"
        end
    elseif amountPorcentS > #data.params then
        for i = 1, amountPorcentS do
            if not data.params[i] then
                data.params[i] = "nil"
            end
        end
    end

    return string.format(data.message, table.unpack(data.params))
end

function HNF.Utils.informFail(locale)
    TriggerEvent("hnf_garage:custom:Notify", HNF.Locale("generalErrorInstruction"), "error", 7000)

    locale = type(locale) == "table" and locale or { index = locale }

    if HNF.Locale(locale.index) then
        local message = HNF.Utils.formatMessageNormalized({ message = HNF.Locale(locale.index), params = locale.params })
        print(message)
        return
    end

    print(HNF.Locale("failLocale") or "^1[ERROR] ^3 The locale 'failLocale' is undefined or no exists. Show this to admin")
end

function HNF.Utils.startLoadInUI()
    SendNUIMessage({ action = "startLoad" })
    return true
end
lib.callback.register("hnf_garage:StartLoadInUI", HNF.Utils.startLoadInUI)