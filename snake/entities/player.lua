local world               = require 'world'
local vars                = require 'vars'
local normalize           = require 'utils.normalize'

local segment_radius_step = (vars.player_radius_max - vars.player_radius_min) / vars.player_segments

local player              = {
  head = {},
  segments = {},
  health_max = vars.player_segments,
  health_current = vars.player_segments,
  is_dead = false
}

local create_head         = function()
  local head = {
    name = "player_head",
    state = "vulnerable",
    recovery_timer = 0,
    recovery_delay = vars.player_recovery_time
  }
  local target = {}

  head.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'dynamic')
  head.shape = love.physics.newCircleShape(segment_radius_step * vars.player_segments)
  head.fixture = love.physics.newFixture(head.body, head.shape)

  head.take_damage = function(self)
    if player.is_dead then return end

    player.health_current = player.health_current - 1
    table.remove(player.segments, player.segments.size)
    self:begin_recovery()

    if player.health_current <= 0 then
      self:die()
    end
  end

  head.begin_recovery = function(self)
    self.fixture:setFilterData(1, 0, 0)
    self.state = "invulnerable"
  end

  head.end_recovery = function(self)
    self.fixture:setFilterData(1, 65535, 0)
    self.state = "vulnerable"
    self.recovery_timer = 0
    self.recovery_delay = vars.player_recovery_time
  end

  head.die = function(self)
    player.is_dead = true
  end

  head.update_state = function(self, delta)
    if self.state == 'vulnerable' then return end

    self.recovery_timer = self.recovery_timer + delta

    if self.recovery_timer >= self.recovery_delay then
      self:end_recovery()
    end
  end

  head.draw_state = function(self, x, y)
    if self.state == 'invulnerable' then
      love.graphics.setColor(1, 0, 0, 1)
      love.graphics.circle('fill', x, y, self.shape:getRadius())

      local radius_percentage = self.recovery_timer / self.recovery_delay
      local new_radius = self.shape:getRadius() * (radius_percentage)

      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.circle('fill', x, y, new_radius)
    else
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.circle('fill', x, y, self.shape:getRadius())
    end
  end

  head.update = function(self, delta)
    head:update_state(delta)

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

    self:draw_state(x, y)

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.line(x, y, target.x, target.y)
    love.graphics.setColor(1, 1, 1, 1)
  end

  head.fixture:setUserData(head)

  return head
end

--- @param index number
local create_segment      = function(index, prev_segment)
  local segment = {
    name = "player_segment_" .. index
  }
  local target = {}

  segment.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'kinematic')
  segment.shape = love.physics.newCircleShape(segment_radius_step * (vars.player_segments - index))
  segment.fixture = love.physics.newFixture(segment.body, segment.shape)

  segment.update = function(self)
    local px, py = self.body:getPosition()

    target.x, target.y = prev_segment.body:getPosition()
    local vx, vy = normalize(px - target.x, py - target.y)
    local spacing = prev_segment.shape:getRadius() * 2
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

local create_segments     = function(head)
  local segments = {}
  local index = 1
  local prev_segment = head

  while index < vars.player_segments do
    local new_segment = create_segment(index, prev_segment)
    table.insert(segments, new_segment)
    prev_segment = new_segment
    index = index + 1
  end

  return segments
end

player.update             = function(self, delta)
  self.head:update(delta)
  for _, segment in ipairs(self.segments) do
    segment:update(delta)
  end
end

player.draw               = function(self)
  self.head:draw()
  for _, segment in ipairs(self.segments) do
    segment:draw()
  end
end

player.reset              = function(self)
  self.head           = create_head()
  self.segments       = create_segments(self.head)
  self.health_current = vars.player_segments
  self.is_dead        = false
end

player:reset()

return player
