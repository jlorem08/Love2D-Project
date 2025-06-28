---------- IMPORTS ----------

local Vector3 = require("Vector3")
local Mat4 = require("lib.Mat4")

---------- SETUP ----------

local Camera = {}
Camera.__index = Camera

---------- CONSTRUCTOR ----------

function Camera.new(position, target, up, fov, aspectRatio, near, far)
    local self = setmetatable({}, Camera)

    self.position = position or Vector3.new(0, 0, 0)
    self.target = target or Vector3.new(0, 0, -1)
    self.up = up or Vector3.new(0, 1, 0)

    self.fov = fov or math.rad(70)
    self.aspectRatio = aspectRatio or (16/9)
    self.near = near or 0.1
    self.far = far or 100

    return self
end

---------- METAMETHODS ----------



---------- METHODS ----------

function Camera:getViewMatrix()
    local zAxis = (self.position - self.target):normalize()
    local xAxis = self.up:cross(zAxis):normalize()
    local yAxis = zAxis:cross(xAxis)

    local px = -xAxis:dot(self.position)
    local py = -yAxis:dot(self.position)
    local pz = -zAxis:dot(self.position)

    return Mat4.new({
        xAxis.X, yAxis.X, zAxis.X, 0,
        xAxis.Y, yAxis.Y, zAxis.Y, 0,
        xAxis.Z, yAxis.Z, zAxis.Z, 0,
        px, py, pz, 1
    })
end

function Camera:getProjectionMatrix()
    return Mat4.perspective(self.fov, self.aspectRatio, self.near, self.far)
end

---------- CLOSING ----------

return Camera
