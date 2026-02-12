local input        = require 'scenes.home.input'
local create_scene = require('scenes.create_scene')

local scene        = create_scene({
  name = 'scene_home',

  keybindings = input,

  draw = function(self, delta)
    return
  end,

  update = function(self, delta)
    return
  end
})

return scene
