errorhandler = function(message) -- the error handler that deals with continuations in debug mode
    print "@0"

    -- Make it so we can recover from an error

    local colors = {0xFF1E1E2C, 0xFFF0A3A3, 0xFF92B5B0, 0xFF66666A, 0xFFCDCDCD}
    --local oldFont = love.graphics.getFont()
    local oldBGC = {love.graphics.getBackgroundColor()}

    print "@1"

    love.graphics.reset()

    --love.graphics.setFont(love.graphics.newFont('dat/fon/FSEX300.ttf',16))
    love.graphics.setFont(love.graphics.newFont(12))

    print "@2"

    local strrgba = function(color)
        local a, r, g, b = string.gmatch(color, "..(..)(..)(..)(..)")()
        return r, g, b, a
    end

    local rgba = function(color)
        local a = math.floor((color / 16777216) % 256)
        local r = math.floor((color / 65536) % 256)
        local g = math.floor((color / 256) % 256)
        local b = math.floor((color) % 256)
        return r, g, b, a
    end

    local cerp = function(a, b, t)
        local f = (1 - math.cos(t * math.pi)) * 0.5
        return a * (1 - f) + b * f
    end

    local triangle = function(x)
        return 1 - math.abs(1 - x % 2)
    end

    local time = love.timer.getTime()

    print "@3"

    local trace = debug.traceback()
    local err = {}

    for l in string.gmatch(trace, "(.-)\n") do
        if not string.match(l, "boot.lua") then
            l = string.gsub(l, "stack traceback:", "Traceback\n")
            table.insert(err, l)
        end
    end

    print "@4"

    local p = table.concat(err, "\n")

    p = string.gsub(p, "\t", "")
    p = string.gsub(p, '%[string "(.-)"%]', "%1")

    print "@5"

    -- temporary function innards from rxi's lurker.

    local draw = function()
        local pad = 25
        local width = love.graphics.getWidth()

        local function drawhr(pos, color1, color2)
            local animpos = cerp(pad, width - pad - 8, triangle((love.timer.getTime() - time) / 2))
            if color1 then
                love.graphics.setColor(rgba(color1))
            end
            love.graphics.rectangle("fill", pad, pos, width - pad * 2, 1)
            if color2 then
                love.graphics.setColor(rgba(color2))
            end
            love.graphics.rectangle("fill", animpos, pos, 8, 1)
        end

        local function drawtext(str, x, y, color, limit)
            love.graphics.setColor(rgba(color))
            love.graphics[limit and "printf" or "print"](str, x, y, limit)
        end

        love.graphics.setBackgroundColor(rgba(colors[1]))
        love.graphics.clear()
        drawtext("An error has occurred", pad, pad, colors[2])
        drawtext(
            "zege (screen code borrowed from rxi's lurker for the time being)",
            width - love.graphics.getFont():getWidth("zege (screen code borrowed from rxi's lurker for the time being)") -
                pad,
            pad,
            colors[4]
        )
        drawhr(pad + 32, colors[4], colors[5])
        drawtext("If you fix the problem and update the file, the program will resume.", pad, pad + 46, colors[3])
        drawhr(pad + 72, colors[4], colors[5])
        drawtext(message, pad, pad + 90, colors[5], width - pad * 2)
        drawtext(p, pad, pad + 120, colors[5], width - pad * 2)
        love.graphics.present()
    end

    print "@6"

    while true do
        love.event.pump()

        for e, a, b, c in love.event.poll() do
            if e == "quit" then
                return true
            end
            if e == "keypressed" and a == "escape" then
                return true
            end
        end

        --local current = state.current()
        --if current.modified and current:modified() then break end
        if game:modified() then
            break
        end

        draw()

        if love.timer then
            love.timer.sleep(0.001)
        end
    end

    love.graphics.setBackgroundColor(unpack(oldBGC))
    --love.graphics.setFont(oldFont)

    return false
end
