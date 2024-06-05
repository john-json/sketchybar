local settings = require("settings")
local colors = require("colors")

sbar.default(
	{
		updates = "when_shown",
		icon = {
			padding_left = 5,
			padding_right = 5,
			font = {
				family = settings.font.text,
				style = settings.font.style_map.Bold
			},
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
				size = 12
			},
			color = colors.white
		},
		background = {
			height = 30,
			corner_radius = 6,
			border_width = 0,
			border_color = colors.border2
		},
		popup = {
			position = "center",
			align = "left",
			y_offset = 10,
			width = "dynamic",
			label = {
				font = {
					size = 10
				}
			},
			background = {
				border_width = 0,
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
