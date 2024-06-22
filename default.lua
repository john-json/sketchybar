local settings = require("settings")
local colors = require("colors")

sbar.default(
	{

		updates = "when_shown",
		icon = {

			color = colors.foreground,
			font = {
				family = settings.font.text,
				style = settings.font.style_map.Bold,
				size = 18.0
			},
		},
		label = {
			padding_left = settings.paddings,
			padding_right = settings.paddings,
			font = {
				family = settings.font.text,
				style = settings.font.style_map.SemiBold,
				size = 14.0
			},
			color = colors.foreground
		},
		background = {
			height = 28,
			corner_radius = 6,
			border_width = 1,

			border_color = colors.darkgrey,

			image = {
				corner_radius = 8
			},


		},
		popup = {
			background = {
				border_width = 1,
				corner_radius = 6,
				border_color = colors.popup.border,
				color = colors.popup.bg,
				shadow = {
					drawing = true
				},
			},
			blur_radius = 80
		},
		padding_right = settings.group_paddings,
		padding_left = settings.group_paddings,
		scroll_texts = true
	}
)
