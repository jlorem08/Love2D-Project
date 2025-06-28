---------- IMPORTS ----------
local Vector3 = require("lib.Vector3")
local Mat4 = require("lib.Mat4")

---------- SETUP ----------

local Triangle = {}
Triangle.__index = Triangle

---------- CONSTRUCTOR ----------

function Triangle.new(vertex1Vector, vertex2Vector, vertex3Vector)
    local self = setmetatable({}, Triangle)

    self.v1 = vertex1Vector
    self.v2 = vertex2Vector
    self.v3 = vertex3Vector

    return self
end

---------- METAMETHODS ----------



---------- METHODS ----------

function Triangle:transform(matrix)
    return Triangle.new(
        matrix * self.v1,
        matrix * self.v2,
        matrix * self.v3
    )
end

---------- CLOSING ----------

return Triangle