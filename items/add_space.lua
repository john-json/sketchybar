local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
sbar.add(
	"item",
	{
		width = 0
	}
)
local add_space =
	sbar.add(
	"item",
	{
		icon = {
			align = "center",
			font = {
				size = 14
			},
			string = icons.plus,
			color = colors.grey
		},
		background = {
			color = {
				alpha = 0
			}
		}
	}
)
sbar.add(
	"bracket",
	{
		add_space.name
	},
	{}
)

add_space:subscribe(
	"mouse.entered",
	function(env)
		sbar.animate(
			"elastic",
			10,
			function()
				add_space:set(
					{
						background = {
							color = colors.bg1
						},
						icon = {
							padding_right = 10,
							padding_left = 10,
							string = "Add 􀅼",
							color = colors.orange,
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
add_space:subscribe(
	"mouse.exited",
	function(env)
		sbar.animate(
			"elastic",
			15,
			function()
				add_space:set(
					{
						background = {
							color = {
								alpha = 0
							}
						},
						icon = {
							padding_right = 0,
							padding_left = 0,
							string = icons.plus,
							color = colors.grey,
							font = {
								size = 18
							}
						}
					}
				)
			end
		)
	end
)

add_space:subscribe(
	"mouse.clicked",
	function(env)
		add_space:set(
			{
				icon = {
					string = icons.plus,
					sbar.exec('osascript "$CONFIG_DIR/items/scripts/newSpace.scpt"')
				}
			}
		)
	end
)
