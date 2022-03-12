local Door = Class { __includes = Scene }

function Door:init(id, direction, x, y, type, locked)
    Scene.init(self, id)
    self.direction = direction
    self.x = x
    self.y = y
    self.locked = locked
end

return Door