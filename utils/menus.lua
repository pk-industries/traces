require "house.bedroom.bathroom"
---@diagnostic disable: redundant-parameter
local OptionsMenu, NewGameMenu, PauseMenu, Mainmenu

function FileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local Mainmenu = MenuEngine.new(0, 0)

Mainmenu:addEntry(
    "Enter",
    function()
        print("Entering game")
        GameState.switch(Bedroom)
    end
)

Mainmenu:addEntry(
    "Options",
    function()
        MenuEngine.disable()
        OptionsMenu:setDisabled(false) -- ...but enable Firstmenu.
        OptionsMenu.cursor = 1 -- reset Selection to the first Entry
    end
)

OptionsMenu = MenuEngine.new(0, 0)
if FileExists("save.lua") then
    OptionsMenu:addEntry(
        "New Game",
        function()
            MenuEngine.disable()
            NewGameMenu:setDisabled(false)
            NewGameMenu.cursor = 2
        end
    )
end

NewGameMenu = MenuEngine.new(0, 0)

NewGameMenu:addEntry("Are you sure?")

NewGameMenu:addEntry(
    "No",
    function()
        MenuEngine.disable()
        OptionsMenu:setDisabled(false)
        OptionsMenu.cursor = 1
    end
)
NewGameMenu:addEntry(
    "Yes",
    function()
        local erased, err = os.remove("save.lua")
        if not erased then
            print(err)
        else
            GameState.switch(States.welcome)
        end
        MenuEngine.disable()
        Mainmenu:setDisabled(false)
    end
)

OptionsMenu:addEntry(
    "Back",
    function()
        MenuEngine.disable()
        Mainmenu:setDisabled(false)
    end
)

Mainmenu:addSep()

Mainmenu:addEntry(
    "Quit",
    function()
        love.event.quit()
    end
)

PauseMenu = MenuEngine.new(0, 0)
PauseMenu:addEntry(
    "Resume Game",
    function()
        GameState.switch(States.game)
    end
)
PauseMenu:addSep()
PauseMenu:addEntry(
    "Quit Game",
    function()
        PauseMenu.quit()
    end
)

return {
    Mainmenu = Mainmenu,
    OptionsMenu = OptionsMenu,
    NewGameMenu = NewGameMenu,
    PauseMenu = PauseMenu
}
