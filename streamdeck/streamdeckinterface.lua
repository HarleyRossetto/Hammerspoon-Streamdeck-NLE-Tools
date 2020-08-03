--Interface object
local StreamdeckInterface = {}

require("hs.streamdeck")
require("streamdeck.utils")

--Debug logger
local debug_logger = hs.logger.new("streamdeck_interface", 4)

--Dictionary of connected streamdecks
local connectedStreamdecks = {}

--Page history
local pagePool = {}
local pageHistory = {}

--Callback from parent application
local parentCallback = nil

local function streamdeckSetDisplayColor(pDevice, pButtonLowerId, pButtonUpperId, pColor)
    local startIndex = pButtonLowerId or 1
    local endIndex = pButtonUpperId or 15
    if pDevice then
        for i = startIndex, endIndex do
            pDevice:setButtonColor(i, pColor)
        end
    end
end


--Clears all button displays on the device
local function streamdeckClearDisplay(pDevice, pButtonLowerId, pButtonUpperId) 
    streamdeckSetDisplayColor(pDevice, pButtonLowerId, pButtonUpperId, {alpha = 1})
end

local function streamdeckLoadPage(pDevice, pPage)
    if pDevice then
        for i = 1, 15 do
            local button = pPage.buttons[i]
            --If the value is set load its visuals, otherwise clear the button.
            if button then
                if button.image then
                    pDevice:setButtonImage(i, button.image)
                elseif button.color then
                    pDevice:setButtonColor(i, button.color)
                else
                    --Generate image for button
                    local basicImage = createTextImage(button.id, 16, COLORS.WHITE, 0, 0)
                    pDevice:setButtonImage(i, basicImage)
                end
            else
                pDevice:setButtonColor(i, COLORS.BLACK)
            end
        end
        local sdObj = connectedStreamdecks[pDevice:serialNumber()]
        sdObj.currentPageId = pPage.id
        return true
    else
        debug_logger.df("Cannot load page, device nil.")
        return false
    end
end

--[[
    Navigates to devices master page if it exists.
    Clearing the devices page history in the process
]]--
local function streamdeckNavigateHome(pDevice)
    local sdiDevice = connectedStreamdecks[pDevice:serialNumber()]
    if sdiDevice and sdiDevice.masterPageId then
        if pagePool[sdiDevice.masterPageId] then
            streamdeckLoadPage(pDevice, pagePool[sdiDevice.masterPageId])
            local devicePageHistory = pageHistory[pDevice:serialNumber()]
            if devicePageHistory then
                devicePageHistory = nil
            end
        end
    end
end

local function streamdeckNavigateForward(pDevice, pPage) 
    --If no device specific history table exists, create one.
    if not pageHistory[pDevice:serialNumber()] then
        pageHistory[pDevice:serialNumber()] = {}
    end
    --Get a reference to devices history table
    local devicePageHistory = pageHistory[pDevice:serialNumber()]
    local streamdeck = connectedStreamdecks[pDevice:serialNumber()]
    --Load page onto device
    local success = streamdeckLoadPage(pDevice, pPage)
    if success then 
        --Ensure we are not storing the master page in the page history
        if pPage.id ~= streamdeck.masterPageId then
            --Insert the table into the history state
            table.insert(devicePageHistory, pPage.id)
        end
    else
        debug_logger.df("Failed to navigate to page %s", pPage.id)
    end
end

local function streamdeckNavigateBack(pDevice)
    --Local reference to devices specific history table
    local devicePageHistory = pageHistory[pDevice:serialNumber()]
    --Local reference to name of page we wish to navigate back to
    local previousPageId = #devicePageHistory - 1
    local success = false
    if previousPageId < 1 then
        local sdiDevice = connectedStreamdecks[pDevice:serialNumber()]
        if sdiDevice then
            local masterPage = pagePool[sdiDevice.masterPageId]
            if masterPage then
                success = streamdeckLoadPage(pDevice, masterPage)
            else
                --Do nothing, we have nothing to navigate back to
                debug_logger.df("Unable to navigate back, no pages in history and no master page to fall back on.")
            end
        end
    else 
        local pageBackName = devicePageHistory[previousPageId]
        local page = pagePool[pageBackName]
        success = streamdeckLoadPage(pDevice, page)
    end
    if success then
        table.remove(devicePageHistory)
    else
        debug_logger.df("Filed to navigatte back to page %s", page.id)
    end
end

