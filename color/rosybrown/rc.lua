-- Load modules
-- Standard awesome library
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

require("awful.autofocus")

-- User modules
local flex = require("flex")

-- debug locker
local lock = lock or {}

-- Enable desktop
lock.desktop = false

flex.startup.locked = lock.autostart
flex.startup:activate()

-- Error handling
require("common.ercheck") -- load file with error handling

-- Setup theme and environment vars
local env = require("common.env") -- load file with environment
env:init({ theme = "rosybrown", desktop_autohide = false, set_center = true })

-- Layouts setup
local layouts = require("common.layout") -- load file with tile layouts setup
layouts:init()

-- Main menu configuration
local mymenu = require("common.menu") -- load file with menu configuration
mymenu:init({ env = env })

-- Panel widgets
-- Separator
local separator = flex.gauge.separator.vertical()

-- Taglist widget
local taglist = {}

local rosy_brown_gauge = flex.gauge.tag["rosybrown"].new
taglist.style = { widget = rosy_brown_gauge, show_tip = true }

-- double line taglist
taglist.cols_num = 5
taglist.rows_num = 2

taglist.layout = wibox.widget({
	expand = true,
	forced_num_rows = taglist.rows_num,
	forced_num_cols = taglist.cols_num,
	layout = wibox.layout.grid,
})

