--require 'ffiImageData'

local map = {}
map.__index = map

map.new = function(res, max)

	local t = setmetatable({map = {}}, map)
	t.max = max
	t.res = res
	for x = 1, res do
		t.map[x] = {}
		for y = 1, res do
			t.map[x][y] = math.random(max)
		end
	end
	return t
end

function map:pass()

	local t = {}
	for x = 1, #self.map*2-1 do
		t[x] = {}
	end
	for x = 1, #self.map do
		local newX = x*2-1
		for y = 1, #self.map do
			local newY = y*2-1
			--t[x][y] = 
			--t[newX][newY] = self.map[x][y]
			t[newX][newY] = math.abs(self.map[x][y] + math.random(self.max)*self.res/#self.map-self.max*self.res/#self.map/2)
		end
	end
	for x = 1, #t do
		for y = 1, #t do
			if not t[x][y] then
				local s = 0
				local n = 0
				for dx = -1, 1 do
					if t[x+dx] then
						for dy = -1, 1 do
							if t[x+dx][y+dy] then
								s = s + t[x+dx][y+dy]
								n = n + 1
							end
						end
					end
				end
				t[x][y] = (math.random(2) == 1) and math.floor(s/n) or math.ceil(s/n)
			end
		end
	end

	self.map = t

	return self
end

function map:print()
	for x, row in ipairs(self.map) do
		print(table.concat(row, ''))
	end
end

function map:render(colors)

	local imgData = love.image.newImageData(#self.map, #self.map)
	--[=[
	local getColor = love.graphics.getColor
	local rect = love.graphics.rectangle
	local p = print
	for x = 1, #self.map do
		for y = 1, #self.map do
			self.map[x][y] = math.abs(self.map[x][y] - self.max/2)
			love.graphics.setColor(colors[self.map[x][y]])
			--c:renderTo(function() love.graphics.point(x, y) print(love.graphics.getColor()) end)
			c:renderTo(function() rect('fill', x-.5, y-.5, 1, 1) end)
			--rect('fill', x-.5, y-.5, 1, 1)
		end
	end
	self.canvas = c
	self.canvas:setFilter('nearest', 'nearest')--]=]
	imgData:mapPixel(function(x, y)
		x, y = x+1, y+1
		return unpack(colors[self.map[x][y]])
	end)
	self.imgData = imgData
	self.img = love.graphics.newImage(imgData)
	self.img:setFilter('nearest', 'nearest')
	return self

end

return map