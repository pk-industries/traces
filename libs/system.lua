-- @author snorhax
-- This is a library for the functions native to system this game is developed in.
-- This file is currently supporting LOVE

--- System functions; file system save/load, window functions, etc.
local System = {}

-- Resources
function System.createFont(path)
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

function System.setFont(font)
    love.graphics.setFont(font)
end

---Creates a new Image from a filepath, FileData, an ImageData, or a CompressedImageData, and optionally generates or specifies mipmaps for the image.
---
---@param filename string The filepath to the image file.
---@param flags? table {dpiscale: number, linear: boolean, mipmaps: boolean}
---@return image image A new Image object which can be drawn on screen.
function System.createImage(filename, flags)
    return love.graphics.newImage(filename, flags)
end

---The purpose of a crop is to use a fraction of an image to draw objects, as opposed to drawing entire image.
---
---@param x number The top-left position in the Image along the x-axis.
---@param y number The top-left position in the Image along the y-axis.
---@param width number The width of the crop in the Image. (Must be greater than 0.)
---@param height number The height of the crop in the Image. (Must be greater than 0.)
---@param sw number The reference width, the width of the Image. (Must be greater than 0.)
---@param sh number The reference height, the height of the Image. (Must be greater than 0.)
---@return crop crop The new crop.
function System.createCrop(x, y, width, height, sw, sh)
    return love.graphics.newQuad(x, y, width, height, sw, sh)
end

---@param drawable any A drawable object. May change actual type in the future, only meant to interact with drawables/images made in system.lua to ensure functionality.
---@param x? number The position to draw the object (x-axis).
---@param y? number The position to draw the object (y-axis).
---@param r? number Orientation (radians).
---@param sx? number Scale factor (x-axis).
---@param sy? number Scale factor (y-axis).
---@param ox? number Origin offset (x-axis).
---@param oy? number Origin offset (y-axis).
---@param kx? number Shearing factor (x-axis).
---@param ky? number Shearing factor (y-axis).
function System.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
     love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
end

---Draws a rectangle.
---@param mode string Options are "fill" or "line".
---@param x number The position of top-left corner along the x-axis.
---@param y number The position of top-left corner along the y-axis.
---@param width number Width of the rectangle.
---@param height number Height of the rectangle.
function System.drawRectangle(mode, x, y, width, height)
    love.graphics.rectangle(mode, x, y, width, height)
end


--- Common System functions

--- Returns the width and height of the game window.
---@return number width
---@return number height
function System.getDimensions()
    return love.graphics.getDimensions
end

--- Set the title of the game window
---@param title string
function System.setTitle(title)
    love.window.setTitle(title)
end

---@param red number The red component (0-1).
---@param green number The green component (0-1).
---@param blue number The blue component (0-1).
---@param alpha? number The alpha component (0-1).
function System.setBackgroundColor(red, green, blue, alpha)
    love.graphics.setBackgroundColor(red, green, blue, alpha)
end

---@param red number The red component (0-1).
---@param green number The green component (0-1).
---@param blue number The blue component (0-1).
---@param alpha? number # The alpha component (0-1).
function System.setColor(red, green, blue, alpha)
    love.graphics.setColor(red, green, blue, alpha)
end

---@param text string The text to draw.
---@param x? number The position to draw the object (x-axis).
---@param y? number The position to draw the object (y-axis).
---@param r? number Orientation (radians).
---@param sx? number Scale factor (x-axis).
---@param sy? number Scale factor (y-axis).
---@param ox? number Origin offset (x-axis).
---@param oy? number Origin offset (y-axis).
---@param kx? number Shearing factor (x-axis).
---@param ky? number Shearing factor (y-axis).
function System.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
    love.graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
end

--- Key functions

--- Check if key/input is pressed down.
---@param key string
function System.isDown(key)
    return love.keyboard.isDown(key)
end

---
---Creates a new Source from a filepath, File, Decoder or SoundData. Source implementation is subject to change and may not work with functions outside this file.
---
---Sources created from SoundData are always static.
---
---@param filename string The filepath to the audio file.
---@param type string Types: "static" (all audio decoded), "stream" (decoded in chunks as needed),"queue" (audio must me manually queued). A good rule of thumb is to use stream for music files and static for all short sound effects. Basically, you want to avoid loading large files into memory at once.
---@return source source A new Source that can play the specified audio.
function System.createAudioSource(filename, type)
    return love.audio.newSource(filename,type)
end

function System.setWheelMoved(fun)
    love.wheelmoved = fun
end

---Event manager for things like keypresses.
System.event = {
    ---Clears the event queue.
    clear = function() love.event.clear() end,
    ---Returns an iterator for messages in the event queue.
    poll = function() return love.event.poll() end,
    ---Pump events into the event queue. Usually not called by the user.
    pump = function() love.event.pump() end,
    ---Adds an event(s) to the event queue. Params 2-6 are optional.
    push = function(n, a, b, c, d, e, f) love.event.push(n, a, b, c, d, e, f) end,
    ---Adds the quite event to the queue.
    ---@param exitstatus? number The program exit status to use when closing the application.
    quit = function(exitstatus) love.event.quit(exitstatus) end,
    ---Like poll, but blocks until there is an event in the queue.
    ---@return Event n The name of the event
    ---@return any a, any b, any c, any d, any e, any f Event arguements
    wait = function() return love.event.wait() end,
    ---Event arguments for things like push.
    EventArguments = {
        ---Window focus gained or lost
        focus = "focus",
        joystickpressed = "joystickpressed",
        joystickreleased = "joystickreleased",
        keypressed = "keypressed",
        keyreleased = "keyreleased",
        mousepressed = "mousepressed",
        mousereleased = "mousereleased",
        quit = "quit",
        resize = "resize",
        visible = "visible",
        mousefocus = "mousefocus",
        threaderror = "threaderror",
        joystickadded = "joystickadded",
        joystickremoved = "joystickremoved",
        joystickaxis = "joystickaxis",
        joystickhat = "joystickhat",
        gamepadpressed = "gamepadpressed",
        gamepadreleased = "gamepadreleased",
        gamepadaxis = "gamepadaxis",
        textinput = "textinput",
        mousemoved = "mousemoved",
        lowmemory = "lowmemory",
        textedited = "textedited",
        wheelmoved = "wheelmoved",
        touchpressed = "touchpressed",
        touchreleased = "touchreleased",
        touchmoved = "touchmoved",
        ---Directory is dragged and dropped onto the window
        directorydropped = "directorydropped",
        filedropped = "filedropped"
    }
}

return System