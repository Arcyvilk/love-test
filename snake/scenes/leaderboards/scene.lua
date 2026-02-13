local create_button = require 'ui.button'
local create_scene  = require 'scenes.create_scene'
local input         = require 'scenes.leaderboards.input'
local center_text   = require 'utils.center_text'
local fs            = require 'utils.fs'
local vars          = require 'vars'

local create_entry  = function(text, offset_y)
  return {
    text = text,
    size = 's',
    color = { 1, 1, 1, 1 },
    offset_x = 0,
    offset_y = offset_y,
    parent = { x = 0, y = 0, width = vars.world_width, height = vars.world_height }
  }
end

return function(scene_manager)
  local buttons = {
    create_button("Back", 0, vars.world_height / 2.4, vars.button_width, vars.button_height,
      function() scene_manager:move_to('scene_home') end)
  }

  local entries = {}

  local scene = create_scene({
    name = 'scene_leaderboards',

    keybindings = input(scene_manager),

    init = function()
      entries = {}
      local leaderboards = {}
      local data_str = fs.read(vars.save_file_name)

      string.gsub(data_str, "[^|]+", function(row)
        local entry = {}
        string.gsub(row, "[^,]+", function(data)
          table.insert(entry, data)
        end)
        table.insert(leaderboards, entry)
      end)

      table.sort(leaderboards, function(a, b) return tonumber(a[1]) > tonumber(b[1]) end)

      for index, entry in ipairs(leaderboards) do
        if index > 10 then return end

        local score = entry[1]
        local user = entry[2] == 'true' and 'you' or 'not you'
        table.insert(entries, create_entry(score .. " - " .. user, -140 + index * 20))
      end
    end,

    mousepressed = function(self, x, y, mouse_button)
      for _, button in ipairs(buttons) do
        button:click(x, y, mouse_button)
      end
    end,

    draw = function(self)
      center_text({
        text = "LEADERBOARDS",
        size = 'l',
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

    update = function(self)
      for _, button in ipairs(buttons) do
        button:update()
      end
    end
  })

  return scene
end
