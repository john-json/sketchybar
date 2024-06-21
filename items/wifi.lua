local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
sbar.exec(
	"killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en1 network_update 2.0"
)

local popup_width = 250
local wifi_up =
	sbar.add(
		"item",
		"widgets.wifi1",
		{
			position = "right",
			width = 0,
			icon = {

				font = {
					style = settings.font.style_map.Bold,
					size = 9
				},
				string = icons.wifi.upload
			},
			label = {
				font = {
					family = settings.font.numbers,
					style = settings.font.style_map.Bold,
					size = 9
				},
				string = "en1 Bps"
			},
			y_offset = 4
		}
	)
local wifi_down =
	sbar.add(
		"item",
		"widgets.wifi2",
		{
			position = "right",
			padding_left = 5,
			icon = {
				font = {
					style = settings.font.style_map.Bold,
					size = 9
				},
				string = icons.wifi.download
			},
			label = {
				font = {
					family = settings.font.numbers,
					style = settings.font.style_map.Bold,
					size = 9
				},
				color = colors.seezalt.light,
				string = "en1 Bps"
			},
			y_offset = -4
		}
	)
local wifi_icon =
	sbar.add(
		"item",
		"wifi.icon",
		{
			padding_left = -5,
			label = {
				drawing = false,
			},
			position = "right",
			icon = {
				string = icons.wifi.connected,
				color = colors.orange,
				font = {
					size = 14
				}
			},

		}
	)
local wifi = sbar.add("item", "widgets.wifi.padding", {
	position = "right",
	label = { drawing = false },
})


sbar.add(
	"item",
	{

		position = "right",
		width = 10
	}
)

-- Background around the item
local wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {
	wifi.name,
	wifi_icon.name,
	wifi_up.name,
	wifi_down.name
}, {
	background = {

		color = colors.bar.bg
	},
	popup = { align = "center", height = 30 }
})


local ssid =
	sbar.add(
		"item",
		{
			position = "popup." .. wifi_bracket.name,
			icon = {
				font = {
					size = 8,
					style = settings.font.style_map.Bold
				},
				string = icons.wifi.router
			},
			width = popup_width,
			align = "center",
			label = {
				font = {
					style = settings.font.style_map.Bold,
					color = colors.bg1
				},
				max_chars = 18,
				string = "????????????????"
			},
			background = {
				height = 40,
				color = colors.transparent,
				y_offset = -50
			}
		}
	)
local hostname =
	sbar.add(
		"item",
		{
			position = "popup." .. wifi_bracket.name,
			icon = {
				align = "left",
				string = "Hostname:",
				width = popup_width / 2
			},
			label = {
				max_chars = 20,
				string = "????????????",
				style = settings.font.style_map.Bold,
				width = popup_width / 2,
				align = "left"
			}
		}
	)
local ip =
	sbar.add(
		"item",
		{
			position = "popup." .. wifi_bracket.name,
			icon = {
				align = "left",
				string = "IP:",
				width = popup_width / 2
			},
			label = {
				string = "???.???.???.???",
				width = popup_width / 2,
				align = "left"
			}
		}
	)
local mask =
	sbar.add(
		"item",
		{
			position = "popup." .. wifi_bracket.name,
			icon = {
				align = "left",
				string = "Subnet mask:",
				width = popup_width / 2
			},
			label = {
				string = "???.???.???.???",
				width = popup_width / 2,
				align = "left"
			}
		}
	)
local router =
	sbar.add(
		"item",
		{
			position = "popup." .. wifi_bracket.name,
			icon = {
				align = "left",
				string = "Router:",
				width = popup_width / 2
			},
			label = {
				string = "???.???.???.???",
				width = popup_width / 2,
				align = "left"
			}
		}
	)
sbar.add(
	"item",
	{
		position = "left",
		width = settings.group_paddings,
		label = {
			font = {
				size = 10
			}
		}
	}
)
wifi_up:subscribe(
	"network_update",
	function(env)
		local up_color = env.upload == "000 Bps" and colors.grey or colors.text_active
		local down_color = env.download == "000 Bps" and colors.grey or colors.text_active
		wifi_up:set(
			{
				icon = {
					color = colors.green,
					padding_right = 5
				},
				label = {
					string = env.upload,
					style = settings.font.style_map.Bold,
					color = colors.granit.one
				}
			}
		)
		wifi_down:set(
			{
				icon = {
					color = colors.red,
					padding_right = 5
				},
				label = {
					string = env.download,
					style = settings.font.style_map.Bold,
					color = colors.granit.two
				}
			}
		)
	end
)
wifi:subscribe(
	{
		"wifi_change",
		"system_woke"
	},
	function(env)
		sbar.exec(
			"ipconfig getifaddr en0",
			function(ip)
				local connected = not (ip == "")
				wifi:set(
					{
						icon = {
							string = connected and icons.wifi.connected or icons.wifi.disconnected,
							color = connected and colors.green or colors.red
						}
					}
				)
			end
		)
	end
)
local function hide_details()
	wifi_bracket:set(
		{
			popup = {
				drawing = false
			}
		}
	)
end
local function toggle_details()
	local should_draw = (wifi_bracket:query()).popup.drawing == "off"
	if should_draw then
		wifi_bracket:set(
			{
				popup = {
					drawing = true,
					label = {

						size = 8

					}
				}
			}
		)
		sbar.exec(
			"networksetup -getcomputername",
			function(result)
				hostname:set(
					{
						label = result
					}
				)
			end
		)
		sbar.exec(
			"ipconfig getifaddr en1",
			function(result)
				ip:set(
					{
						label = result
					}
				)
			end
		)
		sbar.exec(
			"ipconfig getsummary en1 | awk -F ' SSID : '  '/ SSID : / {print $2}'",
			function(result)
				ssid:set(
					{
						label = result
					}
				)
			end
		)
		sbar.exec(
			"networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'",
			function(result)
				mask:set(
					{
						label = result
					}
				)
			end
		)
		sbar.exec(
			"networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'",
			function(result)
				router:set(
					{
						label = result
					}
				)
			end
		)
	else
		hide_details()
	end
end


wifi_up:subscribe("mouse.clicked", toggle_details)
wifi_down:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.exited.global", hide_details)




local function copy_label_to_clipboard(env)
	local label = (sbar.query(env.NAME)).label.value
	sbar.exec('echo "' .. label .. '" | pbcopy')
	sbar.set(
		env.NAME,
		{
			label = {
				string = icons.clipboard,
				align = "left",
				size = 8
			}
		}
	)
	sbar.delay(
		1,
		function()
			sbar.set(
				env.NAME,
				{
					label = {
						string = label,
						align = "right",
						size = 8
					}
				}
			)
		end
	)
end
ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
