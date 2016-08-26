require "love"

--provides loadTiles() which returns a table mapping tileset names to tilesets

function loadTiles()
    local tilesets = {}
    local tiledirs = love.filesystem.getDirectoryItems("tiles")
    for _,subdir in pairs(tiledirs) do 
        tilesets[subdir] = {
            plain    = love.graphics.newImage("tiles/"..subdir.."/plain.png"),
            rough    = love.graphics.newImage("tiles/"..subdir.."/rough.png"),
            mountain = love.graphics.newImage("tiles/"..subdir.."/mountain.png"),
            castle   = love.graphics.newImage("tiles/"..subdir.."/castle.png"),
            green    = love.graphics.newImage("tiles/"..subdir.."/green.png"),
        }
    end

    return tilesets
end
