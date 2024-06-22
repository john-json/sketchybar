local settings = require("settings")
local colors = require("colors")


local cal =
    sbar.add(
        "item",
        {
            position = "right",


            label = {
                padding_right = 10,
                padding_left = 10,


                background = {

                    color = colors.foreground,
                    height = 30,
                    corner_radius = 6,
                },


                color = colors.foreground_light,
                font = {
                    style = settings.font.style_map["Bold"],
                    size = 14
                }
            },
            icon = {
                padding_left = 10,
                padding_right = 10,
                align = "laft",
                color = colors.foreground,
                font = {
                    style = settings.font.style_map["Regualr"],
                    size = 12

                }
            },

            update_freq = 30,
            background = {
                border_width = 2,
                border_color = colors.bar.bg,
                color = colors.bar.bg,

            },

            width = "dynamic",

        }

    )


cal:subscribe(
    { "forced", "routine", "system_woke" },
    function(env)
        cal:set(
            {
                icon = os.date("%A %d %B "),
                label = os.date("􁆸 %H:%M")
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
