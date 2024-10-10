local lfs = require("lfs")

local helpers = {}

function helpers.get_wallpapers(dir)
	local files = {}
	for file in lfs.dir(dir) do
		if file ~= "." and file ~= ".." then
			table.insert(files, dir .. file)
		end
	end
	return files
end

function helpers.shuffle_table(t)
	local rand = math.random
	assert(t, "table.shuffle() expected a table, got nil")
	local iterations = #t
	local j

	for i = iterations, 2, -1 do
		j = rand(i)
		t[i], t[j] = t[j], t[i]
	end
end

return helpers
