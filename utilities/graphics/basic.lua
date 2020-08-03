function styledTextOnBackground(styledText, textFrame, backgroundColor)
    local canvas = hs.canvas.new({x = 0, y = 0, w = 72, h = 72})
    canvas[1] = {
        frame = {x = 0, y = 0, w = 72, h = 72},
        type = "rectangle",
        fillColor = backgroundColor
    }
    canvas[2] = {
        frame = textFrame,
        text = styledText,
        type = "text"
    }
    return canvas:imageFromCanvas()
end