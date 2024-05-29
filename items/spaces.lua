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
local spaces = {
	background = {
		colors = colors.bg1
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
				color = colors.frost_light,
				align = "center",
				padding_left = 5,
				font = {
					family = settings.font.text,
					size = 10
				}
			},
			icon = {
				string = getSpaceIcon(i, false),
				size = 20,
				color = colors.bg1
			},
			background = {
				color = colors.bg1,
				border_color = colors.bg1
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
									size = selected and 12 or 20
								}
							},
							icon = {
								padding_left = selected and 5 or 0,
								paddings_right = selected and 5 or 0,
								style = settings.font.style_map.SemiBold,
								string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
								color = selected and colors.frost_blue1 or colors.bg1,
								font = {
									size = selected and 14 or 18
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
								string = selected and icons.space_control3 or getSpaceIcon(i, true),
								style = settings.font.style_map.Regular,
								color = selected and colors.frost_blue1 or colors.bg1,
								font = {
									size = selected and 18 or 25
								}
							},
							label = {
								string = env.INFO,
								color = colors.frost_blue1,
								font = {
									size = 2
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
				15,
				function()
					space:set(
						{
							icon = {
								style = settings.font.style_map.SemiBold,
								font = {
									size = selected and 14 or 18
								},
								-- string = selected and "" or getSpaceIcon(i, false),
								string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false),
								color = selected and colors.frost_blue1 or colors.bg1
							},
							label = {
								style = settings.font.style_map.Regular,
								padding_right = selected and 15 or 0,
								color = colors.frost_light,
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
			local selected = env.SELECTED == "true"

			sbar.exec(selected and "open -a 'Mission Control'" or "osascript $CONFIG_DIR/items/scripts/newSpace.scpt")
		end
	)

	-- 	space:subscribe(
	-- 		"mouse.exited",
	-- 		function(env)
	-- 			local selected = env.SELECTED == "true"
	-- 			space:set(
	-- 				{
	-- 					icon = {
	-- 						drawing = selected and false or true
	-- 					},
	-- 					label = {
	-- 						string = env.INFO,
	-- 						padding_left = selected and 5 or "",
	-- 						color = colors.frost_light,
	-- 						padding_right = selected and 10 or "",
	-- 						font = {
	-- 							size = 10
	-- 						}
	-- 					}
	-- 				}
	-- 			)
	-- 		end
	-- 	)
end
