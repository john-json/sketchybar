local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", {
    width = 5
})

local apple = sbar.add("item", {
    icon = {
        font = {
            size = 14.0
        },
        string = "///",
        padding_right = 15,
        padding_left = 15,
        color = colors.grey,
        
    },
    label = {
        drawing = false
    },
    background = {
        color = colors.bg1,
        border_width = 0,


    },

    click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})

-- Double border for apple using a single item bracket
sbar.add("bracket", {apple.name}, {
    background = {
        color = colors.transparent,
        border_width = 0
    }
})

apple:subscribe(
    "swap_menus_and_spaces",
    function(env)
        local currently_on = apple:query().icon.value == icons.menu_alt
        apple:set(
            {
                icon = currently_on and "///" or icons.menu_alt
            }
        )
    end
)

apple:subscribe(
    "mouse.entered",
    function(env)
        sbar.animate(
            "circ",
            35,
            function()
                apple:set(
                    {
                        background = {
     
                            color = {
                                alpha = 1.0
                            }
                        },
                        icon = {
                            padding_right = 15,
                            padding_left = 15,
                            string = icons.menu_alt,
                            color = colors.yellow,
                            font = {size = 14}

                        },
                        label = {
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

apple:subscribe(
    "mouse.exited",
    function(env)
        sbar.animate(
            "circ",
            35,
            function()
                apple:set(
                    {
                        background = {
                            color = {
                                alpha = 1.0
                            }
                        },
                        icon = {
                            padding_right = 15,
                            padding_left = 15,
                            position = "center",
                            align = "center",
                            color = colors.grey,
                            size = 10,
                            string = "///",
                        },
                        label = {
                            width = 20,
                        }
                    }
                )
            end
        )
    end
)

apple:subscribe(
    "mouse.clicked",
    function(env)
        sbar.animate("circ", 35, function() apple:set({
label = {

    font = {
        colors = colors.bg1
    }
}
        }
    )
end
    )
    end
)
