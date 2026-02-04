local vars       = require 'vars'
local ball       = require 'entities.ball'
local boundary   = require 'entities.boundary'
local spawner    = require 'entities.spawner'

local boundaries = {
  boundary('top'),
  boundary('bottom'),
  boundary('left'),
  boundary('right')
}

local spawners   = {
  spawner(vars.spawner_offset_x, vars.spawner_offset_y, ball, vars.ball_spawn_delay),
  spawner(vars.world_width - vars.spawner_offset_x, vars.spawner_offset_y, ball, vars.ball_spawn_delay)
}

return {
  boundaries = boundaries,
  spawners = spawners
}
