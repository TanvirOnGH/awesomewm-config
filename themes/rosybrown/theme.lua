-----------------------------------------------------------------------------------------------------------------------
--                                                  rosybrown theme                                                       --
-----------------------------------------------------------------------------------------------------------------------
local awful = require("awful")

-- This theme was inherited from another with overwriting some values
-- Check parent theme to find full settings list and its description
local theme = require("themes/colored/theme")

-- Color scheme
-----------------------------------------------------------------------------------------------------------------------
theme.color.main = "#C38F8F" -- Rosy Brown
theme.color.urgent = "#8DB8CD" -- Light blue-gray

-- Common
-----------------------------------------------------------------------------------------------------------------------
theme.path = awful.util.get_configuration_dir() .. "themes/rosybrown"

-- Main config
--------------------------------------------------------------------------------
theme.panel_height = 38 -- panel height
theme.wallpaper = "~/media/pictures/wallpapers/awesome/rosybrown/rosybrown.png"
theme.desktopbg = theme.wallpaper

-- Setup parent theme settings
--------------------------------------------------------------------------------
theme:update()

-- Desktop config
-----------------------------------------------------------------------------------------------------------------------

-- Desktop widgets placement
--------------------------------------------------------------------------------
theme.desktop.grid = {
	width = { 450, 450 },
	height = { 100, 100, 100, 100, 100 },
	edge = { width = { 100, 850 }, height = { 100, 100 } },
}

theme.desktop.places = {
	cpumem = { 1, 1 },
	disks = { 1, 2 },
	ssdspeed = { 1, 5 },

	netspeed = { 2, 5 },
}

-- Desktop widgets
--------------------------------------------------------------------------------
-- individual widget settings doesn't used by flex module
-- but grab directly from rc-files to rewrite base style
theme.individual.desktop = { speedmeter = {}, multimeter = {}, multiline = {} }

-- Lines (common part)
theme.desktop.common.pack.lines.line.height = 5
theme.desktop.common.pack.lines.progressbar.chunk = { gap = 6, width = 16 }
theme.desktop.common.pack.lines.tooltip.set_position = function(wibox)
	awful.placement.under_mouse(wibox)
	wibox.y = wibox.y - 30
end

-- Upright bar (common part)
theme.desktop.common.bar.shaped.show.tooltip = true
theme.desktop.common.bar.shaped.tooltip.set_position = theme.desktop.common.pack.lines.tooltip.set_position

-- Speedmeter (base widget)
theme.desktop.speedmeter.compact.icon = {
	up = theme.path .. "/desktop/up.svg",
	down = theme.path .. "/desktop/down.svg",
	margin = { 0, 10, 0, 0 },
}
theme.desktop.speedmeter.compact.height.chart = 45
theme.desktop.speedmeter.compact.label.width = 70
theme.desktop.speedmeter.compact.label.height = 15 -- manually set after font size
theme.desktop.speedmeter.compact.label.font = { font = "Fira Code", size = 20, face = 1, slant = 0 }
theme.desktop.speedmeter.compact.margins.label = { 10, 10, 0, 0 }
theme.desktop.speedmeter.compact.margins.chart = { 0, 0, 3, 3 }
theme.desktop.speedmeter.compact.chart = { bar = { width = 6, gap = 3 }, height = nil, zero_height = 0 }
theme.desktop.speedmeter.compact.progressbar = { chunk = { width = 6, gap = 3 }, height = 3 }

-- Speedmeter drive (individual widget)
theme.individual.desktop.speedmeter.drive = {
	unit = { { "B", -1 }, { "KB", 2 }, { "MB", 2048 } },
}

-- Multimeter (base widget)
theme.desktop.multimeter.upbar = { width = 32, chunk = { num = 8, line = 4 }, shape = "plain" }
theme.desktop.multimeter.lines.show = { label = false, tooltip = true, text = false }
theme.desktop.multimeter.icon.full = false
theme.desktop.multimeter.icon.margin = { 0, 8, 0, 0 }
theme.desktop.multimeter.height.upright = 66
theme.desktop.multimeter.height.lines = 20

