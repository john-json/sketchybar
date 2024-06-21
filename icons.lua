local settings = require("settings")

local icons = {
    sf_symbols = {
        plus = "􀅼",
        plus2 = "􀃝",
        loading = "􀖇",
        apple = "􀣺",
        line = "􀝷",
        gear = "􀍟",
        cpu = "􀧓",
        clipboard = "􀉄",
        aqi = "􀴿",
        bookmark = "􀉟",
        clock = "􀐫",
        Tornado = "􁛴",
        arrow_circle_down = "􀁱",
        pill = "􀝷",
        pill_lines = "􀝶",
        stack = "􀐋",
        stack_right = "􀧏",
        direct_current = "􀯝",
        rotate_circle = "􁱀",
        arrow_down = "􀆈",
        arrow_left = "􀁙",
        arrow_right = "􀆊",
        arrow_up = "􀆇",
        menu_bar2 = "􀾚",
        menu_bar = "􀾩",
        active_space = "􀯺",
        inactive_space = "􀯺",
        spaces = "􁏮",
        menu = "􀱢",
        space_control2 = "􀚅",
        space_control = "􀫲",
        space_control4 = "􁈔",
        space_control3 = "􀚅",
        space_add = "􀁍",
        m_control = "􁻻",
        menu_alt = "􀱢",
        menu_alt_dots = "􀈏",
        settings = "􀍠",
        MC1 = "􀏪",
        stack1 = "􀏲",
        line_menu = "􀌇",
        line_menu_circle = "􀧲",
        new_space = "􀑎",
        MC_round = "􀚅",
        MC_round3 = "􂁁",
        MC_add = "􂇓",
        MC_round2 = "􀍢",
        drop = "􁹡",
        drop_start = "􀌝",
        drop_start_riv = "􀶡",
        cpu2 = "􀎴",
        circle_options = "􀆕",
        circle_menu = "􀌉",
        circle_quit = "􀁑",
        play = "􀊄",
        swap2 = "􀊞",
        swap = "􁏰",
        switch = {
            on = "􀯻",
            off = "􀯶"
        },
        volume = {
            _100 = "􀊩",
            _66 = "􀊩",
            _33 = "􀊧",
            _10 = "􀊥",
            _0 = "􀊣"
        },
        battery = {
            _100 = "􀛨",
            _75 = "􀺸",
            _50 = "􀺶",
            _25 = "􀛩",
            _0 = "􀛪",
            charging = "􀢋"
        },
        wifi = {
            upload = "􀄨",
            download = "􀄩",
            connected = "􀙇",
            disconnected = "􀙈",
            router = "􁓤"
        },
        media = {
            back = "􀊊",
            forward = "􀊌",
            play_pause = "􀊈"
        }
    },
    -- Alternative NerdFont icons
    nerdfont = {
        plus = "",
        loading = "",
        apple = "",
        gear = "",
        cpu = "",
        clipboard = "Missing Icon",
        switch = {
            on = "􁏮",
            off = "􁏯"
        },
        volume = {
            _100 = "􀊩",
            _66 = "􀊩",
            _33 = "􀊧",
            _10 = "􀊥",
            _0 = "􀊣"
        },
        battery = {
            _100 = "",
            _75 = "",
            _50 = "",
            _25 = "",
            _0 = "",
            charging = ""
        },
        wifi = {
            upload = "",
            download = "",
            connected = "󰖩",
            disconnected = "󰖪",
            router = "Missing Icon"
        },
        media = {
            back = "",
            forward = "",
            play_pause = ""
        }
    }
}

if not (settings.icons == "NerdFont") then
    return icons.sf_symbols
else
    return icons.nerdfont
end
