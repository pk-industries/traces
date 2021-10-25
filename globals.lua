require("libs.lovedebug")
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end
package.cpath = package.cpath .. ";/Users/gw/.vscode/extensions/tangzx.emmylua-0.3.49/debugger/emmy/mac/emmy_core.dylib"
local dbg = require("emmy_core")
dbg.tcpListen("localhost", 9966)

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !! This flag controls the ability to toggle the debug view.         !!
-- !! You will want to turn this to 'true' when you publish your game. !!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
RELEASE = false

-- Enables the debug stats
DEBUG = not RELEASE

GameState = require "libs.gamestate"
require "libs.tablesave"
Husl = require "libs.husl"
Lume = require "libs.lume"
Class = require "libs.class"
Saver = require "libs.saver"
Timer = require "libs.timer"
Camera = require "libs.camera"
Signal = require "libs.signal"
Vector = require "libs.vector"
Inspect = require "libs.inspect"
MenuEngine = require "libs.menuengine"
MenuEngine.stop_on_nil_functions = false
require "libs.colorize"
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
        icon = "assets/images/icon.png",
        scale = 1,
        width = 400,
        height = 240
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

CONFIG.window.resize = function(newScale)
    CONFIG.window.scale = newScale
    local w = CONFIG.window.width
    local h = CONFIG.window.height
    local s = CONFIG.window.scale
    love.window.setMode(w * s, h * s)
end

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
    white = {1, 1, 1, 1},
    black = {0, 0, 0, 1}
}

Fonts.default = Fonts.regular
CONFIG.debug.stats.font = Fonts.monospace
CONFIG.debug.error.font = Fonts.monospace

States = {
    welcome = require "states.welcome",
    game = require "states.game",
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

function FileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end
