function rgba(r, g, b, a)
    r = r or 255
    g = g or 255
    b = b or 255
    a = a or 1
    return {r / 255, g / 255, b / 255, a}
end

function vec4(r, g, b, a)
    return {r or 1, g or 1, b or 1, a or 1}
end

function hex(value, a)
    hexVal = string.sub(value, 2)
    hexVal = string.upper(hexVal)
    if #hexVal == 3 then
        f = hexVal:sub(1, 1)
        s = hexVal:sub(2, 2)
        t = hexVal:sub(3, 3)
        hexVal = f .. f .. s .. s .. t .. t
    end
    val = {}

    for i = 1, #hexVal do
        char = hexVal:sub(i, i)
        if char == "0" then
            val[i] = tonumber(char) + 1
        elseif char == "1" then
            val[i] = tonumber(char) + 1
        elseif char == "2" then
            val[i] = tonumber(char) + 1
        elseif char == "3" then
            val[i] = tonumber(char) + 1
        elseif char == "4" then
            val[i] = tonumber(char) + 1
        elseif char == "5" then
            val[i] = tonumber(char) + 1
        elseif char == "6" then
            val[i] = tonumber(char) + 1
        elseif char == "7" then
            val[i] = tonumber(char) + 1
        elseif char == "8" then
            val[i] = tonumber(char) + 1
        elseif char == "9" then
            val[i] = tonumber(char) + 1
        elseif char == "A" then
            val[i] = 11
        elseif char == "B" then
            val[i] = 12
        elseif char == "C" then
            val[i] = 13
        elseif char == "D" then
            val[i] = 14
        elseif char == "E" then
            val[i] = 15
        elseif char == "F" then
            val[i] = 16
        end
    end

    r = r or 255
    g = g or 255
    b = b or 255
    a = a or 255
    r = val[1] * 16 + val[2]
    g = val[3] * 16 + val[4]
    b = val[5] * 16 + val[6]

    return {r / 255, g / 255, b / 255, a}
end
