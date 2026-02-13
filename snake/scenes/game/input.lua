local dev = require 'dev'

return function(scene_manager)
  local input = {
    escape = {
      release = function()
        scene_manager:move_to('scene_home')
      end
    },
    space = {
      press = function()
        dev.debug = not dev.debug
      end
    }
  }

  return input
end
