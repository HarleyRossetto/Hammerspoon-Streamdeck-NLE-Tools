local logger = hs.logger.new("premierestreamdeck.lua", 4)

require("streamdeck.utils")
require("utilities.appUtils")
require("utilities.colours")
require("utilities.graphics.basic")
require("utilities.screen")

local premiereFunctions = require("adobe.premiere.premierefunctions")

local streamdeckInterface = require("streamdeck.streamdeckinterface")
local streamdeckConstants = require("streamdeck.constants")
local Page = require("streamdeck.page")
local Button = require("streamdeck.button")

local PremiereStreamdeck = {}

local labelStyledText = {
    font = {name = ".AppleSystemUIFont", size = 15},
    color = hs.drawing.color.black,
    paragraphStyle = {
        alignment = "center",
        lineBreak = "charWrap"
    }
}

PremiereStreamdeck.ButtonLoadPage = Button:new(  "Load Premiere Home",
                                                    hs.image.imageFromAppBundle(Apps.PREMIERE.bundleID),
                                                    nil,
                                                    function(pDevice)
                                                        streamdeckInterface.navigateForward(pDevice, PremiereStreamdeck.MasterPage)
                                                    end)

PremiereStreamdeck.ButtonReverseClip = Button:new(  "Reverse Clip",
                                                    createTextImage("Reverse Clip", 18, COLORS.WHITE, 0, 24),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.ReverseClip2()
                                                    end)
  
PremiereStreamdeck.ButtonTest = Button:new(  "Test",
                                                    createTextImage("Apply Warp", 18, COLORS.WHITE, 0, 24),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.ApplyWarpStabiliser()
                                                    end)

PremiereStreamdeck.ButtonPositionX = Button:new(  "X",
                                                    createTextImage("GOTO X", 18, COLORS.WHITE, 0, 24),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.GoToPositionX()
                                                    end)

PremiereStreamdeck.ButtonSetToFrameSize  = Button:new(  "Set To Frame Size",
                                                    createTextImage("Scale to Fit", 24, COLORS.WHITE, 0, 0),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetToFrameSize()
                                                    end)

PremiereStreamdeck.ButtonModifyAudioChannels  = Button:new(  "Modify Audio Channels",
                                                    createTextImage("Modify Audio Channels", 15, COLORS.WHITE, 0, 5),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.ModifyAudioChannels()
                                                    end)
PremiereStreamdeck.ButtonModifyAudioChannelsMono3  = Button:new(  "Mono 3 Audio",
                                                    createTextImage("Mono 3 Audio", 15, COLORS.WHITE, 0, 5),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.ModifyAudioChannels()

                                                        local loopIterations = 0
    hs.timer.doUntil(function()
                        if loopIterations > 20 then
                            loopIterations = 0
                            return true
                        else
                            return false
                        end
                    end,
                    function(timer)
                        --Get a list of all open windows
                        local openWindows = PremiereFunctions.getPremiereApp():allWindows()
                        --Iterate through all the windows, if we find one matching the title, stop the timer
                        --and do the keypresses
                        for key, value in pairs(openWindows) do
                            if value:title() == "Modify Clip" then
                                timer:stop()
                                --Ensure premiere is activated
                                local premiere = PremiereFunctions.getPremiereApp()
                                premiere:activate()
                                for i = 1, 5 do
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map["tab"], true):post()
                                    hs.eventtap.event.newKeyEvent(hs.keycodes.map["tab"], false):post()
                                end
                                hs.eventtap.event.newKeyEvent(hs.keycodes.map["3"], true):post()
                                hs.eventtap.event.newKeyEvent(hs.keycodes.map["3"], false):post()
                                hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], true):post()
                                hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], false):post()
                            end
                            loopIterations = loopIterations + 1
                        end
                    end,
                    0.05)

                                                    

                                                    end)

