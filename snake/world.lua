local vars                   = require 'vars'

local begin_contact_callback = function(fixture_a, fixture_b, contact)
  return
end

local end_contact_callback   = function(fixture_a, fixture_b, contact)
  return
end

local pre_solve_callback     = function(fixture_a, fixture_b, contact)
  return
end

local post_solve_callback    = function(fixture_a, fixture_b, contact)
  return
end

local world                  = love.physics.newWorld(0, vars.gravity * vars.gravity_multiplier)

world:setCallbacks(
  begin_contact_callback,
  end_contact_callback,
  pre_solve_callback,
  post_solve_callback
)

return world
