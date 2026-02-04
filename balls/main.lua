local world           = require 'world'
local input           = require 'input'
local entities        = require 'entities.entities'

local draw_boundaries = function()
  for _, entity in ipairs(entities.boundaries) do
    if entity.draw then entity:draw() end
  end
end

local draw_spawners   = function()
  for _, spawner in ipairs(entities.spawners) do
    if spawner.draw then
      spawner:draw()
    end

    for _, entity_to_spawn in ipairs(spawner.entities_to_spawn) do
      if entity_to_spawn.draw then
        entity_to_spawn:draw()
      end
    end
  end
end

love.draw             = function()
  draw_boundaries()
  draw_spawners()
end


love.update = function(dt)
  for _, spawner in ipairs(entities.spawners) do
    if spawner.spawn then
      spawner:spawn()
    end
  end

  world:update(dt)
end

love.keypressed = function(pressed_key)
  if input[pressed_key] then
    input[pressed_key]()
  end
end
