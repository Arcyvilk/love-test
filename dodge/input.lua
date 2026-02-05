local input = {
  escape = {
    press = function()
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
