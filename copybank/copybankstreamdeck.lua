require("streamdeck.utils")
require("utilities.colours")

local streamdeckConstants = require("streamdeck.constants")
local streamdeckInterface = require("streamdeck.streamdeckinterface")
local Page = require("streamdeck.page")
local Button = require("streamdeck.button")

local copybank = require("copybank.copybank")

local logger = hs.logger.new("copybankstreamdeck.lua", 4)

local CopybankStreamdeck = {
    copyBank1 = copybank:new("Bank 1"),
    copyBank2 = copybank:new("Bank 2"),
    copyBank3 = copybank:new("Bank 3"),
    copyBank4 = copybank:new("Bank 4"),
    copyBank5 = copybank:new("Bank 5")
}

CopybankStreamdeck.ButtonLoadPage = Button:new("Copybanks",
                                                createTextImage("Copy Banks", 20, COLORS.RED, 0, 12),
                                                nil,
                                                function(pDevice)
                                                    streamdeckInterface.navigateForward(pDevice, streamdeckInterface.pagePool["Copybanks"])
                                                end)

CopybankStreamdeck.ButtonCB1Copy = Button:new(  "CB1 Copy",
                                                createTextImage("CB1 Copy", 20, COLORS.BLUE, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank1:store()
                                                end)

CopybankStreamdeck.ButtonCB1Paste = Button:new( "CB1 Paste",
                                                createTextImage("CB1 Paste", 20, COLORS.GREEN, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank1:retrieve()
                                                end)
                                                
CopybankStreamdeck.ButtonCB2Copy = Button:new(  "CB2 Copy",
                                                createTextImage("CB2 Copy", 20, COLORS.BLUE, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank2:store()
                                                end)

CopybankStreamdeck.ButtonCB2Paste = Button:new( "CB2 Paste",
                                                createTextImage("CB2 Paste", 20, COLORS.GREEN, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank2:retrieve()
                                                end)

CopybankStreamdeck.ButtonCB3Copy = Button:new(  "CB3 Copy",
                                                createTextImage("CB3 Copy", 20, COLORS.BLUE, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank3:store()
                                                end)

CopybankStreamdeck.ButtonCB3Paste = Button:new( "CB3 Paste",
                                                createTextImage("CB3 Paste", 20, COLORS.GREEN, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank3:retrieve()
                                                end)

CopybankStreamdeck.ButtonCB4Copy = Button:new(  "CB4 Copy",
                                                createTextImage("CB4 Copy", 20, COLORS.BLUE, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank4:store()
                                                end)

CopybankStreamdeck.ButtonCB4Paste = Button:new( "CB4 Paste",
                                                createTextImage("CB4 Paste", 20, COLORS.GREEN, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank4:retrieve()
                                                end)

CopybankStreamdeck.ButtonCB5Copy = Button:new(  "CB5 Copy",
                                                createTextImage("CB5 Copy", 20, COLORS.BLUE, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank5:store()
                                                end)

CopybankStreamdeck.ButtonCB5Paste = Button:new( "CB5 Paste",
                                                createTextImage("CB5 Paste", 20, COLORS.GREEN, 0, 12),
                                                nil,
                                                function(pDevice) 
                                                    CopybankStreamdeck.copyBank5:retrieve()
                                                end)

CopybankStreamdeck.MasterPage = Page:new("Copybanks")
CopybankStreamdeck.MasterPage.buttons = {
    [TOP_1] = streamdeckConstants.ButtonBack,
    [MID_1] = CopybankStreamdeck.ButtonCB1Copy,
    [BOT_1] = CopybankStreamdeck.ButtonCB1Paste,
    [MID_2] = CopybankStreamdeck.ButtonCB2Copy,
    [BOT_2] = CopybankStreamdeck.ButtonCB2Paste,
    [MID_3] = CopybankStreamdeck.ButtonCB3Copy,
    [BOT_3] = CopybankStreamdeck.ButtonCB3Paste,
    [MID_4] = CopybankStreamdeck.ButtonCB4Copy,
    [BOT_4] = CopybankStreamdeck.ButtonCB4Paste,
    [MID_5] = CopybankStreamdeck.ButtonCB5Copy,
    [BOT_5] = CopybankStreamdeck.ButtonCB5Paste
}

function CopybankStreamdeck.init()
    streamdeckInterface.registerPage(CopybankStreamdeck.MasterPage)
end

return CopybankStreamdeck