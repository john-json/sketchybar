local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

sbar.add(
	"item",
	{

		position = "left",
		width = 5
	}
)

local terminal =
	sbar.add(
		"item",
		{
			shadown = true,
			position = "left",
			background = {
				border_width = 0,
				border_color = colors.transparent,
				color = colors.transparent
			},
			icon = {
				font = { size = 18,
				},
				padding_left = 5,
				string = "􀁗",
				color = colors.lightgray,

			},
			label = {
				drawing = false,
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
			position = "left",
			background = {
				border_width = 0,
				border_color = colors.transparent,
				color = colors.transparent

			},
			icon = {
				font = { size = 18,
				},

				string = "􂄼",
				color = colors.lightgray,

			},
			label = {
				drawing = false,
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

			position = "left",
			background = {
				border_width = 0,
				border_color = colors.transparent,
				color = colors.transparent

			},
			icon = {
				padding_right = 5,
				string = "􀤘",
				color = colors.lightgray,
				font = { size = 18,
				},
			},
			label = {
				drawing = false,
			}

		}
	)



code:subscribe(
	"mouse.clicked",
	function(env)
		sbar.exec("open -a 'Visual Studio Code'")
	end
)






-- Double border for apple using a single item bracket
sbar.add("bracket", { chat.name, terminal.name, code.name }, {

	background = {
		position = "left",
		color = colors.bar.bg,
		width = "dynamic",
		border_color = colors.grey,

	}
})
