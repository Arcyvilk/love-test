local scene_state = function()
  local state   = {
    scenes = {
      scene_home = require 'scenes.home',
      scene_game = require 'scenes.game',
      scene_end  = require 'scenes.end'
    },
    current_scene = nil
  }

  state.init    = function(self)
    self.current_scene = self.scenes.scene_home
  end

  state.move_to = function(self, scene_name)
    self.current_scene = self.scenes[scene_name]
  end

  return state
end

return scene_state
