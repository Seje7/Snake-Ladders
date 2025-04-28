-- Sound Dictionary / Table
local sounds = {}  -- create an empty table

sounds["music_adventure"] = love.audio.newSource("sounds/Music/Ogi_Feel_the_Beat_-_Tristeza.mp3","static")
sounds["music_adventure"]:setVolume(0.3)

sounds["ladder"] = love.audio.newSource("sounds/ladderClimb.mp3","static")
sounds["running"] = love.audio.newSource("sounds/running-in-grass.mp3","static")


return sounds
