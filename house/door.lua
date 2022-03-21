local Scene = require "house.scene"

---@param destId string The ID of the destination.
---@param destCoor table d,x,y - The direction, x, and y of the distination.
---@param coor table d,x,y - The direction, x, and y of the door itself.
---@param isLocked boolean Is the door locked or not.
---@field string destD The direction (n,s,e,w) of the destination.
---@field string destX The X coordinate of the destination.
---@field string destY The Y coordinate of the destination.
---@field boolean isDoor Indicates that this class is a door.
local Door = Class { __includes = Scene }

--- func desc
---@param destId string The ID of the destination.
---@param destCoor table d,x,y - The direction, x, and y of the distination.
---@param coor table d,x,y - The direction, x, and y of the door itself.
---@param isLocked boolean Is the door locked or not.
function Door:init(destId, destCoor, coor, isLocked)
    self.destD = destCoor.d
    self.destX = destCoor.x
    self.destY = destCoor.y
    self.isDoor = true
    Scene.init(self, destId, coor.d, coor.x, coor.y, isLocked)
end

return Door