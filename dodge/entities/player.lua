local world          = require 'world'
local vars           = require 'vars'
local normalize      = require 'utils.normalize'
local clamp          = require 'utils.clamp'

local segments       = {}

--- @param index number
local create_segment = function(index)
  local segment = {}

  local segment_radius = (vars.player_radius_max - vars.player_radius_min) / vars.player_segments

  segment.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'kinematic')
  segment.shape = love.physics.newCircleShape(segment_radius * (vars.player_segments - index))
  segment.fixture = love.physics.newFixture(segment.body, segment.shape)
  segment.fixture:setUserData(segment)
  segment.target = {}

  segment.update = function(self, delta)
    local px, py = self.body:getPosition()
    local is_head = index == 1

    if is_head then -- target cursor
      segment.target.x, segment.target.y = love.mouse.getPosition()
      local vx, vy = normalize(segment.target.x - px, segment.target.y - py)
      local distance_factor_x = math.abs(segment.target.x - px) / 100
      local distance_factor_y = math.abs(segment.target.y - py) / 100
      self.body:setLinearVelocity(
        vx * clamp(vars.player_speed_min, vars.player_speed_max, vars.player_base_speed * distance_factor_x),
        vy * clamp(vars.player_speed_min, vars.player_speed_max, vars.player_base_speed * distance_factor_y))
    else -- target previous chain segment
      segment.target.x, segment.target.y = segments[index - 1].body:getPosition()
      local vx, vy = normalize(px - segment.target.x, py - segment.target.y)
      local spacing = segments[index - 1].shape:getRadius() * 2
      local x = segment.target.x + vx * spacing
      local y = segment.target.y + vy * spacing

      self.body:setPosition(x, y)
    end
  end

  segment.draw = function(self)
    local x_self, y_self = self.body:getWorldCenter()
    love.graphics.circle('line', x_self, y_self, self.shape:getRadius())
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.line(x_self, y_self, segment.target.x, segment.target.y)
    love.graphics.setColor(1, 1, 1, 1)
  end

  return segment
end

local create_player  = function()
  local player = {}
  local curr_segment = 1

  while curr_segment <= vars.player_segments do
    local segment = create_segment(curr_segment)
    table.insert(segments, segment)
    curr_segment = curr_segment + 1
  end

  player.update = function(self, delta)
    for _, segment in ipairs(segments) do
      segment:update(delta)
    end
  end

  player.draw = function(self)
    for _, segment in ipairs(segments) do
      segment:draw()
    end
  end

  return player
end

local player         = create_player()

return player
