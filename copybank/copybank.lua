local Copybank = {}

local logger = hs.logger.new("Copybank.lua", 4)

function Copybank:new(name)
    cp = {title = name, id = hs.pasteboard.uniquePasteboard()}
    setmetatable(cp, self)
    hs.pasteboard.deletePasteboard(name)
    self.__index = self
    return cp
end

local function paste()
    hs.window.focusedWindow():application():selectMenuItem({"Edit", "Paste"})
end

local function copy()
    hs.window.focusedWindow():application():selectMenuItem({"Edit", "Copy"})
end

function Copybank:store(data)
    --Store copy of original contents
    logger.df("Storing pasteboard data to: %s", self.title)
    local dataToStore = hs.pasteboard.readAllData()
    hs.pasteboard.writeAllData(self.title, dataToStore)
end

function Copybank:retrieve()
    hs.pasteboard.writeAllData(hs.pasteboard.readAllData(self.title))
    paste()
end
return Copybank