local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local sf_icons_active = {
	"􀃋",
	"􀃍",
	"􀃏",
	"􀃑",
	"􀃓",
	"􀃕",
	"􀃗",
	"􀃙",
	"􀃛"
}
local sf_icons_inactive = {
	"􀨂",
	"􀨂",
	"􀨂",
	"􀨂",
	"􀨂",
	"􀨂",
	"􀨂",
	"􀨂",
	"􀨂",
	"􀨂",
}

local function getSpaceIcon(space, active)
	if active then
		return sf_icons_active[space]
	else
		return sf_icons_inactive[space] or "􀂓"
	end
end



local spaces = {}

-- Create a parent container with a background
local parent_container =
	sbar.add(
		"parent",
		"parent_container",
		{
			width = "dynamic",
			background = {
				height = 15,
				drawing = true,
				color = colors.red,
				corner_radius = 6,
				padding = 0
			},
			position = "center",
			align = "center"
		}
	)

for i = 1, 10 do
	local space =
		sbar.add(
			"space",
			"space." .. i,
			{
				parent = "parent_container",
				position = "center",
				align = "center",
				space = i,
				label = {
					padding_right = 10,
					color = colors.black,
					align = "center",
					font = {
						family = settings.font.text,
						size = 10
					}
				},
				icon = {
					string = getSpaceIcon(i, false),
					size = 18,
					color = colors.bg2
				},
				background = {
					drawing = true,
					color = colors.bg2
				}
			}
		)
	spaces[i] = space

	space:subscribe(
		"front_app_switched",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.animate(
				"elastic",
				5,
				function()
					space:set(
						{
							label = {
								padding_right = selected and 10 or 0,
								padding_left = selected and 0 or 0,
								style = settings.font.style_map.SemiBold,
								string = selected and env.INFO or "",
								color = {
									alpha = selected and 1 or 0,
								},
								font = {
									color = colors.black,
									size = selected and 0 or 1
								}
							},
							icon = {

								string = selected and "" or getSpaceIcon(i, false),
								color = colors.bg2,
								font = {
									size = selected and 0 or 10
								}
							},
							background = {
								drawing = selected and true or false
							}
						}
					)
				end
			)
		end
	)

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

								string = selected and "􀚅" or getSpaceIcon(i, true),
								style = settings.font.style_map.Regular,
								color = selected and colors.bg1 or colors.bg2,
								font = {
									size = selected and 0 or 20
								},

							},
							label = {

								drawing = false,
								string = env.INFO,



								font = {
									size = selected and 12 or 12,
									color = colors.black,
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

								style = settings.font.style_map.SemiBold,
								font = {
									size = selected and 0 or 12
								},
								string = selected and "" or getSpaceIcon(i, false),
								color = selected and colors.bg2 or colors.white
							},
							label = {

								padding_left = selected and 10 or 0,
								padding_right = selected and 10 or 0,
								drawing = true,
								style = settings.font.style_map.Regular,
								color = colors.black,
								string = env.INFO,
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

	space:subscribe(
		"mouse.clicked",
		function(env)
			local selected = env.SELECTED == "true"
			sbar.exec("open -a 'Mission Control'")
			space:set(
				{
					icon = {
						style = settings.font.style_map.SemiBold,
						font = {
							size = selected and 12 or 18
						},
						string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
						color = selected and colors.red or colors.bg2
					},
					label = {
						drawing = true,
						style = settings.font.style_map.Regular,
						color = colors.white,
						font = {
							size = selected and 12 or 0
						}
					}
				}
			)
		end
	)
end
