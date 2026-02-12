local vars        = require 'vars'
local player      = require 'entities.player'
local center_text = require 'utils.center_text'

local entity      = {}

function entity.draw()
  center_text({
    text = string.format('Score: %.1f', player.score),
    size = 12,
    color = { 1, 0, 0, 1 },
    offset_x = 0,
    offset_y = vars.world_height / -2.1,
    parent = {
      x = 0, y = 0, width = vars.world_width, height = vars.world_height
    }
  })
end

return entity
