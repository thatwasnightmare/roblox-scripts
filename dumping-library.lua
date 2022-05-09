local module = {}

local function register_closure(string, closure)
	module[string] = closure
end

local function find_closure(string)
	for index, value in pairs(module) do
		if index == string then
			return value
		end
	end
	return false
end

register_closure("search", function(table, index, lines, pattern)
	for line = 1, #table do
		local current_line = table[line]
		if not current_line then
			break
		end
		if line > index then
			local current_match = string.match(current_line, pattern)
			if current_match then
				return line, current_match
			end
			if line >= (index + lines) then
				break
			end
		end
	end
	return false
end)

return setmetatable({}, {
	__call = function(self, ...)
		local closure = find_closure(...)
		return closure
	end,
	__metatable = "The metatable is locked"
})
