---------- SETUP ----------

local Vector3 = {}
Vector3.__index = Vector3

---------- CONSTRUCTOR ----------

-- creates a new vector3 object with given sidelengths (or zero)
function Vector3.new(x, y, z)
    local self = setmetatable({}, Vector3)

    self.X = x or 0
    self.Y = y or 0
    self.Z = z or 0

    return self
end

---------- METAMETHODS ----------

function Vector3:__tostring()
    return string.format("Vector3(%.2f, %.2f, %.2f)", self.X, self.Y, self.Z)
end

function Vector3.__add(a, b)
    return Vector3.new(a.X + b.X, a.Y + b.Y, a.Z + b.Z)
end

function Vector3.__sub(a, b)
    return Vector3.new(a.X - b.X, a.Y - b.Y, a.Z - b.Z)
end

function Vector3.__mul(a, b)
    if type(a) == "number" then
        return Vector3.new(b.X * a, b.Y * a, b.Z * a)
    elseif type(b) == "number" then
        return Vector3.new(a.X * b, a.Y * b, a.Z * b)
    end
end

function Vector3.__eq(a, b)
    return a.X == b.X and a.Y == b.Y and a.Z == b.Z
end

function Vector3.__unm(v)
    return Vector3.new(-v.X, -v.Y, -v.Z)
end

---------- METHODS ----------

-- takes Vector3 argument and adds its side lengths to side lengths of self
function Vector3:add(otherVector)
    self.X = self.X + otherVector.X
    self.Y = self.Y + otherVector.Y
    self.Z = self.Z + otherVector.Z

    return self
end

-- takes Vector3 argument and subtracts its side lengths from side lengths of self
function Vector3:sub(otherVector)
    self.X = self.X - otherVector.X
    self.Y = self.Y - otherVector.Y
    self.Z = self.Z - otherVector.Z

    return self
end

-- multiplies all side lengths of self by scalar amount or one
function Vector3:mul(scalar)
    self.X = self.X * (scalar or 1)
    self.Y = self.Y * (scalar or 1)
    self.Z = self.Z * (scalar or 1)

    return self
end

-- divides all side lengths of self by scalar amount or one
function Vector3:div(scalar)
    self.X = self.X / (scalar or 1)
    self.Y = self.Y / (scalar or 1)
    self.Z = self.Z / (scalar or 1)

    return self
end

-- returns the length of self from origin
function Vector3:magnitude()
    return math.sqrt(self.X^2 + self.Y^2 + self.Z^2)
end

-- returns the squared length of self from origin
function Vector3:magnitudeSquared()
    return self.X^2 + self.Y^2 + self.Z^2
end

-- returns unit vector of self
function Vector3:normalize()
    local magnitude = self:magnitude()

    if magnitude == 0 then
        return Vector3.new(0, 0, 0) -- cant divide by 0 so return early
    end

    return Vector3.new(self.X/magnitude, self.Y/magnitude, self.Z/magnitude)
end

-- returns true if all axis' length of self are zero
function Vector3:isZero()
    return (self.X == 0) and (self.Y == 0) and (self.Z == 0)
end

-- returns dot product of self and other vector
function Vector3:dot(otherVector)
    return (self.X * otherVector.X) + (self.Y * otherVector.Y) + (self.Z * otherVector.Z)
end

-- returns cross product of self and other vector
function Vector3:cross(otherVector)
    return Vector3.new(
        (self.Y * otherVector.Z) - (self.Z * otherVector.Y),
        (self.Z * otherVector.X) - (self.X * otherVector.Z),
        (self.X * otherVector.Y) - (self.Y * otherVector.X)
    )
end

-- gets the distance between self and other vector
function Vector3:distanceTo(otherVector)
    return math.sqrt((self.X - otherVector.X)^2 + (self.Y - otherVector.Y)^2 + (self.Z - otherVector.Z)^2)
end

-- gets the angle difference between self and other vector in radians
function Vector3:angleTo(otherVector)
    local dot = self:dot(otherVector)
    local magProduct = self:magnitude() * otherVector:magnitude()

    if magProduct == 0 then
        return 0 -- cant divide by 0 so return early
    end

    local cosTheta = math.max(-1, math.min(1, dot / magProduct))
    return math.acos(cosTheta)
end

-- projects self onto another vector
function Vector3:projectOn(otherVector)
    local otherMagSquared = otherVector:magnitudeSquared()

    if otherMagSquared == 0 then
        return Vector3.new(0, 0, 0) -- cant divide by 0 so return early
    end

    local scalar = self:dot(otherVector) / otherMagSquared
    return otherVector:clone():mul(scalar)
end

-- returns an identical vector of self
function Vector3:clone()
    return Vector3.new(self.X, self.Y, self.Z)
end

-- linear interpolate between self and other vector
function Vector3:lerp(otherVector, t)
    t = math.max(0, math.min(1, t))

    return Vector3.new(
        self.X + (otherVector.X - self.X) * t,
        self.Y + (otherVector.Y - self.Y) * t,
        self.Z + (otherVector.Z - self.Z) * t
    )
end

-- return if self is identical to other vector
function Vector3:equals(otherVector)
    return (self.X == otherVector.X) and (self.Y == otherVector.Y) and (self.Z == otherVector.Z)
end

-- update self with new position values
function Vector3:set(x, y, z)
    self.X = x or 0
    self.Y = y or 0
    self.Z = z or 0
end

-- returns x, y, z of self
function Vector3:unpack()
    return self.X, self.Y, self.Z
end

---------- CLOSING ----------

return Vector3