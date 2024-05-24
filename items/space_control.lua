local colors = require("colors")
local settings = require("settings")
local icons = require("icons")
local app_icons = require("helpers.app_icons")

local space_control =
    sbar.add(
    "item",
    "space_control",
    {
        icon = {
            color = colors.bg2,
            string = icons.space_add,
            align = "center",
            position = "center",
            font = {
                size = 22,
                style = settings.font.style_map["Bold"]
            }
        },
        label = {
            color = colors.bar.bg,
            align = "center",
            font = {
                family = settings.font.text,
                size = 10
            }
        },
        position = "center",
        update_freq = 30,
        background = {
            color = colors.transparent
        }
    }
)
space_control:subscribe(
    "mouse.entered",
    function(env)
        local selected = env.SELECTED == "true"
        sbar.animate(
            "elastic",
            15,
            function()
                space_control:set(
                    {
                        background = {
                            color = {
                                alpha = 0
                            }
                        },
                        icon = {
                            color = colors.green,
                            style = settings.font.style_map.Bold,
                            string = icons.space_add,
                            font = {
                                size = 24
                            }
                        }
                    }
                )
            end
        )
    end
)

space_control:subscribe(
    "mouse.exited",
    function(env)
        local selected = env.SELECTED == "true"
        space_control:set(
            {
                background = {
                    color = {
                        alpha = 0
                    }
                },
                icon = {
                    color = colors.bg2,
                    string = icons.space_add,
                    align = "center",
                    position = "center",
                    font = {
                        style = settings.font.style_map["Bold"],
                        size = 22
                    }
                },
                label = {
                    align = "center",
                    position = "center",
                    color = colors.bg1,
                    string = selected and env.INFO or ""
                }
            }
        )
    end
)
space_control:subscribe(
    "mouse.clicked",
    function(env)
        sbar.exec("open -a 'Mission Control'")
    end
)
