local clamp = function(min, max, value)
  return math.max(min, math.min(max, value))
end

return clamp
