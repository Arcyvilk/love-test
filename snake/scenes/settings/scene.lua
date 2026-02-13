local create_button = require 'ui.button'
local create_scene  = require 'scenes.create_scene'
local input         = require 'scenes.settings.input'
local center_text   = require 'utils.center_text'
local dev           = require 'dev'
local vars          = require 'vars'

return function(scene_manager)
  local buttons = {
    create_button("Debug mode", 0, -160, vars.button_width, vars.button_height,
      function() dev.debug = not dev.debug end),
    create_button("Back", 0, vars.world_height / 2.4, vars.button_width, vars.button_height,
      function() scene_manager:move_to('scene_home') end)
  }

  local scene = create_scene({
    name = 'scene_settings',

    keybindings = input(scene_manager),

    init = function() return end,

    mousepressed = function(self, x, y, mouse_button)
      for _, button in ipairs(buttons) do
        button:click(x, y, mouse_button)
      end
    end,

    draw = function(self)
      center_text({
        text = "SETTINGS",
        size = 'l',
        color = { 0.5, 0.7, 0.98, 1 },
        offset_x = 0,
        offset_y = vars.world_height / -2.4,
        parent = { x = 0, y = 0, width = vars.world_width, height = vars.world_height }
      })

      center_text({
        text = dev.debug and 'ON' or 'OFF',
        size = 'm',
        color = { 0.5, 0.7, 0.98, 1 },
        offset_x = vars.button_width / 3 * 2,
        offset_y = -160,
        parent = { x = 0, y = 0, width = vars.world_width, height = vars.world_height }
      })

      for _, button in ipairs(buttons) do
        button:draw()
      end
    end,

    update = function(self)
      for _, button in ipairs(buttons) do
        button:update()
      end
    end
  })

  return scene
end
