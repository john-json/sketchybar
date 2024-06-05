local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu =
    sbar.add(
    "graph",
    "widgets.cpu",
    42,
    {
        position = "right",
        graph = {
            color = colors.blue
        },
        background = {
            color = colors.bg1,
            border_color = {
                alpha = 0
            },
            drawing = true
        },
        icon = {
            string = "􀼣",
            padding_right = 25,
            padding_left = 5,
            align = "center",
            color = colors.frost_blue1,
            font = {
                size = 12
            }
        },
        label = {
            position = "center",
            color = colors.frost_light,
            padding_right = 15,
            string = "cpu ??%",
            font = {
                family = settings.font.text,
                style = settings.font.style_map["SemiBold"],
                size = 12
            },
            align = "right",
            width = 10,
            y_offset = 0
        }
    }
)

cpu:subscribe(
    "cpu_update",
    function(env)
        -- Also available: env.user_load, env.sys_load
        local load = tonumber(env.total_load)
        cpu:push({load / 100.})

        local color = colors.green
        if load > 30 then
            if load < 60 then
                color = colors.frost_light
            elseif load < 80 then
                color = colors.frost_blue1
            else
                color = colors.frost_blue4
            end
        end

        cpu:set(
            {
                graph = {
                    color = colors.bg1
                },
                label = "cpu " .. env.total_load .. "%"
            }
        )
    end
)

cpu:subscribe(
    "mouse.clicked",
    function(env)
        sbar.exec("open -a 'Activity Monitor'")
    end
)

-- Background around the cpu item
sbar.add(
    "bracket",
    "widgets.cpu.bracket",
    {cpu.name},
    {
        background = {
            color = colors.transparent,
            border_width = 0
        }
    }
)

-- Background around the cpu item
sbar.add(
    "item",
    "widgets.cpu.padding",
    {
        position = "right",
        width = "dynamic"
    }
)
