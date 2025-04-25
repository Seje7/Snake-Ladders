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

    -- Add this to Player:createAnimations()
  --  self.animations["attack1"] = attack1Anim
   -- self.animations["attack1"].onLoop = function() self:finishAttack() end
   -- self.sprites["attack1"] = attackSprite

    -- Add these to Player:createAnimations()
   -- self.hurtboxes["idle"] = Hbox(self,24,16,16,48)
    -- self.hurtboxes["run"] = Hbox(self,34,16,26,48)
   -- self.hurtboxes["attack1"] = Hbox(self,34,16,26,48)
    -- self.hitboxes["attack1"] = Hbox(self,60,0,34,64)
    -- self.hurtboxes["attack2"] = Hbox(self,34,16,26,48)
   -- self.hitboxes["attack2"] = Hbox(self,60,16,34,64)
   -- self.hurtboxes["jump"] = Hbox(self,12,10,26,48)
end

--[[ function Player:update(dt, stage)
    -- movement logic first
    if love.keyboard.isDown("d","right") then
        self:setDirection("r")
        if not stage:rightCollision(self, 1) then
            self.x = self.x + 96*dt
        end
    elseif love.keyboard.isDown("a","left") then
        self:setDirection("l")
        if not stage:leftCollision(self,1) then
            self.x = self.x - 96*dt
        end
    end

    -- changing states logic
    if self.state == "idle" or self.state == "run" then
        if not stage:bottomCollision(self,0,1) then
            self.state = "jump"
            self.speedY = 32
            self:jump(dt, stage)
        elseif love.keyboard.isDown("a","d","right","left") then
            self.state = "run"
        else
            self.state = "idle"
        end
    elseif self.state == "jump" then
        if self.speedY < 0 then
            self:jump(dt, stage)
        elseif not stage:bottomCollision(self,1,1) then
            self:jump(dt, stage)
        else
            self.state = "idle"
            self.speedY = 1
        end
    end

    -- collisions logic
    local obj = stage:checkObjectsCollision(self)
    if obj then
        -- Player colided with obj
        self:handleObjectCollision(obj)
    end

    if self.state == "attack1" or self.state == "attack2" then
        local mob = stage:checkMobsHboxCollision(self:getHitbox())
        if mob ~= nil then
            mob:hit(10, self.dir)
            if mob.died then 
                self.score = self.score + mob.score 
            end
        end
    end

    -- getting hit code
    if self.state ~= "hit" then -- has not been hit yet, check for it
        local mob = stage:checkMobsHboxCollision(self:getHurtbox(),"hit")
        if mob then
            self.state = "hit"
            self.speedY = -32 
            self.hp = math.max(0, self.hp - mob.damage)
        end
    else -- Player got hit, continue the animation/movement of getting hit
        if self.dir == "r" then
            self.x = math.max(0,self.x - 96*dt) -- move backwards
        else
            self.x = math.min(self.x + 96*dt, stage:getWidth()-32)
        end
        if not stage:bottomCollision(self,1,1) then --did not land on ground
            self:jump(dt, stage) -- keeps jumping/falling 
        end
    end

    -- Check Player HP for d*
    if self.hp <= 0 then 
        self.state = "die"
        Sounds["die"]:play()
    end

    self.animations[self.state]:update(dt)
end  --]]

function Player:update(dt)
if self.state == "idle" then
        self.speedY = 32
    elseif self.state == "run" then
       self.x = self.x + 96*dt
    elseif self.state == "jump" then
    elseif self.state == "climb" then
    elseif self.state == "land" then
end
self.animations["run"]:update(dt)
end

--[[function Player:handleObjectCollision(obj)
    if obj.name == "coin" then
        self.coins = self.coins +1
        self.score = self.score +10
        Sounds["coin"]:play()
    elseif obj.name == "gem" then
        self.gems = self.gems +1
        self.score = self.score +50
        Sounds["gem"]:play()
    end
end --]]

function Player:draw()
    self.animations["run"]:draw(self.sprites["run"],
        math.floor(self.x), math.floor(self.y) )

  --  if debugFlag then
    --    local w,h = self:getDimensions()
    --    love.graphics.rectangle("line",self.x,self.y,w,h) -- sprite

      --  if self:getHurtbox() then
       --     love.graphics.setColor(0,0,1) -- blue
        --    self:getHurtbox():draw()
    --    end

    --    if self:getHitbox() then
          --  love.graphics.setColor(1,0,0) -- red
        --    self:getHitbox():draw()
     --   end
     --   love.graphics.setColor(1,1,1) 
    end

    function Player:runPlayer()
        if self.stats.die.currentFace == 1 then 
            for i = 0,  9 do
                --self.board.tiles[i] = {} -- Initialize each row
            for j = 0, 9 do 
                if i % 2 == 1 then 


                    self.tiles[i][9-j] == self.stats.die.currentFace
                else self.tiles[i][j] = self.stats.die.currentFace end 
                self.tileNumber = self.tileNumber + 1 
                end 
            self.dieRecording = self.dieRecording + 1
           end




           
        elseif self.stats.die.currentFace == 2 then
            self.dieRecording = self.dieRecording + 2
        elseif self.stats.die.currentFace == 3 then
            self.dieRecording = self.dieRecording + 3
        elseif self.stats.die.currentFace == 4 then
            self.dieRecording = self.dieRecording + 4
        elseif self.stats.die.currentFace == 5 then
            self.dieRecording = self.dieRecording + 5
        elseif self.stats.die.currentFace == 6 then
            self.dieRecording = self.dieRecording + 6
        end
        
    end

    return Player