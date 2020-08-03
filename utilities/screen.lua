local logger = hs.logger.new("screen.lua", 4)

function mapRange(value, valueLow, valueHigh, targetLow, targetHigh)
    return targetLow + ((value - valueLow) * (targetHigh - targetLow)) / (valueHigh - valueLow)
end

function convertInternalScreenPositionToScreenPosition(mappedPoint)
    local screenFrame = hs.screen.mainScreen():fullFrame()
    local mappedX = mapRange(mappedPoint.x, 0, 1, 0, screenFrame.w)
    local mappedY = mapRange(mappedPoint.y, 0, 1, 0, screenFrame.h)
    return {x = mappedX, y = mappedY}
end

function getPixelColorAtPoint(point)
    return hs.screen.mainScreen():snapshot():colorAt(point)
end

function getPixelColorAtPoint2(point)
    local bounds = {   
        x = point.y,
        y = point.x,
        w = 1,
        h = 1
    }
    local img =  hs.screen.mainScreen():snapshot(bounds)
    return img:colorAt({x = 0, y = 0})
end

function getPixelColorAtMousePosition()
    local currentScreen = hs.screen.mainScreen()
    local scale = currentScreen:currentMode().scale
    local mousePos = hs.mouse.getRelativePosition()
    local mappedPosition = hs.geometry.point(mousePos.x * scale, ((mousePos.y * -1) + currentScreen:fullFrame().h) * scale)
    return getPixelColorAtPoint(mappedPosition)
end

function getPixelColorAtMousePosition2()
    local mousePos = hs.mouse.getRelativePosition()

    local currentScreen = hs.screen.mainScreen()
    local scale = currentScreen:currentMode().scale

    local mX = math.floor(mousePos.x + 0.5)
    local mY = math.floor(mousePos.y + 0.5)

    local mappedPosition = hs.geometry.point(mX * scale, ((mY * -1) + currentScreen:fullFrame().h) * scale)

    local bounds = {   
        x = mappedPosition.y,
        y = mappedPosition.x,
        w = 1,
        h = 1
    }

    --local image = currentScreen:snapshot(bounds)
    local image = currentScreen:snapshot(hs.geometry(mappedPosition.x, mappedPosition.y, 1, 1))

    return image:colorAt({x = 0, y = 0})
end

function getPixelColorAtInternalPoint(point)
    local currentScreen = hs.screen.mainScreen()
    local scale = currentScreen:currentMode().scale
    point = convertInternalScreenPositionToScreenPosition(point)
    local mappedPosition = hs.geometry.point(point.x * scale, ((point.y * -1) + currentScreen:fullFrame().h) * scale)
    return getPixelColorAtPoint(mappedPosition)
end

function screenshotActiveScreen()
    return hs.screen.mainScreen():snapshot()
end