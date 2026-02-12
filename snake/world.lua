local vars                   = require 'vars'

local get_entity_by_name     = function(entity_name, entity_a, entity_b)
  if entity_a and entity_a.name == entity_name then return entity_a end
  if entity_b and entity_b.name == entity_name then return entity_b end
end

local begin_contact_callback = function(fixture_a, fixture_b, contact)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()

  local head = get_entity_by_name('player_head', entity_a, entity_b)
  local arrow = get_entity_by_name('arrow', entity_a, entity_b)

  if head and arrow then
    head:take_damage()
    arrow:mark_as_assassin()
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
