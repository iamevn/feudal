require "imgui"
-- set makeprg=love\ .
-- autocmd BufWritePost *.lua Make!

local testbool = false
local showStyle = false
local clearColor = {56, 16, 16}
local spaceColor = {51, 78, 48}
local mountColor = {126, 120, 99}
local p1Color = {173, 125, 55}
local p2Color = {46, 85, 124}

--
-- LOVE callbacks
--

function love.load(arg)
end

function love.update(dt)
    imgui.NewFrame()
end

function love.draw()
    local status

    -- Menu
    if imgui.BeginMainMenuBar() then
        if imgui.BeginMenu("File") then
            if imgui.MenuItem("Test") then
                testbool = not testbool
            elseif imgui.MenuItem("Style") then
                showStyle = not showStyle
            elseif imgui.MenuItem("Quit") then
                love.event.quit()
            end
            imgui.EndMenu()
        end
        imgui.EndMainMenuBar()
    end

    -- Debug window
    if testbool then
        imgui.Text("Test!")
    end

    if showStyle then
        imgui.ShowStyleEditor()
    end

    love.graphics.clear(clearColor[1], clearColor[2], clearColor[3], 255)
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

function love.mousemoved(x, y)
    imgui.MouseMoved(x, y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousepressed(x, y, button)
    imgui.MousePressed(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousereleased(x, y, button)
    imgui.MouseReleased(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end
