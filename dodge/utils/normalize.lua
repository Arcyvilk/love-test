---@param vx number
---@param vy number
local normalize = function(vx, vy)
  local magnitude = math.sqrt(vx ^ 2 + vy ^ 2)
  local normalized_x = 0
  local normalized_y = 0

  if magnitude > 0 then
    normalized_x = vx / magnitude
    normalized_y = vy / magnitude
  end

  return normalized_x, normalized_y
end

return normalize
