-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !! This flag controls the ability to toggle the debug view.         !!
-- !! You will want to turn this to 'true' when you publish your game. !!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
RELEASE = false

-- Enables the debug stats
DEBUG = not RELEASE

require "libs.tablesave"
Lume = require "libs.lume"
Class = require "libs.class"
Saver = require "libs.saver"
Timer = require "libs.timer"
Camera = require "libs.camera"
Signal = require "libs.signal"
Vector = require "libs.vector"
Inspect = require "libs.inspect"
GameState = require "libs.gamestate"
Window = require "libs.window"
Saveable = require "libs.saveable"
Scene = require "libs.scene"
-- MenuEngine = require "libs.menuengine"
Anim8 = require "libs.anim8"
-- MenuEngine.stop_on_nil_functions = true

require "libs.set"

CONFIG = {
    graphics = {
        filter = {
            -- FilterModes: linear (blurry) / nearest (blocky)
            -- Default filter used when scaling down
            down = "nearest",
            -- Default filter used when scaling up
            up = "nearest",
            -- Amount of anisotropic filter performed
            anisotropy = 1
        }
    },
    debug = {
        -- The key (scancode) that will toggle the debug state.
        -- Scancodes are independent of keyboard layout so it will always be in the same
        -- position on the keyboard. The positions are based on an American layout.
        key = "`",
        stats = {
            font = nil, -- set after fonts are created
            fontSize = 10,
            lineHeight = 12,
            foreground = {1, 1, 1, 1},
            shadow = {0, 0, 0, 1},
            shadowOffset = {x = 1, y = 1},
            position = {x = 420, y = 6},
            kilobytes = false
        },
        -- Error screen config
        error = {
            font = nil, -- set after fonts are created
            fontSize = 16,
            background = {.1, .31, .5},
            foreground = {1, 1, 1},
            shadow = {0, 0, 0, .88},
            shadowOffset = {x = 1, y = 1},
            position = {x = 70, y = 70}
        }
    }
}

local function makeFont(path)
    return setmetatable(
        {},
        {
            __index = function(t, size)
                local f = love.graphics.newFont(path, size)
                rawset(t, size, f)
                return f
            end
        }
    )
end

Fonts = {
    default = nil,
    regular = makeFont "assets/fonts/Roboto-Regular.ttf",
    bold = makeFont "assets/fonts/Roboto-Bold.ttf",
    light = makeFont "assets/fonts/Roboto-Light.ttf",
    thin = makeFont "assets/fonts/Roboto-Thin.ttf",
    regularItalic = makeFont "assets/fonts/Roboto-Italic.ttf",
    boldItalic = makeFont "assets/fonts/Roboto-BoldItalic.ttf",
    lightItalic = makeFont "assets/fonts/Roboto-LightItalic.ttf",
    thinItalic = makeFont "assets/fonts/Roboto-Italic.ttf",
    monospace = makeFont "assets/fonts/RobotoMono-Regular.ttf",
    pixel = makeFont "assets/fonts/Pixel.ttf"
}

-- -@alias Colors table<string, number>
Colors = {
    white = {1, 1, 1, 1},
    black = {0, 0, 0, 1},
    red = {255, 0, 0, 1}
}

Fonts.default = Fonts.regular
CONFIG.debug.stats.font = Fonts.monospace
CONFIG.debug.error.font = Fonts.monospace

Player = require "states.player"
House = {
    Bedroom = require "house.bedroom.bedroom"
}
States = {
    start = require "states.start",
    game = require "states.game"
}

Controls = {
    up = "up",
    down = "down",
    left = "left",
    right = "right",
    a = "return",
    b = "backspace",
    arrowkeys = set("up", "down", "left", "right")
}

GamePad = {
    up = Controls.up,
    down = Controls.down,
    left = Controls.left,
    right = Controls.right
}
GamePad.includes = set(GamePad.up, GamePad.down, GamePad.left, GamePad.right)

---@param name string
function FileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end
function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(
        pattern,
        function(c)
            fields[#fields + 1] = c
        end
    )
    return fields
end
