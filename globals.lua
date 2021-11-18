-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !! This flag controls the ability to toggle the debug view.         !!
-- !! You will want to turn this to 'true' when you publish your game. !!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
RELEASE = false

-- Enables the debug stats
DEBUG = not RELEASE
require "utils.debug"
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
        scale = 2,
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

function set(...)
    local ret = {}
    for _, k in ipairs({...}) do
        ret[k] = true
    end
    return ret
end
---@class Controls
---@field up "up"
---@field down "down"
---@field left "left"
---@field right "right"
---@field enter "return"
---@field pause "p"
Controls = {
    up = "up",
    down = "down",
    left = "left",
    right = "right",
    enter = "return",
    back = "escape",
    pause = "p",
    arrowkeys = set("up", "down", "left", "right")
}

function FileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

---@class love.shader
PlayDateShader =
    love.graphics.newShader [[
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
	vec4 pixel = Texel(texture, texture_coords );
	if(pixel.r < 0.65) {
		return vec4(0.193, 0.184, 0.158, pixel.a);
	} else {
		return vec4(0.747, 0.757, 0.743, pixel.a);
	}
}
]]

-- GameObject = require "libs.gameobject"
