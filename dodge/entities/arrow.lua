local world     = require 'world'
local vars      = require 'vars'
local player    = require 'entities.player'
local get_angle = require 'utils.get_angle'

return function(x_pos, y_pos)
  local entity   = {
    is_moving = false,
    angle = 0
  }
  entity.body    = love.physics.newBody(world, x_pos, y_pos, 'kinematic')
  entity.shape   = love.physics.newRectangleShape(x_pos, y_pos, vars.arrow_width, vars.arrow_height, entity.angle)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)

  entity.update  = function(self)
    local x_head, y_head = player.head.body:getPosition()
    local x_self, y_self = self.body:getPosition()
    self.angle           = get_angle(x_self, y_self, x_head, y_head) - math.pi / 2
  end

  entity.draw    = function(self)
    local x = self.body:getX()
    local y = self.body:getY()
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(self.angle)
    love.graphics.rectangle("line", 0, 0, vars.arrow_width, vars.arrow_height)
    love.graphics.pop()
  end

  return entity
end
