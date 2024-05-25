local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
sbar.add(
	"item",
	{
		width = 20
	}
)
local apple =
	sbar.add(
	"item",
	{
		icon = {
			align = "center",
			position = "center",
			font = {
				size = 14
			},
			padding_right = 10,
			padding_left = 10,
			string = icons.apple,
			color = colors.frost_light
		},
		label = {
			width = "dynamic",
			drawing = true,
			string = "system",
			padding_right = 15,
			font = {
				size = 12,
				color = colors.frost_blue1
			}
		},
		background = {
			padding_right = 10,
			align = "center",
			position = "center",
			color = colors.bg1,
			border_width = 0,
			corner_radius = 25,
			width = 20
		},
		click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
	}
)
sbar.add(
	"bracket",
	{
		apple.name
	},
	{
		background = {
			color = colors.transparent,
			border_width = 0
		}
	}
)
apple:subscribe(
	"swap_menus_and_spaces",
	function(env)
		local currently_on = (apple:query()).icon.value == icons.apple
		apple:set(
			{
				icon = currently_on and icons.apple or icons.arrow_up
			}
		)
	end
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
							string = icons.apple,
							color = colors.frost_blue1,
							font = {
								size = 14
							}
						},
						label = {
							string = "s y s t e m",
							font = {
								size = 12,
								color = colors.frost_blue1
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
							font = {
								size = 14
							},
							string = icons.apple,
							color = colors.frost_light
						},
						label = {
							string = "system",
							padding_right = 15,
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
