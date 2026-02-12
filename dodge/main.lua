local world                          = require 'world'
local input                          = require 'input'
local player                         = require 'entities.player'
local ui                             = require 'ui.ui'
local death_screen                   = require 'ui.death_screen'
local draw_spawners, update_spawners = unpack(require 'entities.entities')

love.draw                            = function(dt)
  if player.is_dead then
    death_screen.draw()
  end

  player:draw(dt)
  ui.draw()
  draw_spawners()
end

love.update                          = function(dt)
  if player.is_dead then return end

  player:update(dt)
  update_spawners(dt)

  world:update(dt)
end

love.keypressed                      = function(pressed_key)
  if input[pressed_key] then
    input[pressed_key]:press()
  end
end

love.keyreleased                     = function(released_key)
  if input[released_key] then
    input[released_key]:release()
  end
end
