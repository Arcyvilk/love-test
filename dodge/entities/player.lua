local world               = require 'world'
local vars                = require 'vars'
local normalize           = require 'utils.normalize'

local segment_radius_step = (vars.player_radius_max - vars.player_radius_min) / vars.player_segments
local segments            = {}

local create_head         = function()
  local head = {}
  local target = {}

  head.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'kinematic')
  head.shape = love.physics.newCircleShape(segment_radius_step * vars.player_segments)
  head.fixture = love.physics.newFixture(head.body, head.shape)

  --- @param delta number
  head.update = function(self, delta)
    local px, py = self.body:getPosition()

    target.x, target.y = love.mouse.getPosition()
    local vx, vy = normalize(target.x - px, target.y - py)
    local distance_factor = {
      x = math.abs(target.x - px) / 100,
      y = math.abs(target.y - py) / 100
    }
    self.body:setLinearVelocity(
      vx * distance_factor.x * vars.player_base_speed,
      vy * distance_factor.y * vars.player_base_speed)
  end

  head.draw = function(self)
    local x, y = self.body:getPosition()
    love.graphics.circle('line', x, y, self.shape:getRadius())
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.line(x, y, target.x, target.y)
    love.graphics.setColor(1, 1, 1, 1)
  end

  return head
end

--- @param index number
local create_segment      = function(index)
  local segment = {}
  local target = {}

  segment.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'kinematic')
  segment.shape = love.physics.newCircleShape(segment_radius_step * (vars.player_segments - index))
  segment.fixture = love.physics.newFixture(segment.body, segment.shape)

  --- @param delta number
  segment.update = function(self, delta)
    local px, py = self.body:getPosition()

    target.x, target.y = segments[index - 1].body:getPosition()
    local vx, vy = normalize(px - target.x, py - target.y)
    local spacing = segments[index - 1].shape:getRadius() * 2
    local x = target.x + spacing * vx
    local y = target.y + spacing * vy

    self.body:setPosition(x, y)
  end

  segment.draw = function(self)
    local x, y = self.body:getWorldCenter()
    love.graphics.circle('line', x, y, self.shape:getRadius())
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.line(x, y, target.x, target.y)
    love.graphics.setColor(1, 1, 1, 1)
  end

  return segment
end

local create_player       = function()
  local player = {}
  local curr_segment = 1

  local head = create_head()
  table.insert(segments, head)
  curr_segment = curr_segment + 1

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

local player              = create_player()

return player
