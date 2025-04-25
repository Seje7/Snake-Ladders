local Class = require "libs.hump.class"
local Object = require "src.games.Object"
local Snake = require "src.games.Snake"
local Stats = require "src.games.Stats"
local Anim8 = require "libs.anim8"
local Tween = require "libs.tween"
local Board = require "src.games.Board"

local idleSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Idle/Player Idle 48x48.png")
local idleGrid = Anim8.newGrid(48,48,
    idleSprite:getWidth(),idleSprite:getHeight())
local idleAnim = Anim8.newAnimation( idleGrid('1-10',1), 0.1)

local runSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Run/player run 48x48.png")
local runGrid = Anim8.newGrid(48,48,
    runSprite:getWidth(),runSprite:getHeight())
local runAnim = Anim8.newAnimation( runGrid('1-8',1), 0.1)

local jumpSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Jump/player new jump 48x48.png")
local jumpGrid = Anim8.newGrid(48,48,
    jumpSprite:getWidth(),jumpSprite:getHeight())
local jumpAnim = Anim8.newAnimation( jumpGrid('1-6',1), 0.1)

local climbSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Climb (facing side of player)/Player Side-Climb 48x48.png")
local climbGrid = Anim8.newGrid(48,48,
    climbSprite:getWidth(),climbSprite:getHeight())
local climbAnim = Anim8.newAnimation( climbGrid('1-4',1), 0.2)

local landSprite = love.graphics.newImage(
    "graphics/border/2D-Pixel-Art-Character-Template/Land/player land 48x48.png")
local landGrid = Anim8.newGrid(48,48,
    landSprite:getWidth(),landSprite:getHeight())
local landAnim = Anim8.newAnimation( landGrid('1-9',1), 0.12)

local Player = Class{}
function Player:init(x,y)
    self.x = x
    self.y = y
    self.name = "char"
    self.hitboxes = {}
    self.hurtboxes = {}

    self.state = "idle"
    self.dir = "r" -- r for right, l for left
    self.speedY = 0

    self.animations = {}
    self.sprites = {}
    self:createAnimations()

    self.stats = Stats
    self.board = Board
    self.obj = Object

    self.ladderStart = {x = 0, y = 0}
    self.ladderEnd = {x = 0, y = 0}
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
    if love.keyboard.isDown("d", "right") then
        self:setDirection("r")
        self.x = self.x + 96 * dt
        self.state = "run"
    elseif love.keyboard.isDown("a", "left") then
        self:setDirection("l")
        self.x = self.x - 96 * dt
        self.state = "run"
    elseif love.keyboard.isDown("w", "up") then
        self:setDirection("r")
        self.y = self.y - 96 * dt
        self.x = self.x + 96 * dt
        self.state = "climb"
    elseif self.obj[1][9] % 10 == 1 then 


    else
        self.state = "idle"
    end

    self.animations[self.state]:update(dt)
end


function Player:handleObjectCollision(obj)
    if obj == self.ObjectTable[1] then
        self.coins = self.coins +1
        self.score = self.score +10
        Sounds["coin"]:play()
    elseif obj.name == "gem" then
        self.gems = self.gems +1
        self.score = self.score +50
        Sounds["gem"]:play()
    end
end

function Player:draw()
    self.animations[self.state]:draw(self.sprites[self.state],
        math.floor(self.x), math.floor(self.y) )

  --  if debugFlag then
    --    local w,h = self:getDimensions()
    --    love.graphics.rectangle("line",self.x,self.y,w,h) -- sprite
    end


function Player:setCoords(x,y)
        self.x = x
        self.y = y
end

function Player:setDirection(newdir)
        if self.dir ~= newdir then
            self.dir = newdir
            for states,anim in pairs(self.animations) do
                anim:flipH()
            end -- end for
        end -- end if
end

function Player:startClimb(startX, startY, endX, endY)
    self.ladderStart = {x = startX, y = startY}
    self.ladderEnd = {x = endX, y = endY}

    -- normalize direction vector
    local newX = endX - startX
    local newY = endY - startY
    local ladderDiagonal = math.sqrt(newX*newX + newX*newX)
    self.climbDir = {x = newY / ladderDiagonal, y = newY / ladderDiagonal}

    self.state = "climb"
end

function Player:getDimensions()
    return self.animations[self.state]:getDimensions()
end

--[[function Player:Jump(obj)
    for i = 0,  9 do
        obj[i] = {} -- Initialize each row
    
        for j = 0, 9 do 
            if obj[i][(j+1) % 10] == 1 and i % 2 == 1 then 
            self.state = "jump"
                self:setDirection("l")
            elseif obj[i][(j+1) % 10] == 0 then
            self.state = "jump"
            self:setDirection("r")
            end
            end

    end
end]]--

    return Player