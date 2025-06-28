---------- IMPORTS ----------
local Vector3 = require("Vector3")

---------- SETUP ----------

local Mat4 = {}
Mat4.__index = Mat4

---------- CONSTRUCTOR ----------

function Mat4.new(data)
    local self = setmetatable({}, Mat4)

    self.data = data or { -- set to given matrix or identity matrix
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
    }

    return self
end

function Mat4.identity()
    return Mat4.new()
end

function Mat4.translation(x, y, z)
    return Mat4.new({
        1, 0, 0, x,
        0, 1, 0, y,
        0, 0, 1, z,
        0, 0, 0, 1,
    })
end

function Mat4.scale(x, y, z)
    return Mat4.new({
        x, 0, 0, 0,
        0, y, 0, 0,
        0, 0, z, 0,
        0, 0, 0, 1,
    })
end

function Mat4.rotationX(angle)
    local c = math.cos(angle)
    local s = math.sin(angle)

    return Mat4.new({
        1, 0, 0, 0,
        0, c, -s, 0,
        0, s, c, 0,
        0, 0, 0, 1
    })
end

function Mat4.rotationY(angle)
    local c = math.cos(angle)
    local s = math.sin(angle)

    return Mat4.new({
        c, 0, -s, 0,
        0, 1, 0, 0,
        s, 0, c, 0,
        0, 0, 0, 1
    })
end

function Mat4.rotationZ(angle)
    local c = math.cos(angle)
    local s = math.sin(angle)

    return Mat4.new({
        c, -s, 0, 0,
        s, c, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
    })
end

---------- METAMETHODS ----------

function Mat4:__mul(a, b)
    if getmetatable(a) == Mat4 and getmetatable(b) == Mat4 then
        local matrixData = {}

        for row = 1, 4 do
            for column = 1, 4 do
                local sum = 0

                for i = 1, 4 do
                    sum = sum + a:get(row, i) * b:get(i, column)
                end

                matrixData[(row - 1) * 4 + column] = sum
            end
        end

        return Mat4.new(matrixData)
    elseif getmetatable(a) == Mat4 and getmetatable(b) == Vector3 then
        local x, y, z = b.X, b.Y, b.Z
        local m = a.data

        local newX = m[1]*x + m[2]*y + m[3]*z + m[4]*1
        local newY = m[5]*x + m[6]*y + m[7]*z + m[8]*1
        local newZ = m[9]*x + m[10]*y + m[11]*z + m[12]*1
        local w = m[13]*x + m[14]*y + m[15]*z + m[16]*1

        -- normalize if w is not 1
        if w ~= 0 and w ~= 1 then
            newX = newX / w
            newY = newY / w
            newZ = newZ / w
        end

        return Vector3.new(newX, newY, newZ)
    end
end

---------- METHODS ----------

function Mat4:get(row, column)
    return self.data[(row - 1) * 4 + column]
end

function Mat4:set(row, column, value)
    self.data[(row - 1) * 4 + column] = value
end

---------- CLOSING ----------

