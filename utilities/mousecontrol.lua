require("streamdeck.utils")
require("utilities.appUtils")
require("utilities.colours")
require("utilities.filesystem")

local streamdeckConstants = require("streamdeck.constants")
local streamdeckInterface = require("streamdeck.streamdeckinterface")
local Page = require("streamdeck.page")
local Button = require("streamdeck.button")

local logger = hs.logger.new("mousecontrol.lua", 4)

local Profiler = require("utilities.profiler")

local rate = true
local highRate = 20
local lowRate = 1

local MouseControlStreamdeck = {}

local function adjustMousePosition(xDelta, yDelta)
    local pos = hs.mouse.getRelativePosition()
    hs.mouse.setRelativePosition({x = (pos.x + xDelta), y = (pos.y + yDelta)})
end

local renderableText = nil
local showPos = true
local renderableColorRect = nil

local function updatePosition()
    if showPos then
        if not renderableText then
            renderableText = hs.drawing.text({w = 250, h = 250}, "")
            renderableText:setTextColor(COLORS.BLUE)
            renderableText:show()
        end
        renderableText:setText(hs.inspect(hs.mouse.getRelativePosition()))
    else
        if renderableText then
            renderableText:hide()
        end
    end
end

local renderableMappedPosition = nil

local function renderMappedValue()
    local mappedValues = {x = 0, y = 0}
    if showPos then
        if not renderableMappedPosition then
            renderableMappedPosition = hs.drawing.text({x = 200, y = 0, w = 400, h = 250}, "")
            renderableMappedPosition:setTextColor(COLORS.YELLOW)
            renderableMappedPosition:show()
            renderableMappedPosition:setClickCallback(nil, function() hs.pasteboard.setContents(hs.inspect(mappedValues)) end)
        end
        local mouseRelativePosition = hs.mouse.getRelativePosition()
        local screenFrame = hs.screen.mainScreen():fullFrame()
        mappedValues.x = mapRange(mouseRelativePosition.x, 0, screenFrame.w - 1, 0, 1)
        mappedValues.y = mapRange(mouseRelativePosition.y, 0, screenFrame.h - 1, 0, 1)
        renderableMappedPosition:setText(string.format("X: %s\nY: %s", mappedValues.x, mappedValues.y))
    else
        if renderableMappedPosition then
            renderableMappedPosition:hide()
        end
    end
end

MouseControlStreamdeck.ButtonLoadPage = Button:new("Mouse Control",
                                                createTextImage("Mouse Ctrl", 16, COLORS.WHITE, 0, 24),
                                                nil,
                                                function(pDevice)
                                                    streamdeckInterface.navigateForward(pDevice, streamdeckInterface.pagePool["Mouse Control"])
                                                end)

MouseControlStreamdeck.ButtonUp = Button:new("Up",
                                                        createTextImage("Up", 20, COLORS.WHITE, 0, 24),
                                                        nil,
                                                        function(pDevice) 
                                                            local adjustValue = 0
                                                            if rate then
                                                                adjustValue = highRate
                                                            else
                                                                adjustValue = lowRate
                                                            end
                                                            adjustMousePosition(0, -adjustValue)
                                                            updatePosition()
                                                            renderMappedValue()
                                                        end)


MouseControlStreamdeck.ButtonDown = Button:new(   "Down",
                                                        createTextImage("Down", 20, COLORS.WHITE, 0, 24),
                                                        nil,
                                                        function(pDevice)
                                                            local adjustValue = 0
                                                            if rate then
                                                                adjustValue = highRate
                                                            else
                                                                adjustValue = lowRate
                                                            end
                                                            adjustMousePosition(0, adjustValue)
                                                            updatePosition()
                                                            renderMappedValue()
                                                        end)      
                                                        
MouseControlStreamdeck.ButtonLeft = Button:new(   "Left",
                                                        createTextImage("Left", 20, COLORS.WHITE, 0, 24),
                                                        nil,
                                                        function(pDevice)
                                                            local adjustValue = 0
                                                            if rate then
                                                                adjustValue = highRate
                                                            else
                                                                adjustValue = lowRate
                                                            end
                                                            adjustMousePosition(-adjustValue, 0)
                                                            updatePosition()
                                                            renderMappedValue()
                                                        end) 
                                                        
MouseControlStreamdeck.ButtonRight = Button:new(   "Right",
                                                        createTextImage("Right", 20, COLORS.WHITE, 0, 24),
                                                        nil,
                                                        function(pDevice)
                                                            local adjustValue = 0
                                                            if rate then
                                                                adjustValue = highRate
                                                            else
                                                                adjustValue = lowRate
                                                            end
                                                            adjustMousePosition(adjustValue, 0)
                                                            updatePosition()
                                                            renderMappedValue()
                                                        end)  
                                                        
MouseControlStreamdeck.ButtonRate = Button:new(   "Rate",
                                                        createTextImage("RATE", 20, COLORS.WHITE, 0, 24),
                                                        nil,
                                                        function(pDevice)
                                                            rate = not rate
                                                        end)    

MouseControlStreamdeck.ButtonMousePosition = Button:new("MousePosition",
                            createTextImage("Mouse Pos", 16, COLORS.RED, 0, 15),
                            nil,
                            function(pDevice)
                                logger.df(hs.inspect(hs.mouse.getRelativePosition()))
                            end)


MouseControlStreamdeck.ButtonSampleColor = Button:new(  "Sample",
                                                        createTextImage("Color", 20, COLORS.YELLOW, 0, 15),
                                                        nil,
                                                        function(pDevice) 
                                                            --local color = getPixelColorAtMousePosition()
                                                            local pr1 = Profiler:start("fullshot")
                                                            local color = getPixelColorAtMousePosition()
                                                            pr1:stop()
                                                            local pr2 = Profiler:start("pixel")
                                                            local color = getPixelColorAtMousePosition2()
                                                            pr2:stop()

                                                            if showPos then
                                                                if not renderableColorRect then
                                                                    renderableColorRect = hs.drawing.rectangle({x = 200, y = 0, w = 50, h = 50})
                                                                    renderableColorRect:show()
                                                                end
                                                                renderableColorRect:setFillColor(color)
                                                            else
                                                                if renderableColorRect then
                                                                    renderableColorRect:hide()
                                                                end
                                                            end
                                                            hs.pasteboard.setContents(hs.inspect(color))
                                                            --pDevice:setButtonColor(14, color)
                                                        end)
                                                        
MouseControlStreamdeck.MasterPage = Page:new("Mouse Control")
MouseControlStreamdeck.MasterPage.buttons = {
    [TOP_1] = streamdeckConstants.ButtonBack,
    [TOP_4] = MouseControlStreamdeck.ButtonUp,
    [MID_3] = MouseControlStreamdeck.ButtonLeft,
    [MID_4] = MouseControlStreamdeck.ButtonRate,
    [MID_5] = MouseControlStreamdeck.ButtonRight,
    [BOT_4] = MouseControlStreamdeck.ButtonDown,
    [BOT_1] = MouseControlStreamdeck.ButtonMousePosition,
    [MID_2] = MouseControlStreamdeck.ButtonSampleColor                             
}

function MouseControlStreamdeck.init()
    streamdeckInterface.registerPage(MouseControlStreamdeck.MasterPage)
end



return MouseControlStreamdeck