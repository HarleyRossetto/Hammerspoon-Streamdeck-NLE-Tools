
--[[
    pText = text to render
    pFontSize = font size
    pColor = font color
    pPosition = "Top", "Middle" or "Bottom"
]]--
function createTextImage(pText, pFontSize, pColor, pPositionX, pPositionY)
    local canvas = hs.canvas.new({w = 72, h = 72})
    local framePos = { h = 72, w = 72, x = pPositionX, y = pPositionY}
    canvas[1] = {
        frame = framePos,
        text = hs.styledtext.new(pText, {
            font = { name = ".AppleSystemUIFont", size = pFontSize},
            paragraphStyle = {alignment = "center", linebreak = "wordWrap"},
            color = pColor
        }),
        type = "text",
    }

    return canvas:imageFromCanvas()
end