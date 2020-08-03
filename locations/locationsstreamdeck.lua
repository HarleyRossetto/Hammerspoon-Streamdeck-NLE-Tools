require("streamdeck.utils")
require("utilities.appUtils")
require("utilities.colours")
require("utilities.filesystem")

local streamdeckConstants = require("streamdeck.constants")
local streamdeckInterface = require("streamdeck.streamdeckinterface")
local Page = require("streamdeck.page")
local Button = require("streamdeck.button")

local LocationsStreamdeck = {}

local preferredBrowser = Apps.SAFARI

LocationsStreamdeck.ButtonLoadPage = Button:new("Locations",
                                                createTextImage("Locations", 16, COLORS.WHITE, 0, 24),
                                                nil,
                                                function(pDevice)
                                                    streamdeckInterface.navigateForward(pDevice, streamdeckInterface.pagePool["Locations"])
                                                end)

LocationsStreamdeck.buttonLocationsDropbox = Button:new("Location Dropbox",
                                                        hs.image.imageFromAppBundle(Apps.DROPBOX.bundleID),
                                                        nil,
                                                        function(pDevice) 
                                                            --Desktop
                                                            openDirectory("/Volumes/GTV Raid/Dropbox")
                                                            --Laptop
                                                            --openDirectory("~/Dropbox")
                                                        end)


LocationsStreamdeck.buttonLocationsRAID = Button:new(   "Location RAID",
                                                        createTextImage("GTV RAID", 20, COLORS.WHITE, 0, 15),
                                                        nil,
                                                        function(pDevice)
                                                            openDirectory("/Volumes/GTV Raid")
                                                        end)          
                                                        
LocationsStreamdeck.ButtonLocationsTravelOz = Button:new(   "Location TOZ",
                                                        createTextImage("Raid TOZ", 20, COLORS.WHITE, 0, 15),
                                                        nil,
                                                        function(pDevice)
                                                            openDirectory("/Volumes/GTV Raid/Travel Oz")
                                                        end)  
                                                        
LocationsStreamdeck.ButtonLocationsProjects = Button:new(   "Location Projects",
                                                        createTextImage("Projects", 20, COLORS.WHITE, 0, 15),
                                                        nil,
                                                        function(pDevice)
                                                            openDirectory("/Volumes/GTV Raid/Projects")
                                                        end)      

LocationsStreamdeck.ButtonLocationsVimeo = Button:new(   "Vimeo Home",
                                                        loadStreamdeckImage("vimeo"),
                                                        nil,
                                                        function(pDevice)
                                                            hs.execute("open https://vimeo.com")
                                                        end)    

LocationsStreamdeck.ButtonLocationsVimeoUpload = Button:new(   "Vimeo Upload",
                                                        createTextImage("Vimeo Upload", 20, COLORS.WHITE, 0, 15),
                                                        nil,
                                                        function(pDevice)
                                                            hs.execute("open https://vimeo.com/upload")
                                                        end)     
                                                        
LocationsStreamdeck.ButtonLocationsTransit = Button:new(   "Transit",
                                                        createTextImage("Transit", 20, COLORS.BLUE, 0, 15),
                                                        nil,
                                                        function(pDevice)
                                                            openDirectory("/Volumes/GTV Raid/Dropbox/GTV/transit")
                                                        end)   
                                                        
LocationsStreamdeck.ButtonLocationsEITS = Button:new(   "EITS",
                                                        createTextImage("EITS", 16, COLORS.GREEN, 0, 20),
                                                        nil,
                                                        function(pDevice)
                                                            openDirectory("/Volumes/Pegasus6/Projects/Aerial Australia")
                                                        end)   

LocationsStreamdeck.ButtonLocationsGmail = Button:new(   "G-Mail",
                                                        loadStreamdeckImage("gmail"),
                                                        nil,
                                                        function(pDevice)
                                                            hs.execute("open https://www.google.com/gmail/")
                                                        end)   

LocationsStreamdeck.ButtonLocationsCalender = Button:new(   "Google Calender",
                                                            loadStreamdeckImage("calender"),
                                                            nil,
                                                            function(pDevice)
                                                                hs.execute("open https://calendar.google.com/calendar/r")
                                                            end) 

LocationsStreamdeck.MasterPage = Page:new("Locations")
LocationsStreamdeck.MasterPage.buttons = {
    [TOP_1] = streamdeckConstants.ButtonBack,
    [TOP_2] = LocationsStreamdeck.buttonLocationsDropbox,
    [TOP_3] = LocationsStreamdeck.buttonLocationsRAID,
    [TOP_4] = LocationsStreamdeck.ButtonLocationsTravelOz,
    [TOP_5] = LocationsStreamdeck.ButtonLocationsProjects,
    [BOT_1] = LocationsStreamdeck.ButtonLocationsVimeo,
    [BOT_2] = LocationsStreamdeck.ButtonLocationsVimeoUpload,
    [MID_5] = LocationsStreamdeck.ButtonLocationsTransit,
    [BOT_5] = LocationsStreamdeck.ButtonLocationsEITS,
    [MID_1] = LocationsStreamdeck.ButtonLocationsGmail,
    [MID_2] = LocationsStreamdeck.ButtonLocationsCalender
}

function LocationsStreamdeck.init()
    streamdeckInterface.registerPage(LocationsStreamdeck.MasterPage)
end

return LocationsStreamdeck