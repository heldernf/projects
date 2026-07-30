local bussyDimensions = {}

local function getFreeDimension()
    local targetDimension = 1

    for _, bussyDimension in ipairs(bussyDimensions) do
        if bussyDimension == targetDimension then
            targetDimension = targetDimension + 1
        else
            break
        end
    end

    return targetDimension
end

function HNF.Utils.setPlayerInFreeDimension(source)
    local freeDimension = getFreeDimension(1)
    table.insert(bussyDimensions, freeDimension)
    table.sort(bussyDimensions)

    SetPlayerRoutingBucket(source, freeDimension)
    return true
end
lib.callback.register("hnf_garage:utils:setPlayerInFreeDimension", HNF.Utils.setPlayerInFreeDimension)

function HNF.Utils.returnPlayerToDefaultDimension(source)
    local playerCurrentDimension = GetPlayerRoutingBucket(source)
    for i, bussyDimension in pairs(bussyDimensions) do
        if bussyDimension == playerCurrentDimension then
            table.remove(bussyDimensions, i)
        end
    end

    SetPlayerRoutingBucket(source, 0)
end
lib.callback.register("hnf_garage:utils:returnPlayerToDefaultDimension", HNF.Utils.returnPlayerToDefaultDimension)

function HNF.Utils.haveThisMoney(source, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerAmountMoney = xPlayer.getAccount(data.account).money

    return playerAmountMoney >= data.amount
end
lib.callback.register("hnf_garage:HaveThisMoney", HNF.Utils.haveThisMoney)

function HNF.Utils.removeAccountMoney(source, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local initialMoney = xPlayer.getAccount(data.account).money
    xPlayer.removeAccountMoney(data.account, data.amount)

    xPlayer = ESX.GetPlayerFromId(source)
    local finalMoney = xPlayer.getAccount(data.account).money

    return initialMoney - data.amount == finalMoney
end
lib.callback.register("hnf_garage:RemoveAccountMoney", HNF.Utils.removeAccountMoney)

function HNF.Utils.startLoadInUI(source)
    return lib.callback.await("hnf_garage:StartLoadInUI", source)
end