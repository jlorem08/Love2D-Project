---------- IMPORTS ----------
local Vector3 = require("Vector3")
local Mat4 = require("lib.Mat4")

---------- SETUP ----------

local Scene = {}
Scene.__index = Scene

---------- CONSTRUCTOR ----------

function Scene.new()
    local self = setmetatable({}, Scene)

    self.objects = {}
    self.camera = nil
    self.lights = {}

    return self
end

---------- METAMETHODS ----------



---------- METHODS ----------



---------- CLOSING ----------

return Scene