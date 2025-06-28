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

---------- METAMETHODS ----------



---------- METHODS ----------

function Mat4:get(row, column)
    return self.data[(row - 1) * 4 + column]
end

function Mat4:set(row, column, value)
    self.data[(row - 1) * 4 + column] = value
end

---------- CLOSING ----------

