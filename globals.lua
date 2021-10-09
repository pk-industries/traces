-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !! This flag controls the ability to toggle the debug view.         !!
-- !! You will want to turn this to 'true' when you publish your game. !!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
RELEASE = false

-- Enables the debug stats
DEBUG = not RELEASE

require "libs.tablesave"
Husl = require "libs.husl"
Lume = require "libs.lume"
Class = require "libs.class"
Saver = require "libs.saver"
State = require "libs.state"
Timer = require "libs.timer"
Camera = require "libs.camera"
Signal = require "libs.signal"
Vector = require "libs.vector"
Inspect = require "libs.inspect"
MenuEngine = require "libs.menuengine"
CONFIG = {
    saveDir = love.filesystem.getSaveDirectory(),
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
    window = {
        icon = "assets/images/icon.png"
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
Colors = {
    darkGrey = {84, 84, 84, 1},
    green = {0, 1, 0, 1},
    blue = {0, 0, 1, 1},
    white = {1, 1, 1, 1},
    black = {0, 0, 0, 1}
}

Fonts.default = Fonts.regular
CONFIG.debug.stats.font = Fonts.monospace
CONFIG.debug.error.font = Fonts.monospace

States = {
    game = require "states.game",
    menu = require "states.menu",
    pause = require "states.pause"
}

Controls = {
    up = "up",
    down = "down",
    left = "left",
    right = "right",
    enter = "return",
    pause = "p"
}

Rooms = require("rooms")
