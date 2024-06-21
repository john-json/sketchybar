local settings = require("settings")
local colors = require("colors")

sbar.default(
	{

		updates = "when_shown",
		icon = {
			padding_left = settings.paddings,
			padding_right = settings.paddings,
			color = colors.slategray.two,
			font = {
				family = settings.font.text,
				style = settings.font.style_map.Bold,
				size = 14.0
			},
		},
		label = {
			padding_left = settings.paddings,
			padding_right = settings.paddings,
			font = {
				family = settings.font.text,
				style = settings.font.style_map.SemiBold,
				size = 12.0
			},
			color = colors.foreground
		},
		background = {
			height = 30,
			corner_radius = 6,
			border_width = 1,
			border_color = {
				color = colors.bar.border
			},
			image = {
				corner_radius = 8
			}

		},
		popup = {
			background = {
				border_width = 2,
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
