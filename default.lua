local settings = require("settings")
local colors = require("colors")

sbar.default(
	{
		updates = "when_shown",
		icon = {
			padding_left = 2,
			padding_right = 2,
			font = {
				family = settings.font.text,
				style = settings.font.style_map.Heavy,
				size = 14
			},
			background = {
				image = {
					corner_radius = 4
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
			height = 18,
			corner_radius = 4,
			border_width = 0,
			border_color = colors.transparent
		},
		popup = {
			padding_left = 10,
			padding_right = 10,
			position = "center",
			align = "left",
			y_offset = 10,
			width = "dynamic",
			label = {

				font = {
					size = 12
				}
			},
			background = {
				padding_left = 10,
				padding_right = 10,
				border_width = 0,
				corner_radius = 8,
				border_color = colors.popup.border,
				color = colors.popup.bg,
				shadow = {
					drawing = true
				}
			},
			blur_radius = 80
		},
		padding_left = 5,
		padding_right = 5,
		scroll_texts = true
	}
)
