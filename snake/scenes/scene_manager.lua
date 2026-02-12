---@class Scene
---@field name string
---@field draw fun(self: table, dt:number)
---@field update fun(self: table, dt:number)
---@field keypressed fun(self: table, key: string)
---@field keyreleased fun(self: table, key: string)

local scene_manager   = {
  ---@type Scene
  current_scene = nil,
  ---@type table { [key]: Scene }
  scenes = {
    scene_home = require 'scenes.home.scene',
    scene_game = require 'scenes.game.scene',
    scene_end  = require 'scenes.end.scene'
  }
}

scene_manager.init    = function(self)
  self.current_scene = self.scenes.scene_home
  print('Scene ' .. self.current_scene.name .. ' initialized!')
end

scene_manager.move_to = function(self, scene_name)
  self.current_scene = self.scenes[scene_name]
  print('Moved to ' .. self.current_scene.name .. ' scene!')
end

return scene_manager
