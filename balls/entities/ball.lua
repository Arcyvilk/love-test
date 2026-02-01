local world = require 'world'
local vars = require 'vars'

--- @param x_pos number
--- @param y_pos number
return function(x_pos, y_pos)
  local entity = {}

  entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
  entity.shape = love.physics.newCircleShape(vars.ball_radius)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setUserData(entity)

  entity.draw = function(self)
    local x_self, y_self = self.body:getWorldPoint(x_pos, y_pos)
    love.graphics.circle('fill', x_self, y_self, vars.ball_radius)
  end

  return entity
end
