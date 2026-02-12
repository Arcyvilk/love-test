local create_button = require 'ui.button'
local create_scene  = require 'scenes.create_scene'
local input         = require 'scenes.home.input'
local center_text   = require 'utils.center_text'
local vars          = require 'vars'

local buttons       = {
  create_button("Start", 0, 40, 160, 40, function() print('start') end),
  create_button("Exit", 0, 100, 160, 40, function() print('end') end)
}

local scene         = create_scene({
  name = 'scene_home',

  keybindings = input,

  mousepressed = function(self, x, y, mouse_button)
    for _, button in ipairs(buttons) do
      button:click(x, y, mouse_button)
    end
  end,

  draw = function(self, delta)
    center_text({
      text = "SNAKE",
      size = 72,
      color = { 0.5, 0.7, 0.98, 1 },
      offset_x = 0,
      offset_y = -100,
      parent = { x = 0, y = 0, width = vars.world_width, height = vars.world_height }
    })

    for _, button in ipairs(buttons) do
      button:draw()
    end
  end,

  update = function(self, delta)
    for _, button in ipairs(buttons) do
      button:update()
    end
  end
})

return scene
