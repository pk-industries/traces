-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !! This flag controls the ability to toggle the debug view.         !!
-- !! You will want to turn this to 'true' when you publish your game. !!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
RELEASE = false

-- Enables the debug stats
DEBUG = not RELEASE

require "libs.tablesave"
require "libs.coordinates"
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
Scene = require "house.scene"
System = require "libs.system"
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

Fonts = {
    default = nil,
    regular = System.graphics.createFont "assets/fonts/Roboto-Regular.ttf",
    bold = System.graphics.createFont "assets/fonts/Roboto-Bold.ttf",
    light = System.graphics.createFont "assets/fonts/Roboto-Light.ttf",
    thin = System.graphics.createFont "assets/fonts/Roboto-Thin.ttf",
    regularItalic = System.graphics.createFont "assets/fonts/Roboto-Italic.ttf",
    boldItalic = System.graphics.createFont "assets/fonts/Roboto-BoldItalic.ttf",
    lightItalic = System.graphics.createFont "assets/fonts/Roboto-LightItalic.ttf",
    thinItalic = System.graphics.createFont "assets/fonts/Roboto-Italic.ttf",
    monospace = System.graphics.createFont "assets/fonts/RobotoMono-Regular.ttf",
    pixel = System.graphics.createFont "assets/fonts/Pixel.ttf"
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

local PlayerClass = require "states.player"
local playerOk, playerData = pcall(PlayerClass, "player")
if not playerOk then print("Player could not be created: ", playerData) end
Player = playerData

House = require "house.house"
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

function keyOf(table, value)
    for k, v in pairs(table) do
        if v == value then return k end
    end
    return nil
end

function indexOf(table, value)
    for k, v in ipairs(table) do
        if v == value then return k end
    end
    return nil
end