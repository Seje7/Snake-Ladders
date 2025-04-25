local Class = require "libs.hump.class"
local Matrix = require "libs.matrix"
local Tween = require "libs.tween"
local Timer = require "libs.hump.timer"
local Boarding = require "src.games.Boarding"

local Board = Class{}

function Board:init(width, height)
    self.tiles = {}

    self.x = 50 -- bottom coordinate of board for x-axis
    self.x1 = 0
    self.x2 = 0
    self.x3 = 0

    self.y = 450 -- bottom coordinate of board for y-axis
    self.y1 = 0
    self.y2 = 0
    self.y3 = 0

    self.tileWidth = width/10
    self.tileHeight = height/10
    self.tileSize = self.tileHeight * self.tileWidth
    self.tileNumber = 1

for i = 0,  9 do
    self.tiles[i] = {} -- Initialize each row

    for j = 0, 9 do 
        if i % 2 == 1 then 
        self.tiles[i][9-j] = { number = self.tileNumber } 
    else self.tiles[i][j] = { number = self.tileNumber } end 
    self.tileNumber = self.tileNumber + 1 
    end 
end 
end


function Board:getCoOrdinates()
    local column = self.y -- 450
    
    for i = 0, 9 do 
        local row = self.x -- 50
        local tempRow = 410 -- 450

        for j = 0, 9 do 
if i % 2 == 1 then 
    self.tiles[i][9-j].x = tempRow  -- 450 - width of a tile
    self.tiles[i][9-j].y = column -- 450

    self.tiles[i][9-j].x1 = self.tiles[i][9-j].x
    self.tiles[i][9-j].y1 = self.tiles[i][9-j].y - self.tileHeight

    self.tiles[i][9-j].x2 = tempRow + self.tileWidth
    self.tiles[i][9-j].y2 = self.tiles[i][9-j].y1

    self.tiles[i][9-j].x3 = self.tiles[i][9-j].x + self.tileWidth
    self.tiles[i][9-j].y3 = self.tiles[i][9-j].y

    tempRow = tempRow - self.tileWidth

else 
    self.tiles[i][j].x = row -- 50
    self.tiles[i][j].y = column -- 450

    self.tiles[i][j].x1 = self.tiles[i][j].x
    self.tiles[i][j].y1 = self.tiles[i][j].y - self.tileHeight

    self.tiles[i][j].x2 = self.tiles[i][j].x1 + self.tileWidth
    self.tiles[i][j].y2 = self.tiles[i][j].y1

    self.tiles[i][j].x3 = self.tiles[i][j].x + self.tileWidth
    self.tiles[i][j].y3 = self.tiles[i][j].y

    row = row + self.tileWidth
end
        end 
        column = column - self.tileHeight

    end end


return Board