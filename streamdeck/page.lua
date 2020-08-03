local Page = { }

local logger = hs.logger.new("page.lua", 4)

function Page:new(id)
    p = {id = id, buttons = {}}
    setmetatable(p, self)
    self.__index = self
    return p
end

return Page