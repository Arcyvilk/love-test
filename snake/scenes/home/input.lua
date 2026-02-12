return function(scene_manager)
  local input = {
    escape = {
      release = function()
        love.event.quit()
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
