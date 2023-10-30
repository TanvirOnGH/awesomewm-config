-----------------------------------------------------------------------------------------------------------------------
--                                                Colorless theme                                                    --
-----------------------------------------------------------------------------------------------------------------------
local awful = require("awful")

local theme = {}
--local wa = mouse.screen.workarea

-- Color scheme
-----------------------------------------------------------------------------------------------------------------------
theme.color = {
	-- main colors
	main = "#C38F8F",
	gray = "#575757",
	bg = "#161616",
	bg_second = "#181818",
	wibox = "#202020",
	icon = "#a0a0a0",
	text = "#aaaaaa",
	urgent = "#8DB8CD",
	highlight = "#e0e0e0",
	border = "#404040",

	-- secondary colors
	shadow1 = "#141414",
	shadow2 = "#313131",
	shadow3 = "#1c1c1c",
	shadow4 = "#767676",

	button = "#575757",
	pressed = "#404040",

	desktop_gray = "#404040",
	desktop_icon = "#606060",
}

-- Common
-----------------------------------------------------------------------------------------------------------------------
theme.path = awful.util.get_configuration_dir() .. "themes/colorless"
theme.base = awful.util.get_configuration_dir() .. "themes/colorless"
theme.homedir = os.getenv("HOME")

-- Main config
------------------------------------------------------------

theme.panel_height = 40 -- panel height
theme.border_width = 0 -- window border width
theme.useless_gap = 5 -- useless gap
theme.cellnum = { x = 96, y = 58 } -- grid layout property
theme.wallpaper = awful.util.get_configuration_dir() .. "misc/wallpapers/colorless/primary.png"

-- Fonts
------------------------------------------------------------
theme.fonts = {
	main = "Fira Code 12", -- main font
	menu = "Fira Code 12", -- main menu font
	tooltip = "Fira Code 12", -- tooltip font
	notify = "Fira Code bold 14", -- flex notify popup font
	clock = "Fira Code bold 12", -- textclock widget font
	qlaunch = "Fira Code bold 14", -- quick launch key label font
	logout = "Fira Code bold 14", -- logout screen labels
	title = "Fira Code bold 12", -- widget titles font
	tiny = "Fira Code bold 10", -- smallest font for widgets
	keychain = "Fira Code bold 14", -- key sequence tip font
	titlebar = "Fira Code bold 12", -- client titlebar font
	logout = {
		label = "Fira Code bold 14", -- logout option labels
		counter = "Fira Code bold 24", -- logout counter
	},
	hotkeys = {
		main = "Fira Code 12", -- hotkeys helper main font
		key = "mono 12", -- hotkeys helper key font (use monospace for align)
		title = "Fira Code bold 14", -- hotkeys helper group title font
	},
	player = {
		main = "Fira Code bold 12", -- player widget main font
		time = "Fira Code bold 14", -- player widget current time font
	},
	-- very custom calendar fonts
	calendar = {
		clock = "Fira Code 24",
		date = "Fira Code 15",
		week_numbers = "Fira Code 12",
		weekdays_header = "Fira Code 11",
		days = "Fira Code 12",
		default = "Fira Code 10",
		focus = "Fira Code 14 Bold",
		controls = "Fira Code 13",
	},
}

theme.cairo_fonts = {
	tag = { font = "Fira Code", size = 16, face = 1 }, -- tag widget font
	appswitcher = { font = "Fira Code", size = 22, face = 1 }, -- appswitcher widget font
	navigator = {
		title = { font = "Fira Code", size = 28, face = 1, slant = 0 }, -- window navigation title font
		main = { font = "Fira Code", size = 22, face = 1, slant = 0 }, -- window navigation  main font
	},

	desktop = {
		textbox = { font = "Fira Code", size = 24, face = 1 },
	},
}

-- Shared icons
--------------------------------------------------------------------------------
theme.icon = {
	check = theme.path .. "/common/check.svg",
	blank = theme.path .. "/common/blank.svg",
	submenu = theme.path .. "/common/submenu.svg",
	warning = theme.path .. "/common/warning.svg",
	awesome = theme.path .. "/common/awesome.svg",
	system = theme.path .. "/common/system.svg",
	mark = theme.path .. "/common/mark.svg",
	left = theme.path .. "/common/arrow_left.svg",
	right = theme.path .. "/common/arrow_right.svg",
	unknown = theme.path .. "/common/unknown.svg",
}