PremiereStreamdeck.ButtonLoadPanelsPage  = Button:new(  "Load Panels",
                                                    createTextImage("Panels", 24, COLORS.YELLOW, 0, 16),
                                                    nil,
                                                    function(pDevice)
                                                        streamdeckInterface.navigateForward(pDevice, PremiereStreamdeck.PanelsPage)
                                                    end)

PremiereStreamdeck.ButtonLoadLabelPage  = Button:new(  "Load Labels",
                                                    createTextImage("Labels", 24, COLORS.YELLOW, 0, 16),
                                                    nil,
                                                    function(pDevice)
                                                        streamdeckInterface.navigateForward(pDevice, PremiereStreamdeck.LabelPage)
                                                    end)

PremiereStreamdeck.ButtonSetLabelInterview  = Button:new(  "Label Interview",
                                                    styledTextOnBackground(hs.styledtext.new("Interview", labelStyledText), 
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.57325100898743,
                                                        green = 0.33206248283386,
                                                        red = 0.94571423530579
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Lavender")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)

PremiereStreamdeck.ButtonSetLabelStandup  = Button:new(  "Label Standup",
                                                    styledTextOnBackground(hs.styledtext.new("Stand-Up", labelStyledText),
                                                    {x = 1, y = 25, w = 70, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.88333284854889,
                                                        green = 0.0,
                                                        red = 0.86696666479111
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Violet")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)                                                    
                         
PremiereStreamdeck.ButtonSetLabelGraphics  = Button:new(  "Label Graphics",
                                                    styledTextOnBackground(hs.styledtext.new("Graphics", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.17657661437988,
                                                        green = 0.58266073465347,
                                                        red = 0.90529048442841
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Mango")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)   

PremiereStreamdeck.ButtonSetLabelVoiceOver  = Button:new(  "Label Voice Over",
                                                    styledTextOnBackground(hs.styledtext.new("Voice \nOver", labelStyledText),
                                                    {x = 3, y = 16, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.52323895692825,
                                                        green = 0.82017087936401,
                                                        red = 0.16665825247765
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Caribbean")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)   
                                                    
PremiereStreamdeck.ButtonSetLabelIris  = Button:new(  "Label Iris",
                                                    styledTextOnBackground(hs.styledtext.new("Iris", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.84979128837585,
                                                        green = 0.47389167547226,
                                                        red = 0.58311641216278
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Iris")
                                                    end)    
                                                    
PremiereStreamdeck.ButtonSetLabelLavender  = Button:new(  "Label Lavender",
                                                    styledTextOnBackground(hs.styledtext.new("Lavender", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.8629058599472,
                                                        green = 0.41088163852692,
                                                        red = 0.85241734981537
                                                    }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Lavender")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)     
                                                    
PremiereStreamdeck.ButtonSetLabelCerulean  = Button:new(  "Label Cerulean",
                                                    styledTextOnBackground(hs.styledtext.new("Cerulean", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.83808219432831,
                                                        green = 0.69685757160187,
                                                        red = 0.16919314861298
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Cerulean")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)  

PremiereStreamdeck.ButtonSetLabelForest  = Button:new(  "Label Forest",
                                                    styledTextOnBackground(hs.styledtext.new("Forest", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.27356877923012,
                                                        green = 0.68276035785675,
                                                        red = 0.26671436429024
                                                    }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Forest")
                                                    end)  

 PremiereStreamdeck.ButtonSetLabelPurple  = Button:new(  "Label Purple",
                                                    styledTextOnBackground(hs.styledtext.new("Purple", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.52040553092957,
                                                        green = 0.0,
                                                        red = 0.51132845878601
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Purple")
                                                    end)  

PremiereStreamdeck.ButtonSetLabelBlue  = Button:new(  "Label Blue",
                                                    styledTextOnBackground(hs.styledtext.new("Blue", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.99925351142883,
                                                        green = 0.084634259343147,
                                                        red = 0.17399753630161
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Blue")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)  
                                                    
PremiereStreamdeck.ButtonSetLabelGreen  = Button:new(  "Label Green",
                                                    styledTextOnBackground(hs.styledtext.new("Green", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.098909169435501,
                                                        green = 0.37385576963425,
                                                        red = 0.10292889177799
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Green")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)                                                      

PremiereStreamdeck.ButtonSetLabelMagenta  = Button:new(  "Label Magenta",
                                                    styledTextOnBackground(hs.styledtext.new("Magenta", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.88077068328857,
                                                        green = 0.0,
                                                        red = 0.87087935209274
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Magenta")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end) 

PremiereStreamdeck.ButtonSetLabelYellow  = Button:new(  "Label Yellow",
                                                    styledTextOnBackground(hs.styledtext.new("Yellow", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.32212373614311,
                                                        green = 0.87475001811981,
                                                        red = 0.86097770929337
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Yellow")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)   
                                                    
PremiereStreamdeck.ButtonSetLabelRed  = Button:new(  "Label Brown",
                                                    styledTextOnBackground(hs.styledtext.new("Red", labelStyledText),
                                                    {x = 3, y = 25, w = 66, h = 72},
                                                    {
                                                        alpha = 1.0,
                                                        blue = 0.084948360919952,
                                                        green = 0.04401770979166,
                                                        red = 0.56816607713699
                                                      }),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.SetLabel("Brown")
                                                    end,
                                                    function(pDevice)
                                                        premiereFunctions.SelectLabelGroup()
                                                    end)

PremiereStreamdeck.ButtonLumetriPanel = Button:new(  "Lumetri Panel",
                                                    createTextImage("Lumetri", 20, COLORS.PURPLE, 0, 20),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.LumetriPanelWindow()
                                                    end)

PremiereStreamdeck.ButtonGraphicsPanel = Button:new(  "Graphics Panel",
                                                    createTextImage("Graphics", 16, COLORS.BLUE, 0, 24),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.EssentialGraphicsWindow()
                                                    end)       
                                                    
PremiereStreamdeck.ButtonApplyTOZSuperPreset = Button:new(  "TOZ Super Preset",
                                                    createTextImage("TOZ Super Preset", 16, COLORS.BLUE, 0, 8),
                                                    nil,
                                                    function(pDevice)
                                                        --[[
                                                        local topPresetIconPosition =  {
                                                            x = 0.014935741576936,
                                                            y = 0.65163681284744
                                                        }
                                                        local mappedPos = convertInternalScreenPositionToScreenPosition(topPresetIconPosition)
                                                        local color = getPixelColorAtInternalPoint(topPresetIconPosition)
                                                        logger.d(hs.inspect(color))
                                                        ]]
                                                        premiereFunctions.DragPresetToMousePosition("Lower Third Position, Scale, Drop Shadow")
                                                    end)                                         

PremiereStreamdeck.ButtonSourceMonitor = Button:new(  "SRCMON",
                                                    createTextImage("SRC MON", 16, COLORS.GREEN, 0, 18),
                                                    nil,
                                                    function(pDevice)
                                                        hs.eventtap.keyStroke({'cmd', 'alt', 'shift', 'ctrl'}, 's')
                                                    end)

PremiereStreamdeck.ButtonProgramMonitor = Button:new(  "PRGMMON",
                                                    createTextImage("PRGM MON", 16, COLORS.RED, 0, 18),
                                                    nil,
                                                    function(pDevice)
                                                        hs.eventtap.keyStroke({'cmd', 'alt', 'shift', 'ctrl'}, 'p')
                                                    end)

PremiereStreamdeck.ButtonAudioNormaliseneg3 = Button:new(  "Normalise Neg 3",
                                                    createTextImage("Normalise -3", 14, COLORS.RED, 0, 18),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.normaliseMaxPeakTo(3)
                                                    end)    
                                                    
PremiereStreamdeck.ButtonGenerateAudioWaveform = Button:new(  "Gen Audio Waveform",
                                                    createTextImage("Gen Audio Waveform", 15, COLORS.YELLOW, 0, 10),
                                                    nil,
                                                    function(pDevice)
                                                        premiereFunctions.GenerateAudioWaveforms()
                                                    end)     
                                                    
PremiereStreamdeck.ButtonMakeSubclip = Button:new(  "MakeSubclip",
                                                    createTextImage("Make Subclip", 16, COLORS.BLUE, 0, 18),
                                                    nil,
                                                    function(pDevice)
                                                        if isApplicationCurrent(Apps.PREMIERE.bundleID) then
                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], true):post()
                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["u"], true):post()
                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["u"], false):post()
                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], false):post()
                                                            for i = 1, 3 do
                                                                hs.eventtap.event.newKeyEvent(hs.keycodes.map["tab"], true):post()
                                                                hs.eventtap.event.newKeyEvent(hs.keycodes.map["tab"], false):post()
                                                            end
                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["space"], true):post()
                                                            hs.eventtap.event.newKeyEvent(hs.keycodes.map["space"], false):post()
                                                        end
                                                    end)

--Premiere Master Page
PremiereStreamdeck.MasterPage = Page:new("Premiere Master")
PremiereStreamdeck.MasterPage.buttons = {
    [TOP_5] = PremiereStreamdeck.ButtonReverseClip,
    --[2] = PremiereStreamdeck.ButtonTest,
    [TOP_3] = PremiereStreamdeck.ButtonProgramMonitor,
    [TOP_2] = PremiereStreamdeck.ButtonSourceMonitor,
    [TOP_1] = streamdeckConstants.ButtonBack,
    --[6] = PremiereStreamdeck.ButtonGotoScale,
    --[7] = PremiereStreamdeck.ButtonGraphicsPanel,
    --[8] = PremiereStreamdeck.ButtonLumetriPanel,
    [MID_2] = PremiereStreamdeck.ButtonMakeSubclip,
    [MID_1] = PremiereStreamdeck.ButtonLoadLabelPage,
    [BOT_5] = PremiereStreamdeck.ButtonSetToFrameSize,
    [BOT_4] = PremiereStreamdeck.ButtonAudioNormaliseneg3,
    [BOT_3] = PremiereStreamdeck.ButtonGenerateAudioWaveform,
    [BOT_2] = PremiereStreamdeck.ButtonModifyAudioChannelsMono3,
    [BOT_1] = PremiereStreamdeck.ButtonModifyAudioChannels
}

PremiereStreamdeck.PanelsPage = Page:new("Premiere Panels")

PremiereStreamdeck.LabelPage = Page:new("Premiere Labels")
PremiereStreamdeck.LabelPage.buttons = {
    [TOP_1] = streamdeckConstants.ButtonBack,
    [TOP_5] = PremiereStreamdeck.ButtonSetLabelVoiceOver,
    [TOP_2] = PremiereStreamdeck.ButtonSetLabelGraphics,
    [TOP_3] = PremiereStreamdeck.ButtonSetLabelInterview,
    [TOP_4] = PremiereStreamdeck.ButtonSetLabelStandup,
    [MID_1] = PremiereStreamdeck.ButtonSetLabelYellow,
    [MID_2] = PremiereStreamdeck.ButtonSetLabelIris,
    [MID_3] = PremiereStreamdeck.ButtonSetLabelLavender,
    [MID_4] = PremiereStreamdeck.ButtonSetLabelCerulean,
    [MID_5] = PremiereStreamdeck.ButtonSetLabelForest,
    [BOT_1] = PremiereStreamdeck.ButtonSetLabelBlue,
    [BOT_2] = PremiereStreamdeck.ButtonSetLabelRed,
    [BOT_3] = PremiereStreamdeck.ButtonSetLabelPurple,
    [BOT_4] = PremiereStreamdeck.ButtonSetLabelGreen,
    [BOT_5] = PremiereStreamdeck.ButtonSetLabelMagenta
}
function PremiereStreamdeck.init()
    streamdeckInterface.registerPage(PremiereStreamdeck.MasterPage)
    streamdeckInterface.registerPage(PremiereStreamdeck.LabelPage)
end

return PremiereStreamdeck