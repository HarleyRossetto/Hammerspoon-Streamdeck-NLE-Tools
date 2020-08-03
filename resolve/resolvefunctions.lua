require("utilities.appUtils")
require("utilities.screen")

local logger = hs.logger.new("premieresd.lua", 4)
local Profiler = require("utilities.profiler")

ResolveFunctions = {}

local function isResolveCurrent()
    return isApplicationCurrent(Apps.RESOLVE.bundleID)
end

function ResolveFunctions.TryCallResolveMenuItem(menuItem)
    if isResolveCurrent() then
        selectMenuItem(Apps.RESOLVE.bundleID, menuItem, true)
    end
end

function ResolveFunctions.SetClipColor(label)
    local labelDir = {"Mark", "Set Clip Color", label}
    ResolveFunctions.TryCallResolveMenuItem(labelDir)
end

function ResolveFunctions.LoadMemory(number)
    hs.eventtap.keyStroke({"cmd"}, number)
end

function ResolveFunctions.SaveMemory(number)
    hs.eventtap.keyStroke({"option"}, number)
end

return ResolveFunctions