local map = require 'newMap'

love.load = function()

  m = map.new(10, 50)

  while #m.map*2-1 <= 600 do

    m:pass()
  
  end

  colors = setmetatable({}, {__index = function(t, k)
    if tonumber(k) and k <= 20 then
      return {0, 0, 64+192/20*k}
    elseif tonumber(k) and k <= 40 then
      k = 41-k
      return {192/20*k, 192, 0}
    elseif tonumber(k) then
      k = k-41
      return {192+63/9*k, 192+63/9*k, 192+63/9*k}
    end end})


  m:render(colors)

end


love.draw = function()

  love.graphics.draw(m.canvas, 0, 0)

end
