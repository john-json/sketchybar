local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")



local terminal =
	sbar.add(
		"item",
		{
			shadown = true,
			position = "right",
			background = {
				border_width = 0,
				border_color = colors.transparent,
				color = colors.transparent
			},
			icon = {

				string = "􀩼",
				color = colors.yellow,
				font = { size = 14,
				},
			},
			label = {
				drawing = true,
			}

		}
	)

terminal:subscribe(
	"mouse.clicked",
	function(env)
		sbar.exec("open -a 'iTerm'")
	end
)

local chat =
	sbar.add(
		"item",
		{
			position = "right",
			background = {
				border_width = 0,
				border_color = colors.transparent,
				color = colors.transparent

			},
			icon = {

				string = "􀌲",
				color = colors.yellow,
				font = { size = 14,
				},
			},
			label = {
				drawing = true,
			}

		}
	)

chat:subscribe(
	"mouse.clicked",
	function(env)
		sbar.exec("open -a 'ChatGPT'")
	end
)



local code =
	sbar.add(
		"item",
		{

			position = "right",
			background = {
				border_width = 0,
				border_color = colors.transparent,
				color = colors.transparent

			},
			icon = {
				padding_left = 5,
				string = "􀤘",
				color = colors.yellow,
				font = { size = 14,
				},
			},
			label = {
				drawing = true,
			}

		}
	)



code:subscribe(
	"mouse.clicked",
	function(env)
		sbar.exec("open -a 'Visual Studio Code'")
	end
)




sbar.add(
	"item",
	{

		position = "right",
		width = 5
	}
)


-- Double border for apple using a single item bracket
sbar.add("bracket", { chat.name, terminal.name, code.name }, {

	background = {
		position = "right",
		color = colors.bar.bg,
		width = "dynamic",
		border_color = colors.grey,

	}
})
