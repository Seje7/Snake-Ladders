local Class = require "libs.hump.class"
local Die = Class{}

function Die:init(x, y)
    self.x = x
    self.y = y

    -- Load sprite sheet
    self.sheet = love.graphics.newImage("graphics/sprites/Dice.png")
    self.frames = {}

    local frameWidth = self.sheet:getWidth() / 6
    local frameHeight = self.sheet:getHeight()

    -- This divides the die sprite sheet into 6
    for i = 0, 5 do
        self.frames[i + 1] = love.graphics.newQuad(
            i * frameWidth, 0, -- top left of the x, y coordinates of the die 
            frameWidth, frameHeight, -- the width and height of each die 
            self.sheet:getDimensions() -- total size of the die 
        )
    end

    self.currentFace = 1
    self.rolling = false
    self.timer = 0
    self.rollDuration = 0.8
    self.timePerFrame = 0.1
end

function Die:roll()
    self.rolling = true
    self.timer = 0
end

function Die:update(dt)
    if self.rolling then
        self.timer = self.timer + dt
        if self.timer < self.rollDuration then
            if math.floor(self.timer / self.timePerFrame) ~= math.floor((self.timer - dt) / self.timePerFrame) then
                self.currentFace = love.math.random(1, 6)
            end
        else
            self.rolling = false
            self.currentFace = love.math.random(1, 6) -- Final result
        end
    end
end

function Die:draw()
   -- local frameWidth = self.sheet:getWidth() / 6
   --local frameHeight = self.sheet:getHeight()

    love.graphics.draw(self.sheet, self.frames[self.currentFace], self.x, self.y  ,0,0.25,0.25)
end

return Die
