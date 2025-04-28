local Class = require "libs.hump.class"
local Object = require "src.games.Object"
local Snake = require "src.games.Snake"
local Stats = require "src.games.Stats"
local Anim8 = require "libs.anim8"
local Tween = require "libs.tween"
local Board = require "src.games.Board"
local Die = require "src.games.Die"

local statFont = love.graphics.newFont(26)

local idleSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Idle/Player Idle 48x48.png")
local idleGrid = Anim8.newGrid(48, 48,
    idleSprite:getWidth(), idleSprite:getHeight())
local idleAnim = Anim8.newAnimation(idleGrid('1-10', 1), 0.1)

local runSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Run/player run 48x48.png")
local runGrid = Anim8.newGrid(48, 48,
    runSprite:getWidth(), runSprite:getHeight())
local runAnim = Anim8.newAnimation(runGrid('1-8', 1), 0.1)

local jumpSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Jump/player new jump 48x48.png")
local jumpGrid = Anim8.newGrid(48, 48,
    jumpSprite:getWidth(), jumpSprite:getHeight())
local jumpAnim = Anim8.newAnimation(jumpGrid('1-6', 1), 0.1)

local climbSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Climb (facing side of player)/Player Side-Climb 48x48.png")
local climbGrid = Anim8.newGrid(48, 48,
    climbSprite:getWidth(), climbSprite:getHeight())
local climbAnim = Anim8.newAnimation(climbGrid('1-4', 1), 0.2)

local landSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Land/player land 48x48.png")
local landGrid = Anim8.newGrid(48, 48,
    landSprite:getWidth(), landSprite:getHeight())
local landAnim = Anim8.newAnimation(landGrid('1-9', 1), 0.12)

local Player = Class {}
function Player:init(x, y, boards)
    self.x = x
    self.y = y
    self.name = "char"
    self.hitboxes = {}
    self.hurtboxes = {}

    self.state = "idle"
    self.dir = "r" -- r for right, l for left
    self.finishedClimb = false 
    self.speedY = 0
    self.imageNumber = 1

    self.animations = {}
    self.sprites = {}
    self:createAnimations()

    --self.stats = Stats()
    --self.board = boards
    self.obj = Object(50, 50, 140, 260)
    --self.die = Die()

    self.ladderStart = { x = 0, y = 0 }
    self.ladderEnd = { x = 0, y = 0 }
    self.climbSpeed = 50
end

function Player:createAnimations() -- fill up the animations & sprites
    self.animations["idle"] = idleAnim
    self.sprites["idle"] = idleSprite

    self.animations["run"] = runAnim
    self.sprites["run"] = runSprite

    self.animations["jump"] = jumpAnim
    self.sprites["jump"] = jumpSprite

    self.animations["climb"] = climbAnim
    self.sprites["climb"] = climbSprite

    self.animations["land"] = landAnim
    self.sprites["land"] = landSprite
end

function Player:update(dt)
     if self.state == "climb" and self.finishedClimb == false then
        if self.imageNumber == 1 then 
            self:startClimb(board.tiles[8][3], dt)
        elseif self.imageNumber == 3 then
            self:startClimb(board.tiles[2][0], dt)
        elseif self.imageNumber == 2 then 
            self:startClimb(board.tiles[9][3], dt)
        elseif self.imageNumber == 4 then 
            self:startClimb(board.tiles[2][9], dt)
        elseif self.imageNumber == 5 then  
            self:startClimb(board.tiles[7][3], dt)
        end
            self.animations[self.state]:update(dt)
            return
        end

    local i, j = self:getXY()

    if i and j and board.tiles[i] and board.tiles[i][j] then
        local targetX = board.tiles[i][j].x1
        local targetY = board.tiles[i][j].y1

        if self.x < targetX  then
            -- Move right
            self.x = self.x + 96 * dt
            if self.x > targetX then
                self.x = targetX
            end
            self:setDirection("r")
            self.state = "run"

        elseif self.x > targetX then
            -- Move left
            self.x = self.x - 96 * dt
            if self.x < targetX then
               self.x = targetX
            end
            self:setDirection("l")
            self.state = "run"
        else
            -- Reached the tile
            self.x = targetX
            self.state = "idle"

        end 

