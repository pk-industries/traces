-- @author snorhax
-- This is a library for the functions native to system this game is developed in.
-- This file is currently supporting LOVE

---System functions; file system save/load, window functions, etc.
local System = {

    ---Set the title of the game window
    ---@param title string
    setTitle = function(title)
        love.window.setTitle(title)
    end,
    setWheelMoved = function(fun)
        love.wheelmoved = fun
    end
}

System.audio = {
    ---
    ---Creates a new Source from a filepath, File, Decoder or SoundData. Source implementation is subject to change and may not work with functions outside this file.
    ---
    ---Sources created from SoundData are always static.
    ---
    ---@param filename string The filepath to the audio file.
    ---@param type string Types: "static" (all audio decoded), "stream" (decoded in chunks as needed),"queue" (audio must me manually queued). A good rule of thumb is to use stream for music files and static for all short sound effects. Basically, you want to avoid loading large files into memory at once.
    ---@return source source A new Source that can play the specified audio.
    createSource = function(filename, type)
        return love.audio.newSource(filename, type)
    end,
    play = function(source, ...)
        return love.audio.play(source, ...)
    end,
    pause = function(source, ...)
        return love.audio.pause(source, ...)
    end,
    ---Gets the duration of the Source. For streaming Sources it may not always be sample-accurate,
    ---and may return -1 if the duration cannot be determined at all.
    ---@param Source source The audio source.
    ---@param unit? "seconds"|"samples" The duration in the unit given, or seconds if none given.
    getDuration = function(source, unit)
        return source:getDuration(unit)
    end,
    ---@param Source source The audio source.
    ---@param unit? "seconds"|"samples" The duration in the unit given, or seconds if none given.
    seek = function(source, position, unit)
        return source:seek(position, unit)
    end,
    setLooping = function(source, loop)
        return source:setLooping(loop)
    end,
    ---@param Source source
    ---@param number? volume Decimal between 0.0 to 1.0.
    setVolume = function(source, volume)
        return source:setVolume(volume)
    end
}

---Event manager for things like keypresses.
System.event = {
    ---Clears the event queue.
    clear = function()
        love.event.clear()
    end,
    ---Returns an iterator for messages in the event queue.
    poll = function()
        return love.event.poll()
    end,
    ---Pump events into the event queue. Usually not called by the user.
    pump = function()
        love.event.pump()
    end,
    ---Adds an event(s) to the event queue. Params 2-6 are optional.
    push = function(n, a, b, c, d, e, f)
        love.event.push(n, a, b, c, d, e, f)
    end,
    ---Adds the quite event to the queue.
    ---@param exitstatus? number The program exit status to use when closing the application.
    quit = function(exitstatus)
        love.event.quit(exitstatus)
    end,
    ---Like poll, but blocks until there is an event in the queue.
    ---@return Event n The name of the event
    ---@return any a, any b, any c, any d, any e, any f Event arguements
    wait = function()
        return love.event.wait()
    end,
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

System.filesystem = {
    checkFileExists = function(filename)
        return love.filesystem.getInfo(filename) ~= nil
    end,
}

System.graphics = {
    getWidth = function()
        return love.graphics.getWidth()
    end,
    getHeight = function()
        return love.graphics.getHeight()
    end,
    getDimensions = function()
        return love.graphics.getDimensions()
    end,
    createFont = function(path)
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
    end,
    setFont = function(font)
        love.graphics.setFont(font)
    end,
    ---@param red number The red component (0-1).
    ---@param green number The green component (0-1).
    ---@param blue number The blue component (0-1).
    ---@param alpha? number # The alpha component (0-1).
    setColor = function(red, green, blue, alpha)
        love.graphics.setColor(red, green, blue, alpha)
    end,
    ---@param red number The red component (0-1).
    ---@param green number The green component (0-1).
    ---@param blue number The blue component (0-1).
    ---@param alpha? number The alpha component (0-1).
    setBackgroundColor = function(red, green, blue, alpha)
        love.graphics.setBackgroundColor(red, green, blue, alpha)
    end,
    ---Creates a new Image from a filepath, FileData, an ImageData, or a CompressedImageData, and optionally generates or specifies mipmaps for the image.
    ---
    ---@param filename string The filepath to the image file.
    ---@param flags? table {dpiscale: number, linear: boolean, mipmaps: boolean}
    ---@return image image A new Image object which can be drawn on screen.
    createImage = function(filename, flags)
        return love.graphics.newImage(filename, flags)
    end,
    getImageWidth = function(image)
        return image:getWidth()
    end,
    getImageHeight = function(image)
        return image:getHeight()
    end,
    ---The purpose of a crop is to use a fraction of an image to draw objects, as opposed to drawing entire image.
    ---
    ---@param x number The top-left position in the Image along the x-axis.
    ---@param y number The top-left position in the Image along the y-axis.
    ---@param width number The width of the crop in the Image. (Must be greater than 0.)
    ---@param height number The height of the crop in the Image. (Must be greater than 0.)
    ---@param sw number The reference width, the width of the Image. (Must be greater than 0.)
    ---@param sh number The reference height, the height of the Image. (Must be greater than 0.)
    ---@return crop crop The new crop.
    createCrop = function(x, y, width, height, sw, sh)
        return love.graphics.newQuad(x, y, width, height, sw, sh)
    end,
    translate = function(dx, dy)
        love.graphics.translate(dx, dy)
    end,
    rotate = function(angle)
        love.graphics.rotate(angle)
    end,
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
    draw = function(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
        love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
    end,
    ---Draws a rectangle.
    ---@param mode string Options are "fill" or "line".
    ---@param x number The position of top-left corner along the x-axis.
    ---@param y number The position of top-left corner along the y-axis.
    ---@param width number Width of the rectangle.
    ---@param height number Height of the rectangle.
    drawRectangle = function(mode, x, y, width, height)
        love.graphics.rectangle(mode, x, y, width, height)
    end,
    ---Print text to the screen.
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
    print = function(text, x, y, r, sx, sy, ox, oy, kx, ky)
        love.graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
    end,
    ---Print formatted text to the screen.
    ---@param text string The text to draw.
    ---@param x number The position to draw the object (x-axis).
    ---@param y number The position to draw the object (y-axis).
    ---@param limit number Wrap the line after this many horizontal pixels.
    ---@param align? "center"|"justify"|"left"|"right"
    ---@param r? number Orientation (radians).
    ---@param sx? number Scale factor (x-axis).
    ---@param sy? number Scale factor (y-axis).
    ---@param ox? number Origin offset (x-axis).
    ---@param oy? number Origin offset (y-axis).
    ---@param kx? number Shearing factor (x-axis).
    ---@param ky? number Shearing factor (y-axis).
    printf = function(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
        love.graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
    end
}

---Keyboard functions
System.keyboard = {
    --- Check if key/input is pressed down.
    ---@param key string
    isDown = function(key)
        return love.keyboard.isDown(key)
    end
}

return System
