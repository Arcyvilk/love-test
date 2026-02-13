local world         = require 'world'
local fonts         = require '_assets.fonts.fonts'
local scene_manager = require 'scenes.scene_manager'
local dev           = require 'dev'

love.load           = function()
  fonts:load()
  scene_manager:init()
end

love.draw           = function()
  scene_manager.current_scene:draw()
  if dev.debug then
    dev.draw_physics()
  end
end

love.update         = function(delta)
  scene_manager.current_scene:update()
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
