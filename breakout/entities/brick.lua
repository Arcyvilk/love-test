local world = require 'world'
local vars = require 'vars'

--- @param x_pos number
--- @param y_pos number
return function(x_pos, y_pos)
  local entity = {}

  entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
  entity.shape = love.physics.newRectangleShape(vars.brick_width, vars.brick_height)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)


  entity.body:setMass(1000)
  -- entity.body:setLinearVelocity(0, 10)
  entity.fixture:setRestitution(-1000)

  entity.fixture:setUserData(entity)

  entity.draw = function(self)
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
  end

  return entity
end
