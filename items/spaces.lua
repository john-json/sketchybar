local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local sf_icons_active = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
}
local sf_icons_inactive = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",

}

local function getSpaceIcon(space, active)
	if active then
		return sf_icons_active[space]
	else
		return sf_icons_inactive[space]
	end
end


local spaces = {}

-- Create a parent container with a background

for i = 1, 10, 1 do
	local space =
		sbar.add(
			"space",
			"space." .. i, {
				space = i,

				position = "center",
				label = {


					highlight_color = colors.white,
					color = colors.foreground,
					align = "center",
					font = {
						family = settings.font.text,
						size = 14
					}
				},
				icon = {
					padding_left = 10,
					padding_right = 5,
					string = getSpaceIcon(i, false),
					size = 12,
					color = colors.granit.three
				},
				background = {
					drawing = true,
					color = colors.bar.bg
				},
			}
		)
	spaces[i] = space


	-- Padding space
	sbar.add("space", "space.padding." .. i, {
		space = i,
		script = "",
		width = settings.group_paddings,
	})


	space:subscribe(
		"front_app_switched",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.animate(
				"elastic",
				8,
				function()
					space:set(
						{
							label = {
								padding_right = selected and 10 or 2,
								style = settings.font.style_map.SemiBold,
								string = selected and env.INFO or "",
								color = selected and colors.foreground or colors.granit.one,
								font = {

									size = selected and 14 or 18
								}
							},
							icon = {

								string = selected and getSpaceIcon(i, false) or getSpaceIcon(i, false),
								color = selected and colors.foreground or colors.granit.two,
								font = {
									size = selected and 14 or 12
								}
							},
							background = {
								height = selected and 30 or 25,
								color = selected and colors.bar.bg or colors.bar.bg,
							}
						}
					)
				end
			)
		end
	)



	-- local space_bracket = sbar.add("bracket", "space.bracket", { space.name }, {
	-- 	background = {
	-- 		color = colors.red,
	-- 		height = 30,

	-- 	}
	-- })

	-- Padding space

	------------ ANIMATIONS AND CLICKS -----------

	space:subscribe(
		"mouse.entered",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.animate(
				"elastic",
				5,
				function()
					space:set(
						{

							icon = {

								padding_left = 10,
								padding_right = 5,
								string = selected and icons.space_control or getSpaceIcon(i, false),
								style = settings.font.style_map.SemiBold,
								color = selected and colors.yellow or colors.granit.one,
								font = {
									size = selected and 14 or 20
								},

							},
							label = {

								style = settings.font.style_map.SemiBold,
								string = env.INFO,
								color = colors.yellow,
								font = {
									size = selected and 14 or 12,

								}
							}
						}
					)
				end
			)
		end
	)

	space:subscribe(
		"mouse.exited",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.animate(
				"elastic",
				5,
				function()
					space:set(
						{
							icon = {
								padding_left = 10,
								padding_right = 5,
								style = settings.font.style_map.SemiBold,
								font = {
									size = selected and 14 or 12
								},
								string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
								color = selected and colors.foreground or colors.granit.one
							},
							label = {
								style = settings.font.style_map.SemiBold,
								color = colors.foreground,
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

	space:subscribe(
		"mouse.clicked",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.exec("open -a 'Mission Control'")
		end
	)
end



-------------- ADD SPACE BUTTON -----------

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
			position = "center",

			icon = {
				padding_left = 8,
				padding_right = 10,
				font = {
					size = 12
				},
				string = icons.plus,
				color = colors.orange
			},
			label = {
				drawing = false,
			},
			background = {

				color = colors.bar.bg,
				height = 25,
			},
		}
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

						icon = {

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

						icon = {
							string = icons.plus,
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
	"mouse.clicked",
	function(env)
		add_space:set(
			{
				click_script = {
					sbar.exec('osascript "$CONFIG_DIR/items/scripts/newSpace.scpt"')
				}
			}
		)
	end
)


-- Padding item required because of bracket
sbar.add("item", { width = 5 })
