-----------------------------------------------------------------------------------------------------------------------
--                                                Layouts config                                                     --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")
local awsmx = require("awsmx")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local layouts = {}


-- Build  table
-----------------------------------------------------------------------------------------------------------------------
function layouts:init()

	-- layouts list
	local layset = {
		awful.layout.suit.floating,
		awsmx.layout.grid,
		awful.layout.suit.tile,
		awful.layout.suit.fair,
		awsmx.layout.map,
		awful.layout.suit.max,
		awful.layout.suit.max.fullscreen,
	}

	awful.layout.layouts = layset
end

-- some advanced layout settings
awsmx.layout.map.notification = false


-- connect alternative moving handler to allow using custom handler per layout
-- by now custom handler provided for 'awsmx.layout.grid' only
-- feel free to remove if you don't use this one
client.disconnect_signal("request::geometry", awful.layout.move_handler)
client.connect_signal("request::geometry", awsmx.layout.common.mouse.move)


-- connect additional signal for 'awsmx.layout.map'
-- this one removing client in smart way and correct tiling scheme
-- feel free to remove if you want to restore plain queue behavior
client.connect_signal("unmanage", awsmx.layout.map.clean_client)

client.connect_signal("property::minimized", function(c)
	if c.minimized and awsmx.layout.map.check_client(c) then awsmx.layout.map.clean_client(c) end
end)
client.connect_signal("property::floating", function(c)
	if c.floating and awsmx.layout.map.check_client(c) then awsmx.layout.map.clean_client(c) end
end)

client.connect_signal("untagged", function(c, t)
	if awsmx.layout.map.data[t] then awsmx.layout.map.clean_client(c) end
end)


-- user map layout preset
-- preset can be defined for individual tags, but this should be done after tag initialization

-- awsmx.layout.map.base_construct = function(wa)
-- 	local tree = { set = {}, active = 1, autoaim = true }

-- 	tree.set[1] = awsmx.layout.map.construct_itempack({}, wa, false)
-- 	tree.set[2] = awsmx.layout.map.base_set_new_pack({}, wa, true, tree.set[1])
-- 	tree.set[3] = awsmx.layout.map.base_set_new_pack({}, wa, true, tree.set[1])
-- 	tree.set[4] = awsmx.layout.map.base_set_new_pack({}, wa, true, tree.set[1])

-- 	function tree:aim()
-- 		for i = 2, 4 do if #self.set[i].items == 0 then return i end end
-- 		local active = #self.set[4].items >= #self.set[2].items and 2 or 4
-- 		return active
-- 	end

-- 	return tree
-- end


-- End
-----------------------------------------------------------------------------------------------------------------------
return layouts
