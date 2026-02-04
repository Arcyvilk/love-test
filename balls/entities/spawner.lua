local world = require 'world'

--- @param x_pos number
--- @param y_pos number
--- @param entity_to_spawn function
--- @param spawn_delay number
return function(x_pos, y_pos, entity_to_spawn, spawn_delay)
  local accumulated_delay = 0

  local entity = {
    radius = 2,
    entities_to_spawn = {},
    spawn_delay = spawn_delay or 1
  }

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
    love.graphics.circle('line', x_self, y_self, self.shape:getRadius())
  end

  return entity
end
