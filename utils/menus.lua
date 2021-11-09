function FileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

mainmenu = MenuEngine.new(0, 0)

mainmenu:addEntry(
    "Enter",
    function()
        print("Entering game")
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

options = MenuEngine.new(0, 0)
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

new_game = MenuEngine.new(0, 0)

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

pausemenu = MenuEngine.new(0, 0)
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

mainmenu:setColorNormal(Colors.black)
mainmenu:setColorSelected(Colors.black)
options:setColorNormal(Colors.black)
options:setColorSelected(Colors.black)
new_game:setColorNormal(Colors.black)
new_game:setColorSelected(Colors.black)
pausemenu:setColorNormal(Colors.black)
pausemenu:setColorSelected(Colors.black)
