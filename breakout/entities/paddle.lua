local world = require 'world'
local input = require 'input'
local vars = require 'vars'

--- @param x_pos number
--- @param y_pos number
return function(x_pos, y_pos)
  local entity = {}

  entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
  entity.shape = love.physics.newRectangleShape(vars.paddle_width, vars.paddle_height)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setUserData(entity)

  entity.draw = function(self)
    love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
  end

  entity.update = function(self)
    if input.left and input.right then return end

    local self_x, self_y = self.body:getPosition()

    if input.left then
      local boundary_x = math.max(self_x - vars.paddle_speed, vars.paddle_width / 2)
      self.body:setPosition(boundary_x, self_y)
    end

    if input.right then
      local boundary_x = math.min(self_x + vars.paddle_speed, vars.world_width - vars.paddle_width / 2)
      self.body:setPosition(boundary_x, self_y)
    end
  end

  return entity
end
