local function notify(message, messageType, duration)
    ESX.ShowNotification(message, messageType, duration)
end
RegisterNetEvent("hnf_garage:custom:Notify", notify)