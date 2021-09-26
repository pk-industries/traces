local utils = {}

function utils.startGame(key)
    local start = false
    if key == "space" or "enter" then start = true end
    return start
end

function utils.key_cleaner(key)
    local action = key

    if key == "up" or key == "kp8" then
        action = "up"

        return action
    elseif key == "down" or key == "kp2" then
        key = "down"

        return action
    elseif key == "left" or key == "kp4" then
        key = "left"

        return action
    elseif key == "right" or key == "kp6" then
        key = "right"

        return action
    elseif key == "space" then
        key = "space"

        return action
    end

end

return utils
