--Debug logger
local logger = hs.logger.new("init.lua", 4)

--Streamdeck Library Interface
streamdeck = require("streamdeck.streamdeckinterface")
local Page = require("streamdeck.page")
local Button = require("streamdeck.button")


local streamdeckConstants = require("streamdeck.constants")
require("streamdeck.utils")

local premiereStreamdeck = require("adobe.premiere.premierestreamdeck")
local hammerspoonStreamdeck = require("hammerspoonUtils.hammerspoonstreamdeck")
local locationsStreamdeck = require("locations.locationsstreamdeck")
local mouseStreamdeck = require("utilities.mousecontrol")
local copybankStreamdeck = require("copybank.copybankstreamdeck")

local resolveStreamdeck = require("resolve.resolvestreamdeck")

--Application/Window names
require("utilities.appUtils")
require("utilities.colours")

--Button Declarations
buttonOpenClips = Button:new(   "OpenClips",
                                createTextImage("Open", 20, COLORS.BLUE, 0, 15),
                                nil,
                                function(pDevice)
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], true):post()
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map[41], true):post()
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map[41], false):post()
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], false):post()
                                end)

buttonDownload = Button:new(   "DL",
                                createTextImage("DL", 20, COLORS.RED, 0, 15),
                                nil,
                                function(pDevice)
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], true):post()
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map[41], true):post()
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map[41], false):post()
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], false):post()
                                end)


buttonAppMenu = Button:new( "App Menu",
                            loadStreamdeckImage("Apps"),
                            COLORS.GREEN,
                            function(pDevice)
                                streamdeck.navigateForward(pDevice, streamdeck.pagePool["App Menu"])
                            end
                            )

buttonLaunchFinder = Button:new("Launch Finder",
                                hs.image.imageFromAppBundle(Apps.FINDER.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.FINDER.bundleID) end,
                                function(pDevice) closeAppByID(Apps.FINDER.bundleID) end)

buttonLaunchSafari = Button:new("Launch Safari",
                                hs.image.imageFromAppBundle(Apps.SAFARI.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.SAFARI.bundleID) end,
                                function(pDevice) closeAppByID(Apps.SAFARI.bundleID) end)

buttonLaunchOutlook = Button:new("Launch Outlook",
                                hs.image.imageFromAppBundle(Apps.OUTLOOK.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.OUTLOOK.bundleID) end,
                                function(pDevice) closeAppByID(Apps.OUTLOOK.bundleID) end)

buttonLaunchResolve = Button:new("Launch Resolve",
                                hs.image.imageFromAppBundle(Apps.PREMIERE.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.PREMIERE.bundleID) end,
                                function(pDevice) closeAppByID(Apps.PREMIERE.bundleID) end)

buttonLaunchPremiere = Button:new("Launch Premiere",
                                hs.image.imageFromAppBundle(Apps.PREMIERE.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.PREMIERE.bundleID) end,
                                function(pDevice) closeAppByID(Apps.PREMIERE.bundleID) end)

buttonLaunchAfterEffects = Button:new("Launch After Effects",
                                hs.image.imageFromAppBundle(Apps.AFTERFX.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.AFTERFX.bundleID) end,
                                function(pDevice) closeAppByID(Apps.AFTERFX.bundleID) end)

buttonLaunchMediaEncoder = Button:new("Launch Media Encoder",
                                hs.image.imageFromAppBundle(Apps.MEDIAENCODER.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.MEDIAENCODER.bundleID) end,
                                function(pDevice) closeAppByID(Apps.MEDIAENCODER.bundleID) end)

buttonLaunchAudition = Button:new("Launch Audition",
                                hs.image.imageFromAppBundle(Apps.AUDITION.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.AUDITION.bundleID) end,
                                function(pDevice) closeAppByID(Apps.AUDITION.bundleID) end)

buttonLaunchBridge = Button:new("Launch Bridge",
                                hs.image.imageFromAppBundle(Apps.BRIDGE.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.BRIDGE.bundleID) end,
                                function(pDevice) closeAppByID(Apps.BRIDGE.bundleID) end)

