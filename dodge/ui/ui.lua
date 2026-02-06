local player = require 'entities.player'

local entity = {}

function entity.draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.print(string.format('Health: %.1f', player.health_current), 10, 10)
  love.graphics.setColor(1, 1, 1)
end

return entity
