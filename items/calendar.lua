local settings = require("settings")
local colors = require("colors")


local cal =
    sbar.add(
        "item",
        {
            position = "center",

            label = {
                padding_right = 10,
                position = "left",
                color = colors.slategray.one,
                font = {
                    style = settings.font.style_map["Bold"],
                    size = 14
                }
            },
            icon = {
                padding_left = 10,
                align = "laft",
                color = colors.slategray.four,
                font = {
                    style = settings.font.style_map["SemiBold"],
                    size = 12

                }
            },

            update_freq = 30,
            background = {
                height = 24,
                color = colors.bg2,
                border_width = 0
            },

            width = "dynamic",

        }
    )


cal:subscribe(
    { "forced", "routine", "system_woke" },
    function(env)
        cal:set(
            {
                icon = os.date("%a.%d 􀥤 %H:"),
                label = os.date("%M")
                -- icon = os.date("%a.%d %b. %H"),
            }
        )
    end
)

cal:subscribe(
    "mouse.clicked",
    function(env)
        sbar.exec("open -a 'Calendar'")
    end
)
