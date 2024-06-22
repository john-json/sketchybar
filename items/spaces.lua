local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- ADD SPACE BUTTON---------------------------
----------------------------------------------

local add_space = sbar.add("item", {
	position = "center",
	icon = {
		padding_left = 8,
		padding_right = 10,
		font = {
			size = 18,
		},
		string = icons.plus,
	},
	label = {
		drawing = false,
	},
	background = {
		color = colors.bar.bg,
	},
})

add_space:subscribe("mouse.entered", function(env)
	sbar.animate("elastic", 20, function()
		add_space:set({
			icon = {
				string = "Add",
				color = colors.white,
				font = {
					size = 12,
				},
			},
		})
	end)
end)

add_space:subscribe("mouse.exited", function(env)
	sbar.animate("elastic", 20, function()
		add_space:set({
			icon = {
				string = icons.plus,
				color = colors.stormcloud.two,
				font = {
					size = 12,
				},
			},
		})
	end)
end)

add_space:subscribe("mouse.clicked", function(env)
	sbar.exec('osascript "$CONFIG_DIR/items/scripts/newSpace.scpt"')
end)

--------- SPACES --------------------------------
-------------------------------------------------

local sf_icons_active = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
}

local sf_icons_inactive = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
}

local function getSpaceIcon(space, active)
	if active then
		return app_icons[space]
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
			padding_right = 10,
			padding_left = 5,
			font = {
				style = settings.font.style_map.Heavy,
				family = settings.font.text,
			},
		},
		icon = {

			color = colors.foreground,
			border_width = 0,
		},
		background = {

			border_width = 0,
			border_color = colors.transparent,

			height = 30,
		},
	})
	spaces[i] = space

	space:subscribe("front_app_switched", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				label = {
					drawing = false,
					-- string = selected and env.INFO or "",
					-- font = {
					-- 	size = 14
					-- },
				},
				icon = {

					border_width = 0,
					padding_left = selected and 10 or 5,
					padding_right = selected and 10 or 5,
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
					font = {
						size = selected and 16 or 14,
					},
				},
				background = {

					corner_radius = selected and 6 or 25,
					height = selected and 22 or 16,
					color = selected and colors.grey or colors.transparent,
					padding_left = 5,
					padding_right = 5,
				},
			})
		end)
	end)

	space:subscribe("mouse.entered", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				icon = {
					border_width = 0,
					drawing = selected and false or true,
					string = "􀽐",
					color = colors.ebony,
					font = {
						size = selected and 16 or 10,
					},
				},
				label = {
					color = colors.foreground,
				},
			})
		end)
	end)

	space:subscribe("mouse.exited", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				icon = {

					drawing = selected and false or true,
					style = settings.font.style_map.Regular,

					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
					color = colors.ebony,
				},
				label = {
					style = settings.font.style_map.Heavy,
					color = colors.foreground,
				},
			})
		end)
	end)

	space:subscribe("mouse.clicked", function(env)
		log("Clicked space: " .. i)
		switchToSpace(i)
	end)
end

-- Group space items into a bracket with a background------------
-----------------------------------------------------------------

local space_names = {}
for i = 1, 10 do
	table.insert(space_names, spaces[i].name)
end

sbar.add("bracket", space_names, add_space, {
	label = {
		padding_left = 20,
		padding_right = 20,
	},
	background = {
		padding_left = 20,
		padding_right = 20,
		color = colors.bar.bg,

		corner_radius = 6, -- Adjust the corner radius as needed
	},
})
