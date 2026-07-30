lib.locale()

HNF = {
    Config = require("config.config"),
    System = {},
    Utils = {},
    Locale = locale,
    Details = {
        resourceName = GetCurrentResourceName(),
        locale = GetConvar("ox:locale") -- TODO: CHANGE
    },
}