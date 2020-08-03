local logger = hs.logger.new("resolvestreamdeck.lua", 4)

require("streamdeck.utils")
require("utilities.appUtils")
require("utilities.colours")
require("utilities.graphics.basic")
require("utilities.screen")

local resolveFunctions = require("resolve.resolvefunctions")

local streamdeckInterface   = require("streamdeck.streamdeckinterface")
local streamdeckConstants  = require("streamdeck.constants")
local Page = require("streamdeck.page")
local Button = require("streamdeck.button")

local ResolveStreamdeck = {}

local labelStyledText = {
    font = {name = ".AppleSystemUIFont", size = 15},
    color = hs.drawing.color.black,
    paragraphStyle = {
        alignment = "center",
        lineBreak = "charWrap"
    }
}

local memoryStyledText = {
    font = {name = ".AppleSystemUIFont", size = 16},
    color = hs.drawing.color.black,
    paragraphStyle = {
        alignment = "center",
        lineBreak = "wordWrap"
    }
}

local resolveImagePath = "resolve//images//"

ResolveStreamdeck.ButtonLoadPage = Button:new(  "Load Resolve Home",
                                                    hs.image.imageFromAppBundle(Apps.RESOLVE.bundleID),
                                                    nil,
                                                    function(pDevice)
                                                        streamdeckInterface.navigateForward(pDevice, ResolveStreamdeck.MasterPage)
                                                    end)

ResolveStreamdeck.ButtonLoadClipColorPage  = Button:new(  "Load Clip Colors",
                                                    createTextImage("Clip Colors", 24, COLORS.YELLOW, 0, 16),
                                                    nil,
                                                    function(pDevice)
                                                        streamdeckInterface.navigateForward(pDevice, ResolveStreamdeck.ClipColorPage)
                                                    end)

ResolveStreamdeck.ButtonLoadMemPage  = Button:new(  "Load Memorys",
                                                    createTextImage("Memories", 24, COLORS.WHITE, 0, 16),
                                                    nil,
                                                    function(pDevice)
                                                        streamdeckInterface.navigateForward(pDevice, ResolveStreamdeck.ColorWorkspace_MemoriesPage)
                                                    end)
