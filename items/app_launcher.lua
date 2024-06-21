local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Padding item required because of bracket
sbar.add("item", { width = 5 })


local terminal =
	sbar.add(
		"item",
		"widgets.terminal",
		{
			position = "right",
			icon = {

				color = colors.metalsaurus,
				size = 18,
				string = ""
			},
			label = {
				drawing = false,

			},
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
				color = colors.transparent

			},
			icon = {

				string = "󱜸",
				color = colors.metalsaurus,
				font = { size = 18,
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
				color = colors.transparent

			},
			icon = {

				string = "󱃖",
				color = colors.metalsaurus,
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

		position = "right",
		width = 5
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
		position = "right",
		color = colors.bar.bg,
		width = "dynamic",
		border_color = colors.grey,

	}
})
