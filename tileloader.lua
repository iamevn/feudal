require "love"

--provides loadTiles() which returns a table mapping tileset names to tilesets

function loadTiles()
    local tilesets = {}
    local tiledirs = love.filesystem.getDirectoryItems("resources/tiles")
    for _,subdir in pairs(tiledirs) do 
        tilesets[subdir] = {
            plain    = love.graphics.newImage("resources/tiles/"..subdir.."/plain.png"),
            rough    = love.graphics.newImage("resources/tiles/"..subdir.."/rough.png"),
            mountain = love.graphics.newImage("resources/tiles/"..subdir.."/mountain.png"),
            castle   = love.graphics.newImage("resources/tiles/"..subdir.."/castle.png"),
            green    = love.graphics.newImage("resources/tiles/"..subdir.."/green.png"),
        }
    end

    return tilesets
end

function loadTokens()
    local tokensets = {}
    local tokendirs = love.filesystem.getDirectoryItems("resources/tokens")
    for _,subdir in pairs(tokendirs) do 
        tokensets[subdir] = {}
        for _,color in pairs({"blue", "brown"}) do
            tokensets[subdir][color] = {
                archer  = love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/archer.png"),
                duke    = love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/duke.png"),
                king    = love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/king.png"),
                knight  = love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/knight.png"),
                pikeman = love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/pikeman.png"),
                prince  = love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/prince.png"),
                sergeant= love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/sergeant.png"),
                squire  = love.graphics.newImage("resources/tokens/"..subdir.."/"..color.."/squire.png"),
            }
        end
    end

    return tokensets
end

function loadGui()
    local guiset = {
        frame = love.graphics.newImage("resources/gui/frame.png")
    }
    return guiset
end
