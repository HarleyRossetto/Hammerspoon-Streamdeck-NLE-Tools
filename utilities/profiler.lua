local Profiler = {}

function Profiler:start(name)
    p = {
        logger = hs.logger.new(name, 4),
        profilerName = name,
        startTime = hs.timer.secondsSinceEpoch(),
        stopTime = 0
    }
    setmetatable(p, self)
    self.__index = self
    return p
end

function Profiler:stop()
    self.stopTime = hs.timer.secondsSinceEpoch()
    self.logger.df("Profiler %s duration: %s", self.profilerName, self.stopTime - self.startTime)
end

return Profiler