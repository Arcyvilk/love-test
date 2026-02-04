local world = require 'world'

local radius = 2

return function(x_pos, y_pos, entity_to_spawn)
  local spawner = {
    entities = {}
  }

  spawner.body = love.physics.newBody(world, x_pos, y_pos, 'static')
  spawner.shape = love.physics.newCircleShape(radius)
  spawner.fixture = love.physics.newFixture(spawner.body, spawner.shape)
  spawner.fixture:setUserData(spawner)

  spawner.spawn = function(self)
    table.insert(self.entities, entity_to_spawn)
  end

  spawner.draw = function(self)
    local x_self, y_self = self.body:getWorldPoint(x_pos, y_pos)
    love.graphics.circle('line', x_self, y_self, radius)
  end

  return spawner
end
