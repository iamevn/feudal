require "imgui"
require "util"
require "love"
require "tileloader"
require "board"
-- dumb reminder for editor
-- set makeprg=love\ .
-- autocmd BufWritePost *.lua Make!

local showVars = true
local showStyle = false
local clearColor = {56, 16, 16}
local tilesets = {}
local currenttilesetname
local currenttileset
local board
local splitboard
local rightmouseheld = false
local zoomlevel = 1.0 -- image pixels per screen pixel
local pixel_offset_x = 0
local pixel_offset_y = 0
local tileres = 64
local resolution = {}
local states = {
    "init",
    "connect (server)",
    "connect (client)",
    "determine first player",
    "choose board layout",
    "place pieces",
    "your turn",
    "opponent turn",
    "game end"
} --not sure where this is going, we'll see how I feel about it tomorrow
local currentstate = states[1]

--
-- LOVE callbacks
--

function love.load(arg)
    tilesets = loadTiles()
    currenttilesetname = "rpg"
    currenttileset = tilesets.rpg
    --this isn't where this is going to end up but until I decide how I'm handling states...
    splitboard = createBoard()
    board = combineSegments(splitboard)
end

function love.update(dt)
    imgui.NewFrame()
end

function love.draw()
    local status

    local win_w, win_h = love.graphics.getWidth(), love.graphics.getHeight()
    -- Menu
    if imgui.BeginMainMenuBar() then
        if imgui.BeginMenu("File") then
            if imgui.MenuItem("Toggle Fullscreen") then
                if love.window.getFullscreen() then
                    love.window.setFullscreen(false)
                    -- restore old size
                    love.window.setMode(resolution.x, resolution.y, resolution.flags)
                else
                    -- save size
                    resolution.x, resolution.y, resolution.flags = love.window.getMode()
                    love.window.setFullscreen(true, "desktop")
                end
            elseif imgui.MenuItem("Quit") then
                love.event.quit()
            end
            imgui.EndMenu()
        end
        if imgui.BeginMenu("Help") then
            -- show help
            imgui.MenuItem("todo")
            imgui.EndMenu()
        end
        if imgui.BeginMenu("Tileset") then
            for tilesetname, tilesettiles in pairs(tilesets) do
                if imgui.MenuItem(tilesetname) then
                    currenttilesetname = tilesetname
                    currenttileset = tilesettiles
                end
            end
            imgui.EndMenu()
        end
        if imgui.BeginMenu("Debug") then
            if imgui.MenuItem("Variables") then
                showVars = not showVars
            elseif imgui.MenuItem("Style") then
                showStyle = not showStyle
            end
            imgui.EndMenu()
        end
        imgui.EndMainMenuBar()
    end

    -- Debug window
    if showVars then
        imgui.Begin("Debug", false, {"AlwaysAutoResize"})
        imgui.Text("Variables:"..
        "\n currentstate = "..currentstate..
        "\n currenttileset = "..currenttilesetname..
        "\n rightmouseheld = "..tostring(rightmouseheld)..
        "\n zoomlevel = "..zoomlevel..
        "\n pixel_offset_x, pixel_offset_y = "..pixel_offset_x..", ".. pixel_offset_y..
        "\n tileres = "..tileres..
        -- [win_w/2 - off_x , win_h/2 - off_y] / (zoomold * tileres)
        "\n center tile: "..(win_w/2 - pixel_offset_x)/(zoomlevel * tileres)..", "..(win_h/2 - pixel_offset_y)/(zoomlevel * tileres)
        )
        imgui.End()
    end

    if showStyle then
        imgui.Begin("Style Editor", false, {"AlwaysAutoResize"})
        imgui.ShowStyleEditor()
        imgui.End()
    end

    love.graphics.clear(clearColor[1], clearColor[2], clearColor[3], 255)

    -- draw board

    for board_y in range(#board) do
        for board_x in range(#board[board_y]) do
            -- love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
            love.graphics.draw(
            currenttileset[board[board_y][board_x]],
            (board_x - 1) * tileres * zoomlevel + pixel_offset_x,
            (board_y - 1) * tileres * zoomlevel + pixel_offset_y,
            0,
            zoomlevel, zoomlevel
            )
            love.graphics.circle("fill",
            (board_x - 0.5) * tileres * zoomlevel + pixel_offset_x,
            (board_y - 0.5) * tileres * zoomlevel + pixel_offset_y,
            1,
            10)
        end
    end


    imgui.Render()
end

function love.quit()
    imgui.ShutDown()
end


--
-- User inputs
--
function love.textinput(t)
    imgui.TextInput(t)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.keypressed(key)
    imgui.KeyPressed(key)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.keyreleased(key)
    imgui.KeyReleased(key)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.mousemoved(x, y, dx, dy)
    imgui.MouseMoved(x, y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
        if rightmouseheld then
            pixel_offset_x = pixel_offset_x + dx
            pixel_offset_y = pixel_offset_y + dy
        end
    end
end

function love.mousepressed(x, y, button)
    imgui.MousePressed(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
        if button == 2 then 
            rightmouseheld = true
        end
    end
end

function love.mousereleased(x, y, button)
    imgui.MouseReleased(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
        if button == 2 then
            rightmouseheld = false
        end
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
        local win_w, win_h = love.graphics.getWidth(), love.graphics.getHeight()
        -- centered tile: [win_w/2 - off_x , win_h/2 - off_y] / (zoomold * tileres)
        local tilecenter_x = (win_w/2 - pixel_offset_x)/(zoomlevel * tileres)
        local tilecenter_y = (win_h/2 - pixel_offset_y)/(zoomlevel * tileres)
        if y > 0 then
            zoomlevel = zoomlevel * 0.9
            if zoomlevel < 0.1 then
                zoomlevel = 0.1
            end
        elseif y < 0 then
            zoomlevel = zoomlevel * 1.1
            if zoomlevel > 20 then
                zoomlevel = 20
            end
        end
        -- work it backwards for off_x and off_y
        pixel_offset_x = win_w/2 - tilecenter_x * zoomlevel * tileres
        pixel_offset_y = win_h/2 - tilecenter_y * zoomlevel * tileres
    end
end
