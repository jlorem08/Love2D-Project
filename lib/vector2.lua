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

function Vector2:__tostring()
    return string.format("Vector2(%.2f, %.2f)", self.X, self.Y)
end

function Vector2.__add(a, b)
    return Vector2.new(a.X + b.X, a.Y + b.Y)
end

function Vector2.__sub(a, b)
    return Vector2.new(a.X - b.X, a.Y - b.Y)
end

function Vector2.__mul(a, b)
    if getmetatable(a) == Vector2 and getmetatable(b) == Vector2 then
        return Vector2.new(a.X * b.X, a.Y * b.Y)
    end

    if type(a) == "number" then
        return Vector2.new(b.X * a, b.Y * a)
    elseif type(b) == "number" then
        return Vector2.new(a.X * b, a.Y * b)
    end
end

function Vector2.__eq(a, b)
    return a.X == b.X and a.Y == b.Y
end

function Vector2.__unm(v)
    return Vector2.new(-v.X, -v.Y)
end

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

function Vector2:projectOn(otherVector)
    local otherMagSquared = otherVector:magnitudeSquared()

    if otherMagSquared == 0 then
        return Vector2.new(0, 0)
    end

    local scalar = self:dot(otherVector) / otherMagSquared
    return otherVector:clone():mul(scalar)
end

function Vector2:lerp(otherVector, t)
    t = math.max(0, math.min(1, t))

    return Vector2.new(
        self.X + (otherVector.X - self.X) * t,
        self.Y + (otherVector.Y - self.Y) * t
    )
end

function Vector2:reflect(normal)
    local dot = self:dot(normal)
    return self:clone():sub(normal:clone():mul(2 * dot))
end

function Vector2:clamp(minVec, maxVec)
    self.X = math.max(minVec.X, math.min(self.X, maxVec.X))
    self.Y = math.max(minVec.Y, math.min(self.Y, maxVec.Y))

    return self
end

function Vector2:floor()
    self.X = math.floor(self.X)
    self.Y = math.floor(self.Y)

    return self
end

function Vector2:ceil()
    self.X = math.ceil(self.X)
    self.Y = math.ceil(self.Y)

    return self
end

function Vector2:round()
    self.X = math.floor(self.X + 0.5)
    self.Y = math.floor(self.Y + 0.5)

    return self
end

---------- CLOSING ----------

return Vector2