-- buttons
taglist.buttons = awful.util.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ env.mod }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 2, awful.tag.viewtoggle),
	awful.button({}, 3, function(t)
		flex.widget.layoutbox:toggle_menu(t)
	end),
	awful.button({ env.mod }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

-- some tag settings which indirectly depends on row and columns number of taglist
taglist.names = {
	"1:1",
	"1:2",
	"1:3",
	"1:4",
	"1:5",

	"2:1",
	"2:2",
	"2:3",
	"2:4",
	"2:5",
}

local al = awful.layout.layouts
taglist.layouts = {
	-- Check common/layout for layouts
	al[18],
	al[3],
	al[4],
	al[7],
	al[13],

	al[18],
	al[4],
	al[3],
	al[8],
	al[14],
}

-- Tasklist
local tasklist = {}

-- dirty double tag line setup for tasklist client menu
local tagline_style = { tagline = { height = 40, rows = taglist.rows_num, spacing = 4 } }

-- Load the rosybrown tasklist gauge widget
local rosy_brown_task_gauge = flex.gauge.task["rosybrown"].new

-- load list of app name aliases from files and set it as part of tasklist theme
tasklist.style = {
	appnames = require("common.alias"),
	widget = rosy_brown_task_gauge,
	winmenu = tagline_style,
}

tasklist.buttons = awful.util.table.join(
	awful.button({}, 1, flex.widget.tasklist.action.select),
	awful.button({}, 2, flex.widget.tasklist.action.close),
	awful.button({}, 3, flex.widget.tasklist.action.menu),
	awful.button({}, 4, flex.widget.tasklist.action.switch_next),
	awful.button({}, 5, flex.widget.tasklist.action.switch_prev)
)

-- double tag line setup for main client menu
flex.float.clientmenu:set_style(tagline_style)

-- Textclock widget
local textclock = {}
textclock.widget = flex.widget.textclock({ timeformat = "%I:%M %p", dateformat = "%A, %d/%m/%Y" })

textclock.buttons = awful.util.table.join(awful.button({}, 1, function()
	flex.float.calendar:show()
end))

-- Layoutbox configure
local layoutbox = {}

layoutbox.buttons = awful.util.table.join(
	awful.button({}, 3, function()
		mymenu.mainmenu:toggle()
	end),
	awful.button({}, 1, function()
		flex.widget.layoutbox:toggle_menu(mouse.screen.selected_tag)
	end),
	awful.button({}, 4, function()
		awful.layout.inc(1)
	end),
	awful.button({}, 5, function()
		awful.layout.inc(-1)
	end)
)

-- Tray widget
local tray = {}
tray.widget = flex.widget.minitray()

tray.buttons = awful.util.table.join(awful.button({}, 1, function()
	flex.widget.minitray:toggle()
end))

-- System resource monitoring widgets
local sysmon = { widget = {}, buttons = {} }

-- network speed
sysmon.widget.network = flex.widget.net({
	interface = "enp42s0",
	speed = { up = 6 * 1024 ^ 2, down = 6 * 1024 ^ 2 },
	autoscale = true,
}, { timeout = 1, widget = flex.gauge.icon.double, monitor = { step = 0.1 } })

-- GPU usage
sysmon.widget.gpu = flex.widget.sysmon(
	{ func = flex.system.pformatted.gpu(75) },
	{ timeout = 1, widget = flex.gauge.monitor.circle }
)

sysmon.buttons.gpu = awful.util.table.join(awful.button({}, 1, function()
	flex.float.top:show("gpu")
end))

-- VRAM usage
sysmon.widget.vram = flex.widget.sysmon(
	{ func = flex.system.pformatted.vram(95) },
	{ timeout = 1, widget = flex.gauge.monitor.circle }
)

sysmon.buttons.vram = awful.util.table.join(awful.button({}, 1, function()
	flex.float.top:show("vram")
end))

-- CPU usage
sysmon.widget.cpu = flex.widget.sysmon(
	{ func = flex.system.pformatted.cpu(80) },
	{ timeout = 1, widget = flex.gauge.monitor.circle }
)

sysmon.buttons.cpu = awful.util.table.join(awful.button({}, 1, function()
	flex.float.top:show("cpu")
end))

-- RAM usage
sysmon.widget.ram = flex.widget.sysmon(
	{ func = flex.system.pformatted.mem(70) },
	{ timeout = 2, widget = flex.gauge.monitor.circle }
)

sysmon.buttons.ram = awful.util.table.join(awful.button({}, 1, function()
	flex.float.top:show("mem")
end))

-- SWAP usage
sysmon.widget.swap = flex.widget.sysmon(
	{ func = flex.system.pformatted.swap(50) },
	{ timeout = 2, widget = flex.gauge.monitor.circle }
)

sysmon.buttons.swap = awful.util.table.join(awful.button({}, 1, function()
	flex.float.top:show("swap")
end))

-- Screen setup
-- setup
awful.screen.connect_for_each_screen(function(s)
	-- wallpaper
	env.wallpaper(s)

	-- tags
	awful.tag(taglist.names, s, taglist.layouts)

	-- layoutbox widget
	layoutbox[s] = flex.widget.layoutbox({ screen = s })

	-- taglist widget
	taglist[s] = flex.widget.taglist(
		{ screen = s, buttons = taglist.buttons, hint = env.tagtip, layout = taglist.layout },
		taglist.style
	)

	-- tasklist widget
	tasklist[s] = flex.widget.tasklist({ screen = s, buttons = tasklist.buttons }, tasklist.style)

	-- panel wibox
	s.panel = awful.wibar({ position = "bottom", screen = s, height = beautiful.panel_height })

	-- add widgets to the wibox
	s.panel:setup({
		layout = wibox.layout.align.horizontal,
		{ -- left widgets
			layout = wibox.layout.fixed.horizontal,

			env.wrapper(layoutbox[s], "layoutbox", layoutbox.buttons),
			separator,
			env.wrapper(taglist[s], "taglist"),
			separator,
		},
		{ -- middle widget
			layout = wibox.layout.align.horizontal,
			expand = "outside",

			nil,
			env.wrapper(tasklist[s], "tasklist"),
		},
		{ -- right widgets
			layout = wibox.layout.fixed.horizontal,

			separator,
			env.wrapper(sysmon.widget.network, "network"),
			separator,
			env.wrapper(sysmon.widget.gpu, "gpu", sysmon.buttons.gpu),
			env.wrapper(sysmon.widget.vram, "vram", sysmon.buttons.vram),
			env.wrapper(sysmon.widget.cpu, "cpu", sysmon.buttons.cpu),
            env.wrapper(sysmon.widget.ram, "ram", sysmon.buttons.ram),
			env.wrapper(sysmon.widget.swap, "swap", sysmon.buttons.swap),
			separator,
			env.wrapper(textclock.widget, "textclock", textclock.buttons),
			separator,
			env.wrapper(tray.widget, "tray", tray.buttons),
		},
	})
end)

-- Desktop widgets
if not lock.desktop then
	local desktop = require("color.rosybrown.desktop") -- load file with desktop widgets configuration
	desktop:init({
		env = env,
		buttons = awful.util.table.join(awful.button({}, 3, function()
			mymenu.mainmenu:toggle()
		end)),
	})
end

-- Active screen edges
local edges = require("color.rosybrown.edges") -- load file with edges configuration
edges:init({ tag_cols_num = taglist.cols_num })

-- Log out screen
local logout = require("common.logout")
logout:init()

-- Key bindings
local hotkeys = require("color.rosybrown.keys") -- load file with hotkeys configuration
hotkeys:init({
	env = env,
	menu = mymenu.mainmenu,
	tag_cols_num = taglist.cols_num,
})

-- Rules
local rules = require("common.rules") -- load file with rules configuration
rules:init({ env = env, hotkeys = hotkeys })

-- Titlebar setup
local titlebar = require("color.rosybrown.titlebar") -- load file with titlebar configuration
titlebar:init()

-- Base signal set for awesome wm
local signals = require("common.signals") -- load file with signals configuration
signals:init({ env = env })

-- Autostart user applications
if flex.startup.is_startup then
	local autostart = require("common.autostart") -- load file with autostart application list
	autostart.run()
end
