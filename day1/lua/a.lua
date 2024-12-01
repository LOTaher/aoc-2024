-- module for file operations
local open = io.open

-- taken from the INTERNET!
function string:split(delimiter)
	local result = {}
	local from = 1
	local delim_from, delim_to = string.find(self, delimiter, from, true)
	while delim_from do
		if delim_from ~= 1 then
			table.insert(result, string.sub(self, from, delim_from - 1))
		end
		from = delim_to + 1
		delim_from, delim_to = string.find(self, delimiter, from, true)
	end
	if from <= #self then
		table.insert(result, string.sub(self, from))
	end
	return result
end

local sum = 0

local file = open("input.txt", "rb")
if not file then
	return nil
end

-- M = {}
--
-- M = {
--     value = 10,
--     test = function(self)
--         self.value = self.value + 5
--         return self.value
--     end,
-- }
--
-- print(M:test()) // output = 15

-- : signifies call self within a table. `file` is a table. it is returned by the open function.
local content = file:read("*a")
file:close()

-- define the table that will hold each line
local lines = {}

-- operations seem to be done through calling the module of the data structure. ie: table, string, etc.
for line in content:gmatch("[^\r\n]*") do
	table.insert(lines, line)
end

local left_side = {}
local right_side = {}

for _, line in ipairs(lines) do
	local split_lines = line:split("   ")

	table.insert(left_side, split_lines[1])
	table.insert(right_side, split_lines[2])
end

-- sort both lists
table.sort(left_side, function(a, b)
	return a < b
end)
table.sort(right_side, function(a, b)
	return a < b
end)

-- for each value in the sides, subtract both, take the abs val then add to total
for index, value in ipairs(left_side) do
	local difference = math.abs(value - right_side[index])
	sum = sum + difference
end

print(sum)
