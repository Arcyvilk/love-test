-- This table is the service and will contain some functions
-- that can be accessed from entities or the main.lua
local input = {}
-- Map specific user inputs to game actions
local press_functions = {}
local release_functions = {}

input.left = false
input.right = false
input.paused = false

--- @param pressed_key string
input.press = function(pressed_key)
  if press_functions[pressed_key] then
    press_functions[pressed_key]()
  end
end

--- @param released_key string
input.release = function(released_key)
  if release_functions[released_key] then
    release_functions[released_key]()
  end
end

--- @param focused boolean
input.toggle_focus = function(focused)
  if not focused then
    input.paused = true
  end
end

press_functions.left = function()
  input.left = true
end
press_functions.right = function()
  input.right = true
end
press_functions.escape = function()
  love.event.quit()
end
press_functions.space = function()
  input.paused = not input.paused
end

release_functions.left = function()
  input.left = false
end
release_functions.right = function()
  input.right = false
end

return input
