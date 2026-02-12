return function(scene_manager)
  local input = {
    escape = {
      release = function()
        scene_manager:move_to('scene_home')
      end
    },
    space = {
      press = function()
        debug.debug()
      end
    }
  }

  return input
end
