require("utilities.appUtils")
require("utilities.screen")

local logger = hs.logger.new("premieresd.lua", 4)
local Profiler = require("utilities.profiler")

PremiereFunctions = {}

local function isPremiereCurrent()
    return isApplicationCurrent(Apps.PREMIERE.bundleID)
end

function PremiereFunctions.getPremiereApp()
    return getApplication(Apps.PREMIERE.bundleID)
end

local function tryCallPremiereMenuItem(menuItem)
    if isPremiereCurrent() then
        selectMenuItem(Apps.PREMIERE.bundleID, menuItem, true)
    end
end

function PremiereFunctions.NewSequence()
    tryCallPremiereMenuItem({"File", "New", "Sequence..."})
end

function PremiereFunctions.NewColorMatte()
    tryCallPremiereMenuItem({"File", "New", "Color Matte..."})
end

function PremiereFunctions.NewBlackVideo()
    tryCallPremiereMenuItem({"File", "New", "Black Video..."})
end

function PremiereFunctions.GetSelectionProperties()
    tryCallPremiereMenuItem({"File", "Get Properties for", "Selection..."})
end

function PremiereFunctions.Duplicate()
    tryCallPremiereMenuItem({"Edit", "Duplicate", "Color Matte..."})
end

function PremiereFunctions.EditClipInAudition()
    tryCallPremiereMenuItem({"Edit", "Edit in Adobe Audition", "Clip"})
end

function PremiereFunctions.EditSequenceInAudition()
    tryCallPremiereMenuItem({"Edit", "Edit in Adobe Audition", "Sequence..."})
end

function PremiereFunctions.MakeSubclip()
    tryCallPremiereMenuItem({"Clip", "Make Subclip..."})
end

function PremiereFunctions.EditSubclip()
    tryCallPremiereMenuItem({"Clip", "Edit Subclip..."})
end

function PremiereFunctions.SourceSettings()
    tryCallPremiereMenuItem({"Clip", "Souce Settings..."})
end

function PremiereFunctions.GenerateAudioWaveforms()
    tryCallPremiereMenuItem({"Clip", "Generate Audio Waveform"})
end

function PremiereFunctions.InterpretFootage()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["P"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["P"], false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post()
    -- Need a way to varify window is open/item is selected vefore proceeding
    -- Myabe make a focus clip to handle keypresses first?
    hs.timer.doAfter(1, function()
        tryCallPremiereMenuItem({"Clip", "Modify", "Interpret Footage..."})
    end)

end

function PremiereFunctions.ModifyAudioChannels()
    tryCallPremiereMenuItem({"Clip", "Modify", "Audio Channels..."})
end

function PremiereFunctions.SpeedDuration()
    tryCallPremiereMenuItem({"Clip", "Speed/Duration..."})
end

function PremiereFunctions.ReverseClip()
    PremiereFunctions.SpeedDuration()
    local loopIterations = 0
    local initalMousePosition = hs.mouse.getRelativePosition()
    local targetPositionRaw = {x = 857.0, y = 610.0}

    local targetColor = {
        alpha = 1.0,
        blue = 0.80201804637909,
        green = 0.80219793319702,
        red = 0.80204391479492
    }

    local targetColor2 = {
        alpha = 1.0,
        blue = 0.1598694473505,
        green = 0.15990529954433,
        red = 0.15987460315228
    }

    local targetPositionRaw2 = {x = 0.49869723814487, y = 0.47956630525438}

    local okTargetPositionRaw = {x = 999.765625, y = 715.2265625}
    hs.timer.doUntil(function()
        if loopIterations > 20 then
            loopIterations = 0
            hs.mouse.setRelativePosition(initalMousePosition)
            return true
        else
            return false
        end
    end, function(timer)
        -- hs.mouse.setRelativePosition(targetPositionRaw)

        -- local sampleColor = getPixelColorAtMousePosition()
        local sampleColor = getPixelColorAtInternalPoint(targetPositionRaw2)

        -- Some rounding issue is present when comparing directly
        -- should figure out why.
        -- Tostring is unlike to be too optimised

        if (tostring(sampleColor.red) == tostring(targetColor2.red)) and
            (tostring(sampleColor.green) == tostring(targetColor2.green)) and
            (tostring(sampleColor.blue) == tostring(targetColor2.blue)) then
            timer:stop()
            local premiere = PremiereFunctions.getPremiereApp()
            -- Ensure premiere is activated
            premiere:activate()
            -- Click checkbox to reverse clip
            -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, targetPositionRaw):post()
            -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, targetPositionRaw):post()

            hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
            hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()
            hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
            hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()
            hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, true):post()
            hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, false):post()

            -- Use keyboard to press ok button
            hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], true):post()
            hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], false):post()

            -- Click ok button
            -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, okTargetPositionRaw):post()
            -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, okTargetPositionRaw):post()

            hs.mouse.setRelativePosition(initalMousePosition)
        end
        loopIterations = loopIterations + 1
    end, 0.4)

    --[[
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], false):post()
    ]]
