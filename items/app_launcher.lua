local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local terminal =
	sbar.add(
		"item",
		"widgets.terminal",
		{
			position = "right",
			padding_right = 5,
			padding_left = 2,
			icon = {
				padding_right = 0,
				color = colors.orange,
				size = 14,
				string = ""
			},
			label = {
				drawing = false,

			},
		}
	)
local chat =
	sbar.add(
		"item",
		{
			position = "right",
			background = {
				color = colors.transparent

			},
			icon = {
				padding_left = 10,
				string = "󱜸",
				color = colors.orange,
				font = { size = 18,
				},
			},
			label = {
				drawing = true,
			}

		}
	)
sbar.add(
	"item",
	{
		width = 0
	}
)

local app_launcher =
	sbar.add(
		"item",
		{
			padding_right = 13,
			position = "right",
			background = {
				color = colors.transparent

			},
			icon = {
				padding_left = 10,
				color = colors.orange,
				font = { size = 18,
				},
			},
			label = {
				drawing = false,
			}

		}
	)




app_launcher:subscribe(
	"mouse.entered",
	function(env)
		sbar.animate(
			"elastic",
			10,
			function()
				app_launcher:set(
					{

						icon = {

							string = "ChatGPT",
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
app_launcher:subscribe(
	"mouse.exited",
	function(env)
		sbar.animate(
			"elastic",
			15,
			function()
				app_launcher:set(
					{

						icon = {

							color = colors.bar.bg,
							font = {
								size = 14
							}
						}
					}
				)
			end
		)
	end
)

chat:subscribe(
	"mouse.clicked",
	function(env)
		app_launcher:set(
			{
				sbar.exec("open -a 'ChatGPT'")
			}
		)
	end
)

terminal:subscribe(
	"mouse.clicked",
	function(env)
		app_launcher:set(
			{
				sbar.exec("open -a 'Alacritty'")
			}
		)
	end
)

-- Double border for apple using a single item bracket
sbar.add("bracket", { chat.name, terminal.name }, {

	background = {
		position = "right",
		padding_left = 20,
		color = colors.bar.bg,
		height = 30,
		width = "dynamic",
		border_color = colors.grey,

	}
})

-- Padding item required because of bracket
sbar.add("item", { width = 5 })
