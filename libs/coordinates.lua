function coordinates(d, x, y)
    return {
        ["d"] = d,
        ["x"] = x,
        ["y"] = y
    }
end

local function indexOf(set, value)
    for i, v in ipairs(set) do
        if v == value then
            return i
        end
    end
    return nil
end

Cardinals = {
    cardinals = {"n", "e", "s", "w"},
    getTurnRight = function(cardinal, rotations)
        local index = indexOf(Cardinals.cardinals, cardinal) - 1
        local rotatedIndex = (index + rotations) % (#Cardinals.cardinals + 1)
        return Cardinals.cardinals[rotatedIndex]
    end,
    getTurnLeft = function(cardinal, rotations)
        local index = indexOf(Cardinals.cardinals, cardinal) - 1
        local rotatedIndex = (index - rotations) % (#Cardinals.cardinals + 1)
        return Cardinals.cardinals[rotatedIndex]
    end,
    getOpposite = function(cardinal)
        return Cardinals.getTurnRight(cardinal, 2)
    end,
    isOpposite = function(cardinalA, cardinalB)
        local oppositeOfA = Cardinals.getOpposite(cardinalA)
        return cardinalB == oppositeOfA
    end,
}

