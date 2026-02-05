local world          = require 'world'
local vars           = require 'vars'
local normalize      = require 'utils.normalize'
local clamp          = require 'utils.clamp'

local segments       = {}

--- @param index number
local create_segment = function(index)
  local segment = {
    index = index
  }

  segment.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'dynamic')
  segment.shape = love.physics.newCircleShape(clamp(vars.player_radius_min, vars.player_radius_max,
    (vars.player_segments - index) / 2))
  segment.fixture = love.physics.newFixture(segment.body, segment.shape)
  segment.fixture:setUserData(segment)
  segment.target = {}

  segment.update = function(self, delta)
    local px, py = self.body:getPosition()
    local is_head = index == 1
    local distance_factor_x = 1
    local distance_factor_y = 1

    if is_head then -- target cursor
      segment.target.x, segment.target.y = love.mouse.getPosition()
    else            -- target previous chain segment
      segment.target.x, segment.target.y = segments[index - 1].body:getPosition()
    end

    local vx, vy = normalize(segment.target.x - px, segment.target.y - py)
    self.body:setLinearVelocity(vx * vars.player_speed * distance_factor_x, vy * vars.player_speed * distance_factor_y)
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
