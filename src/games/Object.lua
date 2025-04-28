local Class = require "libs.hump.class"
local Board = require "src.games.Board"

local Object = Class {}

function Object:init(x, y, width, height)
    self.ObjectTable = {}
    self.ObjectTable[1] = { image = love.graphics.newImage("graphics/sprites/YellowLadderRight.png") }
    self.ObjectTable[2] = { image = love.graphics.newImage("graphics/sprites/YellowLadderLeft.png") }
    self.ObjectTable[3] = { image = love.graphics.newImage("graphics/sprites/BrownLadderRight.png") }
    self.ObjectTable[4] = { image = love.graphics.newImage("graphics/sprites/BrownLadderLeft.png") }
    self.ObjectTable[5] = { image = love.graphics.newImage("graphics/sprites/BrownLadderLeft.png") }

    board = Board(400, 400)
    board:getCoOrdinates()

    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.newX = 0
    self.newY = 0
    self.newX1 = 0
    self.newY1 = 0

    self.angle = 0
    self.diagonal = 0
end

function Object:draw()
    self:drawLadder1(1, 8, 3, 2, 7)
    self:drawLadder2(2, 9, 3, 7, 0)
    self:drawLadder3(3, 2, 0, 0, 2)
    self:drawLadder4(4, 2, 9, 0, 7)
    self:drawLadder5(5, 7, 3, 5, 2)
    if debugFlag then
        --love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
    end
end

function Object:createLadder(tileNumber, startRow, startColumn, endRow, endColumn)
    self.newX = math.floor((board.tiles[startRow][startColumn].x1 + board.tiles[startRow][startColumn].x2) / 2)
    self.newY = math.floor((board.tiles[startRow][startColumn].y1 + board.tiles[startRow][startColumn].y) / 2)
    self.newX1 = math.floor((board.tiles[endRow][endColumn].x1 + board.tiles[endRow][endColumn].x2) / 2)
    self.newY1 = math.floor((board.tiles[endRow][endColumn].y1 + board.tiles[endRow][endColumn].y) / 2)

    local x = self.newX - self.newX1 -- self.newX1 - self.newX
    local y = self.newY - self.newY1 -- self.newY1 - self.newY

    self.diagonal = math.sqrt(math.pow(x, 2) + math.pow(y, 2))

    -- self.angle = math.atan2(y,x) -- not rotating well can you also fix this ?

    self.scaleX = self.width / self.ObjectTable[tileNumber].image:getWidth()

    self.scaleY = self.height / self.ObjectTable[tileNumber].image:getHeight()
end

function Object:drawLadder1(tileNumber, startRow, startColumn, endRow, endColumn)
    self:createLadder(tileNumber, startRow, startColumn, endRow, endColumn)

    self.ObjectTable[tileNumber].angle = -0.1

    love.graphics.draw(
        self.ObjectTable[tileNumber].image,
        self.newX, self.newY,
        self.ObjectTable[tileNumber].angle,
        self.scaleX, self.scaleY)

    if debugFlag then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("line", self.newX, self.newY, 5)
        love.graphics.circle("line", self.newX1, self.newY1, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

function Object:drawLadder2(tileNumber, startRow, startColumn, endRow, endColumn)
    self:createLadder(tileNumber, startRow, startColumn, endRow, endColumn)

    self.ObjectTable[tileNumber].angle = 0.5

    love.graphics.draw(
        self.ObjectTable[tileNumber].image,
        self.newX, self.newY,
        self.ObjectTable[tileNumber].angle,
        self.scaleX / 2, self.scaleY / 2, self.ObjectTable[tileNumber].image:getWidth(), 0)


    if debugFlag then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("line", self.newX, self.newY, 5)
        love.graphics.circle("line", self.newX1, self.newY1, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

function Object:drawLadder3(tileNumber, startRow, startColumn, endRow, endColumn)
    self:createLadder(tileNumber, startRow, startColumn, endRow, endColumn)

    self.ObjectTable[tileNumber].angle = -0.35

    love.graphics.draw(
        self.ObjectTable[tileNumber].image,
        self.newX, self.newY,
        self.ObjectTable[tileNumber].angle,
        self.scaleX / 2.5, self.scaleY / 2.5)

    if debugFlag then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("line", self.newX, self.newY, 5)
        love.graphics.circle("line", self.newX1, self.newY1, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

function Object:drawLadder4(tileNumber, startRow, startColumn, endRow, endColumn)
    self:createLadder(tileNumber, startRow, startColumn, endRow, endColumn)

    self.ObjectTable[tileNumber].angle = 0.3

    love.graphics.draw(
        self.ObjectTable[tileNumber].image,
        self.newX, self.newY,
        self.ObjectTable[tileNumber].angle,
        self.scaleX / 2.2, self.scaleY / 2.2, self.ObjectTable[tileNumber].image:getWidth(), 0)

    if debugFlag then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("line", self.newX, self.newY, 5)
        love.graphics.circle("line", self.newX1, self.newY1, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

function Object:drawLadder5(tileNumber, startRow, startColumn, endRow, endColumn)
    self:createLadder(tileNumber, startRow, startColumn, endRow, endColumn)

    self.ObjectTable[tileNumber].angle = 0

    love.graphics.draw(
        self.ObjectTable[tileNumber].image,
        self.newX, self.newY,
        self.ObjectTable[tileNumber].angle,
        self.scaleX / 2.5, self.scaleY / 2.5, self.ObjectTable[tileNumber].image:getWidth(), 0)

    if debugFlag then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("line", self.newX, self.newY, 5)
        love.graphics.circle("line", self.newX1, self.newY1, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

return Object

-- the ladder draws around tile 81 to 17, but the debug flag draws at the right tiles 84 to 28
