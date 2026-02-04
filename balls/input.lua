local input = {
  escape = {
    press = function(self)
      love.event.quit()
    end
  },

  left   = {
    active = false,
    press = function(self)
      self.active = true
    end,
    release = function(self)
      self.active = false
    end
  },

  right  = {
    active = false,
    press = function(self)
      self.active = true
    end,
    release = function(self)
      self.active = false
    end
  },

  up     = {
    active = false,
    press = function(self)
      self.active = true
    end,
    release = function(self)
      self.active = false
    end
  },

  down   = {
    active = false,
    press = function(self)
      self.active = true
    end,
    release = function(self)
      self.active = false
    end
  }
}

return input
