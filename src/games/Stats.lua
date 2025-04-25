local Class = require "libs.hump.class"
local Die = require "src.games.Die"
local Timer = require "libs.hump.timer"

local statFont = love.graphics.newFont(26)

local Stats = Class{}
function Stats:init(x, y)

    self.die = Die()
    self.dieRecording = 0
    self.elaspsedTime = 0
    self.numberOfRows = 0 
    self.MAX_BOARD_ROWS = 100

    Timer.every(1, function ()
        if gameState == "play" then
            self.elaspsedTime = self.elaspsedTime + 1    
             end
         end)

end 

function Stats:draw()
    love.graphics.setColor(1,0,0) -- Magenta
   -- love.graphics.printf("Level "..tostring(self.level), statFont, gameWidth/2-60,self.y,100,"center")
    love.graphics.printf("Score "..tostring(self.dieRecording), statFont ,10,10,200) -- .."/"..tostring(self.maxSecs)
   -- love.graphics.printf("Time "..tostring(self.elaspsedTime), statFont,gameWidth-210,10,200,"right")
    love.graphics.setColor(1,1,1) -- White
end

function Stats:update(dt) -- for now, empty function
    Timer.update(dt)
    end

function Stats:Recording()
    if self.die.currentFace == 1 then 
        self.dieRecording = self.dieRecording + 1
    elseif self.die.currentFace == 2 then
        self.dieRecording = self.dieRecording + 2
    elseif self.die.currentFace == 3 then
        self.dieRecording = self.dieRecording + 3
    elseif self.die.currentFace == 4 then
        self.dieRecording = self.dieRecording + 4
    elseif self.die.currentFace == 5 then
        self.dieRecording = self.dieRecording + 5
    elseif self.die.currentFace == 6 then
        self.dieRecording = self.dieRecording + 6
    end
end

function Stats:Rows()
    self.numberOfRows = self.numberOfRows + 1
end

return Stats