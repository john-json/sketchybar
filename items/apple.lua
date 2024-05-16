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
			drawing = false
		},
		background = {
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
			"circ",
			25,
			function()
				apple:set(
					{
						background = {
							align = "center",
							position = "center",
							color = {
								alpha = 1
							}
						},
						icon = {
							align = "center",
							position = "center",
							padding_right = 10,
							pading_left = 10,
							string = icons.apple,
							color = colors.frost_red,
							font = {
								size = 25
							}
						},
						label = {
							width = 10,
							string = "Settings"
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
			"circ",
			25,
			function()
				apple:set(
					{
						background = {
							align = "center",
							position = "center",
							color = {
								alpha = 1
							}
						},
						icon = {
							align = "center",
							position = "center",
							font = {
								size = 16
							},
							string = icons.apple,
							color = colors.frost_light
						},
						label = {
							width = 10
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
			"circ",
			25,
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
