local world    = require 'world'
local vars     = require 'vars'
local input    = require 'input'

local entity   = {
  health = vars.player_health
}

entity.body    = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'kinematic')
entity.shape   = love.physics.newCircleShape(vars.player_radius)
entity.fixture = love.physics.newFixture(entity.body, entity.shape)
entity.fixture:setUserData(entity)

entity.draw    = function(self)
  local x_self, y_self = self.body:getWorldCenter()
  love.graphics.circle('fill', x_self, y_self, self.shape:getRadius())
end

entity.update  = function(self)
  local x_self, y_self = self.body:getPosition()

  if input.left.active then
    local boundary_left = math.max(x_self - vars.player_speed, vars.player_radius / 2)
    self.body:setPosition(boundary_left, y_self)
  end

  if input.right.active then
    local boundary_right = math.min(x_self + vars.player_speed, vars.world_width - vars.player_radius / 2)
    self.body:setPosition(boundary_right, y_self)
  end

  if input.up.active then
    local boundary_top = math.max(vars.player_radius / 2, y_self - vars.player_speed)
    self.body:setPosition(x_self, boundary_top)
  end

  if input.down.active then
    local boundary_down = math.min(vars.world_height - vars.player_radius / 2, y_self + vars.player_speed)
    self.body:setPosition(x_self, boundary_down)
  end
end

entity.collide = function(self)
  self.health = self.health - 1
end

return entity
