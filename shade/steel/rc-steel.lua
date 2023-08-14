-----------------------------------------------------------------------------------------------------------------------
--                                                    Steel config                                                   --
-----------------------------------------------------------------------------------------------------------------------

-- Load modules
-----------------------------------------------------------------------------------------------------------------------

-- Standard awesome library
------------------------------------------------------------
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

require("awful.autofocus")

-- User modules
------------------------------------------------------------
local awsmx = require("awsmx")

-- debug locker
local lock = lock or {}

awsmx.startup.locked = lock.autostart
awsmx.startup:activate()


-- Error handling
-----------------------------------------------------------------------------------------------------------------------
require("colorless.ercheck-config") -- load file with error handling


-- Setup theme and environment vars
-----------------------------------------------------------------------------------------------------------------------
local env = require("color.blue.env-config") -- load file with environment
env:init({ theme = "steel" })


-- Layouts setup
-----------------------------------------------------------------------------------------------------------------------
local layouts = require("color.blue.layout-config") -- load file with tile layouts setup
layouts:init()


-- Main menu configuration
-----------------------------------------------------------------------------------------------------------------------
local mymenu = require("color.blue.menu-config") -- load file with menu configuration
mymenu:init({ env = env })


-- Panel widgets
-----------------------------------------------------------------------------------------------------------------------

-- Separator
--------------------------------------------------------------------------------
local separator = awsmx.gauge.separator.vertical()

-- Layoutbox configure
--------------------------------------------------------------------------------
awsmx.widget.layoutbox:init(awful.layout.layouts)

-- Tasklist
--------------------------------------------------------------------------------
local tasklist = {}

-- load list of app name aliases from files and set it as part of tasklist theme
tasklist.style = { appnames = require("common.alias-config"),  widget = awsmx.gauge.task.ruby.new }

tasklist.buttons = awful.util.table.join(
	awful.button({}, 1, awsmx.widget.tasklist.action.select),
	awful.button({}, 2, awsmx.widget.tasklist.action.close),
	awful.button({}, 3, awsmx.widget.tasklist.action.menu),
	awful.button({}, 4, awsmx.widget.tasklist.action.switch_next),
	awful.button({}, 5, awsmx.widget.tasklist.action.switch_prev)
)

