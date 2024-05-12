local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Define SF icons for spaces
local sf_icons_active = {""}
local sf_icons_inactive = {"􀀻", "􀀽", "􀀿", "􀁁", "􀁃", "􀁅", "􀁇", "􀁉", "􀁋",} -- Icons for inactive spaces
-- local sf_icons_inactive = {"􀃋", "􀃍", "􀃏", "􀃑", "􀃓", "􀑶", "􀃗", "􀃙"} -- Icons for inactive spaces


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
        corner_radius = 25,
    },
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

                style = settings.font.style_map["Bold"],
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
                string = getSpaceIcon(i, false), -- Use inactive icon by default
                color = colors.bg1,
                highlight_color = colors.frost_blue3
            },
            background = {
                color = colors.bg1,
                border_color = colors.bg1,
                corner_radius = 25,
            },

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
                        height = 20
                    },
                    icon = {
                        string = selected and getSpaceIcon(i, true) or getSpaceIcon(i, false)
                    },
                    label = {
                        padding_left = selected and 5 or "",
                        color = colors.grey,

                        padding_right = selected and 10 or "",
                        string = selected and env.INFO or ""
                    }
                }
            )

            sbar.animate(
                "circ",
                15,
                function()
                    space:set(
                        {
                            label = {
                                style = settings.font.style_map["Bold"],
                                color = {
                                    alpha = selected and 1.0 or 0.0
                                }
                            },
                            icon = {
                                style = settings.font.style_map["Bold"],
                                size = 20,
                                string = selected and "" or getSpaceIcon(i, false),
                                color = selected and colors.frost_blue1 or colors.bg1
                            },
                            background = {
                                drawing = selected and true or false,

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
                "circ",
                15,
                function()
                    space:set(
                        {

                            background = {
                                color = {
                                    alpha = 1.0
                                }
                            },
                            icon = {
                                style = settings.font.style_map["Bold"],
                                color = colors.bg1,
                                string = selected and "" or getSpaceIcon(i, false),
                                font = {
                                    size = 30
                                },
                                position = "center",
                                align = "center",
                            },
                            label = {
                                string = selected and "" or getSpaceIcon(i, false),
                                width = "dynamic",
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
        "item",
        function(env)
            local selected = env.SELECTED == "true"
            if env.BUTTON == "other" then
                space:set(
                    {
                    label = {
                        style = settings.font.style_map["Bold"],
                        color = colors.grey,
                        string = selected and env.info or ""
                    },
                        icon = {
                            style = settings.font.style_map["Bold"],
                            string = selected and "" or getSpaceIcon(i, false),
                            font = {
                            color = colors.blue,
                            },
                       
                        },
               
                    }
                )
            else
                sbar.exec("open -a 'Mission Control'")
            end
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
                            size = 30,
                        },
                        string = selected and "" or getSpaceIcon(i, true)
                    },
                    label = {
                        padding_left = selected and 5 or "",
                        color = colors.grey,

                        padding_right = selected and 10 or "",
                        string = selected and env.INFO or ""
                    }
                }
            )
        end
    )
end

local space_window_observer =
    sbar.add(
    "item",
    {
        drawing = false,
        updates = true
    }
)

local spaces_indicator =
    sbar.add(
    "item",
    {
        icon = {
            color = colors.bg1,
            string = "",

            font = {
                align = "center",
                size = 14
            }
        },
        label = {
            width = 5,
            color = colors.green
        },
        background = {
            color = colors.bg1,
            corner_radius = 8,
        }
    }
)

spaces_indicator:subscribe(
    "swap_menus_and_spaces",
    function(env)
        local currently_on = spaces_indicator:query().icon.value == icons.switch.on
        spaces_indicator:set(
            {
                icon = currently_on and icons.switch.off or icons.switch.on,
            label = currently_on and "menu" or "",
            }
        )
    end
)

spaces_indicator:subscribe(
    "mouse.entered",
    function(env)
        sbar.animate(
            "circ",
            20,
            function()
                spaces_indicator:set(
                    {
                        background = {
                            width = 5,
                            color = {
                                alpha = 1.0
                            }
                        },
                        icon = {
                            color = colors.bg1,
                            string = icons.menu_alt and "" or icons.arrow_right,
                            font = {size = 14}
                        },
                        label = {
                            width = "dynamic",
                            padding_right = 10,
                            padding_left = 10,
                            string = "Menu",
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

spaces_indicator:subscribe(
    "mouse.exited",
    function(env)
        sbar.animate(
            "sin",
            20,
            function()
                spaces_indicator:set(
                    {
                        background = {
                            color = {
                                alpha = 1.0
                            }
                        },
                        icon = {
                            position = "center",
                            align = "center",
                          font = {
                           color = colors.frost_blue2,
                            size = 12
                          }  
                        },
                        label = {
                            string = "",
                            width = 5,
                        }
                    }
                )
            end
        )
    end
)

spaces_indicator:subscribe(
    "mouse.clicked",
    function(env)
        sbar.trigger("swap_menus_and_spaces")
              sbar.animate(
            "sin",
            20,
            function()
                spaces_indicator:set(
                    {
  
                        icon = {
                            width = "25",
                            color = colors.bg1,
                            string = icons.menu_alt and icons.arrow_left,
                            font = {size = 12}
                        },
                        label = {
                            width = 25,
                            string = "",
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
 