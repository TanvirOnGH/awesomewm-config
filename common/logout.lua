local awful = require("awful")
local logout_screen = require("flex.service.logout")

local logout = {}

function logout:init()
	local logout_entries = {
		{ -- Logout
			callback = function()
				awesome.quit()
			end,
			icon_name = "logout",
			label = "Logout",
			close_apps = true,
		},
		{ -- Shutdown
			callback = function()
				awful.spawn.with_shell("systemctl poweroff")
			end,
			icon_name = "poweroff",
			label = "Shutdown",
			close_apps = true,
		},
		{ -- Reboot
			callback = function()
				awful.spawn.with_shell("systemctl reboot")
			end,
			icon_name = "reboot",
			label = "Restart",
			close_apps = true,
		},
		{ -- Suspend
			callback = function()
				awful.spawn.with_shell("systemctl suspend")
			end,
			icon_name = "suspend",
			label = "Sleep",
			close_apps = false,
		},
		{ -- Hibernate
			callback = function()
				awful.spawn.with_shell("systemctl hibernate")
			end,
			icon_name = "hibernate",
			label = "Hibernate",
			close_apps = false,
		},
		{ -- Hybrid Sleep
			callback = function()
				awful.spawn.with_shell("systemctl hybrid-sleep")
			end,
			icon_name = "hybrid-sleep",
			label = "Hybrid Sleep",
			close_apps = false,
		},
	}

	logout_screen:set_entries(logout_entries)
end

return logout
