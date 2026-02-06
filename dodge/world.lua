local vars                   = require 'vars'

local begin_contact_callback = function(fixture_a, fixture_b, contact)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()

  if entity_a and entity_b then
    if entity_a.name == 'player_head' and entity_b.name == 'arrow' then
      entity_a:take_damage()
    end
    if entity_b.name == 'player_head' and entity_a.name == 'arrow' then
      entity_b:take_damage()
    end
  end
end

local end_contact_callback   = function(fixture_a, fixture_b, contact)
end

local pre_solve_callback     = function(fixture_a, fixture_b, contact)
end

local post_solve_callback    = function(fixture_a, fixture_b, contact)
end

local world                  = love.physics.newWorld(0, vars.gravity * vars.gravity_multiplier)

world:setCallbacks(
  begin_contact_callback,
  end_contact_callback,
  pre_solve_callback,
  post_solve_callback
)

return world
