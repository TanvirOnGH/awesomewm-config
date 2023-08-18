-----------------------------------------------------------------------------------------------------------------------
--                                              Autostart app list                                                   --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local autostart = {}

-- Application list function
--------------------------------------------------------------------------------
function autostart.run()
	-- essentials
	awful.spawn.with_shell("xrandr --output HDMI-0 --primary --mode 1920x1080 --rate 75 --pos 0x0 --rotate normal") -- display output
	awful.spawn.with_shell("xset -dpms") -- prevent X server from turning off the display
	awful.spawn.with_shell("xset s off") -- disable X screen saver feature
	awful.spawn.with_shell("xset r rate 250 50") -- speed up keyboard auto-repeat rate

	-- utils
    awful.spawn.with_shell("picom --daemon") -- compositor
	awful.spawn.with_shell("flashfocus") -- flashfocus daemon

	-- apps
end

-- Read and commands from file and spawn them
--------------------------------------------------------------------------------
function autostart.run_from_file(file_)
	local f = io.open(file_)
	for line in f:lines() do
		if line:sub(1, 1) ~= "#" then
			awful.spawn.with_shell(line)
		end
	end
	f:close()
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return autostart
