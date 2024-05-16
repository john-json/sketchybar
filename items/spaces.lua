local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")
local sf_icons_active = {
	""
}
local sf_icons_inactive = {
	"􀀻",
	"􀀽",
	"􀀿",
	"􀘘",
	"􀁃",
	"􀁅",
	"􀁇",
	"􀁉",
	"􀁋"
}
local function getSpaceIcon(space, active)
	if active then
		return sf_icons_active[space]
	else
		return sf_icons_inactive[space]
	end
end
local spaces = {
	background = {
		colors = colors.bg1,
		corner_radius = 25
	}
}
for i = 1, 10, 1 do
	local space =
		sbar.add(
		"space",
		"space." .. i,
		{
			position = "center",
			align = "center",
			space = i,
			label = {
				color = colors.active,
				padding_left = settings.paddings,
				paddings_right = settings.paddings,
				style = settings.font.style_map.Bold,
				align = "center",
				font = {
					size = 12
				}
			},
			icon = {
				font = {
					family = settings.font.icons,
					size = 20
				},
				string = getSpaceIcon(i, false),
				color = colors.bg1
			},
			background = {
				color = colors.bg1,
				border_color = colors.bg1,
				corner_radius = 20
			}
		}
	)
	spaces[i] = space
	space:subscribe(
		"front_app_switched",
		function(env)
			local selected = env.SELECTED == "true"
			space:set(
				{
					background = {
						width = selected and "dynamic",
						corner_radius = 25,
						height = 30
					},
					icon = {
						string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
						font = {
							size = 20
						}
					},
					label = {
						padding_left = selected and 10 or "",
						padding_right = selected and 15 or "",
						color = colors.frost_light,
						string = selected and env.INFO or ""
					}
				}
			)
			sbar.animate(
				"elastic",
				15,
				function()
					space:set(
						{
							label = {
								style = settings.font.style_map.Bold,
								color = {
									alpha = 1
								}
							},
							icon = {
								style = settings.font.style_map.Bold,
								size = 20,
								string = selected and "" or getSpaceIcon(i, false),
								color = selected and colors.bg2 or colors.bg1
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
				15,
				function()
					space:set(
						{
							background = {
								color = {
									alpha = 1
								}
							},
							icon = {
								style = settings.font.style_map.Bold,
								position = "center",
								align = "center",
								color = colors.bg2,
								font = {
									size = 24
								}
							},
							label = {
								string = env.info,
								width = "dynamic",
								color = colors.frost_blue1,
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
		"mouse.exited",
		function(env)
			local selected = env.SELECTED == "true"
			space:set(
				{
					icon = {
						font = {
							size = 20
						}
					},
					label = {
						string = env.INFO,
						padding_left = selected and 5 or "",
						color = colors.frost_light,
						padding_right = selected and 10 or "",
						font = {
							size = 12
						}
					}
				}
			)
		end
	)
end