end

-- Doesn't use screenshots with pixel colour comparison. Substantially faster. 
-- Averages 40 mil seconds vs 340 + mil seconds
function PremiereFunctions.ReverseClip2()
    PremiereFunctions.SpeedDuration()
    local loopIterations = 0
    hs.timer.doUntil(function()
        if loopIterations > 20 then
            loopIterations = 0
            return true
        else
            return false
        end
    end, function(timer)
        -- Get a list of all open windows
        local openWindows = PremiereFunctions.getPremiereApp():allWindows()
        -- Iterate through all the windows, if we find one matching the title, stop the timer
        -- and do the keypresses
        for key, value in pairs(openWindows) do
            if value:title() == "Clip Speed / Duration" then
                timer:stop()
                -- Ensure premiere is activated
                local premiere = PremiereFunctions.getPremiereApp()
                premiere:activate()
                -- Use keyboard to select reverse checkbox
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, true):post()
                hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, false):post()

                -- Use keyboard to press ok button
                hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], true):post()
                hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], false):post()
            end
            loopIterations = loopIterations + 1
        end
    end, 0.05)
end

function PremiereFunctions.Nest() tryCallPremiereMenuItem({"Clip", "Nest..."}) end

function PremiereFunctions.ReplaceWithClipFromBin()
    tryCallPremiereMenuItem({"Clip", "Replace With Clip", "From Bin"})
end

function PremiereFunctions.ReplaceWithClipFromSourceMonitor()
    tryCallPremiereMenuItem({"Clip", "Replace With Clip", "From Source Monitor"})
end

function PremiereFunctions.ReplaceWithClipFromSourceMonitorMatchFrame()
    tryCallPremiereMenuItem({
        "Clip", "Replace With Clip", "From Source Monitor, Match Frame"
    })
end

function PremiereFunctions.SequenceSettings()
    tryCallPremiereMenuItem({"Sequence", "Sequence Settings..."})
end

function PremiereFunctions.SelectionFollowsPlayhead()
    tryCallPremiereMenuItem({"Sequence", "Selection Follows Playhead"})
end

function PremiereFunctions.LinkedSelection()
    tryCallPremiereMenuItem({"Sequence", "Linked Selection"})
end

function PremiereFunctions.GoToNextMarker()
    tryCallPremiereMenuItem({"Markers", "Go To Next Marker"})
end

function PremiereFunctions.GoToPreviousMarker()
    tryCallPremiereMenuItem({"Markers", "Go To Previous Marker"})
end

function PremiereFunctions.EditMarker()
    tryCallPremiereMenuItem({"Markers", "Edit Marker..."})
end

function PremiereFunctions.RippleSequenceMarkers()
    tryCallPremiereMenuItem({"Markers", "Ripple Sequence Markers"})
end

function PremiereFunctions.EffectsWindow()
    tryCallPremiereMenuItem({"Window", "Effects"})
end

function PremiereFunctions.ProjectsWindow()
    -- tryCallPremiereMenuItem({"Window", "Projects"})
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["shift"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["command"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["p"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["p"], false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["command"], false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["shift"], false):post()

end

function PremiereFunctions.EffectControlsWindow()
    -- tryCallPremiereMenuItem({"Window", "Effects Controls"})
    if isPremiereCurrent() then
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["e"], true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["e"], false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], false):post()
    end
end

function PremiereFunctions.LumetriScopesWindow()
    tryCallPremiereMenuItem({"Window", "Lumetri Scopes"})
end

function PremiereFunctions.LumetriPanelWindow()
    tryCallPremiereMenuItem({"Window", "Lumetri Color"})
end

function PremiereFunctions.TimecodeWindow()
    tryCallPremiereMenuItem({"Window", "Timecode"})
end

function PremiereFunctions.EssentialGraphicsWindow()
    tryCallPremiereMenuItem({"Window", "Essential Graphics"})
end

function PremiereFunctions.AudioGain()
    tryCallPremiereMenuItem({"Clip", "Audio Options", "Audio Gain..."})
end