--Clip Colours
ResolveStreamdeck.ButtonSetClipColorOrange = Button:new(  "Orange",
                                                    styledTextOnBackground(hs.styledtext.new("Orange", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.0,
                                                        green = 0.467,
                                                        red = 0.831
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Orange")
                                                    end,
                                                    nil)   
  
ResolveStreamdeck.ButtonSetClipColorApricot = Button:new(  "Apricot",
                                                    styledTextOnBackground(hs.styledtext.new("Apricot", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.02,
                                                        green = 0.678,
                                                        red = 0.925
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Apricot")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorYellow = Button:new(  "Yellow",
                                                    styledTextOnBackground(hs.styledtext.new("Yellow", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.118,
                                                        green = 0.678,
                                                        red = 0.831
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Yellow")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorLime = Button:new(  "Lime",
                                                    styledTextOnBackground(hs.styledtext.new("Lime", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.102,
                                                        green = 0.776,
                                                        red = 0.667
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Lime")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorOlive = Button:new(  "Olive",
                                                    styledTextOnBackground(hs.styledtext.new("Olive", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.443,
                                                        green = 0.596,
                                                        blue = 0.133,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Olive")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorGreen = Button:new(  "Green",
                                                    styledTextOnBackground(hs.styledtext.new("Green", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.267,
                                                        green = 0.561,
                                                        blue = 0.396,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Green")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorTeal = Button:new(  "Teal",
                                                    styledTextOnBackground(hs.styledtext.new("Teal", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.0,
                                                        green = 0.596,
                                                        blue = 0.6,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Teal")
                                                    end,
                                                    nil) 
                                                    
ResolveStreamdeck.ButtonSetClipColorNavy = Button:new(  "Navy",
                                                    styledTextOnBackground(hs.styledtext.new("Navy", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.212,
                                                        green = 0.376,
                                                        blue = 0.518,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Navy")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorBlue = Button:new(  "Blue",
                                                    styledTextOnBackground(hs.styledtext.new("Blue", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.475,
                                                        green = 0.659,
                                                        blue = 0.816,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Blue")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorPurple = Button:new(  "Purple",
                                                    styledTextOnBackground(hs.styledtext.new("Purple", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.6,
                                                        green = 0.451,
                                                        blue = 0.627,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Purple")
                                                    end,
                                                    nil)   

ResolveStreamdeck.ButtonSetClipColorViolet = Button:new(  "Violet",
                                                    styledTextOnBackground(hs.styledtext.new("Violet", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.729,
                                                        green = 0.369,
                                                        blue = 0.553,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Violet")
                                                    end,
                                                    nil)  

ResolveStreamdeck.ButtonSetClipColorPink = Button:new(  "Pink",
                                                    styledTextOnBackground(hs.styledtext.new("Pink", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.914,
                                                        green = 0.549,
                                                        blue = 0.71,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Pink")
                                                    end,
                                                    nil)  

ResolveStreamdeck.ButtonSetClipColorTan = Button:new(  "Tan",
                                                    styledTextOnBackground(hs.styledtext.new("Tan", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.71,
                                                        green = 0.65,
                                                        blue = 0.48,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Tan")
                                                    end,
                                                    nil)       
                                                    
ResolveStreamdeck.ButtonSetClipColorChocolate = Button:new(  "Chocolate",
                                                    styledTextOnBackground(hs.styledtext.new("Chocolate", {
                                                        font = {name = ".AppleSystemUIFont", size = 13},
                                                        color = hs.drawing.color.black,
                                                        paragraphStyle = {
                                                            alignment = "center",
                                                            lineBreak = "charWrap"
                                                        }
                                                    }),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        red = 0.506,
                                                        green = 0.365,
                                                        blue = 0.247,
                                                        alpha = 1.0
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        resolveFunctions.SetClipColor("Chocolate")
                                                    end,
                                                    nil)     
--Selection Follows Playhead Toggle
ResolveStreamdeck.ButtonToggleSelectionFollowsPlayhead = Button:new(  "Toggle Selection Follows Playhead",
                                                                    styledTextOnBackground(hs.styledtext.new("Selection Follows Playhead", labelStyledText),
                                                                    {x = 3, y = 5, w = 66, h = 72},
                                                                    {
                                                                        alpha = 1.0,
                                                                        blue = 0.5,
                                                                        green = 0.5,
                                                                        red = 0.5
                                                                      }),
                                                                    nil,
                                                                    function(pDevice)
                                                                        resolveFunctions.TryCallResolveMenuItem({"Timeline", "Selection Follows Playhead"})
                                                                    end,
                                                                    nil) 

ResolveStreamdeck.ButtonMedia = Button:new(    "Media",
                                                hs.image.imageFromPath(resolveImagePath .. "Media.png"), 
                                                nil, 
                                                function(pDevice)
                                                    hs.eventtap.keyStroke({"cmd", "ctrl", "shift", "alt"}, "m")
                                                end)

ResolveStreamdeck.ButtonFX = Button:new(    "FX",
                                                hs.image.imageFromPath(resolveImagePath .. "FX.png"), 
                                                nil, 
                                                function(pDevice)
                                                    hs.eventtap.keyStroke({"cmd", "ctrl", "shift", "alt"}, "f")
                                                end)

ResolveStreamdeck.ButtonEditIndex = Button:new(    "Edit Index",
                                                hs.image.imageFromPath(resolveImagePath .. "EditIndex.png"), 
                                                nil, 
                                                function(pDevice)
                                                    hs.eventtap.keyStroke({"cmd", "ctrl", "shift", "alt"}, "e")
                                                end)

ResolveStreamdeck.ButtonColorLoadMemoryA = Button:new(  "LD Mem A",
                                                        styledTextOnBackground(hs.styledtext.new("Load Memory A", memoryStyledText),
                                                                    {x = 3, y = 5, w = 66, h = 72},
                                                                    {
                                                                        alpha = 1.0,
                                                                        blue = 0.0,
                                                                        green = 0.5,
                                                                        red = 0.0
                                                                      }),
                                                        nil,
                                                        function(pDevice)
                                                            resolveFunctions.LoadMemory('1')
                                                        end,
                                                        nil)

ResolveStreamdeck.ButtonColorSaveMemoryA = Button:new(  "SV Mem A",
                                                        styledTextOnBackground(hs.styledtext.new("Save Memory A", memoryStyledText),
                                                                    {x = 3, y = 5, w = 66, h = 72},
                                                                    {
                                                                        alpha = 1.0,
                                                                        blue = 0.0,
                                                                        green = 0.0,
                                                                        red = 0.5
                                                                      }),
                                                        nil,
                                                        function(pDevice)
                                                            resolveFunctions.SaveMemory('1')
                                                        end,
                                                        nil)


--Resolve Master Page
ResolveStreamdeck.MasterPage = Page:new("Resolve Master")
ResolveStreamdeck.MasterPage.buttons = {
    [TOP_5] = ResolveStreamdeck.ButtonLoadMemPage,
    --[2] = ,
    --[3] = ,
    [TOP_2] = ResolveStreamdeck.ButtonMedia,
    [TOP_1] = streamdeckConstants.ButtonBack,
    --[6] = ,
    --[7] = ,
    --[8] = ,
    [MID_2] = ResolveStreamdeck.ButtonFX,
    [MID_1] = ResolveStreamdeck.ButtonLoadClipColorPage,
    --[11] = ,
    --[12] = ,
    --[13] = ,
    [BOT_2] = ResolveStreamdeck.ButtonEditIndex,
    [BOT_1] = ResolveStreamdeck.ButtonToggleSelectionFollowsPlayhead
}

ResolveStreamdeck.ClipColorPage = Page:new("Resolve Clip Colors")
ResolveStreamdeck.ClipColorPage.buttons = {
    [TOP_1] = streamdeckConstants.ButtonBack,
    [TOP_2] = ResolveStreamdeck.ButtonSetClipColorOrange,
    [TOP_3] = ResolveStreamdeck.ButtonSetClipColorApricot,
    [TOP_4] = ResolveStreamdeck.ButtonSetClipColorYellow,
    [TOP_5] = ResolveStreamdeck.ButtonSetClipColorLime,
    [MID_1] = ResolveStreamdeck.ButtonSetClipColorBlue,
    [MID_2] = ResolveStreamdeck.ButtonSetClipColorNavy,
    [MID_3] = ResolveStreamdeck.ButtonSetClipColorTeal,
    [MID_4] = ResolveStreamdeck.ButtonSetClipColorGreen,
    [MID_5] = ResolveStreamdeck.ButtonSetClipColorOlive,
    [BOT_1] = ResolveStreamdeck.ButtonSetClipColorPurple,
    [BOT_2] = ResolveStreamdeck.ButtonSetClipColorViolet,
    [BOT_3] = ResolveStreamdeck.ButtonSetClipColorPink,
    [BOT_4] = ResolveStreamdeck.ButtonSetClipColorTan,
    [BOT_5] = ResolveStreamdeck.ButtonSetClipColorChocolate
}

ResolveStreamdeck.ColorWorkspace_MemoriesPage = Page:new("Memories")
ResolveStreamdeck.ColorWorkspace_MemoriesPage.buttons = {
    --[1] = ResolveStreamdeck.ButtonSetClipColorLime,
    --[2] = ResolveStreamdeck.ButtonSetClipColorYellow,
    --[3] = ResolveStreamdeck.ButtonSetClipColorApricot,
    --[4] = ResolveStreamdeck.ButtonSetClipColorOrange,
    [TOP_1] = streamdeckConstants.ButtonBack,
    --[6] = ResolveStreamdeck.ButtonSetClipColorOlive,
    --[7] = ResolveStreamdeck.ButtonSetClipColorGreen,
    --[8] = ResolveStreamdeck.ButtonSetClipColorTeal,
    --[9] = ResolveStreamdeck.ButtonSetClipColorNavy,
    [MID_1] = ResolveStreamdeck.ButtonColorLoadMemoryA,
    --[11] = ResolveStreamdeck.ButtonSetClipColorChocolate,
    --[12] = ResolveStreamdeck.ButtonSetClipColorTan,
    --[13] = ResolveStreamdeck.ButtonSetClipColorPink,
    --[14] = ResolveStreamdeck.ButtonSetClipColorViolet,
    [BOT_1] = ResolveStreamdeck.ButtonColorSaveMemoryA
}


function ResolveStreamdeck.init()
    streamdeckInterface.registerPage(ResolveStreamdeck.MasterPage)
    streamdeckInterface.registerPage(ResolveStreamdeck.ClipColorPage)
    streamdeckInterface.registerPage(ResolveStreamdeck.ColorWorkspace_MemoriesPage)
end

return ResolveStreamdeck