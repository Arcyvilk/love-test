local world = require 'world'
local input = require 'input'
local ball = require 'entities.ball'

local entities = {
  ball(10, 10),
  ball(100, 10),
  ball(10, 100)
}

love.draw = function()
  for _, entity in ipairs(entities) do
    if entity.draw then
      entity:draw()
    end
  end
end

love.keypressed = function(pressed_key)
  if input[pressed_key] then
    input[pressed_key]()
  end
end

love.update = function(dt)
end
