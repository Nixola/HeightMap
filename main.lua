local map = require 'newMap'

love.load = function()

  local max = 10

  local sea = max/5*2
  local land = max/5*4

  m = map.new(10, max)

  while #m.map*2-1 <= 600 do

    m:pass()
  
  end

  colors = setmetatable({}, {__index = function(t, k)


    if k <= sea then


      return {0, 0, math.floor(63+192/sea*k), 255} --1<=k<=20, 64<=b<=256

    elseif k <= land then

      k = land+1-k --21<=k1<=40, 1<=k2<=20
      return {math.floor(192/land*k), 192, 0, 255}

    else

      k = k-land-1
      local c = math.floor(192+63/sea/2*k)
      return {c,c,c, 255}

    end 

  end})


  m:render(colors)
  local name = os.time()..'.png'
  m.canvas:getImageData():encode(name)
  local dir = love.filesystem.getSaveDirectory()
  local path = dir.."/"..name
  local command = 'uploadImg "'..path..'"'
  print(command)
  os.execute(command)
  love.graphics.setColor(255,255,255)


end


love.draw = function()

  love.graphics.draw(m.canvas, 0, 0)
  --m:render(colors)

end
