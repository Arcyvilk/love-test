local create_scene = require('scenes.create_scene')

local scene = create_scene({
  name = 'scene_end',

  draw = function(self, delta)
    print(delta)
  end,

  update = function(self, delta)
    print(delta)
  end,

  keypressed = function(key)
    print(key)
  end,

  keyreleased = function(key)
    print(key)
  end
})

return scene
