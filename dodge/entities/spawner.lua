local world = require 'world'

--- @param x_pos            number
--- @param y_pos            number
--- @param entity_to_spawn  function
--- @param spawn_delay      number
return function(x_pos, y_pos, entity_to_spawn, spawn_delay)
  local entity = {
    radius = 2,
    spawned_entities = {},
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
      table.insert(self.spawned_entities, entity_to_spawn(x_pos, y_pos))
      accumulated_delay = 0
    end
  end

  entity.draw = function(self)
    local x_self, y_self = self.body:getWorldCenter()
    love.graphics.circle('fill', x_self, y_self, self.shape:getRadius())
  end

  entity.despawn = function(self)
    for index, spawned_entity in ipairs(self.spawned_entities) do
      if spawned_entity.age >= spawned_entity.ttl then
        table.remove(self.spawned_entities, index)
      end
    end
  end

  return entity
end
