local baseImage = love.graphics.newImage("player.png")
local moveFX = love.audio.newSource("Random 34.wav", "static")
local tile = love.graphics.newImage("tile.png")
local player = require "player"

local enemy_base = {
  speed = 200,
  x = function(t)
    return math.cos(t)*3
  end,
  y = function(t)
    return math.sin(t)*5
  end
}

function love.load()

end

function love.update(dt)
  player:move(dt)
end

local r, g, b = 130, 128, 214
local rDir, gDir, bDir = 1, 1, 1
function love.draw()
  if r > 255 then
    r = 255
    rDir = -1
  elseif r < 0 then
    r = 0
    rDir = 1
  end
  if g > 255 then
    g = 255
    gDir = -1
  elseif g < 0 then
    g = 0
    gDir = 1
  end
  if b > 255 then
    b = 255
    bDir = -1
  elseif b < 0 then
    b = 0
    bDir = 1
  end

  r = rDir > 0 and r + 1 or r - 1
  g = gDir > 0 and g + 1 or g - 1
  b = bDir > 0 and b + 1 or b - 1

  for y = 0, 13 do
    for x = 0, 24 do
      love.graphics.setColor(r, g, b)
      love.graphics.draw(tile, x * tile:getWidth(), y * tile:getHeight())
    end
  end

  --love.graphics.rectangle("fill", player.x, player.y, 32, 32)
  love.graphics.setColor(0,0,0)
  love.graphics.draw(baseImage, player.x, player.y, player.theta+math.pi/2, 1.4, 1.4, 16, 16)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(baseImage, player.x, player.y, player.theta+math.pi/2, 1, 1, 16, 16)
end