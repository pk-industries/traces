local welcome = {}

local mainmenu, options

local function main_menu()
    MenuEngine.disable()
    mainmenu:setDisabled(false)
    mainmenu.cursor = 1
end

local function menu_options()
    MenuEngine.disable()
    options:setDisabled(false)
    MODE = 1
    options.cursor = 1
end
-- Called once, and only once, before entering the state the first time. See Gamestate.switch().
function welcome:init()
    mainmenu = MenuEngine.new(330, 180, Fonts.pixel[10])
    mainmenu:addEntry(
        "Enter",
        function()
            GameState.switch(States.game)
        end,
        nil,
        nil,
        Colors.black,
        Colors.red
    )
    mainmenu:addEntry(
        "Quit",
        function()
            love.event.quit()
        end,
        nil,
        nil,
        Colors.black,
        Colors.red
    )
    mainmenu:addEntry("Options", menu_options, nil, nil, Colors.black, Colors.red)

    options = MenuEngine.new(330, 180, Fonts.pixel[10])
    options:addEntry("Back", main_menu, nil, nil, Colors.black, Colors.red)

    MenuEngine.disable()
    mainmenu:setDisabled(false)
end

-- Called every time when entering the state. See Gamestate.switch().
function welcome:enter(previous, ...)
    love.graphics.setBackgroundColor(Colors.bg)
end
-- Called when leaving a state. See Gamestate.switch() and Gamestate.pop().
function welcome:leave()
end

-- Called when re-entering a state by Gamestate.pop()-ing another state.
function welcome:resume()
end

-- Update the game state. Called every frame.
function welcome:update()
    MenuEngine:update()
end

-- Draw on the screen. Called every frame.
function welcome:draw()
    local frame = love.graphics.newImage("assets/images/house.png")
    love.graphics.draw(frame, -5, 0)
    love.graphics.draw(love.graphics.newImage("assets/images/traces.png"), 10, 10)
    mainmenu:draw()
end

-- Called if the window gets or loses focus.
function welcome:focus()
end

-- Triggered when a key is pressed.
---@param key love.KeyConstant
---@param scancode love.Scancode
function welcome:keypressed(key, scancode)
    MenuEngine.keypressed(scancode)
end

-- Triggered when a key is released.
function welcome:keyreleased()
end

-- Triggered when a mouse button is pressed.
function welcome:mousepressed()
end

-- Triggered when a mouse button is released.
function welcome:mousereleased()
end

-- Triggered when a joystick button is pressed.
function welcome:joystickpressed()
end

-- Triggered when a joystick button is released.
function welcome:joystickreleased()
end

-- Called on quitting the game. Only called on the active gamestate.
function welcome:quit()
end

return welcome
--[[
local welcome = {} -- previously: Gamestate.new()
local newImage = love.graphics.newImage

local music = love.audio.newSource("assets/sounds/noisey-static.mp3", "stream")


function welcome:enter()
    music:setLooping(true)
    music:setVolume(0.1)
    music:play()
end

function welcome:leave()
    music:stop()
end

function welcome:draw()
    love.graphics.setBackgroundColor(Colors.bg)
    local bg = newImage("assets/images/startScreen.png")
    love.graphics.draw(bg, 0, 0)
    love.graphics.print("Press Enter to continue", 5, 5)
end

function welcome:keyreleased(key, code)
    if key == Controls.enter then
        GameState.switch(States.game)
    end
end

return welcome ]]

--[[ welcome = {}
local newImage = love.graphics.newImage

function welcome:load()
    welcome.screen = "start"
end

function welcome.update(dt)

end

function welcome:draw()
    if welcome.screen == "start" then
        local frame = newImage("assets/images/startScreen.png")
        love.graphics.draw(frame, 0, 0)
    end
end

function welcome:keypressed(key, scancode, isrepeat)
    if key == Controls.enter then
        state.mode = "game"
        if game == nil then
            game:load()
        end

    end
end

return welcome ]]
