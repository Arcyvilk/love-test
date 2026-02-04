local world = require 'world'

local spawned_entities = {}

--- @param x_pos number
--- @param y_pos number
--- @param entity_to_spawn any
local spawner = function(x_pos, y_pos, entity_to_spawn)
  local entity = {
    radius = 2
  }

  entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
  entity.shape = love.physics.newCircleShape(entity.radius)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setUserData(entity)

  entity.spawn = function()
    table.insert(spawned_entities, entity_to_spawn(x_pos, y_pos))
  end

  entity.draw = function(self)
    local x_self, y_self = self.body:getWorldPoint(x_pos, y_pos)
    love.graphics.circle('line', x_self, y_self, self.shape:getRadius())
  end

  return entity
end

return { spawner, spawned_entities }
