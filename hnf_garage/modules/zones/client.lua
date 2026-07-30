local _HNF = HNF

local function getChildZonesHandlers(_type, depot)
    if _type == "access" then
        return {
            onEnter = function()
                if cache.vehicle then return end
                lib.showTextUI(_HNF.Locale("accessCarsInstruction"))
            end,
            onExit = function()
                _HNF.Utils.hideTextUIIfDisplayed(_HNF.Locale("accessCarsInstruction"))
            end,
            inside = function()
                if cache.vehicle then return end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("hnf_garage:AccessVehicles", depot)
                end
            end,
        }
    elseif _type == "parking" then
        return {
            onEnter = function()
                if not cache.vehicle then return end
                lib.showTextUI(_HNF.Locale("parkingCarInstruction"))
            end,
            onExit = function()
                _HNF.Utils.hideTextUIIfDisplayed(_HNF.Locale("parkingCarInstruction"))
            end,
            inside = function()
                if not cache.vehicle then return end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("hnf_garage:ParkVehicle", depot.vehicleType)
                end
            end
        }
    end
end

local function createZones(depot, marker, childZoneHandlers)
    local childZone
    lib.zones.sphere({
        coords = depot.center,
        radius = depot.viewDistance,
        onEnter = function()
            childZone = lib.zones.sphere({
                coords = depot.center,
                radius = depot.size,
                onEnter = childZoneHandlers.onEnter,
                onExit = childZoneHandlers.onExit,
                inside = childZoneHandlers.inside,
                debug = _HNF.Config.debugZones
            })
        end,
        onExit = function()
            CreateThread(function() childZone:remove() end)
        end,
        inside = function()
            DrawMarker(
                marker.type, depot.center.x, depot.center.y, (depot.center.z + depot.adjustMarkerPositionZ),
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                depot.size * 2, depot.size * 2, depot.size * 2,
                marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.upAndDownAnimation, marker.faceCamera,
                2, marker.rotate, nil, nil, false
            )
        end,
        debug = _HNF.Config.debugZones
    })
end

local function createBlipsAndSetZoneDepots(blip, depotData)
    for i, depot in pairs(depotData) do
        blip.position = depot.access.center
        _HNF.Utils.createBlip(blip)

        createZones(depot.access, _HNF.Config.markers.accessCar, getChildZonesHandlers("access", depot))
        if not depot.isImpound then createZones(depot.parking, _HNF.Config.markers.parkingCar, getChildZonesHandlers("parking", depot)) end
    end
end

createBlipsAndSetZoneDepots(_HNF.Config.blips.garage, _HNF.Config.depots, false)