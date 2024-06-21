local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")



local sf_icons_active = {
	"􀀺",
	"􀀼",
	"􀀾",
	"􀘗",
	"􀁂",
	"􀑱",
	"􀁆",
	"􀁈",
	"􀁊",
	"􀓵",
}
local sf_icons_inactive = {
	"􀧙",
	"􀧙",
	"􀧙",
	"􀧙",
	"􀧙",
	"􀧙",
	"􀧙",
	"􀧙",
	"􀧙",
	"􀧙",

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
				position = "left",
				label = {

					highlight_color = colors.foreground,
					color = colors.slategray.two,
					align = "center",
					font = {
						style = settings.font.style_map.SemiBold,
						family = settings.font.text,
					}
				},
				background = {
					color = {
						color = colors.bar.bg,

					}
				},
				icon = {
					string = getSpaceIcon(i, true),
					size = 18,
					color = colors.slategray.one,

				}
			})
	spaces[i] = space



	space:subscribe(
		"front_app_switched",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.animate(
				"elastic",
				10,
				function()
					space:set(
						{

							label = {
								padding_right = selected and 10 or 0,
								padding_left = selected and 10 or 0,
								style = settings.font.style_map.SemiBold,
								string = selected and env.INFO or "",
								color = selected and colors.bar.bg or colors.slategray.one,
								font = {

									size = selected and 14 or 18
								}
							},
							icon = {

								padding_left = selected and 10 or 5,
								padding_right = selected and 0 or 5,
								string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
								color = selected and colors.bar.bg or colors.slategray.two,
								font = {
									size = selected and 18 or 18,
								},
							},
							background = {
								padding_right = selected and 5 or 5,
								padding_left = selected and 5 or 5,

								drawing = selected and true or true,

								height = selected and 28 or 26,
								color = selected and colors.slategray.two or colors.bar.bg,
							}
						}
					)
				end
			)
		end
	)




	------------ ANIMATIONS AND CLICKS -----------

	space:subscribe(
		"mouse.entered",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.animate(
				"elastic",
				3,
				function()
					space:set(
						{
							background = {
								drawing = true,
							},

							icon = {


								string = icons.space_control,
								style = settings.font.style_map.SemiBold,
								color = selected and colors.bar.bg or colors.slategray.one,
								font = {
									size = selected and 22 or 20
								},

							},
							label = {

								style = settings.font.style_map.SemiBold,
								string = env.INFO,
								color = colors.slategray.one,
								font = {
									size = selected and 16 or 12,

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
				3,
				function()
					space:set(
						{
							icon = {

								style = settings.font.style_map.SemiBold,
								font = {
									size = selected and 18 or 18
								},
								string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
								color = selected and colors.bar.bg or colors.slategray.two
							},
							label = {
								style = settings.font.style_map.SemiBold,
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

	space:subscribe(
		"mouse.clicked",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.exec("open -a 'Mission Control'")
		end
	)
end



-------------- ADD SPACE BUTTON -----------



local add_space =
	sbar.add(
		"item",
		{


			icon = {
				padding_left = 8,
				padding_right = 10,
				font = {
					size = 14
				},
				string = icons.plus,
				color = colors.slategray.tw,
			},
			label = {
				drawing = false,
			},
			background = {

				color = colors.bar.bg,

			},
		}
	)


add_space:subscribe(
	"mouse.entered",
	function(env)
		sbar.animate(
			"elastic",
			8,
			function()
				add_space:set(
					{

						icon = {

							string = "Add",
							color = colors.slategray.one,
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
add_space:subscribe(
	"mouse.exited",
	function(env)
		sbar.animate(
			"elastic",
			8,
			function()
				add_space:set(
					{

						icon = {
							string = icons.plus,
							color = colors.metalsaurus,
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
				click_script = {
					sbar.exec('osascript "$CONFIG_DIR/items/scripts/newSpace.scpt"')
				}
			}
		)
	end
)
