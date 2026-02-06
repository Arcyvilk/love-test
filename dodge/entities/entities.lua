local vars          = require 'vars'
local spawner       = require 'entities.spawner'
local arrow         = require 'entities.arrow'

local spawners      = {
  spawner(vars.spawner_offset_x, vars.spawner_offset_y, arrow, 1),
  spawner(vars.world_width - vars.spawner_offset_x, vars.spawner_offset_y, arrow, 1)
}

local draw_spawners = function()
  for _, entity in ipairs(spawners) do
    entity:draw()
  end
end

return {
  draw_spawners
}
