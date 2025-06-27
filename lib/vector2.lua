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

function Vector2:add(otherVector)
    self.X = self.X + otherVector.X
    self.Y = self.Y + otherVector.Y
end

function Vector2:sub(otherVector)
    self.X = self.X - otherVector.X
    self.Y = self.Y - otherVector.Y
end

function Vector2:mul(scalar)
    self.X = self.X * (scalar or 1)
    self.Y = self.Y * (scalar or 1)
end

function Vector2:div(scalar)

end