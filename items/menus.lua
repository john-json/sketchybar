local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local apple = require("items.apple")

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
            drawing = false,
            icon = {
                drawing = false
            },
            background = {
                drawing = false
            },
            label = {
                padding_left = 5,
                padding_right = 5,
                color = colors.white,
                font = {
                    color = colors.white,
                    size = 12,
                    style = settings.font.style_map[i == 1 and "Bold" or "SemiBold"]
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
            alpha = 0,
            color = colors.bg1
        }
    }
)

local menu =
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
            menu:set(
                {
                    drawing = true
                }
            )
            local id = 1
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
                "/apple\\..*/",
                {
                    drawing = true
                }
            )

            sbar.set(
                "/menu\\..*/",
                {
                    drawing = false
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
                "/apple\\..*/",
                {
                    drawing = true
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

local menu_indicator =
    sbar.add(
    "item",
    {
        position = "left",
        align = "center",
        icon = {
            padding_left = 10,
            padding_right = 10,
            string = icons.swap,
            color = colors.orange,
            font = {
                size = 12
            }
        },
        background = {
            color = colors.bg1
        }
    }
)

menu_indicator:subscribe(
    "mouse.entered",
    function(env)
        sbar.trigger("swap_menus_and_spaces")
        local selected = env.SELECTED == "true"
        sbar.animate(
            "elastic",
            15,
            function()
                menu_indicator:set(
                    {
                        background = {
                            color = {
                                alpha = 1
                            }
                        },
                        icon = {
                            color = colors.orange,
                            font = {
                                size = 12
                            }
                        }
                    }
                )
            end
        )
        -- Animate the menu items when they show up
        for i = 1, max_items do
            local menu_item = menu_items[i]
            if menu_item:query().geometry.drawing == "on" then
                sbar.animate(
                    "elastic",
                    15,
                    function()
                        menu_item:set(
                            {
                                background = {
                                    color = {
                                        alpha = 1
                                    }
                                },
                                label = {
                                    color = colors.white,
                                    font = {
                                        size = 12,
                                        style = settings.font.style_map.SemiBold
                                    }
                                }
                            }
                        )
                    end
                )
            end
        end
    end
)
menu_indicator:subscribe(
    "mouse.exited",
    function(env)
        local selected = env.SELECTED == "true"
        sbar.animate(
            "elastic",
            15,
            function()
                menu_indicator:set(
                    {
                        background = {
                            color = {
                                alpha = 1
                            }
                        },
                        label = {
                            color = colors.gray,
                            font = {
                                size = 12
                            }
                        }
                    }
                )
            end
        )
        -- Animate the menu items when they show up
        for i = 1, max_items do
            local menu_item = menu_items[i]
            if menu_item:query().geometry.drawing == "on" then
                sbar.animate(
                    "elastic",
                    15,
                    function()
                        menu_item:set(
                            {
                                background = {
                                    color = {
                                        alpha = 1
                                    }
                                },
                                label = {
                                    color = colors.white,
                                    font = {
                                        size = 12,
                                        style = settings.font.style_map.SemiBold
                                    }
                                }
                            }
                        )
                    end
                )
            end
        end
    end
)

menu_indicator:subscribe(
    "mouse.clicked",
    function(env)
        local selected = env.SELECTED == "true"
        sbar.trigger("swap_menus_and_spaces")
        sbar.animate(
            "elastic",
            15,
            function()
                menu_indicator:set({})
            end
        )
    end
)

return menu_watcher
