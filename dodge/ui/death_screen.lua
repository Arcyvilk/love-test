local center_text = require 'utils.center_text'

local entity      = {}

function entity.draw()
  center_text("YOU DIED", 72, { 255, 0, 0 })
end

return entity
