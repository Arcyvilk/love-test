local create_button = require 'ui.button'
local create_scene  = require 'scenes.create_scene'
local input         = require 'scenes.leaderboards.input'
local center_text   = require 'utils.center_text'
local vars          = require 'vars'

local create_entry  = function(text, offset_y)
  return {
    text = text,
    size = 12,
    color = { 1, 1, 1, 1 },
    offset_x = 0,
    offset_y = offset_y,
    parent = { x = 0, y = 0, width = vars.world_width, height = vars.world_height }
  }
end

return function(scene_manager)
  local buttons = {
    create_button("Back", 0, vars.world_height / 2.4, 160, 40, function() scene_manager:move_to('scene_home') end)
  }

  local entries = {
    create_entry("1. not you", -100),
    create_entry("2. not you", -80),
    create_entry("3. not you", -60),
    create_entry("4. not you", -40),
    create_entry("5. not you", -20),
    create_entry("6. not you", 0),
    create_entry("7. not you", 20),
    create_entry("8. not you", 40),
    create_entry("9. not you", 60),
    create_entry("10. not you", 80)
  }

  local scene = create_scene({
    name = 'scene_leaderboards',

    keybindings = input(scene_manager),

    init = function() return end,

    mousepressed = function(self, x, y, mouse_button)
      for _, button in ipairs(buttons) do
        button:click(x, y, mouse_button)
      end
    end,

    draw = function(self)
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
      for _, entry in ipairs(entries) do
        center_text(entry)
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
