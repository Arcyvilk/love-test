local world = require 'world'
local vars  = require 'vars'

--- @param x_pos number
--- @param y_pos number
return function(x_pos, y_pos)
  local entity = {}

  entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
  entity.shape = love.physics.newCircleShape(vars.ball_radius)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setRestitution(1)
  entity.fixture:setUserData(entity)

  local bx, by = entity.body:getPosition()
  local dx = vars.world_width / 2 - bx
  local dy = vars.world_height / 2 - by

  entity.body:setMass(20)
  entity.body:setLinearVelocity(dx, dy)

  entity.draw = function(self)
    local x_self, y_self = self.body:getWorldCenter()
    love.graphics.setColor(110 / 255, 110 / 255, 240 / 255)
    love.graphics.circle('fill', x_self, y_self, self.shape:getRadius())
    love.graphics.setColor(1, 1, 1)
  end

  return entity
end