function PremiereFunctions.FocusSearchBox()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["shift"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["f"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["f"], false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["shift"], false):post()
end

local function SearchForEffect(effectName)
    PremiereFunctions.EffectsWindow()
    hs.timer.doAfter(0.1, function()
        PremiereFunctions.FocusSearchBox()
        hs.eventtap.keyStrokes(effectName)
    end)
end

function PremiereFunctions.TestLocateWarpStabiliser()
    SearchForEffect("Warp Stabilizer Preset")
end

local presetIconColor = {
    alpha = 1.0,
    blue = 0.15674404799938,
    green = 0.15677456557751,
    red = 0.15675468742847
}

local topPresetIconPosition = {x = 0.014935741576936, y = 0.65163681284744}

function PremiereFunctions.DragPresetToMousePosition(effectPresetName)
    SearchForEFffect(effectPresetName)
    local startingMousePosition = hs.mouse.getRelativePosition()
    local loopIterations = 0
    local screenMappedPoint = convertInternalScreenPositionToScreenPosition(
                                  topPresetIconPosition)
    local currentScreen = hs.screen.mainScreen()
    local screenScale = currentScreen:currentMode().scale
    local basicScreenRect = {
        x = screenMappedPoint.x,
        y = screenMappedPoint.y,
        w = 1,
        h = 1
    }

    hs.timer.doUntil(function()
        if loopIterations > 20 then
            loopIterations = 0
            hs.mouse.setRelativePosition(startingMousePosition)
            return true
        else
            return false
        end
    end, function(timer)

        local image = currentScreen:snapshot(basicScreenRect)
        image:size({w = 1, h = 1}, false)
        local sampleColor = image:colorAt({x = 0, y = (1 * -1) + 1})

        local format = string.format("%s : %s", hs.inspect(sampleColor),
                                     hs.inspect(presetIconColor))
        logger.d(format)

        -- Some rounding issue is present when comparing directly
        -- should figure out why.
        -- Tostring is unlike to be too optimised

        if (tostring(sampleColor.red) == tostring(presetIconColor.red)) and
            (tostring(sampleColor.green) == tostring(presetIconColor.green)) and
            (tostring(sampleColor.blue) == tostring(presetIconColor.blue)) then
            timer:stop()
            local premiere = PremiereFunctions.getPremiereApp()
            -- Ensure premiere is activated
            premiere:activate()
            -- Click checkbox to reverse clip
            hs.eventtap.event.newMouseEvent(
                hs.eventtap.event.types.leftMouseDown, screenMappedPoint):post()
            hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp,
                                            startingMousePosition):post()
        end
        loopIterations = loopIterations + 1
    end, 0.5)
end

function PremiereFunctions.ApplyWarpStabiliser()
    PremiereFunctions.DragPresetToMousePosition("Warp Stabilizer Preset")
end

function PremiereFunctions.ApplyTOZSuperScalePreset()
    PremiereFunctions.DragPresetToMousePosition(
        "Lower Third Position, Scale, Drop Shadow")
end

local originalMousePosition
function PremiereFunctions.GoToPositionX()
    local normalisedXClickPosition = {x = 0.1235018238666, y = 0.1651376146789}
    local normalisedXClickPositionImac =
        {x = 0.12608544633553, y = 0.12229771463867}
    originalMousePosition = hs.mouse.getRelativePosition()

    hs.eventtap.event.newKeyEvent(hs.keycodes.map["ctrl"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["e"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["e"], false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["ctrl"], false):post()

    -- local currentMousePosition = hs.mouse.getRelativePosition()
    local screenMappedPosition = convertInternalScreenPositionToScreenPosition(
                                     normalisedXClickPositionImac)
    hs.mouse.setRelativePosition(screenMappedPosition)
    hs.timer.doAfter(0.01, function()
        hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown,
                                        screenMappedPosition):post()
    end)
    -- hs.timer.doAfter(0.02, function() end)
end

function PremiereFunctions.GoToScale()
    local normalisedXClickPosition = {x = 0.1235018238666, y = 0.1651376146789}
    local normalisedXClickPositionImac =
        {x = 0.12191733240709, y = 0.13526868437307}

    local scaleColor = {
        alpha = 1.0,
        blue = 0.91696047782898,
        green = 0.54755407571793,
        red = 0.16683122515678
    }
    local mousePosition = hs.mouse.getRelativePosition()

    PremiereFunctions.EffectControlsWindow()

    -- local currentMousePosition = hs.mouse.getRelativePosition()
    local screenMappedPosition = convertInternalScreenPositionToScreenPosition(
                                     normalisedXClickPositionImac)
    hs.mouse.setRelativePosition(screenMappedPosition)
    hs.timer.doAfter(0.01, function()
        hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown,
                                        screenMappedPosition):post()
        -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, { x = screenMappedPosition.x + 0.025, y = screenMappedPosition.y}):post()
        -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, screenMappedPosition):post()

    end)
    -- hs.timer.doAfter(0.02, function() end)
