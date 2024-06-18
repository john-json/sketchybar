local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
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
			position = "center",

			icon = {



				font = {
					size = 14
				},
				string = icons.plus,
				color = colors.slategray.one
			},
			background = {
				color = colors.bg1
			},
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

							string = "Add 􀅼",
							color = colors.green,
							font = {
								size = 16
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
							string = icons.plus,
							color = colors.grey,
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

app_launcher:subscribe(
	"mouse.clicked",
	function(env)
		app_launcher:set(
			{
				sbar.exec("open -a 'ChatGPT'")
			}
		)
	end
)

-- Double border for apple using a single item bracket
sbar.add("bracket", { app_launcher.name }, {
	background = {
		color = colors.transparent,
		height = 30,
		border_color = colors.grey,
	}
})

-- Padding item required because of bracket
sbar.add("item", { width = 5 })
