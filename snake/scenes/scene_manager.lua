---@class Scene
---@field name string
---@field init fun(self: table)
---@field draw fun(self: table, delta: number)
---@field update fun(self: table, delta: number)
---@field keypressed fun(self: table, key: string)
---@field keyreleased fun(self: table, key: string)
---@field mousepressed fun(self: table, x: number, y: number, button: number)

local scene_manager         = {}

---@type Scene
scene_manager.current_scene = nil

---@type table { [key]: Scene }
scene_manager.scenes        = {
  scene_home         = require 'scenes.home.scene' (scene_manager),
  scene_game         = require 'scenes.game.scene' (scene_manager),
  scene_settings     = require 'scenes.settings.scene' (scene_manager),
  scene_leaderboards = require 'scenes.leaderboards.scene' (scene_manager),
  scene_end          = require 'scenes.end.scene' (scene_manager)
}

scene_manager.init          = function(self)
  self.current_scene = self.scenes.scene_home
  print('Scene ' .. self.current_scene.name .. ' initialized!')
end

scene_manager.move_to       = function(self, scene_name)
  self.current_scene = self.scenes[scene_name]
  self.current_scene:init()
  print('Moved to ' .. self.current_scene.name .. ' scene!')
end

return scene_manager
