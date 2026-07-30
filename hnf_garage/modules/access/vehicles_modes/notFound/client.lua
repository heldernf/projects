local _HNF = HNF

RegisterNuiCallback("NotFoundVehicle", function(vehicleModel, cb)
    cb({ message = _HNF.Utils.formatMessageNormalized({ message = _HNF.Locale("vehicleNotfound"), params = {vehicleModel} }) })
end)