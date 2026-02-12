local input        = require 'scenes.game.input'
local create_scene = require('scenes.create_scene')

local scene        = create_scene({
  name = 'scene_game',

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
