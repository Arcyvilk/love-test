local vars = require 'vars'

local begin_collission_callback = function(fixture_a, fixture_b, collission)
end

local end_collission_callback = function(fixture_a, fixture_b, collission)
end

local pre_solve_callback = function(fixture_a, fixture_b, collission)
end

local post_solve_callback = function(fixture_a, fixture_b, collission)
end

local world = love.physics.newWorld(0, vars.gravity * vars.gravity_multiplier)

world:setCallbacks(
  begin_collission_callback,
  end_collission_callback,
  pre_solve_callback,
  post_solve_callback
)

return world
