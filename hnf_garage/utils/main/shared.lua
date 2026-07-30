-- local _HNF = HNF
-- print(_HNF.ResourceName)

-- local sideName = IsDuplicityVersion() and "server" or "client"

-- local folderGeneralShared = LoadResourceFile(_HNF.ResourceName, "utils/general/shared.lua")
-- local folderGeneralSide = LoadResourceFile(_HNF.ResourceName, "utils/general/" .. sideName .. ".lua")
-- print(folderGeneralSide, folderGeneralShared)
-- local allUtilsFunctions = {
--     lib.table.merge(folderGeneralSide, folderGeneralShared),
-- }

-- local allUtilsFunctionsMerged = {}

-- for i, v in pairs(allUtilsFunctions) do
--     for functionName, functionHandle in pairs(v) do
--         allUtilsFunctionsMerged[functionName] = functionHandle
--     end
-- end

-- return allUtilsFunctionsMerged