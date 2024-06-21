local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local sf_icons_active = {
	"", "", "", "", "", "", "", "", "", "", "", ""
}

local sf_icons_inactive = {
	"􀧙", "􀧙", "􀧙", "􀧙", "􀧙",
	"􀧙", "􀧙", "􀧙", "􀧙", "􀧙",
}

local function getSpaceIcon(space, active)
	if active then
		return sf_icons_active[space]
	else
		return sf_icons_inactive[space]
	end
end

local spaces = {}

-- Create space items
for i = 1, 10 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		position = "center",
		label = {
			color = colors.bar.bg,
			padding_right = 0,
			padding_left = 0,
			font = {
				style = settings.font.style_map.SemiBold,
				family = settings.font.text,
			},
		},
		icon = {
			drawing = false,
		},
		background = {
			padding_right = 5,
			padding_left = 5,
			height = 20,
			color = colors.indigo.five,
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
						size = 14
					},
				},
				icon = {
					drawing = selected and false or true,
					padding_left = selected and 5 or 3,
					padding_right = selected and 6 or 4,
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),


				},
				background = {
					padding_right = 5,
					padding_left = 5,
					corner_radius = selected and 4 or 15,
					height = 20,
					color = colors.indigo.five,
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
					color = colors.indigo.one,

				},
				label = {

					color = colors.indigo.one,
					font = {
						size = 14,
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
					padding_right = selected and 6 or 4,
					drawing = selected and false or true,
					style = settings.font.style_map.SemiBold,
					font = {
						size = 14,
					},
					string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
					color = selected and colors.bar.bg or colors.slategray.two,
				},
				label = {
					style = settings.font.style_map.SemiBold,
					color = colors.bar.bg,
					font = {
						size = 14,
					},
				},
			})
		end)
	end)

	space:subscribe("mouse.clicked", function(env)
		sbar.exec("open -a 'Mission Control'")
	end)
end

-- ADD SPACE BUTTON
local add_space = sbar.add("item", {
	position = "center",
	icon = {
		padding_left = 8,
		padding_right = 10,
		font = {
			size = 12,
		},
		string = icons.plus,
		color = colors.slategray.two,
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
				color = colors.indigo.one,
				font = {
					size = 14,
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
				color = colors.indigo.one,
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
		color = colors.bar.bg,
		height = 28, -- Adjust the height as needed
		corner_radius = 6, -- Adjust the corner radius as needed
	}
})
