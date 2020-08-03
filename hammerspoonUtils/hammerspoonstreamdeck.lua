require("streamdeck.utils")
require("utilities.appUtils")
require("utilities.colours")
require("utilities.filesystem")

local streamdeckConstants = require("streamdeck.constants")
local streamdeckInterface = require("streamdeck.streamdeckinterface")
local Page = require("streamdeck.page")
local Button = require("streamdeck.button")

local logger = hs.logger.new("hammerspoonsd.lua", 4)

local HammerspoonStreamdeck = {}

HammerspoonStreamdeck.ButtonLoadPage = Button:new(  "Load HS Page",
                                                    hs.image.imageFromAppBundle(Apps.HAMMERSPOON.bundleID),
                                                    nil,
                                                    function(pDevice)
                                                        streamdeckInterface.navigateForward(pDevice, HammerspoonStreamdeck.MasterPage)
                                                    end)

HammerspoonStreamdeck.ButtonReload = Button:new("Reload",
                                                loadStreamdeckImage("Reload"),
                                                nil,
                                                function(pDevice)
                                                    streamdeckInterface.flashStreamdeck(pDevice, COLORS.PURPLE)
                                                    hs.reload() 
                                                end)

HammerspoonStreamdeck.ButtonConsole = Button:new(   "Console",
                                                    createTextImage("Console", 18, COLORS.BLUE, 0, 20),
                                                    nil,
                                                    function(pDevice)
                                                       hs.openConsole() 
                                                    end)

HammerspoonStreamdeck.ButtonHammerspoonDirectory = Button:new(  "Hammerspoon Directory",
                                                                createTextImage("DIR", 28, COLORS.GREEN, 0, 20),
                                                                nil,
                                                                function(pDevice)
                                                                    --launchAppByID(Apps.FINDER.bundleID) 
                                                                    openDirectory(hs.configdir)
                                                                end)

HammerspoonStreamdeck.ButtonEditConfig = Button:new(  "Edit HS Config",
                                                                createTextImage("Edit", 28, COLORS.GREEN, 0, 20),
                                                                nil,
                                                                function(pDevice)
                                                                    
                                                                    local fivekimacworkspace = "Hammerspoon 5kImac.code-workspace"
                                                                    local laptopworkspace = "Hammerspoon-Laptop Workspace.code-workspace"
                                                                    local openDirectory = nil
                                                                    if string.find(hs.configdir, "gtv") then
                                                                        openDirectory = string.format("%s/%s", hs.configdir, fivekimacworkspace)
                                                                    elseif string.find(hs.configdir, "graingertv") then
                                                                        openDirectory = string.format("%s/%s", hs.configdir, laptopworkspace)
                                                                    else
                                                                        logger.d("Unable to determin system for VSCode workspace loading.")
                                                                        return
                                                                    end
                                                                    logger.d(openDirectory)
                                                                    hs.execute(string.format("open \"%s\"", openDirectory))
                                                                end)

HammerspoonStreamdeck.ButtonGetAppID = Button:new(  "Get App ID",
                                                    createTextImage("Inspect", 20, COLORS.GREEN, 0, 20),
                                                    nil,
                                                    function(pDevice)
                                                        local currentApp = hs.application.frontmostApplication()
                                                        local logger = streamdeckInterface.logger
                                                        local appName = currentApp:name()
                                                        local bundleId = currentApp:bundleID()
                                                        local codeString = string.format("{ name = \"%s\", bundleID = \"%s\"}", appName, bundleId)
                                                        hs.alert(codeString)
                                                        hs.pasteboard.setContents(codeString)
                                                    end)

HammerspoonStreamdeck.ButtonSnapshotTest = Button:new(  "Snapshot Test",
                                                    createTextImage("Snapshot", 20, COLORS.GREEN, 0, 20),
                                                    nil,
                                                    function(pDevice)
                                                        screenshotTests(pDevice)
                                                    end)

function screenshotTests(pDevice)
    local mousePosition = hs.mouse.getRelativePosition()

    local currentScreen = hs.screen.mainScreen()
    local screenScale = currentScreen:currentMode().scale

    local pixelMappedPointX = mousePosition.x * screenScale
    local pixelMappedPointY = ((mousePosition.y * -1) + currentScreen:fullFrame().h) * screenScale

    local x1 = math.floor(mousePosition.x + 0.5)
    local y1 = math.floor(mousePosition.y + 0.5)

    local basicScreenRect = {   x = x1,
                                y = y1,
                                w = 1,
                                h = 1
                            }

    logger.d(hs.inspect(basicScreenRect))
    local image = currentScreen:snapshot(basicScreenRect)

    image:size({w= 1, h = 1}, false)
    --logger.d(hs.inspect(image:size()))

    local colorAt = image:colorAt({x = 0, y = (1 * -1) + 1})

    local rect = hs.drawing.rectangle({x = 1000, y = 0, w = 50, h = 50})

    rect:setFillColor(colorAt)
    rect:show()
    image:saveToFile("test.png", true)
    if pDevice then
        pDevice:setButtonImage(1, image:setSize({w = 72, h = 72}, true))
    end
end

hs.hotkey.bind({"cmd", "shift"}, "r", function() 
    hs.reload() 
end)

HammerspoonStreamdeck.MasterPage = Page:new("Hammerspoon")
HammerspoonStreamdeck.MasterPage.buttons = {
    [TOP_1] = streamdeckConstants.ButtonBack,
    [MID_2] = HammerspoonStreamdeck.ButtonHammerspoonDirectory,
    [MID_1] = HammerspoonStreamdeck.ButtonGetAppID,
    [BOT_2] = HammerspoonStreamdeck.ButtonConsole,
    [BOT_1] = HammerspoonStreamdeck.ButtonReload,
    [BOT_5] = HammerspoonStreamdeck.ButtonEditConfig,
    [TOP_4] = HammerspoonStreamdeck.ButtonSnapshotTest
}

function HammerspoonStreamdeck.init()
    streamdeckInterface.registerPage(HammerspoonStreamdeck.MasterPage)
end

return HammerspoonStreamdeck