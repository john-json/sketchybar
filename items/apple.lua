local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
sbar.add(
	"item",
	{
		width = 0
	}
)
local apple =
	sbar.add(
		"item",
		{
			icon = {
				padding_left = 10,
				padding_right = 10,
				align = "center",
				font = {
					size = 14
				},
				string = icons.apple,
				color = colors.seezalt_dark,
			},
			background = {
				color = colors.bg2
			},
			click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
		}
	)
sbar.add(
	"bracket",
	{
		apple.name
	},
	{}
)

apple:subscribe(
	"mouse.entered",
	function(env)
		sbar.animate(
			"elastic",
			15,
			function()
				apple:set(
					{
						background = {
							color = {
								alpha = 1
							}
						},
						icon = {
							string = "Menu",
							color = colors.red,
							font = {
								size = 12
							}
						}
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
							color = {
								alpha = 1
							}
						},
						icon = {
							string = icons.apple,
							color = colors.seezalt_dark,
							font = {
								size = 12
							}
						}
					}
				)
			end
		)
	end
)
apple:subscribe(
	"mouse.clicked",
	function(env)
		sbar.animate(
			"elastic",
			15,
			function()
				apple:set(
					{
						label = {
							font = {
								colors = colors.bg1
							}
						}
					}
				)
			end
		)
	end
)
