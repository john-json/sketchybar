local settings = require("settings")
local colors = require("colors")

sbar.default(
	{
		updates = "when_shown",
		icon = {
			font = {
				family = settings.font.text,
				style = settings.font.style_map.Bold,
				size = 18
			},
			padding_left = settings.paddings,
			padding_right = settings.paddings,
			background = {
				image = {
					corner_radius = 15
				}
			}
		},
		label = {
			font = {
				family = settings.font.text,
				style = settings.font.style_map.SemiBold,
				size = 16
			},
			color = colors.frost_light,
			padding_left = settings.paddings,
			padding_right = settings.paddings
		},
		background = {
			height = 30,
			corner_radius = 15,
			border_width = 0,
			border_color = colors.border2
		},
		popup = {
			background = {
				border_width = 1,
				corner_radius = 8,
				border_color = colors.popup.border,
				color = colors.popup.bg,
				shadow = {
					drawing = true
				}
			},
			blur_radius = 60
		},
		padding_left = 5,
		padding_right = 5,
		scroll_texts = true
	}
)