if self.x == targetX then 
        if self.y > targetY then 
            self.y = self.y - 96 * dt
            self.state = "jump"
            if self.y < targetY then
                self.y = targetY
             end
        else 
            self.y = targetY
            self.state = "idle"
        end
    end 

   self:handleObjectCollision(i, j)  
end
    self.animations[self.state]:update(dt)
end

function Player:startClimb(endTile, dt)
    local ladderEnd = {x = endTile.x1, y = endTile.y1 }

    if self.y > ladderEnd.y and self.x > ladderEnd.x then 
    self:setDirection("l")
    self.x = self.x - 60 * dt
    self.y = self.y - 60 * dt
    if self.y < ladderEnd.y then
        self.y = ladderEnd.y
    end
    if self.x < ladderEnd.x then
        self.x = ladderEnd.x
    end


    elseif self.y > ladderEnd.y and self.x < ladderEnd.x then 
    self:setDirection("r")
    self.x = self.x + 60 * dt
    self.y = self.y - 60 * dt
    if self.y < ladderEnd.y then
        self.y = ladderEnd.y
    end
    if self.x > ladderEnd.x then
        self.x = ladderEnd.x
    end

    else -- gotten to the end tile 
        self.x = ladderEnd.x
        self.y = ladderEnd.y
        stats.dieRecording = endTile.number
        self.state = "idle"
        self.finishedClimb = true
    end 


end

function Player:handleObjectCollision(i, j)
  if self.finishedClimb == true then return end  -- don't climb again if finished
    
    if self.state == "idle" and board.tiles[i][j] and board.tiles[i][j].number == board.tiles[0][2].number then
        self:setDirection("l")
        self.imageNumber = 3
        self.state = "climb"
        self.finishedClimb = false
        return

    elseif self.state == "idle" and board.tiles[i][j] and board.tiles[i][j].number == board.tiles[0][7].number then
            self:setDirection("r")
            self.imageNumber = 4
            self.state = "climb"
            self.finishedClimb = false
            return
    
    elseif self.state == "idle" and board.tiles[i][j] and board.tiles[i][j].number == board.tiles[2][7].number then
                self:setDirection("l")
                self.imageNumber = 1
                self.state = "climb"
                self.finishedClimb = false
                return
    
    elseif self.state == "idle" and board.tiles[i][j] and board.tiles[i][j].number == board.tiles[5][2].number then
                    self:setDirection("r")
                    self.imageNumber = 5
                    self.state = "climb"
                    self.finishedClimb = false
                    return

    elseif self.state == "idle" and board.tiles[i][j] and board.tiles[i][j].number == board.tiles[7][0].number then
                        self:setDirection("r")
                        self.imageNumber = 2
                        self.state = "climb"
                        self.finishedClimb = false
                        return
    end
end

function Player:draw()
    local obj 
    obj = object.ObjectTable[self.imageNumber] 

    if self.state == "climb" then 
        self.animations[self.state]:draw(self.sprites[self.state],
        math.floor(self.x), math.floor(self.y),obj.angle,1,1)
   else
    self.animations[self.state]:draw(self.sprites[self.state],
        math.floor(self.x), math.floor(self.y))
    end 
end

function Player:setDirection(newdir)
    if self.dir ~= newdir then
        self.dir = newdir
        for states, anim in pairs(self.animations) do
            anim:flipH()
        end     -- end for
    end         -- end if
end

function Player:getXY()
    for i = 0,  9 do
        for j = 0, 9 do
            if i % 2 == 1 then 
                if board.tiles[i][9-j].number == stats.dieRecording then 
                return i,(9-j)
            end 
            elseif board.tiles[i][j].number == stats.dieRecording then
                return i,j
         end
        end
    end
end

return Player
