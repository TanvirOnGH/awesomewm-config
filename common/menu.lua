-----------------------------------------------------------------------------------------------------------------------
--                                                  Menu config                                                      --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local beautiful = require("beautiful")
local flex = require("flex")
local awful = require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local menu = {}

-- Build function
-----------------------------------------------------------------------------------------------------------------------
function menu:init(args)
	-- vars
	args = args or {}
	local env = args.env or {} -- fix this?
	local separator = args.separator or { widget = flex.gauge.separator.horizontal() }
	local theme = args.theme or { auto_hotkey = true }
	local icon_style = args.icon_style or { custom_only = true, scalable_only = true }

	-- theme vars
	local default_icon = flex.util.base.placeholder()
	local icon = flex.util.table.check(beautiful, "icon.awesome") and beautiful.icon.awesome or default_icon
	local color = flex.util.table.check(beautiful, "color.icon") and beautiful.color.icon or nil

	-- icon finder
	local function micon(name)
		return flex.service.dfparser.lookup_icon(name, icon_style)
	end

	-- Application submenu
	------------------------------------------------------------
	local appmenu = flex.service.dfparser.menu({ icons = icon_style, wm_name = "awesome" })

	-- Awesome submenu
	------------------------------------------------------------
	local awesomemenu = {
		{ "Restart", awesome.restart, micon("gnome-session-reboot") },
		separator,
		{ "Awesome config", "code" .. " /home/user/.config/awesome/", micon("terminal") },
	}

	-- Nix submenu
	------------------------------------------------------------
	local nixmenu = {
		{ "Nix config", "code" .. " /home/user/development/github/nix-config/", micon("terminal") },
	}

	-- Places submenu
	------------------------------------------------------------
	local placesmenu = {
		{ "Downloads", env.fm .. " downloads", micon("folder-download") },
		{ "Music", env.fm .. " media/musics", micon("folder-music") },
		{ "Pictures", env.fm .. " media/pictures", micon("folder-pictures") },
		{ "Videos", env.fm .. " media/videos", micon("folder-videos") },
		separator,
		{ "SSD", env.fm .. " /mnt/ssd", micon("folder-bookmarks") },
		{ "HDD", env.fm .. " /mnt/hdd", micon("folder-bookmarks") },
	}

	-- Exit submenu
	------------------------------------------------------------
	local exitmenu = {
		{ "Reboot", "reboot", micon("gnome-session-reboot") },
		{ "Shutdown", "poweroff", micon("system-shutdown") },
		separator,
		{ "Log out", awesome.quit, micon("exit") },
	}

	-- Main menu
	------------------------------------------------------------
	self.mainmenu = flex.menu({
		theme = theme,
		items = {
			{ "Awesome", awesomemenu, micon("awesome") },
			{ "NixOS", nixmenu, micon("nix") },
			{ "Applications", appmenu, micon("folder") },
			{ "Places", placesmenu, micon("folder_home"), key = "c" },
			separator,
			{ "Terminal", env.terminal, micon("terminal") },
			{ "Thunar", env.fm, micon("folder") },
			{ "Firefox", "firefox", micon("firefox") },
            { "VSCode",  "code", micon("code-editor") },
            { "Bluetooth Manager", "blueman-manager", micon("bluetooth") },
			{ "Volume Control", "pavucontrol", micon("volume") },
			separator,
			{ "Lock Screen", "i3lock-fancy-rapid 5 5", micon("exit") },
			separator,
			{ "Exit", exitmenu, micon("exit") },
		},
	})

	-- Menu panel widget
	------------------------------------------------------------

	self.widget = flex.gauge.svgbox(icon, nil, color)
	self.buttons = awful.util.table.join(awful.button({}, 1, function()
		self.mainmenu:toggle()
	end))
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return menu