buttonLaunchCyberduck = Button:new("Launch Cyberduck",
                                hs.image.imageFromAppBundle(Apps.CYBERDUCK.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.CYBERDUCK.bundleID) end,
                                function(pDevice) closeAppByID(Apps.CYBERDUCK.bundleID) end)

buttonLaunchCode = Button:new("Launch Code",
                                hs.image.imageFromAppBundle(Apps.CODE.bundleID),
                                nil,
                                function(pDevice) launchAppByID(Apps.CODE.bundleID) end,
                                function(pDevice) closeAppByID(Apps.CODE.bundleID) end)

ButtonHelp = Button:new(   "Help",
                                                        createTextImage("Help", 20, COLORS.BLUE, 0, 15),
                                                        nil,
                                                        function(pDevice)

                                                            local click1 = {x = 1435, y = 1478}
                                                            local click2 = {x = 1435, y = 1520}
                                                            local mousePos = hs.mouse.getRelativePosition()
                                                            hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, mousePos):post()
                                                            hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, mousePos):post() 
                                                            local loops = 0
                                                            local endLoop = false

                                                            hs.timer.doUntil(function()
                                                                return endLoop
                                                            end,
                                                            function(timer)
                                                                local windows = hs.application.get(Apps.MEDIAENCODER.name):allWindows()

                                                                for key, value in pairs(windows) do
                                                                    if value:title() == "Export Settings" then
                                                                        hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, click1):post()
                                                                        hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, click1):post() 

                                                                        hs.timer.doAfter(0.3, function() 
                                                                            hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, click2):post()
                                                                            hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, click2):post()     
                                                                            
                                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], true):post()
                                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], false):post()
                                                                            hs.mouse.setRelativePosition(mousePos)
                                                                        end)
                                                                    end
                                                                endLoop = true
                                                                end
                                                            end)
                                                        end)   

--Streamdeck page declarations
homePage = Page:new("Home Page")
homePage.buttons = {
    [BOT_1] = hammerspoonStreamdeck.ButtonLoadPage,
    [BOT_5] = premiereStreamdeck.ButtonLoadPage,
    [TOP_1] = buttonAppMenu,
    [MID_5] = resolveStreamdeck.ButtonLoadPage,
    [TOP_2] = locationsStreamdeck.ButtonLoadPage,
    [TOP_5] = mouseStreamdeck.ButtonLoadPage,
    [MID_1] = copybankStreamdeck.ButtonLoadPage,
    [BOT_3] = ButtonHelp,
    [MID_3] = buttonOpenClips
}

appPage = Page:new("App Menu")
appPage.buttons = {
    [TOP_1]     = streamdeckConstants.ButtonBack,
    [TOP_3]     = buttonLaunchSafari,
    [TOP_2]     = buttonLaunchFinder,
    [MID_1]    = buttonLaunchPremiere,
    [MID_2]     = buttonLaunchAfterEffects,
    [MID_3]     = buttonLaunchMediaEncoder,
    [MID_4]     = buttonLaunchAudition,
    [BOT_5]    = buttonLaunchCyberduck,
    [BOT_1]    = buttonLaunchCode
}

--Streamdeck connected callback
function setupStreamdeck(pDevice)
    --Set the master/top level page and navigate to it
    streamdeck.masterPage(pDevice, homePage.id, true)




    --logger.df(hs.inspect(streamdeck))
end




streamdeck.registerPage(homePage)
streamdeck.registerPage(locationsStreamdeck.MasterPage)
streamdeck.registerPage(appPage)
streamdeck.registerPage(hammerspoonStreamdeck.MasterPage)
streamdeck.registerPage(mouseStreamdeck.MasterPage)
--streamdeck.registerPage(premiereStreamdeck.MasterPage)
streamdeck.registerPage(copybankStreamdeck.MasterPage)
premiereStreamdeck.init()
resolveStreamdeck.init()

streamdeck.init(setupStreamdeck)