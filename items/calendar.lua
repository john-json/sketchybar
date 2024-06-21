local settings = require("settings")
local colors = require("colors")


local cal =
    sbar.add(
        "item",
        {
            position = "right",


            label = {
                background = {

                    color = colors.indigo.six,
                    height = 30,
                    padding_right = 5,
                    corner_radius = 6,


                },
                padding_right = 10,
                padding_left = 10,
                position = "left",
                color = colors.foreground,
                font = {
                    style = settings.font.style_map["Bold"],
                    size = 14
                }
            },
            icon = {
                padding_left = 10,
                padding_right = 10,
                align = "laft",
                color = colors.indigo.three,
                font = {
                    style = settings.font.style_map["SemiBold"],
                    size = 12

                }
            },

            update_freq = 30,
            background = {

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
                icon = os.date("%a.%d "),
                label = os.date("%H:%M")
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