end

function PremiereFunctions.CopyKeyframes()
    local previousGenericData = hs.pasteboard.readAllData()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["c"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["c"], false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], false):post()
    local currentData = hs.pasteboard.readAllData()
    local allData = hs.pasteboard.readAllData()
    hs.pasteboard.writeAllData("PremiereKeyframes", allData)
    hs.pasteboard.writeAllData(previousGenericData)
    -- hs.pasteboard.setContents(previousGenericData)
end

function PremiereFunctions.PasteKeyframes()
    local previousData = hs.pasteboard.readAllData()
    hs.pasteboard.writeAllData(hs.pasteboard.readAllData("PremiereKeyframes"))
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["v"], true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["v"], false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map["cmd"], false):post()
    hs.pasteboard.writeAllData(previousData)
end

function PremiereFunctions.SetToFrameSize()
    tryCallPremiereMenuItem({"Clip", "Video Options", "Set to Frame Size"})
end

function PremiereFunctions.SetLabel(label)
    local labelDir = {"Edit", "Label", label}
    tryCallPremiereMenuItem(labelDir)
end

function PremiereFunctions.SelectLabelGroup()
    tryCallPremiereMenuItem({"Edit", "Label", "Select Label Group"})
end

function PremiereFunctions.MovePlayheadToCursor()
    local colorClear = {
        alpha = 1.0,
        blue = 0.09771928191185,
        green = 0.097738325595856,
        red = 0.097725935280323
    }
    local colorClearIO = {
        alpha = 1.0,
        blue = 0.081459172070026,
        green = 0.081475049257278,
        red = 0.081464722752571
    }
    local colorClearTrackTargeted = {
        alpha = 1.0,
        blue = 0.19523659348488,
        green = 0.19527462124825,
        red = 0.19524988532066
    }
    local otherColor = {
        alpha = 1.0,
        blue = 0.094958439469337,
        green = 0.09497694671154,
        red = 0.094964906573296
    }

    local mousePosition = hs.mouse.getRelativePosition()
    local currentScreen = hs.screen.mainScreen()
    local screenScale = currentScreen:currentMode().scale
    local pixelMappedPointX = mousePosition.x * screenScale
    local pixelMappedPointY = ((mousePosition.y * -1) +
                                  currentScreen:fullFrame().h) * screenScale
    local basicScreenRect = {
        x = mousePosition.x,
        y = mousePosition.y,
        w = 1,
        h = 1
    }
    local image = currentScreen:snapshot(basicScreenRect)
    image:size({w = 1, h = 1}, false)
    local sampleColor = image:colorAt({x = 0, y = (1 * -1) + 1})
    if ((tostring(sampleColor.red) == tostring(colorClear.red)) and
        (tostring(sampleColor.green) == tostring(colorClear.green)) and
        (tostring(sampleColor.blue) == tostring(colorClear.blue))) or
        ((tostring(sampleColor.red) == tostring(colorClearIO.red)) and
            (tostring(sampleColor.green) == tostring(colorClearIO.green)) and
            (tostring(sampleColor.blue) == tostring(colorClearIO.blue))) or
        ((tostring(sampleColor.red) == tostring(colorClearTrackTargeted.red)) and
            (tostring(sampleColor.green) ==
                tostring(colorClearTrackTargeted.green)) and
            (tostring(sampleColor.blue) ==
                tostring(colorClearTrackTargeted.blue))) or
        ((tostring(sampleColor.red) == tostring(otherColor.red)) and
            (tostring(sampleColor.green) == tostring(otherColor.green)) and
            (tostring(sampleColor.blue) == tostring(otherColor.blue))) then
        local premiere = PremiereFunctions.getPremiereApp()
        -- Ensure premiere is activated
        premiere:activate()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["\\"], true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["\\"], false):post()
    end
end

function PremiereFunctions.normaliseMaxPeakTo(t)
    PremiereFunctions.AudioGain();

    hs.timer.doAfter(0.5, function()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.down, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.up, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.up, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.tab, false):post()

        hs.eventtap.event.newKeyEvent(hs.keycodes.map["-"], true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["-"], false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map[t], true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map[t], false):post()

        hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map["return"], false):post()
    end)
end

function eventTapMouseCallback(eventObj)
    if isPremiereCurrent() then PremiereFunctions.MovePlayheadToCursor() end
end

local mouseWatcher = hs.eventtap.new({hs.eventtap.event.types.rightMouseDown},
                                     function(obj) eventTapMouseCallback(obj) end):start()

return PremiereFunctions
