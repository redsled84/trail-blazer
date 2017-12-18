local player = {
  x      =     100,
  y      =     100,
  vy     =     0,
  vx     =     0,
  theta  =     0,
  origMSpeed = 1400,
  mSpeed = 1400,
  speed = 0
}
function player:deltaTheta(dt)
  if love.keyboard.isDown("left") then
    self.theta = self.theta - 5 * dt
    -- self.mSpeed = 10000
  elseif love.keyboard.isDown( "right") then
    self.theta = self.theta + 5 * dt
    -- self.mSpeed = 10000
  end
end
function player:deltaSpeed(dt)
  -- acceleration going forwards
  if love.keyboard.isDown("up") then
    -- cap out the acceleration at a positive constant
    if self.mSpeed < self.origMSpeed then
      self.mSpeed = self.mSpeed + 100 * dt
    else
      self.mSpeed = self.origMSpeed
    end
    self.speed = self.speed + self.mSpeed * dt
  -- acceleration going backwards
  elseif love.keyboard.isDown("down") then
    -- cap out the acceleration at a negative constant
    if self.mSpeed > -self.origMSpeed then
      self.mSpeed = self.mSpeed - 100 * dt
    else
      self.mSpeed = -self.origMSpeed
    end
    self.speed = self.speed - self.mSpeed * dt
  else
    -- deceleration when going forward
    if self.speed > 30 then
      self.speed = self.speed - 4200 * dt
    elseif self.speed < -30 then
      self.speed = self.speed + 4200 * dt
    else
      self.speed = 0
    end
  end

  -- basically a speed limit
  if self.speed > self.origMSpeed then
    self.speed = self.origMSpeed
  end
end

function player:keepInWindow()
  if self.x > love.graphics.getWidth() then
    self.x = 0
  elseif self.x < 0 then
    self.x = love.graphics.getWidth()
  end
  if self.y > love.graphics.getHeight() then
    self.y = 0
  elseif self.y < 0 then
    self.y = love.graphics.getHeight()
  end
end

function player:playMovementSound()
  if self.speed ~= 0 then
    local speed = self.speed ~= 0 and self.speed or 1
    moveFX:setVolume(.05)
    if not moveFX:isPlaying() then
      moveFX:play()
    elseif moveFX:getPosition() < .09 then
      moveFX:stop()
      moveFX:play()
    end
  end
end

function player:move(dt)
  self:deltaTheta(dt)
  self:deltaSpeed(dt)

  self.vx = self.speed * math.cos(self.theta)
  self.vy = self.speed * math.sin(self.theta)
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt

  self:keepInWindow()

  self:playMovementSound()
end

function player:fire(key)
  if key == "space" then

  end
end

return player