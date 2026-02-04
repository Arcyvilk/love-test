local world      = require 'world'
local input      = require 'input'
local player     = require 'entities.player'

love.draw        = function()
  player:draw()
end

love.update      = function(dt)
  player:update()
  world:update(dt)
end

love.keypressed  = function(pressed_key)
  if input[pressed_key] and input[pressed_key].press then
    input[pressed_key]:press()
  end
end

love.keyreleased = function(released_key)
  if input[released_key] and input[released_key].release then
    input[released_key]:release()
  end
end
