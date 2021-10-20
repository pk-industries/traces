local mainmenu, options, new_game, pausemenu

local pos = {x = 310, y = 125}

function FileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end
mainmenu = MenuEngine.new(pos.x, pos.y)

mainmenu:addEntry(
    "Enter",
    function()
        GameState.switch(States.game)
    end
)
mainmenu:addEntry(
    "Options",
    function()
        MenuEngine.disable() -- Disable every Menu...
        options:setDisabled(false) -- ...but enable Firstmenu.
        options.cursor = 1 -- reset Selection to the first Entry
    end
)

options = MenuEngine.new(pos.x, pos.y)
if FileExists("save.lua") then
    options:addEntry(
        "New Game",
        function()
            MenuEngine.disable()
            new_game:setDisabled(false)
            new_game.cursor = 2
        end
    )
end

new_game = MenuEngine.new(pos.x, pos.y)

new_game:addEntry("Are you sure?")

new_game:addEntry(
    "No",
    function()
        MenuEngine.disable()
        options:setDisabled(false)
        options.cursor = 1
    end
)
new_game:addEntry(
    "Yes",
    function()
        local erased, err = os.remove("save.lua")
        if not erased then
            print(err)
        else
            GameState.switch(States.welcome)
        end
        MenuEngine.disable()
        mainmenu:setDisabled(false)
    end
)

options:addEntry(
    "Back",
    function()
        MenuEngine.disable()
        mainmenu:setDisabled(false)
    end
)

mainmenu:addSep()

mainmenu:addEntry(
    "Quit",
    function()
        love.event.quit()
    end
)

pausemenu = MenuEngine.new(pos.x, pos.y)
pausemenu:addEntry(
    "Resume Game",
    function()
        GameState.switch(States.game)
    end
)
pausemenu:addSep()
pausemenu:addEntry(
    "Quit Game",
    function()
        pausemenu.quit()
    end
)

mainmenu:setColorNormal(Colors.text)
mainmenu:setColorSelected(Colors.red)
options:setColorNormal(Colors.text)
options:setColorSelected(Colors.red)
new_game:setColorNormal(Colors.text)
new_game:setColorSelected(Colors.red)
pausemenu:setColorNormal(Colors.text)
pausemenu:setColorSelected(Colors.red)

return {
    mainmenu = mainmenu,
    options = options,
    new_game = new_game,
    pausemenu = pausemenu,
    pos = pos
}
