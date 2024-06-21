local colors = require("colors")
local icons = require("icons")
local settings = require("settings")




local apple =
	sbar.add(
		"item",
		{
			icon = {
				font = {
					size = 14
				},
				string = icons.apple,
				color = colors.granit.one,
				padding_right = 10,
				padding_left = 10,
			},

			background = {
				color = colors.bar.bg
			},


			click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
		}
	)

apple:subscribe(
	"mouse.entered",
	function(env)
		local selected = env.SELECTED == "true"
		sbar.animate(
			"elastic",
			15,
			function()
				apple:set(
					{
						background = {
							color = colors.orange
						},
						icon = {
							color = colors.bar.bg,
							font = {
								size = 20
							}
						},

					}
				)
			end
		)
	end
)


apple:subscribe(
	"mouse.exited",
	function(env)
		sbar.animate(
			"elastic",
			15,
			function()
				apple:set(
					{
						background = {
							color = colors.bar.bg,
						},
						icon = {
							padding_right = 10,
							padding_left = 10,
							string = icons.apple,
							color = colors.granit.one,
							font = {
								size = 14
							}
						},

					}
				)
			end
		)
	end
)
