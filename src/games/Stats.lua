local Class = require "libs.hump.class"
local Timer = require "libs.hump.timer"

local statFont = love.graphics.newFont(26)

local Stats = Class {}
function Stats:init()
    self.dieRecording = 0
    self.elaspsedTime = 0
    self.numberOfRows = 0
    self.MAX_BOARD_ROWS = 100

    Timer.every(2, function()
        if gameState == "play" then
            self.elaspsedTime = self.elaspsedTime + 1
        end
    end)
end

function Stats:draw()
    love.graphics.setColor(1, 0, 0)                                                     -- Magenta
    love.graphics.printf("Rows: " .. tostring(self.numberOfRows), statFont, 150, 10, 200)
    love.graphics.printf("Score: " .. tostring(self.dieRecording), statFont, 480, 170, 200) -- .."/"..tostring(self.maxSecs)
    love.graphics.printf("Time " .. tostring(self.elaspsedTime), statFont, gameWidth - 210, 10, 200, "right")
    love.graphics.setColor(1, 1, 1)                                                     -- White
end

function Stats:update(dt) -- for now, empty function
    Timer.update(dt)
end

function Stats:Recording()
    if stats.dieRecording > 100 then
        stats.dieRecording = 100
    elseif self.numberOfRows ~= 0 then
        if die.currentFace == 1 then
            self.dieRecording = self.dieRecording + 1
        elseif die.currentFace == 2 then
            self.dieRecording = self.dieRecording + 2
        elseif die.currentFace == 3 then
            self.dieRecording = self.dieRecording + 3
        elseif die.currentFace == 4 then
            self.dieRecording = self.dieRecording + 4
        elseif die.currentFace == 5 then
            self.dieRecording = self.dieRecording + 5
        elseif die.currentFace == 6 then
            self.dieRecording = self.dieRecording + 6
        end
    end
end

function Stats:Rows()
    self.numberOfRows = self.numberOfRows + 1
end

return Stats
