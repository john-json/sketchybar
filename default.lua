local settings = require("settings")
local colors = require("colors")

sbar.default(
	{
		updates = "when_shown",
		icon = {
			font = {
				family = settings.font.text,
				style = settings.font.style_map.Bold
			},
			padding_left = settings.icon_paddings,
			padding_right = settings.icon_paddings,
			background = {
				image = {
					corner_radius = 8
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
			corner_radius = 6,
			border_width = 0,
			border_color = colors.border2
		},
		popup = {
			margin = 50,
			label = {
				font = {
					size = 10
				}
			},
			background = {
				border_width = 1,
				corner_radius = 12,
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