-- Taglist widget
--------------------------------------------------------------------------------
local taglist = {}
taglist.style = { widget = awsmx.gauge.tag.green.new, show_tip = true }
taglist.buttons = awful.util.table.join(
	awful.button({         }, 1, function(t) t:view_only() end),
	awful.button({ env.mod }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
	awful.button({         }, 2, awful.tag.viewtoggle),
	awful.button({         }, 3, function(t) awsmx.widget.layoutbox:toggle_menu(t) end),
	awful.button({ env.mod }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
	awful.button({         }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({         }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Textclock widget
--------------------------------------------------------------------------------
local binclock = {}
binclock.widget = awsmx.widget.binclock({ timeout = 1, dateformat = "%H:%M:%S  %d-%m" })

-- Software update indcator and menu button in one
--------------------------------------------------------------------------------
awsmx.widget.updates:init({ command = env.updates })

local updates = {}
updates.widget = awsmx.widget.updates()

updates.buttons = awful.util.table.join(
	awful.button({ }, 1, function () mymenu.mainmenu:toggle() end),
	awful.button({ }, 2, function () awsmx.widget.updates:update(true) end),
	awful.button({ }, 3, function () awsmx.widget.updates:toggle() end)
)

-- Tray widget
--------------------------------------------------------------------------------
local tray = {}
tray.widget = awsmx.widget.minitray()

tray.buttons = awful.util.table.join(
	awful.button({}, 1, function() awsmx.widget.minitray:toggle() end)
)

-- PA volume control
--------------------------------------------------------------------------------
local volume = {}
volume.widget = awsmx.widget.pulse(nil, { widget = awsmx.gauge.audio.blue.new })

-- activate player widget
awsmx.float.player:init({ name = env.player })

volume.buttons = awful.util.table.join(
	awful.button({}, 4, function() volume.widget:change_volume()                end),
	awful.button({}, 5, function() volume.widget:change_volume({ down = true }) end),
	awful.button({}, 2, function() volume.widget:mute()                         end),
	awful.button({}, 3, function() awsmx.float.player:show()                  end),
	awful.button({}, 1, function() awsmx.float.player:action("PlayPause")     end),
	awful.button({}, 8, function() awsmx.float.player:action("Previous")      end),
	awful.button({}, 9, function() awsmx.float.player:action("Next")          end)
)


-- System resource monitoring widgets
--------------------------------------------------------------------------------
local sysmon = { widget = {}, buttons = {} }

-- network speed
sysmon.widget.network = awsmx.widget.net(
	{
		interface = "enp42s0",
		speed = { up = 6 * 1024^2, down = 6 * 1024^2 },
		autoscale = false
	},
	{ timeout = 1, widget = awsmx.gauge.icon.double, monitor = { step = 0.1 } }
)

-- CPU usage
sysmon.widget.cpu = awsmx.widget.sysmon(
	{ func = awsmx.system.pformatted.cpu(80) },
	{ timeout = 1, widget = awsmx.gauge.monitor.dash }
)

sysmon.buttons.cpu = awful.util.table.join(
	awful.button({ }, 1, function() awsmx.float.top:show("cpu") end)
)

-- RAM usage
sysmon.widget.ram = awsmx.widget.sysmon(
	{ func = awsmx.system.pformatted.mem(70) },
	{ timeout = 2, widget = awsmx.gauge.monitor.dash }
)

sysmon.buttons.ram = awful.util.table.join(
	awful.button({ }, 1, function() awsmx.float.top:show("mem") end)
)


-- Screen setup
-----------------------------------------------------------------------------------------------------------------------

-- aliases for setup
local al = awful.layout.layouts

-- setup
awful.screen.connect_for_each_screen(
	function(s)
		-- wallpaper
		env.wallpaper(s)

		-- tags
		awful.tag(
			{ "Main", "Full", "Code", "Edit", "Media", "Game", "Free" }, s,
			{ al[5], al[6], al[4], al[4], al[3], al[3], al[5] }
		)

		-- taglist widget
		taglist[s] = awsmx.widget.taglist({ screen = s, buttons = taglist.buttons, hint = env.tagtip }, taglist.style)

		-- tasklist widget
		tasklist[s] = awsmx.widget.tasklist({ screen = s, buttons = tasklist.buttons }, tasklist.style)

		-- panel wibox
		s.panel = awful.wibar({ position = "bottom", screen = s, height = beautiful.panel_height })

		-- add widgets to the wibox
		s.panel:setup {
			layout = wibox.layout.align.horizontal,
			{ -- left widgets
				layout = wibox.layout.fixed.horizontal,

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
				env.wrapper(sysmon.widget.cpu, "cpu", sysmon.buttons.cpu),
				env.wrapper(sysmon.widget.ram, "ram", sysmon.buttons.ram),
				env.wrapper(binclock.widget, "binclock"),
				separator,
				env.wrapper(tray.widget, "tray", tray.buttons),
			},
		}
	end
)


-- Desktop widgets
-----------------------------------------------------------------------------------------------------------------------
if not lock.desktop then
	local desktop = require("shade.steel.desktop-config") -- load file with desktop widgets configuration
	desktop:init({
		env = env,
		buttons = awful.util.table.join(awful.button({}, 3, function () mymenu.mainmenu:toggle() end))
	})
end


-- Active screen edges
-----------------------------------------------------------------------------------------------------------------------
local edges = require("color.blue.edges-config") -- load file with edges configuration
edges:init()


-- Log out screen
-----------------------------------------------------------------------------------------------------------------------
local logout = require("color.blue.logout-config")
logout:init()


-- Key bindings
-----------------------------------------------------------------------------------------------------------------------
local appkeys = require("color.blue.appkeys-config") -- load file with application keys sheet

local hotkeys = require("color.blue.keys-config") -- load file with hotkeys configuration
hotkeys:init({ env = env, menu = mymenu.mainmenu, appkeys = appkeys, volume = volume.widget })


-- Rules
-----------------------------------------------------------------------------------------------------------------------
local rules = require("color.blue.rules-config") -- load file with rules configuration
rules:init({ hotkeys = hotkeys})


-- Titlebar setup
-----------------------------------------------------------------------------------------------------------------------
local titlebar = require("shade.steel.titlebar-config") -- load file with titlebar configuration
titlebar:init()


-- Base signal set for awesome wm
-----------------------------------------------------------------------------------------------------------------------
local signals = require("colorless.signals-config") -- load file with signals configuration
signals:init({ env = env })

