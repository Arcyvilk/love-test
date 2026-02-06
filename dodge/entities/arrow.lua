local world     = require 'world'
local vars      = require 'vars'
local player    = require 'entities.player'
local get_angle = require 'utils.get_angle'
local normalize = require 'utils.normalize'

return function(x_pos, y_pos)
  local entity   = {
    is_moving = false,
    is_shot = false,
    angle = 0,
    preparation_time = 60,
    ttl = 180,
    age = 0,
    target = {
      x = 0,
      y = 0
    }
  }

  entity.body    = love.physics.newBody(world, x_pos, y_pos, 'kinematic')
  entity.shape   = love.physics.newRectangleShape(x_pos, y_pos, vars.arrow_width, vars.arrow_height,
    entity.angle)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)

  entity.home    = function(self)
    local target_x, target_y = player.head.body:getPosition()
    local x_self, y_self     = self.body:getPosition()
    self.angle               = get_angle(x_self, y_self, target_x, target_y) - math.pi / 2
  end

  entity.shoot   = function(self)
    local px, py = self.body:getPosition()
    local vx, vy = normalize(self.target.x - px, self.target.y - py)
    self.body:setLinearVelocity(vx * vars.arrow_base_speed, vy * vars.arrow_base_speed)
  end

  entity.update  = function(self)
    if self.age >= self.preparation_time and not self.is_moving then
      self.target.x, self.target.y = player.head.body:getPosition()
      self.is_moving = true
    end

    self.age = self.age + 1

    if self.is_moving then
      if self.is_shot then return end

      self.is_shot = true
      self:shoot()
    else
      self:home()
    end
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
