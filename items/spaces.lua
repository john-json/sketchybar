local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local sf_icons_active = {
	"", "", "", "", "", "", "", "", "", ""
}

local sf_icons_inactive = {
	"􀧙", "􀧙", "􀧙", "􀧙", "􀧙",
	"􀧙", "􀧙", "􀧙", "􀧙", "􀧙"
}

local function getSpaceIcon(space, active)
	if active then
		return sf_icons_active[space]
	else
		return sf_icons_inactive[space]
	end
end

local spaces = {}

-- local function log(message)
-- 	os.execute('echo "' .. message .. '" >> /tmp/sketchybar.log')
-- end cat /tmp/sketchybar.log

local function switchToSpace(spaceNumber)
	local scriptPath = string.format('"$CONFIG_DIR/items/scripts/switchSpace/switchToSpace%d.scpt"', spaceNumber)
	log("Switching to space: " .. spaceNumber .. " with script: " .. scriptPath)
	local command = 'osascript ' .. scriptPath
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
			color = colors.stormcloud.two,
			padding_right = 10,
			padding_left = 10,
			font = {
				style = settings.font.style_map.SemiBold,
				family = settings.font.text,
			},
		},
		icon = {
			padding_right = 10,
			padding_left = 10,
			drawing = false,
		},
		background = {
			padding_right = 10,
			padding_left = 10,
			height = 28,
			color = colors.grey,
		},
	})
	spaces[i] = space

	space:subscribe("front_app_switched", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				label = {
					drawing = selected and true or false,
					padding_right = selected and 10 or 0,
					padding_left = selected and 0 or 0,
					string = selected and env.INFO or "",
					font = {
						size = 12
					},
				},
				icon = {
					drawing = selected and false or true,
					padding_left = selected and 5 or 5,
					padding_right = selected and 2 or 5,
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
				},
				background = {
					border_width = 0,
					border_color = colors.transparent,
					padding_right = 5,
					padding_left = 5,
					corner_radius = selected and 6 or 15,
					height = 24,
					color = selected and colors.stormcloud.one or colors.transparent,
				},
			})
		end)
	end)

	space:subscribe("mouse.entered", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				icon = {
					padding_left = 3,
					padding_right = 4,
					drawing = selected and false or true,
					string = icons.space_control,
					color = colors.stormcloud.one,
					font = {
						size = 16
					},
				},
				label = {
					color = colors.stormcloud.two,
					font = {
						size = 12,
					},
				},
			})
		end)
	end)

	space:subscribe("mouse.exited", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("elastic", 10, function()
			space:set({
				icon = {
					padding_left = selected and 5 or 3,
					padding_right = selected and 2 or 4,
					drawing = selected and false or true,
					style = settings.font.style_map.SemiBold,
					font = {
						size = 14,
					},
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
					color = colors.stormcloud.two
				},
				label = {
					style = settings.font.style_map.SemiBold,
					color = colors.stormcloud.two,
					font = {
						size = 14,
					},
				},
			})
		end)
	end)

	space:subscribe("mouse.clicked", function(env)
		log("Clicked space: " .. i)
		switchToSpace(i)
	end)
end

-- ADD SPACE BUTTON
local add_space = sbar.add("item", {
	position = "left",
	icon = {
		padding_left = 8,
		padding_right = 10,
		font = {
			size = 12,
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
	sbar.animate("elastic", 8, function()
		add_space:set({
			icon = {
				string = "Add",
				color = colors.stormcloud.two,
				font = {
					size = 12,
				},
			},
		})
	end)
end)

add_space:subscribe("mouse.exited", function(env)
	sbar.animate("elastic", 8, function()
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

-- Group space items into a bracket with a background
local space_names = {}
for i = 1, 10 do
	table.insert(space_names, spaces[i].name)
end

sbar.add("bracket", space_names, {
	background = {
		padding_left = 10,
		padding_right = 10,
		color = colors.bar.bg,
		height = 30, -- Adjust the height as needed
		corner_radius = 6, -- Adjust the corner radius as needed
	}
})
