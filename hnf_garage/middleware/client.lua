local _HNF = HNF

function HNF.Utils.notify(locale, messageType, duration)
    CreateThread(function()
        if type(locale) ~= "table" then
            locale = { index = locale }
        end

        if not HNF.Locale(locale.index) then
            print(("^3[ERROR] ^7Locale (%s) not found"):format(HNF.Locale(locale.index)))
            return
        end

        ESX.ShowNotification(HNF.Locale(locale.index, table.unpack(locale.params or {})), messageType, duration)
    end)
end

RegisterNetEvent("hnf_basicgarage:Notify", HNF.Utils.notify)