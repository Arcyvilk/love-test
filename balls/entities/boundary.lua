local world = require 'world'
local vars  = require 'vars'

local body  = {
  top = love.physics.newBody(world, vars.world_width / 2, vars.boundary_offset_top, 'static'),
  bottom = love.physics.newBody(world, vars.world_width / 2, vars.world_height - vars.boundary_width / 2, 'static'),
  left = love.physics.newBody(world, vars.boundary_width / 2, vars.world_height / 2, 'static'),
  right = love.physics.newBody(world, vars.world_width - vars.boundary_width / 2, vars.world_height / 2, 'static')
}

local shape = {
  top = love.physics.newRectangleShape(vars.world_width, vars.boundary_width),
  bottom = love.physics.newRectangleShape(vars.world_width, vars.boundary_width),
  left = love.physics.newRectangleShape(vars.boundary_width, vars.world_height),
  right = love.physics.newRectangleShape(vars.boundary_width, vars.world_height)
}

--- @param placement 'top' | 'bottom' | 'left' | 'right'
return function(placement)
  local entity = {}

  entity.body = body[placement]
  entity.shape = shape[placement]
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
  entity.fixture:setUserData(entity)

  entity.draw = function(self)
    love.graphics.polygon(vars.boundary_style, self.body:getWorldPoints(self.shape:getPoints()))
  end

  return entity
end
