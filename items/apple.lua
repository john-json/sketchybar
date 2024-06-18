local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", { width = 0 })



local apple =
	sbar.add(
		"item",
		{
			icon = {
				font = {
					size = 14
				},
				string = icons.apple,
				color = colors.dimgray.one,
				padding_right = 12,
				padding_left = 12,
			},
			label = { drawing = false },
			background = {
				color = colors.bar.bg
			},


			click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
		}
	)

apple:subscribe(
	"mouse.entered",
	function(env)
		local selected = env.SELECTED == "true"
		sbar.animate(
			"elastic",
			15,
			function()
				apple:set(
					{
						icon = {
							color = colors.blue,
							font = {
								size = 20
							}
						},

					}
				)
			end
		)
	end
)


apple:subscribe(
	"mouse.exited",
	function(env)
		sbar.animate(
			"elastic",
			15,
			function()
				apple:set(
					{
						background = {
							color = colors.bar.bg,
						},
						icon = {
							string = icons.apple,
							color = colors.dimgray.one,
							font = {
								size = 14
							}
						},

					}
				)
			end
		)
	end
)

-- Double border for apple using a single item bracket
sbar.add("bracket", { apple.name }, {
	background = {

		border_color = colors.grey,
	}
})
-- Padding item required because of bracket
sbar.add("item", { width = 0 })
