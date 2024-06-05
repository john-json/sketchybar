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
	"􀂓",
	"􀂓",
	"􀂓",
	"􀂓",
	"􀂓",
	"􀂓",
	"􀂓",
	"􀂓",
	"􀂓"
}

local function getSpaceIcon(space, active)
	if active then
		return sf_icons_active[space]
	else
		return sf_icons_inactive[space] or "􀂓"
	end
end

-- Create a parent container with a background
local parent_container =
	sbar.add(
	"parent",
	"parent_container",
	{
		width = "dynamic",
		background = {
			drawing = true,
			color = colors.bg1,
			corner_radius = 10,
			padding = 10
		},
		position = "left",
		align = "center"
	}
)

local spaces = {1, 2, 3, 4, 5, 6, 7, 8, 0}

for i = 1, 10 do
	local space =
		sbar.add(
		"space",
		"space." .. i,
		{
			parent = "parent_container",
			position = "left",
			align = "center",
			space = i,
			label = {
				color = colors.text,
				align = "center",
				font = {
					family = settings.font.text,
					size = 10
				}
			},
			icon = {
				string = getSpaceIcon(i, false),
				size = 20,
				color = colors.red
			},
			background = {
				drawing = true,
				color = colors.bg1
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
				10,
				function()
					space:set(
						{
							label = {
								padding_right = selected and 10 or 0,
								padding_left = selected and 5 or 0,
								style = settings.font.style_map.SemiBold,
								string = selected and env.INFO or "",
								color = {
									alpha = 1
								},
								font = {
									color = colors.red,
									size = selected and 12 or 18
								}
							},
							icon = {
								padding_left = selected and 10 or 0,
								style = settings.font.style_map.SemiBold,
								string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
								color = selected and colors.red or colors.bg1,
								font = {
									size = selected and 12 or 18
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
				10,
				function()
					space:set(
						{
							background = {
								color = {
									alpha = 1
								}
							},
							icon = {
								string = selected and "􁻻 Spaces" or getSpaceIcon(i, true),
								style = settings.font.style_map.Regular,
								color = selected and colors.red or colors.bg1,
								font = {
									size = selected and 12 or 25
								}
							},
							label = {
								drawing = false,
								string = selected and "Spaces" or env.INFO,
								color = colors.red,
								font = {
									size = selected and 12 or 12
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
				10,
				function()
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
	)

	space:subscribe(
		"mouse.clicked",
		function(env)
			sbar.exec("open -a 'Mission Control'")
		end
	)
end
