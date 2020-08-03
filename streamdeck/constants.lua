streamdeckInterface = require("streamdeck.streamdeckinterface")
Button = require("streamdeck.button")

StreamdeckConstants = {}

StreamdeckConstants.defaultImagePath = "streamdeck//images//"

TOP_1 = 1
TOP_2 = 2
TOP_3 = 3
TOP_4 = 4
TOP_5 = 5
MID_1 = 6
MID_2 = 7
MID_3 = 8
MID_4 = 9
MID_5 = 10
BOT_1 = 11
BOT_2 = 12
BOT_3 = 13
BOT_4 = 14
BOT_5 = 15

function loadStreamdeckImage(path)
    return hs.image.imageFromPath(StreamdeckConstants.defaultImagePath .. path .. ".png")
end

function loadImage(path)
    return hs.image.imageFromPath(path .. ".png");
end



StreamdeckConstants.ButtonBack = Button:new(    "Back",
                                                loadStreamdeckImage("BackArrow"), 
                                                nil, 
                                                function(pDevice)
                                                    streamdeckInterface.navigateBack(pDevice)
                                                end)


return StreamdeckConstants

