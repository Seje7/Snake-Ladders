local Class = require "libs.hump.class"
local imgBorder = love.graphics.newImage("graphics/boards/Board-1.png")
local Boarding = Class{}

function Boarding:init(x, y, width, height)
    self.x = x
    self.y = y
    self.scaleX = width / imgBorder:getWidth()
    self.scaleY = height / imgBorder:getHeight()
end

function Boarding:draw()
    love.graphics.draw(imgBorder, self.x, self.y, 0, self.scaleX, self.scaleY) 
end

function Boarding:tileToPosition(tileNumber, tileSize)
    local row = math.floor((tileNumber - 1) / 10)
    local col = (tileNumber - 1) % 10

    -- Reverse column on odd rows to create snake pattern
    if row % 2 == 1 then
        col = 9 - col
    end

    local x = col * tileSize
    local y = (9 - row) * tileSize -- flip row vertically

    return x, y
end


return Boarding