local Scene =
    Class {
    init = function(self, id)
        self.id = id
    end,
    enter = function(self)
        print("Entering scene " .. self.id)
    end,
    update = function(self, dt)
    end,
    draw = function(self)
        love.graphics.print("Scene " .. self.id, 0, 0)
    end,
    exit = function(self)
        print("Exiting scene " .. self.id)
    end
}

return Scene
