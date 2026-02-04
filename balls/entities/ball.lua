local world = require 'world'
local vars = require 'vars'

--- @param x_pos number
--- @param y_pos number
return function(x_pos, y_pos)
  local entity = {}

  entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
  entity.body:setMass(20)
  entity.body:setLinearVelocity(0, 0)

  entity.shape = love.physics.newCircleShape(vars.ball_radius)

  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setRestitution(1)
  entity.fixture:setUserData(entity)

  entity.id = 1

  entity.draw = function(self)
    local x_self, y_self = self.body:getWorldPoint(x_pos, y_pos)
    love.graphics.circle('fill', x_self, y_self, self.shape:getRadius())
  end

  return entity
end