local function streamdeckFlashButtons(pDevice, pColor)
    local sdObj = connectedStreamdecks[pDevice:serialNumber()]
    local page = pagePool[sdObj.currentPageId]
    for i = 1, 15 do
        pDevice:setButtonColor(i, pColor)
    end
    hs.timer.doAfter(0.1, function() streamdeckLoadPage(pDevice, page) end)
end

local function streamdeckButtonCallback(pDevice, pButtonId, pIsPressed)
    if connectedStreamdecks[pDevice:serialNumber()] then
        local sd = connectedStreamdecks[pDevice:serialNumber()]
        local currentPageId = sd.currentPageId
        local button = pagePool[currentPageId].buttons[pButtonId]
        if button then
            if pIsPressed then
                button:press(pDevice)
            elseif not pIsPressed then
                button:release(pDevice)
            end
        end
    else
        --Register streamdeck?
    end
end

local function streamdeckReset(pDevice)
    pDevice:reset()
    pDevice:buttonCallback(streamdeckButtonCallback)
end

local function streamdeckDiscoveryCallback(pConnected, pDevice)
    if pConnected then
        dev = {
            device = pDevice,
            currentBrightness = 60,
            previousBrightness = 0,
            masterPageId = nil,
            currentPageId = "NOTSET"
        }
        connectedStreamdecks[pDevice:serialNumber()] = dev
        streamdeckReset(pDevice)
        debug_logger.df("Streamdeck: %s connected", pDevice:serialNumber())

        parentCallback(pDevice)
        --DEBUG LINE SORT THIS OUT
        --streamdeckLoadPage(pDevice, pagePool["Home"])

    else
        debug_logger.d("Device Disconnected?")
        if connectedStreamdecks[pDevice:serialNumber()] then
            connectedStreamdecks[pDevice:serialNumber()].device = nil
            debug_logger.df("Streamdeck: %s disconnected", pDevice:serialNumber())
        end
    end
end

--Basic method to add a page to page pool
local function streamdeckRegisterPage(pPage)
    pagePool[pPage.id] = pPage
end

local function streamdeckMasterPage(pDevice, pPageId, pNavigateTo)
    local sdiDevice = connectedStreamdecks[pDevice:serialNumber()]
    if sdiDevice then
        sdiDevice.masterPageId = pPageId
        local navTo = pNavigateTo or true
        local pageToNavigateTo = pagePool[pPageId]
        if navTo and pageToNavigateTo then
            streamdeckLoadPage(pDevice, pageToNavigateTo)
        end
    end
end

local function registerContextualPageRelationship(pBundleId, pPageName)
    if not contextualPageDictionary then
        contextualPageDictionary = {}
    end
    contextualPageDictionary[pBundleId] = pPageName
end

local function applicationWatcherCallback(appName, eventType, appObject)
    if eventType == hs.application.watcher.activated then
        local cpdRef = contextualPageDictionary[appObject:bundleID()]
        if cpdRef then
            local pageRef = pagePool[cpdRef]
            if pageRef then


--DODGY SHIT HERE

                local device = connectedStreamdecks["AL37G1A09003"]
                streamdeckNavigateForward(device.device, pageRef)
            end
        end
    end
end

StreamdeckInterface.init                =   function(pParentCallback) 
                                                parentCallback = pParentCallback
                                                hs.streamdeck.init(streamdeckDiscoveryCallback) 
                                                if contextualPageDictionary then
                                                    applicationWatcher = hs.application.watcher.new(applicationWatcherCallback)
                                                    applicationWatcher:start()
                                                end
                                            end

StreamdeckInterface.loadPage            = streamdeckLoadPage
StreamdeckInterface.navigateForward     = streamdeckNavigateForward
StreamdeckInterface.navigateBack        = streamdeckNavigateBack
StreamdeckInterface.reset               = streamdeckReset
StreamdeckInterface.logger              = debug_logger
StreamdeckInterface.registerPage        = streamdeckRegisterPage
StreamdeckInterface.navigateHome        = streamdeckNavigateHome  
StreamdeckInterface.masterPage          = streamdeckMasterPage
StreamdeckInterface.setButtonColor      = streamdeckSetDisplayColor
StreamdeckInterface.createButton        = createButton
StreamdeckInterface.registerAppPage     = registerContextualPageRelationship
StreamdeckInterface.flashStreamdeck     = streamdeckFlashButtons

StreamdeckInterface.longPressFlashMode  = longPressFlash
StreamdeckInterface.streamdecks         = connectedStreamdecks
StreamdeckInterface.pagePool            = pagePool
StreamdeckInterface.contextualPageDictionary    = contextualPageDictionary

return StreamdeckInterface

