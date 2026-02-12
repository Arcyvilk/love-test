local create_button = require 'ui.button'
local create_scene  = require 'scenes.create_scene'
local input         = require 'scenes.end.input'
local center_text   = require 'utils.center_text'
local vars          = require 'vars'

return function(scene_manager)
  local buttons = {
    create_button("Back", 0, vars.world_height / 2.4, 160, 40, function() scene_manager:move_to('scene_home') end)
  }

  local scene = create_scene({
    name = 'scene_leaderboards',

    keybindings = input,

    mousepressed = function(self, x, y, mouse_button)
      for _, button in ipairs(buttons) do
        button:click(x, y, mouse_button)
      end
    end,

    draw = function(self, delta)
      center_text({
        text = "LEADERBOARDS",
        size = 32,
        color = { 0.5, 0.7, 0.98, 1 },
        offset_x = 0,
        offset_y = vars.world_height / -2.4,
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
end
