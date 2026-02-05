local world = require 'world'

--- @param x_pos            number
--- @param y_pos            number
--- @param spawn_delay      number
return function(x_pos, y_pos, spawn_delay)
  local entity = {
    radius = 2,
    entities_to_spawn = {},
    spawn_delay = spawn_delay or 1
  }

  local accumulated_delay = 0

  entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
  entity.shape = love.physics.newCircleShape(entity.radius)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setSensor(true) -- disable collission
  entity.fixture:setUserData(entity)

  entity.spawn = function(self, delta)
    accumulated_delay = accumulated_delay + delta

    if accumulated_delay >= self.spawn_delay then
      table.insert(self.entities_to_spawn, entity_to_spawn(x_pos, y_pos))
      accumulated_delay = 0
    end
  end

  entity.draw = function(self)
    local x_self, y_self = self.body:getWorldCenter()
    love.graphics.circle('fill', x_self, y_self, self.shape:getRadius())
  end

  return entity
end
