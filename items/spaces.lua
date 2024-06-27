local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")




-- Background around the cpu item
sbar.add("item", "menus.padding", {
	position = "left",
	width = settings.group_paddings
})
--------- SPACES --------------------------------
-------------------------------------------------

local sf_icons_active = {
	"",

}



local sf_icons_inactive = {
	"",


}

local function getSpaceIcon(space, active, app_name)
	if active then
		return app_icons[app_name]
	else
		return sf_icons_inactive[space]
	end
end



local spaces = {}

local function log(message)
	os.execute('echo "' .. message .. '" >> /tmp/sketchybar.log')
end

local function switchToSpace(spaceNumber)
	local scriptPath = string.format('"$CONFIG_DIR/items/scripts/switchSpace/switchToSpace%d.scpt"', spaceNumber)
	log("Switching to space: " .. spaceNumber .. " with script: " .. scriptPath)
	local command = "osascript " .. scriptPath
	log("Executing command: " .. command)
	local result = os.execute(command)
	log("Result: " .. tostring(result))
end

-- Create space items
for i = 1, 10 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		position = "center",
		label = {
			drawing = false,
		},
		icon = {
			color = colors.bar.bg2,
			border_width = 0,
		},
		background = {
			color = colors.transparent,
			height = 20,
			corner_radius = 50,
		}

	})
	spaces[i] = space

	space:subscribe("front_app_switched", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				label = {
					drawing = false,
				},
				icon = {
					drawing = true,
					padding_left = selected and 15 or 5,
					padding_right = selected and 15 or 5,
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),

					font = {
						font = "sketchybar-app-font:Regular:16.0",
						size = selected and 14 or 14,
					},
					color = selected and colors.bar.bg or colors.transparent,

				},
				background = {
					height = selected and 16 or 10,
					width = selected and 10 or 4,
					corner_radius = selected and 4 or 50,
					color = selected and colors.bar.foreground or colors.bar.foreground_dimmed,

					padding_left = selected and 10 or 5,
					padding_right = selected and 10 or 5,

				},

			})
		end)
	end)

	space:subscribe("mouse.entered", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				label = {
					drawing = false,

				},
				icon = {
					corner_radius = 50,
					drawing = true,
					color = selected and colors.bar.foreground_bar.bg or colors.bar.bg,
					font = {
						size = selected and 20 or 14
					},
				},
				background = {
					border_width = 2,
					border_color = colors.bar.bg,
					height = selected and 16 or 8,
					width = selected and 10 or 4,
					corner_radius = selected and 4 or 25,
					padding_left = selected and 10 or 10,
					padding_right = selected and 10 or 10,

				},
			})
		end)
	end)

	space:subscribe("mouse.exited", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				label = {
					drawing = false,

				},
				icon = {
					drawing = true,
					padding_left = selected and 15 or 4,
					padding_right = selected and 15 or 4,
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),

					font = {
						font = "sketchybar-app-font:Regular:16.0",
						size = selected and 14 or 14,
					},
					color = selected and colors.bar.bg or colors.transparent,

				},

				background = {
					height = selected and 16 or 8,
					width = selected and 10 or 4,
					corner_radius = 4,
					color = selected and colors.bar.foreground or colors.bar.foreground_dimmed,
					padding_left = selected and 5 or 5,
					padding_right = selected and 5 or 5,
				},
			})
		end)
	end)

	space:subscribe("mouse.clicked", function(env)
		local selected = env.SELECTED == "true"
		log("Clicked space: " .. i)
		switchToSpace(i)
		icon = {
			click_script = selected and sbar.exec('osascript "$CONFIG_DIR/items/scripts/newSpace.scpt"'),
		}
	end)
end



-- -- ADD SPACE BUTTON---------------------------
-- ----------------------------------------------

-- local add_space = sbar.add("item", {
-- 	position = "left",
-- 	icon = {
-- 		padding_left = settings.group_paddings,
-- 		padding_right = settings.group_paddings,
-- 		font = {
-- 			size = 12,
-- 		},
-- 		string = icons.plus,

-- 	},
-- 	label = {
-- 		drawing = false,
-- 		string = "]"

-- 	},
-- 	background = {

-- 		color = colors.bar.bg,
-- 	},
-- })

-- add_space:subscribe("mouse.entered", function(env)
-- 	sbar.animate("elastic", 10, function()
-- 		add_space:set({
-- 			icon = {
-- 				string = "Add",
-- 				color = colors.white,
-- 				font = {
-- 					size = 12,
-- 				},
-- 			},
-- 		})
-- 	end)
-- end)

-- add_space:subscribe("mouse.exited", function(env)
-- 	sbar.animate("elastic", 10, function()
-- 		add_space:set({
-- 			icon = {
-- 				string = icons.plus,
-- 				color = colors.stormcloud.two,
-- 				font = {
-- 					size = 12,
-- 				},
-- 			},
-- 		})
-- 	end)
-- end)

-- add_space:subscribe("mouse.clicked", function(env)
-- 	sbar.exec('osascript "$CONFIG_DIR/items/scripts/newSpace.scpt"')
-- end)


local space_names = {}
for i = 1, 10 do
	table.insert(space_names, spaces[i].name)
end

sbar.add("bracket", space_names, add_space, {

	background = {
		margin = 0,

		color = colors.bar.bg,
		corner_radius = 6, -- Adjust the corner radius as needed
	},
})
