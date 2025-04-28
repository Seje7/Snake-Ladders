-- Authors: OSELUINOSEN EHI-DOUGLAS

local Globals = require "src.Globals"
local Push = require "libs.push"
local Background = require "src.games.Background"
local Boarding = require "src.games.Boarding"
local Die = require "src.games.Die"
local Stats = require "src.games.Stats"
local Object = require "src.games.Object"
local Board = require "src.games.Board"
local Player = require "src.games.Player"
local Snake = require "src.games.Snake"
local Tween = require "libs.tween"
local Sounds = require "src.games.Sounds"
local Timer = require "libs.hump.timer"
local Explosion = require "src.games.Explosion"


local wordPostion = { x = 700, y = 120, alpha = 0 }      -- creates a table of the word position
local liftWord = Tween.new(2, wordPostion, { x = 20 }) -- Tween animation


local tileSize = 96
local statFont = love.graphics.newFont(26)


-- Load is executed only once; used to setup initial resource for your game
function love.load()
    love.window.setTitle("CS489 Jewels")
    Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, { fullscreen = false, resizable = true })
    math.randomseed(os.time()) -- RNG setup for later
    bg1 = Background("graphics/bg/back.png", 30)

    boarding = Boarding(50, 50, 400, 400)

    titleFont = love.graphics.newFont(32)

    die = Die(480, 300)
    player = Player(0, 410, board)  -- where it starts drawing the player from 
    stats = Stats()

    explosion = Explosion()

    object = Object(50, 50, 140, 260)

    sounds = Sounds
    sounds["music_adventure"]:setLooping(true)
    sounds["music_adventure"]:play()
end

-- When the game window resizes
function love.resize(w, h)
    Push:resize(w, h) -- must called Push to maintain game resolution
end

-- Event for keyboard pressing
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "F2" or key == "tab" then
        debugFlag = not debugFlag
    elseif key == "return" and gameState == "start" then
        gameState = "play"
    elseif key == "return" and gameState == "over" then
        stats.dieRecording = 0
        stats.elaspsedTime = 0
        stats.numberOfRows = 0
        player.x = 0
        player.y = 410 
        player.state = "idle"
        player:setDirection("r")
        
        gameState = "play"
    elseif key == "space" and gameState == "play" then
        stats:Rows()
        die:roll()
        explosion:trigger(255, 165,0,550,370) -- redd green blue x and y position 
        Timer.after(1.8, function()
            stats:Recording()
        end)
    end
end

-- Update is executed each frame, dt is delta time (a fraction of a sec)
function love.update(dt)
    bg1:update(dt)
    stats:update(dt)
    die:update(dt)
    player:update(dt)
    

    if gameState == "start" then

    elseif gameState == "play" then
        Timer.update(dt)
        explosion:update(dt)
        if stats.dieRecording >= stats.MAX_BOARD_ROWS then
            gameState = "over"
        end
    elseif gameState == "over" then
        liftWord:update(dt)
    end
end

-- Draws the game after the update
function love.draw()
    Push:start()

    -- always draw between Push:start() and Push:finish()
    if gameState == "start" then
        drawStartState()
    elseif gameState == "play" then
        drawPlayState()
    elseif gameState == "over" then
        drawGameOverState()
    end

    if debugFlag then
        love.graphics.print("DEBUG ON", 20, gameHeight - 20)
    end

    Push:finish()
end

function drawStartState()
    bg1:draw()

    love.graphics.printf("SNAKE AND LADDERS", titleFont, 0, 50,
        gameWidth, "center")
    love.graphics.printf("Press Enter to Play or Escape to exit",
        0, 90, gameWidth, "center")
end

function drawPlayState()
    bg1:draw()
    boarding:draw()
    object:draw()
    player:draw()

    die:draw()
    stats:draw()
    if explosion:isActive() then
        explosion:draw()
    end

    local x, y = boarding:tileToPosition(1, tileSize)
end

function drawGameOverState()
  
    bg1:draw()
    love.graphics.printf("GameOver", titleFont, 0, 50,gameWidth, "center")
    love.graphics.printf("Rows" .. tostring(stats.numberOfRows), statFont, wordPostion.x, wordPostion.y, gameWidth,"center")
    love.graphics.printf("FINAL Score " .. tostring(stats.dieRecording), statFont, wordPostion.x, wordPostion.y + 30, gameWidth,"center")
    love.graphics.printf("Time "..tostring(stats.elaspsedTime), statFont, wordPostion.x,wordPostion.y + 60, gameWidth,"center")  -- .."/"..tostring(self.maxSecs)
   
    love.graphics.printf("Press Enter to Play or Escape to exit",0, 350, gameWidth, "center")
end

-- * git this wordPostion
