local vars            = require 'vars'
local spawner         = require 'entities.spawner'
local arrow           = require 'entities.arrow'

local spawners        = {
  spawner(vars.spawner_offset_x, vars.spawner_offset_y, arrow, vars.arrow_spawn_delay),
  spawner(vars.world_width - vars.spawner_offset_x, vars.spawner_offset_y, arrow, vars.arrow_spawn_delay),
  spawner(vars.spawner_offset_x, vars.world_height - vars.spawner_offset_y, arrow, vars.arrow_spawn_delay),
  spawner(vars.world_width - vars.spawner_offset_x, vars.world_height - vars.spawner_offset_y, arrow,
    vars.arrow_spawn_delay)
}

local init_spawners   = function()
  for _, entity in ipairs(spawners) do
    entity:reset()
  end
end

local draw_spawners   = function()
  for _, entity in ipairs(spawners) do
    if entity.draw then
      entity:draw()
    end

    for _, spawned_entity in ipairs(entity.spawned_entities) do
      if spawned_entity.draw then
        spawned_entity:draw()
      end
    end
  end
end

local update_spawners = function()
  for _, entity in ipairs(spawners) do
    if entity.spawn then
      entity:spawn()
    end
    if entity.despawn then
      entity:despawn()
    end

    for _, spawned_entity in ipairs(entity.spawned_entities) do
      if spawned_entity.update then
        spawned_entity:update()
      end
    end
  end
end

return {
  init_spawners,
  draw_spawners,
  update_spawners
}
