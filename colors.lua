return {
    black = 0xff141414,
    white = 0xff272826,
    foreground = 0xffb6b6b5,
    inactive_foreground = 0xff5c5c5c,

    red = 0xff732313,
    green = 0xff717f66,
    yellow = 0xff898862,
    orange = 0xff975338,
    blue = 0xff6d8690,
    magenta = 0xff5a525a,
    grey = 0xff32312f,



    transparent = 0x00000000,

    hover = 0xffffffff,
    grey2 = 0xff626262,
    grey3 = 0xff4e4e4e,
    grey4 = 0xff373737,
    grey5 = 0xff232323,

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
        bg = 0xff171717,
        bg3 = 0xff1c1c1c,
        bg2 = 0x32312f,
        transparent = 0xe61c1c1c,
        border = 0xD92525276,
        secondary = 0xff242424,
        white_transparent = 0x8faeaeae,
        inactive = 0xff727272,
    },
    popup = {
        bg = 0xd91c1c1c,
        border = 0xD95d5d5d,
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
