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
    
end

function Camera:getProjectionMatrix()

end

---------- CLOSING ----------

return Camera
