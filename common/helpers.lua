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

function helpers.get_random_wallpaper(wallpapers)
	return wallpapers[math.random(#wallpapers)]
end

return helpers
