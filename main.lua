local map = require 'newMap'

print((love.graphics.getSystemLimit or love.graphics.getMaxImageSize) "texturesize")

YouShallNotPass = function() pass = false end

love.load = function()

  local max = 100

  local sea = 0.4    *max 
  local land = 0.8   *max

  math.randomseed(os.time())
  math.random()

  m = map.new(16, max)

  --[[
  while #m.map*2-1 <= 600 do

    m:pass()
  
  end--]]

  colors = setmetatable({}, {__index = function(t, k)

    if k <= sea then

    	k = k/sea

      return {0, 0, math.floor(63+192*k), 255} --1<=k<=20, 64<=b<=256

    elseif k <= land then

      k = k/(land-sea)
      return {math.floor(192*k), 192, 0, 255}

    else

      k = k/(max-land)
      local c = math.min(math.floor(192+63*k), 255)
      return {c,c,c, 255}

    end 

  end})


  m:render(colors)
  --local dir = love.filesystem.getSaveDirectory()
  --local path = dir.."/"..name
  --local command = 'uploadImg "'..path..'"'
  --print(command)
  --os.execute(command)
  love.graphics.setColor(255,255,255)


end


love.draw = function()

  love.graphics.draw(m.img, 0, 0, 0, math.floor(600/#m.map))

  love.graphics.print(tostring(#m.map*2-1 <= 600), 600, 0)

  if #m.map*2-1 <= 600 and pass then
  	m:pass()
  	m:render(colors)
  	love.graphics.setColor(255,255,255)
  	YouShallNotPass()
  end
  --m:render(colors)

end


love.keypressed = function(k)

  if k == 'escape' then love.event.quit() end

  if k == ' ' then pass = true end

  if k == 's' then
  	  local name = os.time()..'.png'
      m.img:getData():encode(name)
      os.execute("source /home/nix/.bashrc && uploadImg " .. love.filesystem.getSaveDirectory() .. '/' .. name)
  end

  if k == 'r' then
  	  love.load()
  end

end