---------- SETUP ----------

local Vector2 = {}
Vector2.__index = Vector2

---------- CONSTRUCTOR ----------

-- creates a new vector2 object with given sidelengths (or zero)
function Vector2.new(x, y)
    local self = setmetatable({}, Vector3)

    self.X = x or 0
    self.Y = y or 0

    return self
end

---------- METAMETHODS ----------



---------- METHODS ----------

