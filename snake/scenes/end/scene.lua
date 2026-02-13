local create_button = require 'ui.button'
local create_scene  = require 'scenes.create_scene'
local input         = require 'scenes.home.input'
local center_text   = require 'utils.center_text'
local player        = require 'entities.player'
local fs            = require 'utils.fs'
local vars          = require 'vars'

return function(scene_manager)
  local buttons = {
    create_button("Try again", 0, 120, 160, 40, function() scene_manager:move_to('scene_game') end),
    create_button("Back to title", 0, 180, 160, 40, function() scene_manager:move_to('scene_home') end)
  }

  local scene   = create_scene({
    name = 'scene_end',

    keybindings = input(scene_manager),

    init = function()
      local final_score = { player.score, "true" }
      fs.write(vars.save_file_name, final_score)
    end,

    mousepressed = function(self, x, y, mouse_button)
      for _, button in ipairs(buttons) do
        button:click(x, y, mouse_button)
      end
    end,

    draw = function(self)
      center_text({
        text = "YOU LOST",
        size = 72,
        color = { 0.5, 0.7, 0.98, 1 },
        offset_x = 0,
        offset_y = -140,
        parent = { x = 0, y = 0, width = vars.world_width, height = vars.world_height }
      })

      center_text({
        text = "Final score: " .. player.score,
        size = 32,
        color = { 1, 1, 1, 1 },
        offset_x = 0,
        offset_y = 0,
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
