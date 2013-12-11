local map = {}
map.__index = map

map.new = function(res, max)

	local t = setmetatable({map = {}}, map)
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
			t[newX][newY] = self.map[x][y]
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

	local c = love.graphics.newCanvas(#self.map, #self.map)
	for x = 1, #self.map do
		for y = 1, #self.map do
			love.graphics.setColor(colors[self.map[x][y]])
			c:renderTo(function() love.graphics.point(x, y) end)
		end
	end
	self.canvas = c
	return self

end

return map