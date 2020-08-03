local Button = { }

function Button:new(id, img, clr, pressFunc, holdFunc)
    b = {
        id = id,
        image = img or nil,
        color = clr or nil,

        pressFunction = pressFunc or nil,
        pressFuncTime = 0,

        holdFunction = holdFunc or nil,
        holdTimer = nil,
        holdDuration = 1,

        ignoreUp = false,
        
        pressTime = 0,

        buttonActionCallback = nil,

        isDown = false
    }
    setmetatable(b, self)
    self.__index = self
    return b
end

function Button:press(device)
    --Mark the button as depressed/down.
    self.isDown = true
    --Keep a record of the time when the button was depressed.
    self.pressTime = hs.timer.secondsSinceEpoch()
    --Call action callback if set.
    if self.buttonActionCallback then
        self.buttonActionCallback({ pressed = true })
    end

    if self.holdFunction then
        self.holdTimer = hs.timer.doAfter( self.holdDuration,
                                                function()
                                                    if self.isDown then
                                                       self.holdTimer = nil
                                                       self.holdFunction(device) 
                                                       self.ignoreUp = true
                                                    end
                                                end
                                                )
    end
end

function Button:release(device)
    --Mark the button as released.
    self.isDown = false
    --Keep a local record of the release time
    local releaseTime = hs.timer.secondsSinceEpoch()
    --Key a record of how long the button was held
    local holdDuration = releaseTime - self.pressTime

    --If a long press timers is active, stop it and delete it as the button has been released.
    if self.holdTimer then
        self.holdTimer:stop()
        self.holdTimer = nil
    end

    --Call action callback if set
    if self.buttonActionCallback then
        self.buttonActionCallback({ pressed = false, ignoreUpFlag = self.ignoreUp })
    end

    if self.pressFunction and not self.ignoreUp then
        self.pressFunction(device)
    end
    --Reset ignoreUp flag
    self.ignoreUp = false
end

return Button