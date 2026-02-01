local vars = require 'vars'

local world = love.physics.newWorld(0, vars.gravity * vars.gravity_multiplier)

return world
