local world         = require 'world'
local scene_manager = require 'scenes.scene_manager'

love.load           = function()
  scene_manager:init()
end

love.draw           = function()
  scene_manager.current_scene:draw()
end

love.update         = function(delta)
  scene_manager.current_scene:update(delta)
  world:update(delta)
end

love.keypressed     = function(key)
  scene_manager.current_scene:keypressed(key)
end

love.keyreleased    = function(key)
  scene_manager.current_scene:keyreleased(key)
end

love.mousepressed   = function(x, y, button)
  scene_manager.current_scene:mousepressed(x, y, button)
end
