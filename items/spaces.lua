local colors = require("colors")
local icons = require("icons")
local settings = require("settings")




-- Background around the cpu item
sbar.add("item", "menus.padding", {
	position = "left",
	width = settings.group_paddings
})
--------- SPACES --------------------------------
-------------------------------------------------

local sf_icons_active = {
	"􁽿", "􁽿", "􁽿", "􁽿", "􁽿", "􁽿", "􁽿", "􁽿", "􁽿", "􁽿",

}



local sf_icons_inactive = {
	"􁽾", "􁽾", "􁽾", "􁽾", "􁽾", "􁽾", "􁽾", "􁽾", "􁽾", "􁽾",


}

local function getSpaceIcon(space, active)
	if active then
		return sf_icons_active[space]
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
		position = "left",
		label = {
			drawing = false,
			font = {
				style = settings.font.style_map.Bold,
				family = settings.font.text,
			},
		},
		icon = {
			drawing = true,
			color = colors.bar.bg2,
			border_width = 0,
		},
		background = {
			color = colors.white,
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
					padding_left = 0
				},
				icon = {
					drawing = true,
					padding_left = selected and 5 or 5,
					padding_right = selected and 5 or 5,
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
					font = {
						size = selected and 18 or 12,
					},
					color = colors.bar.active,

				},
				background = {
					drawing = false,
					border_color = selected and colors.blue or colors.grey,
					corner_radius = selected and 50 or 25,

					color = colors.transparent,

					padding_left = selected and 5 or 5,
					padding_right = selected and 5 or 5,
				},

			})
		end)
	end)

	space:subscribe("mouse.entered", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				icon = {
					align = "center",
					corner_radius = 50,
					border_width = 0,
					drawing = true,
					string = selected and "􀏪" or "􀯵",
					color = selected and colors.bar.foreground_alt or colors.bar.foreground_alt,
					font = {
						size = 18
					},
				},
				background = {
					border_width = 0,
					corner_radius = 4,
					color = colors.transparent,
					padding_left = selected and 5 or 5,
					padding_right = selected and 5 or 5,
				},
			})
		end)
	end)

	space:subscribe("mouse.exited", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				icon = {
					font = {
						size = selected and 16 or 14
					},
					drawing = selected and false or true,
					style = settings.font.style_map.Regular,

					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
					color = selected and colors.bar.foreground_alt or colors.grey,
				},
				background = {
					border_width = 0,
					corner_radius = 4,
					color = colors.transparent,
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
