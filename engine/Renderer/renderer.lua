---------- IMPORTS ----------

local Triangle = require("engine.Renderer.Triangle")
local Camera = require("engine.Scene.Camera")
local Scene = require("engine.Scene.Scene")
local Mat4 = require("lib.Mat4")
local Vector3 = require("lib.Vector3")

---------- SETUP ----------

local Renderer = {}
Renderer.__index = Renderer

---------- CONSTRUCTOR ----------

function Renderer.new(screenWidth, screenHeight)
    local self = setmetatable({}, Renderer)

    self.width = screenWidth
    self.height = screenHeight
    self.scene = Renderer:setupScene()

    return self
end

---------- METAMETHODS ----------



---------- METHODS ----------
function Renderer:setupScene()
    local scene = Scene.new()

    local camera = Camera.new()
    scene:setCamera(camera)

    local triangle = Triangle.new(
        Vector3.new(0, 1, 5),
        Vector3.new(-1, -1, 5),
        Vector3.new(1, -1, 5)
    )

    scene:addObject(triangle)

    return scene
end

function Renderer:projectToScreen(v)
    local x = v.X / v.Z
    local y = v.Y / v.Z

    local screenX = (x + 1) * 0.5 * self.width
    local screenY = (1 - y) * 0.5 * self.height

    return screenX, screenY
end

function Renderer:drawWireframe(triangle)
    local sx1, sy1 = self:projectToScreen(triangle.v1)
    local sx2, sy2 = self:projectToScreen(triangle.v2)
    local sx3, sy3 = self:projectToScreen(triangle.v3)

    love.graphics.line(sx1, sy1, sx2, sy2)
    love.graphics.line(sx2, sy2, sx3, sy3)
    love.graphics.line(sx3, sy3, sx1, sy1)
end

function Renderer:render()
    local cam = self.scene.camera
    local view = cam:getViewMatrix()
    local projection = Mat4.perspective(math.rad(70), self.width / self.height, 0.1, 100)

    for _, obj in ipairs(self.scene.objects) do
        local viewSpace = obj:transform(view)
        local clipSpace = viewSpace:transform(projection)
        self:drawWireframe(clipSpace)
    end
end

---------- CLOSING ----------

return Renderer