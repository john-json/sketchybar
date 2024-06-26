local colors = require("colors")
local icons = require("icons")
local settings = require("settings")


local apple = sbar.add("item", {
	icon = {
		font = {
			size = 12,
		},
		string = "􀆧",
		color = colors.bar.foreground_alt,
		padding_right = 2,
		padding_left = 6,
	},

	background = {

		color = colors.bar.bg,
	},

	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})

apple:subscribe("mouse.entered", function(env)
	local selected = env.SELECTED == "true"
	sbar.animate("elastic", 15, function()
		apple:set({
			background = {
				color = colors.bar.foreground_alt,
			},
			icon = {
				color = colors.bar.bg,
				font = {
					size = 18,
				},
			},
		})
	end)
end)

apple:subscribe("mouse.exited", function(env)
	sbar.animate("elastic", 15, function()
		apple:set({
			background = {
				color = colors.bar.bg,
			},
			icon = {

				string = "􀆧",
				color = colors.bar.foreground_alt,
				font = {
					size = 12,
				},
			},
		})
	end)
end)
