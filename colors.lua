return {
    black = 0xff141414,
    white = 0xffcecece,
    foreground_light = 0xffa0a0a0,
    foreground = 0xff444444,
    inactive_foreground = 0xff5c5c5c,


    red = 0xff814e4b,
    red_faded = 0x66814e4b,
    green = 0xff717f66,
    yellow = 0xff898862,
    orange = 0xff8f6441,
    orange_inactive = 0x4D8f6441,
    orange_alt = 0xff975338,
    blue = 0xff333847,
    magenta = 0xff434253,
    grey = 0xff313131,
    lightgray = 0xff808080,
    metalsaurus = 0xff5d5d5d,
    metalsaurus2 = 0xff344156,
    selected = 0xff3e3e3e,
    darkgrey = 0xff252525,
    ebony = 0xff5d5d5d,



    transparent = 0x00000000,

    hover = 0xffffffff,
    grey2 = 0xff626262,
    grey3 = 0xff4e4e4e,
    grey4 = 0xff373737,
    grey5 = 0xff232323,

    stormcloud = {
        one = 0xff516169,
        two = 0xffadb9bf,
    },
    indigo = {
        one = 0xff667287,
        two = 0xff424a57,
        three = 0xff3b424d,
        four = 0xff323841,
        five = 0xff323c49,
        six = 0xff272c33
    },

    dimgray = {
        one = 0xffb5b5b5,
        two = 0xff6d6d6b,
    },

    slategray = {
        one = 0xff73868f,
        two = 0xff5c6d75,
        three = 0xff49575e,
        four = 0xff39454a,
    },

    granit = {
        one = 0xff64655e,
        two = 0xff4f514b,
        three = 0xff373935,
        four = 0xff272826,
    },

    seezalt = {
        spanishgrey = 0xff8f969e,
        light = 0xffacaeb1,
        dark = 0xff545454,
        platinum = 0xffe5e5e5,
    },
    bar = {
        bg = 0xff1c1c1c,
        bg3 = 0xff1e1e1e1e,
        bg2 = 0x00000000,
        selected = 0xff232323,
        transparent = 0xe61c1c1c,
        border = 0xff565656,
        secondary = 0xff242424,
        white_transparent = 0x8faeaeae,
        inactive = 0xff727272,
        icons = 0xff61817f,
        foreground_alt = 0xff8da2b1,
        foreground_alt_blue = 0xff7c879e,
    },
    popup = {
        bg = 0xd9191919,
        border = 0xD93f3f3f,
    },
    bg1 = 0xff1c1c1c,
    bg2 = 0xff242424,
    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color and 0x001e1e1e) or (math.floor(alpha * 255.0) < 24)
    end
}
