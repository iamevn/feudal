require "love"

--provides loadTiles() which returns a table mapping tileset names to tilesets

function loadTiles()
    local tilesets = {}
    local tiledirs = love.filesystem.getDirectoryItems("tiles")
    for _,subdir in pairs(tiledirs) do 
        tilesets[subdir] = {
            plain    = love.graphics.newImage("tiles/"..subdir.."/plain.bmp"),
            rough    = love.graphics.newImage("tiles/"..subdir.."/rough.bmp"),
            mountain = love.graphics.newImage("tiles/"..subdir.."/mountain.bmp"),
            castle   = love.graphics.newImage("tiles/"..subdir.."/castle.bmp"),
            green    = love.graphics.newImage("tiles/"..subdir.."/green.bmp"),
        }
    end

    return tilesets
end
