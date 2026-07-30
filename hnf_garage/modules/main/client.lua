local _HNF = HNF

-- TODO: transformar em uma func "UTILS"
function HNF.Utils.hasRequiredMoney(moneyData, localeIndex)
    local hasMoney = lib.callback.await("hnf_garage:HaveThisMoney", false, moneyData)
    if not hasMoney then
        -- TODO: TROCAR POR NOTIFY DA UI
        lib.alertDialog({ header = _HNF.Locale[localeIndex], centered = true, })
    end

    return hasMoney
end