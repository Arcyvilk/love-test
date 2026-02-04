local world = require 'world'
local input = require 'input'
local ball = require 'entities.ball'
local spawner = require 'entities.spawner'

local spawners = {
  spawner(10, 10, ball(10, 10)),
  spawner(390, 10, ball(390, 10))
}

love.draw = function()
  for _, entity_spawner in ipairs(spawners) do
    if entity_spawner.draw then
      entity_spawner:draw()
    end

    for _, entity_to_spawn in ipairs(entity_spawner.entities) do
      if entity_to_spawn.draw then
        entity_to_spawn:draw()
      end
    end
  end
end

love.update = function(dt)
  for _, entity_spawner in ipairs(spawners) do
    if entity_spawner.spawn then
      entity_spawner:spawn()
    end
  end

  world:update(dt)
end

love.keypressed = function(pressed_key)
  if input[pressed_key] then
    input[pressed_key]()
  end
end
