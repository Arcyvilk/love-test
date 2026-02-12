local input        = require 'scenes.end.input'
local create_scene = require 'scenes.create_scene'

return function(scene_manager)
  local scene = create_scene({
    name = 'scene_settings',

    keybindings = input,

    mousepressed = function(self, x, y, mouse_button)
      return
    end,

    draw = function(self, delta)
      return
    end,

    update = function(self, delta)
      return
    end
  })

  return scene
end
