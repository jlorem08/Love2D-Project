---------- SETUP ----------

local Vector2 = {}
Vector2.__index = Vector2

---------- CONSTRUCTOR ----------

-- creates a new vector2 object with given sidelengths (or zero)
function Vector2.new(x, y)
    local self = setmetatable({}, Vector2)

    self.X = x or 0
    self.Y = y or 0

    return self
end

---------- METAMETHODS ----------



---------- METHODS ----------

function Vector2:add(otherVector)
    self.X = self.X + otherVector.X
    self.Y = self.Y + otherVector.Y

    return self
end

function Vector2:sub(otherVector)
    self.X = self.X - otherVector.X
    self.Y = self.Y - otherVector.Y

    return self
end

function Vector2:mul(scalar)
    self.X = self.X * (scalar or 1)
    self.Y = self.Y * (scalar or 1)

    return self
end

function Vector2:div(scalar)
    self.X = self.X / (scalar or 1)
    self.Y = self.Y / (scalar or 1)

    return self
end

function Vector2:magnitude()
    return math.sqrt(self.X^2 + self.Y^2)
end

function Vector2:magnitudeSquared()
    return self.X^2 + self.Y^2
end

function Vector2:normalize()
    local magnitude = self:magnitude()

    if magnitude == 0 then
        return Vector2.new(0, 0)
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

function Vector2:clone()
    return Vector2.new(self.X, self.Y)
end

function Vector2:set(x, y)
    self.X = x
    self.Y = y

    return self
end

function Vector2:unpack()
    return self.X, self.Y
end

function Vector2:isZero()
    return self.X == 0 and self.Y == 0
end

function Vector2:angle()
    return math.atan2(self.Y, self.X)
end

function Vector2:angleTo(otherVector)
    local dot = self:dot(otherVector)
    local magProduct = self:magnitude() * otherVector:magnitude()

    if magProduct == 0 then
        return 0
    end

    local cosTheta = math.max(-1, math.min(1, dot / magProduct))
    return math.acos(cosTheta)
end

function Vector2:rotate(radians)
    local cos = math.cos(radians)
    local sin = math.sin(radians)

    local x = self.X * cos - self.Y * sin
    local y = self.X * sin + self.Y * cos

    return Vector2.new(x, y)
end

function Vector2:perpendicular()
    return Vector2.new(-self.Y, self.X)
end