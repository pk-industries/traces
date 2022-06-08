local values = {
    OUT = 1,
    IN = 0
 }

local current = {
    val = values.IN
 }

local tween
local isFadeIn = true

--- Functions
local fadeIn, fadeOut, interrupt, draw

local fade = function(fadeIn, after)
    interrupt()
    isFadeIn = fadeIn
    local target = isFadeIn and values.IN or values.OUT
    local endFun = after and cloneFunction(after) or nil
    local fun = function()
        current.val = target
        print("Tween is done! " .. "Tween is now " .. tostring(tween))
        tween = nil
        if endFun then endFun() end
    end
    tween = Timer.tween(
                1, current, {
            val = target
         }, Timer.tween.linear, cloneFunction(fun)
            )
end

fadeIn = function(after) fade(true, after) end

fadeOut = function(after) fade(false, after) end

interrupt = function()
    if tween == nil then return false end
    print("Interrupted")
    if tween then
        Timer.cancel(tween)
        if tween.after then tween.after() end
        tween = nil
    end
    print("Val is now " .. tostring(current.val))
    return true
end

draw = function()
    System.graphics.setColor(0, 0, 0, current.val)
    System.graphics.drawRectangle("fill", 0, 0, WINDOW.width, WINDOW.height)
end

local Fade = {
    ["fadeIn"] = fadeIn,
    ["fadeOut"] = fadeOut,
    ["interrupt"] = interrupt,
    ["draw"] = draw,
    getCurr = function() return current.val end
}

return Fade
