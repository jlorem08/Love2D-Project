---------- IMPORTS ----------
local Vector3 = require("lib.Vector3")
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

function Scene:addObject(obj)
    table.insert(self.objects, obj)
end

function Scene:setCamera(camera)
    self.camera = camera
end

function Scene:update(dt)
    for _, obj in ipairs(self.objects) do
        if obj.update then
            obj:update(dt)
        end
    end
end

---------- CLOSING ----------

return Scene