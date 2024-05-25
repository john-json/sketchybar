local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binaries for CPU and memory usage
sbar.exec(
    "killall cpu_load mem_free >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0"
)
sbar.exec("killall mem_free >/dev/null; $CONFIG_DIR/helpers/event_providers/mem_free/bin/mem_free mem_update 2.0")

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
            string = icons.cpu2,
            padding_right = 20,
            padding_left = 0,
            align = "center",
            color = colors.frost_blue1,
            font = {
                size = 25
            }
        },
        label = {
            position = "center",
            color = colors.frost_blue1,
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

local mem =
    sbar.add(
    "graph",
    "widgets.mem",
    42,
    {
        position = "right",
        graph = {
            color = colors.green
        },
        background = {
            color = colors.bg1,
            border_color = {
                alpha = 0
            },
            drawing = true
        },
        icon = {
            string = icons.memory,
            padding_right = 20,
            padding_left = 0,
            align = "center",
            color = colors.frost_blue1,
            font = {
                size = 25
            }
        },
        label = {
            position = "center",
            color = colors.frost_blue1,
            padding_right = 15,
            string = "mem ??GB",
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

mem:subscribe(
    "mem_update",
    function(env)
        local mem_free = tonumber(env.mem_free)
        local mem_used = tonumber(env.mem_used)
        mem:push({mem_used / 100.})

        local color = colors.green
        if mem_used > 30 then
            if mem_used < 60 then
                color = colors.frost_light
            elseif mem_used < 80 then
                color = colors.frost_blue1
            else
                color = colors.frost_blue4
            end
        end

        mem:set(
            {
                graph = {
                    color = colors.bg1
                },
                label = "mem " ..
                    string.format("%.2f", mem_used / 1024) ..
                        "GB used, " .. string.format("%.2f", mem_free / 1024) .. "GB free"
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

mem:subscribe(
    "mouse.clicked",
    function(env)
        sbar.exec("open -a 'Activity Monitor'")
    end
)

-- Background around the cpu and mem items
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

sbar.add(
    "bracket",
    "widgets.mem.bracket",
    {mem.name},
    {
        background = {
            color = colors.transparent,
            border_width = 0
        }
    }
)

-- Padding items
sbar.add(
    "item",
    "widgets.cpu.padding",
    {
        position = "right",
        width = settings.group_paddings
    }
)

sbar.add(
    "item",
    "widgets.mem.padding",
    {
        position = "right",
        width = settings.group_paddings
    }
)
