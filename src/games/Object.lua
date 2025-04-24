local Class = require "libs.hump.class"
local Board = require "src.games.Board"

local Object = Class{}

function Object:init(x, y, width, height)
    self.ObjectTable = {}
    self.ObjectTable[1] = love.graphics.newImage("graphics/sprites/YellowLadderRight.png")
    self.ObjectTable[2] = love.graphics.newImage("graphics/sprites/YellowLadderLeft.png")
    self.ObjectTable[3] = love.graphics.newImage("graphics/sprites/BrownLadderRight.png")
    self.ObjectTable[4] = love.graphics.newImage("graphics/sprites/BrownLadderLeft.png")
    self.ObjectTable[5] = love.graphics.newImage("graphics/sprites/BrownLadderLeft.png")
    
    self.x = x
    self.y = y
    self.scaleX = width / self.ObjectTable[1]:getWidth()
    self.scaleY = height / self.ObjectTable[1]:getHeight()

    board = Board(400,400)
    board:getCoOrdinates()
    
end

function Object:draw()
    love.graphics.draw(
        self.ObjectTable[1],
        board.tiles[8][3].x1, board.tiles[8][3].y1,0,
    self.scaleX, self.scaleY
)
end

return Object
