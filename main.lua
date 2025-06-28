local Renderer = require("engine.Renderer.Renderer")

local renderer

function love.load() -- runs at start, for setup mostly
    local width, height = love.graphics.getDimensions()
    renderer = Renderer.new(width, height)
end

function love.update(dt) -- runs every frame before draw

end

function love.draw() -- runs every frame after update
    renderer:render(love.timer.getDelta())
end