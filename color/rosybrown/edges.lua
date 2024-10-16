-- Grab environment
local awful = require("awful")
local flex = require("flex")

-- Initialize tables and vars for module
local edges = {}

local switcher = flex.float.appswitcher
local currenttags = flex.widget.tasklist.filter.currenttags
local allscreen = flex.widget.tasklist.filter.allscreen

-- Active screen edges
function edges:init(args)
	args = args or {}
	local ew = args.width or 1 -- edge width
	local workarea = args.workarea or screen[mouse.screen].workarea
	local tcn = args.tag_cols_num or 0

	-- edge geometry
	local egeometry = {
		top = { width = workarea.width - 2 * ew, height = ew, x = ew, y = 0 },
		right = { width = ew, height = workarea.height, x = workarea.width - ew, y = 0 },
		left = { width = ew, height = workarea.height, x = 0, y = 0 },
	}

	-- Top
	local top = flex.util.desktop.edge("horizontal")
	top.wibox:geometry(egeometry["top"])

	top.layout:buttons(awful.util.table.join(awful.button({}, 1, function()
		if client.focus then
			client.focus.maximized = not client.focus.maximized
		end
	end)))

	-- Right
	local right = flex.util.desktop.edge("vertical", { ew, workarea.height - ew })
	right.wibox:geometry(egeometry["right"])

	local function tag_line_switch(colnum)
		local screen = awful.screen.focused()
		local i = screen.selected_tag.index
		local next_index = (i <= colnum) and i + colnum or i - colnum
		-- Check if the tag index is valid
		if next_index > 0 and next_index <= #screen.tags then
			local tag = screen.tags[next_index]
			tag:view_only()
		end
	end

	right.area[1]:buttons(awful.util.table.join(
		awful.button({}, 5, function()
			tag_line_switch(tcn)
		end),
		awful.button({}, 4, function()
			tag_line_switch(tcn)
		end)
	))

	right.area[2]:buttons(awful.util.table.join(
		awful.button({}, 5, function()
			awful.tag.viewnext(mouse.screen)
		end),
		awful.button({}, 4, function()
			awful.tag.viewprev(mouse.screen)
		end)
	))

	-- Left
	local left = flex.util.desktop.edge("vertical", { ew, workarea.height - ew })
	left.wibox:geometry(egeometry["left"])

	left.area[1]:buttons(awful.util.table.join(
		awful.button({}, 4, function()
			switcher:show({ filter = allscreen })
		end),
		awful.button({}, 5, function()
			switcher:show({ filter = allscreen, reverse = true })
		end)
	))

	left.area[2]:buttons(awful.util.table.join(
		awful.button({}, 9, function()
			if client.focus then
				client.focus.minimized = true
			end
		end),
		awful.button({}, 4, function()
			switcher:show({ filter = currenttags })
		end),
		awful.button({}, 5, function()
			switcher:show({ filter = currenttags, reverse = true })
		end)
	))

	left.wibox:connect_signal("mouse::leave", function()
		flex.float.appswitcher:hide()
	end)
end

return edges
