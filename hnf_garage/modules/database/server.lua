while true do
    local invalidType = MySQL.rawExecute.await("SELECT `owner`, `plate` FROM `owned_vehicles` WHERE `type` != ?", { "terrestrial" })

    for i, v in pairs(invalidType) do
        MySQL.update.await("UPDATE `owned_vehicles` SET `type` = ? WHERE `owner` = ? AND `plate` = ?", { "terrestrial", v.owner, v.plate })
    end

    Wait(15000)
end