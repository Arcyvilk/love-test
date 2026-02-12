local scene_manager = function()
  local manager   = {
    scenes = {
      scene_home = require 'scenes.home',
      scene_game = require 'scenes.game',
      scene_end  = require 'scenes.end'
    },
    current_scene = nil
  }

  manager.init    = function(self)
    self.current_scene = self.scenes.scene_home
  end

  manager.move_to = function(self, scene_name)
    self.current_scene = self.scenes[scene_name]
  end

  return manager
end

return scene_manager
