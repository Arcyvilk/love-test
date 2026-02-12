--- @param line_x     number
--- @param line_y     number
--- @param point_x    number
--- @param point_y    number
local get_angle = function(line_x, line_y, point_x, point_y)
  local radians = math.atan2(point_y - line_y, point_x - line_x)
  return radians
end

return get_angle
