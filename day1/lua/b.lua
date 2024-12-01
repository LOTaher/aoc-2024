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

local total = 0

local occurrence_table = {}

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

for _, line in pairs(lines) do
	local split_lines = line:split("   ")

	table.insert(left_side, split_lines[1])
	table.insert(right_side, split_lines[2])
end

-- for each value in the left side, initialize its value in the occurence table to 0
for _, value in pairs(left_side) do
    occurrence_table[value] = 0
end

-- for each value of right side, check to see if it exists in the occurence table,
-- if it does, increment the occurence table's value of that value's key
for _, value in pairs(right_side) do
	if not occurrence_table[value] then
        -- the go to keyword is a little like assembly jumping? I like this a lot
		goto continue
	end

    local current_value = occurrence_table[value] -- this should return 0 on the first run through
    occurrence_table[value] = current_value + 1

	::continue::
end

-- multiply the key by the value of the occurence table, and add it all to the total
-- i would be using ipairs here if `occurrence_table` had numbered, ordered keys
for k, v in pairs(occurrence_table) do
    total = total + (k * v)
end


print(total)
