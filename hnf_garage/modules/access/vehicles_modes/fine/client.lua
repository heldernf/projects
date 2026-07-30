local _HNF = HNF

RegisterNuiCallback("FineVehicle", function(data, cb)
    cb({message = _HNF.Locale("vehicleWithPendencyFines")})
end)