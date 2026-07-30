local _HNF = HNF

local function getVehiclesInDepot(depot)
    if depot.isImpound then
        local ownedVehiclesImpounded = lib.callback.await("hnf_garage:GetOwnedVehiclesImpounded", false, depot.vehicleType)
        if not ownedVehiclesImpounded then _HNF.Utils.notify("no" .. depot.vehicleType:gsub("^%l", string.upper) .. "VehiclesFoundInImpound", "error") return end
        return ownedVehiclesImpounded
    else
        local ownedVehicles = lib.callback.await("hnf_garage:GetOwnedVehiclesByType", false, depot.vehicleType)
        if not ownedVehicles then _HNF.Utils.notify("none" .. depot.vehicleType:gsub("^%l", string.upper) .. "VehiclesFound", "error") return end
        return ownedVehicles
    end
end

function sendVehicleToUI(vehicleData, spawnLocation)
    local _vehicleMode, vehicleDisplayName = lib.callback.await("hnf_garage:GetVehicleMode", false, vehicleData.plate)
    if not _vehicleMode then return end

    local vehicleLabel = GetLabelText(vehicleDisplayName)
    SendNUIMessage({
        action = "addVehicleToUI", vehicle = vehicleData.vehicle, spawnLocation = spawnLocation,
        vehicleMode = _vehicleMode, carLabel = vehicleDisplayName == "CARNOTFOUND" and "???" or vehicleLabel,
    })
end

local camera
local function createVehicleViewCamera(depot)
    local distanceSpawn = _HNF.Utils.getPositionAroundCenter(depot.spawn.xy, depot.camera.distance, depot.camera.angle)
    local cameraPosition = vector3(distanceSpawn, depot.spawn.z + depot.camera.aditionalHeight)
    camera = _HNF.Utils.createCamera(cameraPosition, 1000)
    PointCamAtCoord(camera, depot.spawn.x, depot.spawn.y, depot.spawn.z - 1.0)
end

local function openUI(depot)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "openUI", isImpound = depot.isImpound })

    _HNF.Utils.hideTextUIIfDisplayed(_HNF.Locale("accessCarsInstruction")) -- TODO: VER AS NOTIFY QUE DEVEM SER ESCONDIDADE COM BASE SE É IMPOUND, GARAGE E SE É ACESSO OU SPAWN
end

--- @param depot table
--- @param depot.vehicleType string | "terrestrial" | "maritime" | "aerial"
--- @param depot.isImpound boolean -- This still doesn't work
--- @param depot.spawn vector4
--- @param depot.camera table
--- @param depot.camera.distance float
--- @param depot.camera.angle float
--- @param depot.camera.additionalHeight float
-- TODO: fazer um check no "depot" para ver se tem tudo que é necessário para abrir a garagem
local function accessVehicles(depot)
    if not _HNF.Utils.antiSpamByTime(1000) then return end

    local vehiclesInDepot = getVehiclesInDepot(depot)
    if not vehiclesInDepot then return end

    _HNF.Utils.stopPlayer()

    for i, v in pairs(vehiclesInDepot) do CreateThread(function() sendVehicleToUI(v, depot.spawn) end) end

    createVehicleViewCamera(depot)

    openUI(depot)
end
RegisterNetEvent("hnf_garage:AccessVehicles", accessVehicles)
exports("accessVehicles", accessVehicles)

RegisterNetEvent("hnf_garage:ClosedUI", function()
    _HNF.Utils.destroyCamera(camera, 1000)
    -- lib.showTextUI(_HNF.Locale("accessCarsInstruction"))
end)

RegisterNuiCallback("ClosedUI", function(_, cb)
    SetNuiFocus(false, false)
    TriggerEvent("hnf_garage:ClosedUI")
    cb("ok")
end)