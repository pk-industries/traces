local helpers = {
    posToStr = function(direction, x, y)
        assert(direction == "string", "posToStr: direction string expected")
        assert(x == "number", "posToStr: x number expected")
        assert(y == "number", "posToStr: y number expected")

        return direction .. "." .. x .. "." .. y
    end
}

return helpers