-- Multimeter cpu and ram (individual widget)
theme.individual.desktop.multimeter.cpumem = {
	labels = { "RAM", "SWAP" },
	icon = { image = theme.path .. "/desktop/cpu.svg" },
}

-- Multilines (base widget)
theme.desktop.multiline.lines.show = { label = false, tooltip = true, text = false }
theme.desktop.multiline.icon.margin = theme.desktop.multimeter.icon.margin

-- Multilines storage (individual widget)
theme.individual.desktop.multiline.storage = {
	unit = { { "KB", 1 }, { "MB", 1024 ^ 1 }, { "GB", 1024 ^ 2 } },
	icon = { image = theme.path .. "/desktop/storage.svg" },
	lines = {
		line = { height = 10 },
		progressbar = { chunk = { gap = 6, width = 4 } },
	},
}

-- Multilines qemu drive images (individual widget)
theme.individual.desktop.multiline.images = {
	unit = { { "KB", 1 }, { "MB", 1024 ^ 1 }, { "GB", 1024 ^ 2 } },
}

-- Panel widgets
-----------------------------------------------------------------------------------------------------------------------

-- individual margins for panel widgets
------------------------------------------------------------
theme.widget.wrapper = {
	layoutbox = { 12, 10, 6, 6 },
	textclock = { 10, 10, 0, 0 },
	tray = { 8, 8, 7, 7 },
	cpu = { 1, 1, 1, 1 },
	ram = { 1, 1, 1, 1 },
	network = { 3, 3, 7, 7 },
	taglist = { 4, 4, 4, 4 },
	tasklist = { 0, -6, 0, 0 }, -- centering tasklist widget
}

-- Various widgets style tuning
------------------------------------------------------------

-- Dotcount
theme.gauge.graph.dots.dot_gap_h = 5

-- Dash
theme.gauge.monitor.dash.width = 11

-- Tasklist
theme.widget.tasklist.char_digit = 8
theme.widget.tasklist.task = theme.gauge.task.rosybrown
theme.widget.tasklist.tasktip.max_width = 1200
theme.gauge.task.rosybrown.width = 100
theme.gauge.task.rosybrown.underline = { height = 0, thickness = 2, gap = 34, dh = 0 }

-- Floating widgets
-----------------------------------------------------------------------------------------------------------------------

-- Titlebar helper
theme.float.bartip.names = { "Mini", "Compact", "Full" }

-- client menu tag line
theme.widget.tasklist.winmenu.enable_tagline = false
theme.widget.tasklist.winmenu.icon.tag = theme.path .. "/widget/mark.svg"

theme.float.clientmenu.enable_tagline = false
theme.float.clientmenu.icon.tag = theme.widget.tasklist.winmenu.icon.tag

-- Set hotkey helper size according current fonts and keys scheme
--------------------------------------------------------------------------------
theme.float.hotkeys.geometry = { width = 1420 }
theme.float.appswitcher.keytip = { geometry = { width = 400 }, exit = true }
theme.float.keychain.keytip = { geometry = { width = 1020 }, column = 2 }
theme.float.top.keytip = { geometry = { width = 400 } }
theme.float.apprunner.keytip = { geometry = { width = 400 } }
theme.menu.keytip = { geometry = { width = 400 } }

-- Titlebar
-----------------------------------------------------------------------------------------------------------------------
theme.titlebar.icon_compact = {
	color = { icon = theme.color.gray, main = theme.color.main, urgent = theme.color.main },
	list = {
		maximized = theme.path .. "/titlebar/maximized.svg",
		minimized = theme.path .. "/titlebar/minimize.svg",
		close = theme.path .. "/titlebar/close.svg",
		focus = theme.path .. "/titlebar/focus.svg",
		unknown = theme.icon.unknown,
	},
}

-- End
-----------------------------------------------------------------------------------------------------------------------
return theme
