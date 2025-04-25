-- Sound Dictionary / Table
local sounds = {}  -- create an empty table

sounds["music_adventure"] = love.audio.newSource("sounds/Music/Ogi_Feel_the_Beat_-_Tristeza.mp3","static")
sounds["music_adventure"]:setVolume(0.3)

return sounds
