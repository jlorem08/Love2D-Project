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
    self.X = self.X / (scalar or 1)
    self.Y = self.Y / (scalar or 1)
end

function Vector2:magnitude()
    return math.sqrt(self.X^2 + self.Y^2)
end

function Vector2:magnitudeSquared()
    return self.X^2 + self.Y^2
end

function Vector2:normalize()
    local magnitude = Vector2:magnitude()

    if magnitude == 0 then
        return Vector2.new(0, 0, 0)
    end

    return Vector2.new(self.X/magnitude, self.Y/magnitude)
end

function Vector2:dot(otherVector)
    return (self.X * otherVector.X) + (self.Y * otherVector.Y)
end

function Vector2:distanceTo(otherVector)
    return math.sqrt((self.X - otherVector.X)^2 + (self.Y - otherVector.Y)^2)
end

function Vector2:equals(otherVector)
    return self.X == otherVector.X and self.Y == otherVector.Y
end