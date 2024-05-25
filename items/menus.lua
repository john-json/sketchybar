local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local menu_watcher =
    sbar.add(
    "item",
    {
        drawing = false,
        updates = false
    }
)
local space_menu_swap =
    sbar.add(
    "item",
    {
        drawing = false,
        updates = true
    }
)
sbar.add("event", "swap_menus_and_spaces")

local max_items = 15
local menu_items = {}
for i = 1, max_items, 1 do
    local menu =
        sbar.add(
        "item",
        "menu." .. i,
        {
            padding_left = 10,
            padding_right = 10,
            drawing = false,
            icon = {
                drawing = false
            },
            label = {
                font = {
                    size = 12,
                    style = settings.font.style_map[i == 1 and "SemiBold" or "Regular"]
                }
            },
            click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s " .. i
        }
    )

    menu_items[i] = menu
end

sbar.add(
    "bracket",
    {"/menu\\..*/"},
    {
        background = {
            color = colors.bg1,
            corner_radius = 25
        }
    }
)

local menu_padding =
    sbar.add(
    "item",
    "menu.padding",
    {
        drawing = false
    }
)

local function update_menus(env)
    sbar.exec(
        "$CONFIG_DIR/helpers/menus/bin/menus -l",
        function(menus)
            sbar.set(
                "/menu\\..*/",
                {
                    drawing = false
                }
            )
            menu_padding:set(
                {
                    drawing = true
                }
            )
            id = 1
            for menu in string.gmatch(menus, "[^\r\n]+") do
                if id < max_items then
                    menu_items[id]:set(
                        {
                            label = menu,
                            drawing = true
                        }
                    )
                else
                    break
                end
                id = id + 1
            end
        end
    )
end

menu_watcher:subscribe("front_app_switched", update_menus)

space_menu_swap:subscribe(
    "swap_menus_and_spaces",
    function(env)
        local drawing = menu_items[1]:query().geometry.drawing == "on"
        if drawing then
            menu_watcher:set(
                {
                    updates = false
                }
            )

            sbar.set(
                "/menu\\..*/",
                {
                    drawing = false
                }
            )
            sbar.set(
                "front_app\\",
                {
                    drawing = true
                }
            )
            sbar.set(
                "/space\\..*/",
                {
                    drawing = true
                }
            )
        else
            menu_watcher:set(
                {
                    updates = true
                }
            )
            sbar.set(
                "front_app\\",
                {
                    drawing = false
                }
            )
            sbar.set(
                "/space\\..*/",
                {
                    drawing = false
                }
            )

            update_menus()
        end
    end
)

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
        position = "left",
        align = "center",
        label = {
            padding_right = 15,
            padding_left = 5,
            color = colors.frost_light,
            string = "Menu",
            font = {
                size = 12
            }
        },
        icon = {
            padding_left = 10,
            padding_right = 5,
            string = icons.options,
            color = colors.frost_blue1,
            font = {
                size = 12
            }
        },
        background = {
            color = colors.bg1,
            height = 30,
            corner_radius = 25
        }
    }
)
spaces_indicator:subscribe(
    "swap_menus_and_spaces",
    function(env)
        local currently_on = (spaces_indicator:query()).icon.value == icons.arrow_right
        spaces_indicator:set(
            {
                icon = currently_on and icons.arrow_left or ""
            }
        )
    end
)
spaces_indicator:subscribe(
    "mouse.entered",
    function(env)
        local selected = env.SELECTED == "true"
        sbar.animate(
            "elastic",
            10,
            function()
                spaces_indicator:set(
                    {
                        background = {
                            color = {
                                alpha = 1
                            }
                        },
                        label = {
                            padding_right = 15,
                            padding_left = 5,
                            color = colors.frost_blue1,
                            string = "Menu",
                            font = {
                                size = 2
                            }
                        },
                        icon = {
                            padding_left = 10,
                            padding_right = 10,
                            color = colors.frost_light,
                            position = "center",
                            align = "center",
                            string = "􀰗",
                            font = {
                                size = 16
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
        local selected = env.SELECTED == "true"
        sbar.animate(
            "elastic",
            15,
            function()
                spaces_indicator:set(
                    {
                        background = {
                            width = "dynamic",
                            color = {
                                alpha = 1
                            }
                        },
                        label = {
                            padding_right = 10,
                            padding_left = 5,
                            color = colors.frost_light,
                            string = "Menu",
                            font = {
                                size = 12
                            }
                        },
                        icon = {
                            padding_left = 10,
                            padding_right = 5,
                            string = icons.options,
                            color = colors.frost_blue1,
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
    "mouse.clicked",
    function(env)
        local selected = env.SELECTED == "true"
        sbar.trigger("swap_menus_and_spaces")
        sbar.animate(
            "elastic",
            15,
            function()
                spaces_indicator:set({})
            end
        )
    end
)

return menu_watcher