-- Main theme settings
-- Make it updatabele since it may depends on common
-----------------------------------------------------------------------------------------------------------------------
function theme:init()
	-- Service utils config
	----------------------------------------------------------------------------------
	self.service = {}

	-- Window control mode appearance
	--------------------------------------------------------------------------------
	self.service.navigator = {
		border_width = 0, -- window placeholder border width
		gradstep = 60, -- window placeholder background stripes width
		marksize = { -- window information plate size
			width = 160, -- width
			height = 80, -- height
			r = 20, -- corner roundness
		},
		linegap = 32, -- gap between two lines on window information plate
		timeout = 1, -- highlight duration
		notify = {}, -- flex notify style (see theme.float.notify)
		titlefont = self.cairo_fonts.navigator.title, -- first line font on window information plate
		font = self.cairo_fonts.navigator.main, -- second line font on window information plate

		-- array of hot key marks for window placeholders
		num = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F3", "F4", "F5" },

		-- colors
		color = {
			border = self.color.main, -- window placeholder border color
			mark = self.color.gray, -- window information plate background color
			text = self.color.wibox, -- window information plate text color
			fbg1 = self.color.main .. "40", -- first background color for focused window placeholder
			fbg2 = self.color.main .. "20", -- second background color for focused window placeholder
			hbg1 = self.color.urgent .. "40", -- first background color for highlighted window placeholder
			hbg2 = self.color.urgent .. "20", -- second background color for highlighted window placeholder
			bg1 = self.color.gray .. "40", -- first background color for window placeholder
			bg2 = self.color.gray .. "20", -- second background color for window placeholder
		},
	}

	-- layout hotkeys helper settings
	self.service.navigator.keytip = {}

	-- this one used as fallback when style for certain layout missed
	self.service.navigator.keytip["base"] = { geometry = { width = 600 }, exit = true }

	-- styles for certain layouts
	self.service.navigator.keytip["fairv"] = { geometry = { width = 600 }, exit = true }
	self.service.navigator.keytip["fairh"] = self.service.navigator.keytip["fairv"]
	self.service.navigator.keytip["spiral"] = self.service.navigator.keytip["fairv"]
	self.service.navigator.keytip["dwindle"] = self.service.navigator.keytip["fairv"]

	self.service.navigator.keytip["tile"] = { geometry = { width = 600 }, exit = true }
	self.service.navigator.keytip["tileleft"] = self.service.navigator.keytip["tile"]
	self.service.navigator.keytip["tiletop"] = self.service.navigator.keytip["tile"]
	self.service.navigator.keytip["tilebottom"] = self.service.navigator.keytip["tile"]

	self.service.navigator.keytip["cornernw"] = { geometry = { width = 600 }, exit = true }
	self.service.navigator.keytip["cornerne"] = self.service.navigator.keytip["cornernw"]
	self.service.navigator.keytip["cornerse"] = self.service.navigator.keytip["cornernw"]
	self.service.navigator.keytip["cornersw"] = self.service.navigator.keytip["cornernw"]

	self.service.navigator.keytip["magnifier"] = { geometry = { width = 600 }, exit = true }

	self.service.navigator.keytip["grid"] = { geometry = { width = 1400 }, column = 2, exit = true }
	self.service.navigator.keytip["usermap"] = { geometry = { width = 1400 }, column = 2, exit = true }

	-- Log out screen
	--------------------------------------------------------------------------------
	self.service.logout = {
		button_size = { width = 128, height = 128 },
		icon_margin = 22,
		text_margin = 18,
		button_spacing = 64,
		counter_top_margin = 800,
		label_font = self.fonts.logout.label,
		counter_font = self.fonts.logout.counter,
		keytip = { geometry = { width = 400 } },
		graceful_shutdown = true,
		double_key_activation = true,
		client_kill_timeout = 5,
		icons = {},
		color = self.color, -- colors (main used)
	}

	-- Desktop file parser
	--------------------------------------------------------------------------------
	self.service.dfparser = {
		-- list of path to check desktop files
		desktop_file_dirs = {
			-- On NixOS systems
			"/run/current-system/sw/share/applications/", -- For nix applications
			"~/.local/state/home-manager/gcroots/current-home/home-path/share/applications/", -- For home-manager applications
			-- '/usr/share/applications/',
			-- '/usr/local/share/applications/',
			"~/.local/share/applications/",
		},
		-- icon theme settings
		icons = {
			theme = self.homedir .. "/.icons/ACYLS", -- ACYLS: <https://github.com/worron/acyls>
			df_icon = self.icon.system, -- default (fallback) icon
			custom_only = false, -- use icons from user theme (no system fallback like 'hicolor' allowed) only
			scalable_only = false, -- use vector(svg) icons (no raster icons allowed) only
		},
		wm_name = nil, -- window manager name
	}

	-- Menu config
	--------------------------------------------------------------------------------
	self.menu = {
		border_width = 4, -- menu border width
		screen_gap = self.useless_gap + self.border_width, -- minimal space from screen edge on placement
		height = 32, -- menu item height
		width = 250, -- menu item width
		icon_margin = { 8, 8, 8, 8 }, -- space around left icon in menu item
		ricon_margin = { 9, 9, 9, 9 }, -- space around right icon in menu item
		nohide = false, -- do not hide menu after item activation
		auto_expand = true, -- show submenu on item selection (without item activation)
		auto_hotkey = false, -- automatically set hotkeys for all menu items
		select_first = true, -- auto select first item when menu shown
		hide_timeout = 1, -- auto hide timeout (auto hide disables if this set to 0)
		font = self.fonts.menu, -- menu font
		submenu_icon = self.icon.submenu, -- icon for submenu items
		keytip = { geometry = { width = 400 } }, -- hotkeys helper settings
		shape = nil, -- wibox shape
		action_on_release = false, -- active menu item on mouse release instead of press
		svg_scale = { true, true }, -- use vector scaling for left, right icons in menu item
	}

	self.menu.color = {
		border = self.color.wibox, -- menu border color
		text = self.color.text, -- menu text color
		highlight = self.color.highlight, -- menu text and icons color for selected item
		main = self.color.main, -- menu selection color
		wibox = self.color.wibox, -- menu background color
		submenu_icon = self.color.icon, -- submenu icon color
		right_icon = nil, -- right icon color in menu item
		left_icon = nil, -- left icon color in menu item
	}

	-- Gauge (various elements that used as component for other widgets) style
	--------------------------------------------------------------------------------
	self.gauge = { tag = {}, task = {}, icon = {}, monitor = {}, graph = {} }

	-- Plain progressbar element
	------------------------------------------------------------
	self.gauge.graph.bar = {
		color = self.color, -- colors (main used)
	}

	-- Plain monitor (label and progressbar below)
	--------------------------------------------------------------
	self.gauge.monitor.plain = {
		width = 50, -- widget width
		font = self.cairo_fonts.tag, -- widget font
		text_shift = 19, -- shift from upper border of widget to lower border of text
		label = "MON", -- widget text
		step = 0.05, -- progressbar painting step
		line = { height = 4, y = 27 }, -- progressbar style
		color = self.color, -- colors (main used)
	}

	-- Simple monitor with sigle vertical dashed progressbar
	------------------------------------------------------------
	self.gauge.monitor.dash = {
		width = 10, -- widget width
		color = self.color, -- colors (main used)

		-- progressbar line style
		line = {
			num = 5, -- number of chunks in progressbar
			height = 3, -- height of progressbar chunk
		},
	}

	-- Icon indicator (decoration in some panel widgets)
	------------------------------------------------------------
	self.gauge.icon.single = {
		icon = self.icon.system, -- default icon
		is_vertical = false, -- use vertical gradient (horizontal if false)
		step = 0.02, -- icon painting step
		color = self.color, -- colors (main used)
	}

	-- Double icon indicator
	--------------------------------------------------------------
	self.gauge.icon.double = {
		icon1 = self.icon.system, -- first icon
		icon2 = self.icon.system, -- second icon
		is_vertical = true, -- use vertical gradient (horizontal if false)
		igap = 4, -- gap between icons
		step = 0.02, -- icon painting step
		color = self.color, -- colors (main used)
	}

	-- Double value monitor (double progressbar with icon)
	--------------------------------------------------------------
	self.gauge.monitor.double = {
		icon = self.icon.system, -- default icon
		width = 90, -- widget width
		dmargin = { 10, 0, 0, 0 }, -- margins around progressbar area
		color = self.color, -- colors (main used)

		-- progressbar style
		line = {
			width = 4, -- progressbar height
			v_gap = 6, -- space between progressbar
			gap = 4, -- gap between progressbar dashes
			num = 5, -- number of progressbar dashes
		},
	}

	-- Separator (decoration used on panel, menu and some other widgets)
	------------------------------------------------------------
	self.gauge.separator = {
		marginv = { 2, 2, 4, 4 }, -- margins for vertical separator
		marginh = { 6, 6, 3, 3 }, -- margins for horizontal separator
		color = self.color, -- color (secondary used)
	}

	-- Dotcount (used in minitray widget)
	------------------------------------------------------------
	self.gauge.graph.dots = {
		column_num = { 3, 5 }, -- amount of dot columns (min/max)
		row_num = 3, -- amount of dot rows
		dot_size = 5, -- dots size
		dot_gap_h = 4, -- horizontal gap between dot (with columns number it'll define widget width)
		color = self.color, -- colors (main used)
	}

	-- Circle shaped monitor
	--------------------------------------------------------------
	self.gauge.monitor.circle = {
		width = 32, -- widget width
		line_width = 4, -- width of circle
		iradius = 5, -- radius for center point
		radius = 11, -- circle radius
		step = 0.05, -- circle painting step
		color = self.color, -- colors (main used)
	}

	-- Tag (base element of taglist)
	------------------------------------------------------------
	self.gauge.tag.rosybrown = {
		width = 40, -- widget width
		color = self.color, -- colors (main used)

		-- tag state mark
		base = {
			pad = 6, -- left/right padding
			height = 9, -- mark height
			thickness = 2, -- mark lines thickness
		},

		-- client focus mark
		mark = {
			pad = 10, -- left/right padding
			height = 3, -- mark height
		},
	}

	-- Task (base element of tasklist)
	------------------------------------------------------------
	self.gauge.task.rosybrown = {
		width = 76,
		text_shift = 26,
		color = self.color,
		font = self.cairo_fonts.tag,

		point = { size = 5, space = 5, gap = 4 },
		underline = { height = 10, thickness = 3, gap = 34, dh = 0 },
	}

	-- Panel widgets
	--------------------------------------------------------------------------------
	self.widget = {}

	-- individual margins for panel widgets
	------------------------------------------------------------
	self.widget.wrapper = {
		mainmenu = { 12, 10, 6, 6 },
		layoutbox = { 10, 10, 6, 6 },
		textclock = { 12, 12, 0, 0 },
		taglist = { 4, 4, 0, 0 },
		tray = { 10, 12, 7, 7 },
		-- tasklist    = { 0, 70, 0, 0 }, -- centering tasklist widget
	}

	-- Textclock
	------------------------------------------------------------
	self.widget.textclock = {
		font = self.fonts.clock, -- font
		tooltip = {}, -- flex tooltip style (see theme.float.tooltip)
		color = { text = self.color.icon }, -- colors
	}

	-- Binary clock
	------------------------------------------------------------
	self.widget.binclock = {
		width = 52, -- widget width
		tooltip = {}, -- flex tooltip style (see theme.float.tooltip)
		dot = { size = 5 }, -- mark size
		color = self.color, -- colors (main used)
	}

	-- Minitray
	------------------------------------------------------------
	self.widget.minitray = {
		dotcount = {}, -- flex dotcount style (see theme.gauge.graph.dots)
		border_width = 0, -- floating widget border width
		geometry = { height = 40 }, -- floating widget size
		screen_gap = 2 * self.useless_gap, -- minimal space from screen edge on floating widget placement
		shape = nil, -- wibox shape
		color = { wibox = self.color.wibox, border = self.color.wibox },

		-- function to define floating widget position when shown
		set_position = function(wibox)
			local geometry = {
				x = mouse.screen.workarea.x + mouse.screen.workarea.width,
				y = mouse.screen.workarea.y + mouse.screen.workarea.height,
			}
			wibox:geometry(geometry)
		end,
	}

	-- Layoutbox
	------------------------------------------------------------
	self.widget.layoutbox = {
		micon = self.icon, -- some common menu icons (used: 'blank', 'check')
		color = self.color, -- colors (main used)
	}

	-- layout icons
	self.widget.layoutbox.icon = {
		floating = self.base .. "/layouts/floating.svg",
		max = self.base .. "/layouts/max.svg",
		fullscreen = self.base .. "/layouts/fullscreen.svg",
		tilebottom = self.base .. "/layouts/tilebottom.svg",
		tileleft = self.base .. "/layouts/tileleft.svg",
		tile = self.base .. "/layouts/tile.svg",
		tiletop = self.base .. "/layouts/tiletop.svg",
		fairv = self.base .. "/layouts/fair.svg",
		fairh = self.base .. "/layouts/fair.svg",
		grid = self.base .. "/layouts/grid.svg",
		usermap = self.base .. "/layouts/map.svg",
		magnifier = self.base .. "/layouts/magnifier.svg",
		spiral = self.base .. "/layouts/spiral.svg",
		cornerne = self.base .. "/layouts/cornerne.svg",
		cornernw = self.base .. "/layouts/cornernw.svg",
		cornerse = self.base .. "/layouts/cornerse.svg",
		cornersw = self.base .. "/layouts/cornersw.svg",
		unknown = self.icon.unknown, -- this one used as fallback
	}

	-- flex menu style (see theme.menu)
	self.widget.layoutbox.menu = {
		icon_margin = { 8, 12, 8, 8 },
		width = 260,
		auto_hotkey = true,
		nohide = false,
		color = { right_icon = self.color.icon, left_icon = self.color.icon },
	}

	-- human readable aliases for layout names (displayed in menu and tooltip)
	self.widget.layoutbox.name_alias = {
		floating = "Floating",
		fullscreen = "Fullscreen",
		max = "Maximized",
		grid = "Grid",
		usermap = "User Map",
		tile = "Right Tile",
		fairv = "Fair Tile",
		tileleft = "Left Tile",
		tiletop = "Top Tile",
		tilebottom = "Bottom Tile",
		magnifier = "Magnifier",
		spiral = "Spiral",
		cornerne = "Corner NE",
		cornernw = "Corner NW",
		cornerse = "Corner SE",
		cornersw = "Corner SW",
	}

	-- Tasklist
	--------------------------------------------------------------

	-- main settings
	self.widget.tasklist = {
		custom_icon = false, -- use custom applications icons (not every gauge task widget support icons)
		iconnames = {}, -- icon name aliases for custom applications icons
		widget = nil, -- task gauge widget (usually setted by rc file)
		width = 40, -- width of task element in tasklist
		char_digit = 4, -- number of characters in task element text
		need_group = true, -- group application instances into one task element
		parser = {}, -- redlat desktop file parser settings (see theme.service.dfparser)
		task_margin = { 5, 5, 0, 0 }, -- margins around task element
		task = self.gauge.task.rosybrown, -- style for task gauge widget
	}

	-- menu settings
	self.widget.tasklist.winmenu = {
		micon = self.icon, -- some common menu icons
		titleline = {
			font = self.fonts.title, -- menu title height
			height = 25, -- menu title font
		},
		tagline = { height = 30 }, -- tag line height
		tag_iconsize = { width = 16, height = 16 }, -- tag line marks size
		enable_screen_switch = false, -- screen option in menu
		enable_tagline = false, -- tag marks instead of menu options
		stateline = { height = 30 }, -- height of menu item with state icons
		state_iconsize = { width = 18, height = 18 }, -- size for state icons
		layout_icon = self.widget.layoutbox.icon, -- list of layout icons
		separator = { marginh = { 3, 3, 5, 5 } }, -- flex separator style (see theme.gauge.separator)
		color = self.color, -- colors (main used)

		-- main menu style (see theme.menu)
		menu = { width = 200, color = { right_icon = self.color.icon }, ricon_margin = { 9, 9, 9, 9 } },

		-- tag action submenu style (see theme.menu)
		tagmenu = {
			width = 160,
			color = { right_icon = self.color.icon, left_icon = self.color.icon },
			icon_margin = { 9, 9, 9, 9 },
		},

		-- set which action will hide menu after activate
		hide_action = {
			min = true,
			move = true,
			max = false,
			add = false,
			floating = false,
			sticky = false,
			ontop = false,
			below = false,
			maximized = false,
		},
	}

	-- menu icons
	self.widget.tasklist.winmenu.icon = {
		floating = self.base .. "/titlebar/floating.svg",
		sticky = self.base .. "/titlebar/pin.svg",
		ontop = self.base .. "/titlebar/ontop.svg",
		below = self.base .. "/titlebar/below.svg",
		close = self.base .. "/titlebar/close.svg",
		minimize = self.base .. "/titlebar/minimize.svg",
		maximized = self.base .. "/titlebar/maximized.svg",

		tag = self.icon.mark, -- tag line mark
		unknown = self.icon.unknown, -- this one used as fallback
	}

	-- multiline task element tip
	self.widget.tasklist.tasktip = {
		border_width = 2, -- tip border width
		margin = { 10, 10, 5, 5 }, -- margins around text in tip lines
		timeout = 0.5, -- hide timeout
		shape = nil, -- wibox shape
		sl_highlight = false, -- highlight application state when it's single line tip
		color = self.color, -- colors (main used)
	}

	-- task text aliases
	self.widget.tasklist.appnames = {}

	-- Floating widgets
	--------------------------------------------------------------------------------
	self.float = { decoration = {} }

	-- Client menu
	------------------------------------------------------------
	self.float.clientmenu = {
		actionline = { height = 28 }, -- height of menu item with action icons
		action_iconsize = { width = 18, height = 18 }, -- size for action icons
		stateline = { height = 30 }, -- height of menu item with state icons

		tagline = { height = 30 }, -- tag line height
		tag_iconsize = { width = 16, height = 16 }, -- tag line marks size

		-- flex separator style(see theme.gauge.separator)
		separator = { marginh = { 3, 3, 5, 5 }, marginv = { 3, 3, 3, 3 } },

		-- same elements as for task list menu
		icon = self.widget.tasklist.winmenu.icon,
		micon = self.widget.tasklist.winmenu.micon,
		layout_icon = self.widget.layoutbox.icon,
		menu = self.widget.tasklist.winmenu.menu,
		state_iconsize = self.widget.tasklist.winmenu.state_iconsize,
		tagmenu = self.widget.tasklist.winmenu.tagmenu,
		hide_action = self.widget.tasklist.winmenu.hide_action,
		enable_screen_switch = false,
		enable_tagline = false,
		color = self.color,
	}

	-- Top processes
	------------------------------------------------------------
	self.float.top = {
		geometry = { width = 460, height = 400 }, -- widget size
		screen_gap = 2 * self.useless_gap, -- minimal space from screen edge on floating widget placement
		border_margin = { 20, 20, 10, 0 }, -- margins around widget content
		button_margin = { 140, 140, 18, 18 }, -- margins around kill button
		title_height = 40, -- widget title height
		border_width = 0, -- widget border width
		bottom_height = 70, -- kill button area height
		list_side_gap = 8, -- left/rigth borger margin for processes list
		title_font = self.fonts.title, -- widget title font
		timeout = 2, -- widget update timeout
		shape = nil, -- wibox shape
		color = self.color, -- color (main used)

		-- list columns width
		labels_width = { num = 30, cpu = 70, mem = 120 },

		-- flex key tip settings
		keytip = { geometry = { width = 400 } },

		-- placement function
		set_position = nil,
	}

	-- Application runner
	------------------------------------------------------------
	self.float.apprunner = {
		itemnum = 6, -- number of visible items
		geometry = { width = 620, height = 480 }, -- widget size
		border_margin = { 24, 24, 24, 24 }, -- margin around widget content
		icon_margin = { 8, 16, 0, 0 }, -- margins around widget icon
		title_height = 48, -- height of title (promt and icon) area
		prompt_height = 35, -- prompt line height
		title_icon = self.icon.system, -- widget icon
		border_width = 0, -- widget border width
		parser = {}, -- desktop file parser settings (see theme.service.dfparser)
		field = nil, -- flex text field style(see theme.float.decoration.field)
		shape = nil, -- wibox shape
		color = self.color, -- colors (main used)

		name_font = self.fonts.title, -- application title font
		comment_font = self.fonts.main, -- application comment font
		list_text_vgap = 4, -- space between application title and comment
		list_icon_margin = { 6, 12, 6, 6 }, -- margins around applications icons
		dimage = self.icon.unknown, -- fallback icon for applications

		keytip = { geometry = { width = 400 } }, -- flex key tip settings
	}

	-- Application switcher
	------------------------------------------------------------
	self.float.appswitcher = {
		wibox_height = 240, -- widget height
		label_height = 28, -- height of the area with application mark(key)
		title_height = 40, -- height of widget title line (application name and tag name)
		icon_size = 96, -- size of the application icon in preview area
		preview_gap = 20, -- gap between preview areas
		shape = nil, -- wibox shape

		-- desktop file parser settings (see theme.service.dfparser)
		parser = {
			desktop_file_dirs = awful.util.table.join(
				self.service.dfparser.desktop_file_dirs,
				{ "~/.local/share/applications-fake" }
			),
		},

		border_margin = { 10, 10, 0, 10 }, -- margins around widget content
		preview_margin = { 15, 15, 15, 15 }, -- margins around application preview
		preview_format = 16 / 10, -- preview acpect ratio
		title_font = self.fonts.title, -- font of widget title line
		border_width = 0, -- widget border width
		update_timeout = 1 / 12, -- application preview update timeout
		min_icon_number = 4, -- this one will define the minimal widget width
		-- (widget will not shrink if number of apps items less then this)
		color = self.color, -- colors (main used)
		font = self.cairo_fonts.appswitcher, -- font of application mark(key)

		-- flex key tip settings
		keytip = { geometry = { width = 400 }, exit = true },
	}

	-- additional color
	self.float.appswitcher.color.preview_bg = self.color.main .. "12"

	-- application marks(keys) list
	self.float.appswitcher.hotkeys = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"0",
		"F2",
		"F3",
		"F4",
		"F5",
		"F6",
		"F7",
		"F8",
		"F9",
		"F10",
		"F11",
		"F12",
	}

	-- Quick launcher
	------------------------------------------------------------
	self.float.qlaunch = {
		geometry = { width = 1400, height = 170 }, -- widget size

		border_width = 0, -- widget border width
		border_margin = { 5, 5, 12, 15 }, -- margins around widget content
		notify = {}, -- flex notify style (see theme.float.notify)
		shape = nil, -- wibox shape
		recoloring = false, -- apply flex recoloring feature on application icons
		label_font = self.fonts.qlaunch, -- font of application mark(key)
		color = self.color, -- colors (main used)
		df_icon = self.icon.system, -- fallback application icon
		no_icon = self.icon.unknown, -- icon for unused application slot

		-- desktop file parser settings (see theme.service.dfparser)
		parser = {
			desktop_file_dirs = awful.util.table.join(
				self.service.dfparser.desktop_file_dirs,
				{ "~/.local/share/applications-fake" }
			),
		},

		appline = {
			iwidth = 140, -- application item width
			im = { 5, 5, 0, 0 }, -- margins around application item area
			igap = { 0, 0, 5, 15 }, -- margins around application icon itself (will affect icon size)
			lheight = 26, -- height of application mark(key) area
		},
		state = {
			gap = 5, -- space between application state marks
			radius = 5, -- application state mark radius
			size = 10, -- application state mark size
			height = 14, -- height of application state marks area
		},

		-- flex key tip settings
		keytip = { geometry = { width = 600 } },

		-- file to store widget data
		-- this widget is rare one which need to keep settings between sessions
		configfile = os.getenv("HOME") .. "/.cache/awesome/applist",
	}

	-- Hotkeys helper
	------------------------------------------------------------
	self.float.hotkeys = {
		geometry = { width = 1400 }, -- widget size
		border_margin = { 20, 20, 8, 10 }, -- margins around widget content
		border_width = 0, -- widget border width
		delim = "   ", -- text separator between key and description
		tspace = 5, -- space between lines in widget title
		is_align = true, -- align keys description (monospace font required)
		separator = { marginh = { 0, 0, 3, 6 } }, -- flex separator style (see theme.gauge.separator)
		font = self.fonts.hotkeys.main, -- keys description font
		keyfont = self.fonts.hotkeys.key, -- keys font
		titlefont = self.fonts.hotkeys.title, -- widget title font
		shape = nil, -- wibox shape
		color = self.color, -- colors (main used)

		-- manual setup for expected text line heights
		-- used for auto adjust widget height
		heights = {
			key = 20, -- hotkey tip line height
			title = 22, -- group title height
		},
	}

	-- Titlebar helper
	------------------------------------------------------------
	self.float.bartip = {
		geometry = { width = 260, height = 40 }, -- widget size
		border_margin = { 10, 10, 10, 10 }, -- margins around widget content
		border_width = 0, -- widget border widthj
		font = self.fonts.title, -- widget font
		set_position = nil, -- placement function
		shape = nil, -- wibox shape
		names = { "Mini", "Plain", "Full" }, -- titlebar layout names
		color = self.color, -- colors (main used)

		-- margin around widget elements
		margin = { icon = { title = { 10, 10, 8, 8 }, state = { 10, 10, 8, 8 } } },

		-- widget icons
		icon = {
			title = self.base .. "/titlebar/title.svg",
			active = self.base .. "/titlebar/active.svg",
			hidden = self.base .. "/titlebar/hidden.svg",
			disabled = self.base .. "/titlebar/disabled.svg",
			absent = self.base .. "/titlebar/absent.svg",
			unknown = self.icon.unknown,
		},

		-- flex key tip settings
		keytip = { geometry = { width = 540 } },
	}

	-- Floating window control helper
	------------------------------------------------------------
	self.float.control = {
		geometry = { width = 260, height = 48 }, -- widget size
		border_margin = { 10, 10, 10, 10 }, -- margins around widget content
		border_width = 0, -- widget border widthj
		font = self.fonts.title, -- widget font
		steps = { 1, 10, 25, 50, 200 }, -- move/resize step
		default_step = 3, -- select default step by index
		onscreen = true, -- no off screen for window placement
		set_position = nil, -- widget placement function
		shape = nil, -- wibox shape
		color = self.color, -- colors (main used)

		-- margin around widget elements
		margin = { icon = { onscreen = { 10, 10, 8, 8 }, mode = { 10, 10, 8, 8 } } },

		-- widget icons
		icon = {
			onscreen = self.icon.system,
			resize = {},
		},

		-- flex key tip settings
		keytip = { geometry = { width = 540 } },
	}

	-- Key sequence tip
	------------------------------------------------------------
	self.float.keychain = {
		geometry = { width = 250, height = 56 }, -- default widget size
		font = self.fonts.keychain, -- widget font
		border_width = 2, -- widget border width
		shape = nil, -- wibox shape
		color = self.color, -- colors (main used)

		-- flex key tip settings
		keytip = { geometry = { width = 600 }, column = 1 },
	}

	-- Tooltip
	------------------------------------------------------------
	self.float.tooltip = {
		timeout = 0, -- show delay
		shape = nil, -- wibox shapea
		font = self.fonts.tooltip, -- widget font
		border_width = 2, -- widget border width
		set_position = nil, -- function to setup tooltip position when shown
		color = self.color, -- colors (main used)

		-- padding around widget content
		padding = { vertical = 3, horizontal = 6 },
	}

	-- Floating prompt
	------------------------------------------------------------
	self.float.prompt = {
		geometry = { width = 620, height = 120 }, -- widget size
		border_width = 0, -- widget border width
		margin = { 20, 20, 40, 40 }, -- margins around widget content
		field = nil, -- flex text field style (see theme.float.decoration.field)
		shape = nil, -- wibox shape
		naughty = {}, -- awesome notification style
		color = self.color, -- colors (main used)
	}

	-- Floating calendar
	------------------------------------------------------------
	self.float.calendar = {
		geometry = { width = 340, height = 420 },
		margin = { 20, 20, 20, 15 },
		controls_margin = { 0, 0, 5, 0 },
		calendar_item_margin = { 2, 5, 2, 2 },
		spacing = { separator = 28, datetime = 5, controls = 5, calendar = 8 },
		controls_icon_size = { width = 18, height = 18 },
		separator = {},
		border_width = 2,
		days = {
			weeknumber = { fg = self.color.gray, bg = "transparent" },
			weekday = { fg = self.color.gray, bg = "transparent" },
			weekend = { fg = self.color.highlight, bg = self.color.gray },
			today = { fg = self.color.highlight, bg = self.color.main },
			day = { fg = self.color.text, bg = "transparent" },
			default = { fg = "white", bg = "transparent" },
		},
		fonts = self.fonts.calendar,
		icon = { next = self.icon.right, prev = self.icon.left },
		clock_format = "%H:%M",
		date_format = "%A, %d. %B",
		clock_refresh_seconds = 60,
		weeks_start_sunday = false,
		show_week_numbers = true,
		show_weekday_header = true,
		long_weekdays = false,
		weekday_name_replacements = {},
		screen_gap = 0,
		set_position = nil,
		shape = nil,
		screen_gap = 2 * self.useless_gap, -- screen edges gap on placement
		color = self.color, -- colors (main used)
	}

	-- Notify (flex notification widget)
	------------------------------------------------------------
	self.float.notify = {
		geometry = { width = 484, height = 106 }, -- widget size
		screen_gap = 2 * self.useless_gap, -- screen edges gap on placement
		border_margin = { 20, 20, 20, 20 }, -- margins around widget content
		elements_margin = { 20, 0, 10, 10 }, -- margins around main elements (text and bar)
		font = self.fonts.notify, -- widget font
		icon = self.icon.warning, -- default widget icon
		border_width = 0, -- widget border width
		timeout = 5, -- hide timeout
		shape = nil, -- wibox shape
		color = self.color, -- colors (main used)

		-- progressbar is optional element used for some notifications
		bar_width = 8, -- progressbar width
		progressbar = {}, -- flex progressbar style (see theme.gauge.graph.bar)

		-- placement function
		set_position = function(wibox)
			wibox:geometry({ x = mouse.screen.workarea.x + mouse.screen.workarea.width, y = mouse.screen.workarea.y })
		end,
	}

	-- Decoration (various elements that used as component for other widgets) style
	--------------------------------------------------------------------------------
	self.float.decoration.button = {
		color = self.color, -- colors (secondary used)
	}

	self.float.decoration.field = {
		color = self.color, -- colors (secondary used)
	}

	-- Titlebar
	--------------------------------------------------------------------------------
	self.titlebar = {}

	self.titlebar.base = {
		position = "top", -- titlebar position
		font = self.fonts.titlebar, -- titlebar font
		border_margin = { 0, 0, 0, 4 }, -- margins around titlebar active area
		color = self.color, -- colors (main used)
	}

	-- application state marks settings
	self.titlebar.mark = {
		color = self.color, -- colors (main used)
	}

	-- application control icon settings
	self.titlebar.icon = {
		color = self.color, -- colors (main used)

		-- icons list
		list = {
			focus = self.base .. "/titlebar/focus.svg",
			floating = self.base .. "/titlebar/floating.svg",
			ontop = self.base .. "/titlebar/ontop.svg",
			below = self.base .. "/titlebar/below.svg",
			sticky = self.base .. "/titlebar/pin.svg",
			maximized = self.base .. "/titlebar/maximized.svg",
			minimized = self.base .. "/titlebar/minimize.svg",
			close = self.base .. "/titlebar/close.svg",
			menu = self.base .. "/titlebar/menu.svg",

			unknown = self.icon.unknown, -- this one used as fallback
		},
	}

	-- Desktop config
	--------------------------------------------------------------------------------
	self.desktop = { common = { bar = {}, pack = {} }, speedmeter = {} }

	self.desktop.line_height = 18 -- text and progressbar height for desktop widgets

	-- desktop widget colors
	self.desktop.color = {
		main = self.color.main,
		gray = self.color.desktop_gray,
		icon = self.color.desktop_icon,
		urgent = self.color.urgent,
		wibox = self.color.bg .. "00",
	}

	-- Common (various elem, 0.20, 0.25ents that used as component for desktop widgets)
	--------------------------------------------------------------------------------

	-- Textbox
	------------------------------------------------------------
	self.desktop.common.textbox = {
		width = nil, -- widget width
		height = nil, -- widget height
		draw = "by_left", -- align method ("by_left", "by_right", "by_edges", "by_width")
		color = self.desktop.color.gray, -- text color

		-- font style
		font = self.cairo_fonts.desktop.textbox,
	}

	-- Dashed progressbar
	------------------------------------------------------------
	self.desktop.common.bar.plain = {
		width = nil, -- widget width
		height = nil, -- widget height
		autoscale = true, -- normalize progressbar value
		maxm = 1, -- the maximum allowed value

		-- color (desktop used)
		color = self.desktop.color,

		-- progressbar settings
		chunk = {
			width = 6, -- bar width
			gap = 6, -- space between bars
		},
	}

	-- Time chart
	------------------------------------------------------------
	self.desktop.common.chart = {
		width = nil, -- widget width
		height = nil, -- widget height
		autoscale = true, -- normalize chart values
		maxm = 1, -- the maximum allowed value
		zero_height = 4, -- height for zero value point in chart
		color = self.desktop.color.gray, -- chart bars color

		-- chart bars settings
		bar = {
			width = 5, -- bar width
			gap = 5, -- space between bars
		},
	}

	-- Custom shaped vertical progressbar
	------------------------------------------------------------
	self.desktop.common.bar.shaped = {
		width = nil, -- widget width
		height = nil, -- widget height
		autoscale = true, -- normalize chart values
		maxm = 1, -- the maximum allowed value
		shape = "corner", -- progressbar chunk shape
		show = { tooltip = false }, -- show tooltip
		color = self.desktop.color, -- color (desktop used)

		-- element style
		chunk = {
			num = 10, -- number of elements
			line = 5, -- element line width
			height = 10, -- element height
		},

		-- tooltip style
		tooltip = {},
	}

	-- Lines (group of progressbars with label in front and text value after it)
	------------------------------------------------------------
	self.desktop.common.pack.lines = {
		label = { width = 80, draw = "by_width" }, -- label style (see theme.desktop.common.textbox)
		text = { width = 92, draw = "by_edges" }, -- value style (see theme.desktop.common.textbox)
		progressbar = {}, -- progressbar style (see theme.desktop.common.bar.plain)
		line = { height = self.desktop.line_height }, -- text/progressbar height
		tooltip = {}, -- flex tooltip style (see theme.float.tooltip)
		color = self.desktop.color, -- color (desktop used)

		-- show/hide line elements
		show = { text = true, label = true, tooltip = false },

		-- space between label/text and progressbar
		gap = { text = 22, label = 16 },
	}

	-- Widgets
	--------------------------------------------------------------------------------

	--Custom aligned text block
	------------------------------------------------------------
	self.desktop.textset = {
		font = "Fira Code 12", -- font
		spacing = 0, -- space between lines
		color = self.desktop.color, -- color (desktop used)
	}

	-- Speed widget (double progressbar with time chart for each of it)
	------------------------------------------------------------
	self.desktop.speedmeter.normal = {
		barvalue_height = 32, -- height of the area with progressbar and text
		digits = 2, -- minimal number of digits for progressbar value
		fullchart_height = 80, -- height of the each area with progressbar, text and chart
		image_gap = 16, -- space between direction icon and progressbar/chart
		color = self.desktop.color, -- color (desktop used)

		-- direction icons
		images = {
			self.icon.system, -- up
			self.icon.system, -- down
		},

		-- !!! WARNING some missed style settings for elemets below will be overwritten by widget
		-- do not try to use full style settings from 'theme.desktop.commom' here

		-- time chart style (see theme.desktop.common.chart)
		chart = { bar = { width = 6, gap = 3 }, height = 40, zero_height = 4 },

		-- progressbar label and value (see theme.desktop.common.textbox)
		label = { height = self.desktop.line_height },

		-- progressbar style (see theme.desktop.common.bar.plain)
		progressbar = { chunk = { width = 16, gap = 6 }, height = 6 },
	}

	self.desktop.speedmeter.compact = {
		margins = { label = {}, chart = {} }, -- extra margins for some elements
		height = { chart = 50 }, -- height of the each area with progressbar, text and chart
		digits = 2, -- minimal number of digits for progressbar value
		color = self.desktop.color, -- color (desktop used)

		-- direction icons
		icon = {
			up = self.icon.system, -- up
			down = self.icon.system, -- down
			margin = { 4, 4, 2, 2 }, -- margins around icon
		},

		-- !!! WARNING some style settings for elemets below will be overwritten by widget
		chart = { zero_height = 0 }, -- time chart style (see theme.desktop.common.chart)
		label = {}, -- progressbar value (see theme.desktop.common.textbox)
		progressbar = {}, -- double progressbar style (see theme.desktop.common.bar.plain)
	}

	-- Widget with multiple horizontal and vertical progress bars
	------------------------------------------------------------
	self.desktop.multimeter = {
		digits = 3, -- minimal number of digits for horizontal progressbar values
		color = self.desktop.color, -- color (desktop used)
		labels = {}, -- list of optional labels for horizontal bars

		-- area height
		height = {
			upright = 80, -- vertical progressbars height
			lines = 58, -- horizontal progressbar area height
		},

		-- widget icon
		icon = {
			image = self.icon.system, -- widget icon
			margin = { 0, 16, 0, 0 }, -- margins around icon
			full = false, -- draw icon in full height of widget
		},
		-- !!! WARNING some missed style settings for elemets below will be overwritten by widget

		--  vertical progressbars style (see theme.desktop.common.bar.shaped)
		upbar = { width = 34, chunk = { height = 17, num = 10, line = 4 } },

		-- horizontal progressbars style (see theme.desktop.common.pack.lines)
		lines = {},
	}

	-- Widget with multiple progress bars
	------------------------------------------------------------
	self.desktop.multiline = {
		digits = 3, -- minimal number of digits for progressbar value
		margin = { 0, 0, 0, 0 }, -- margin around progressbar list
		color = self.desktop.color, -- color (desktop used)

		-- widget icon settings
		icon = { image = nil, margin = { 0, 0, 0, 0 } },

		-- !!! WARNING some missed style settings for elemets below will be overwritten by widget

		-- progressbars style (see theme.desktop.common.pack.lines)
		lines = { progressbar = {}, tooltip = {} },
	}

	-- Widget with several text groups in single line
	-- every group has label and value and icon in the middle
	------------------------------------------------------------
	self.desktop.singleline = {
		lbox = { draw = "by_width", width = 50 }, -- label style (see theme.desktop.common.textbox)
		rbox = { draw = "by_edges", width = 60 }, -- value style (see theme.desktop.common.textbox)
		digits = 2, -- minimal number of digits for value
		icon = self.icon.system, -- group icon
		iwidth = 142, -- width for every text group
		color = self.desktop.color, -- color (desktop used)
	}

	-- Calendar widget with lined up marks
	------------------------------------------------------------
	self.desktop.calendar = {
		show_pointer = true, -- show date under mouse
		color = self.desktop.color, -- color (desktop used)
		label = {
			gap = 8, -- space between label and pointer
			sep = "-", -- day/month separator
			font = { font = "Fira Code", size = 16, face = 1, slant = 0 }, -- font
		},

		-- days marks style
		mark = {
			height = 12, -- mark height
			width = 25, -- mark width
			dx = 6, -- pointer arrow width
			line = 2, -- stroke line width for next month marks
		},
	}

	-- Individual styles for certain widgets
	--------------------------------------------------------------------------------
	self.individual = { desktop = {} }

	-- Default awesome theme vars
	--------------------------------------------------------------------------------

	-- colors
	self.bg_normal = self.color.wibox
	self.bg_focus = self.color.main
	self.bg_urgent = self.color.urgent
	self.bg_minimize = self.color.gray

	self.fg_normal = self.color.text
	self.fg_focus = self.color.highlight
	self.fg_urgent = self.color.highlight
	self.fg_minimize = self.color.highlight

	self.border_normal = self.color.wibox
	self.border_focus = self.color.wibox
	self.border_marked = self.color.main

	-- font
	self.font = self.fonts.main

	-- standart awesome notification widget
	self.naughty = {}

	self.naughty.base = {
		timeout = 10,
		margin = 12,
		icon_size = 80,
		font = self.fonts.main,
		bg = self.color.wibox,
		fg = self.color.text,

		border_width = 4,
		border_color = self.color.wibox,
	}

	self.naughty.normal = {
		height = self.float.notify.geometry.height,
		width = self.float.notify.geometry.width,
	}

	self.naughty.low = {
		timeout = 5,
		height = self.float.notify.geometry.height,
		width = self.float.notify.geometry.width,
	}

	self.naughty.critical = {
		timeout = 0,
		border_color = self.color.main,
	}
end

-- End
-----------------------------------------------------------------------------------------------------------------------
theme:init()

return theme
