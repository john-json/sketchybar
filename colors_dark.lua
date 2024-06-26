return {

    ------------------colors ---------------------
    ----------------------------------------------




    black = 0xff000000,
    white = 0xffffffff,
    red = 0xff814e4b,
    green = 0xff717f66,
    yellow = 0xff898862,
    orange = 0xff8f6441,
    blue = 0xff333847,
    magenta = 0xff434253,
    grey = 0xff313131,
    lightgray = 0xff808080,
    metalsaurus = 0xff5d5d5d,
    metalsaurus2 = 0xff344156,
    darkgrey = 0xff252525,

    ------------------color pallettes-------------
    ----------------------------------------------

    pallette = {



        grey2 = 0xff626262,
        grey3 = 0xff4e4e4e,
        grey4 = 0xff373737,
        grey5 = 0xff232323,


        stormcloud_one = 0xff516169,
        stormcloud_two = 0xffadb9bf,


        indigo_one = 0xff667287,
        indigo_two = 0xff424a57,
        indigo_three = 0xff3b424d,
        indigo_four = 0xff323841,
        indigo_five = 0xff323c49,
        indigo_six = 0xff272c33,



        dimgray_one = 0xffb5b5b5,
        dimgray_two = 0xff6d6d6b,



        slategrey_one = 0xff73868f,
        slategrey_two = 0xff5c6d75,
        slategrey_three = 0xff49575e,
        slategrey_four = 0xff39454a,



        granit_one = 0xff64655e,
        granit_two = 0xff4f514b,
        granit_three = 0xff373935,
        granit_four = 0xff272826,



        seezalt_spanishgrey = 0xff8f969e,
        seezalt_light = 0xffacaeb1,
        seezalt_dark = 0xff545454,
        seezalt_platinum = 0xffe5e5e5,

    },

    ------------------Basic colors-------------
    -------------------------------------------

    bar = {
        bg = 0xff1c1c1c,
        sub = 0xffc5c5c5,
        selected = 0xff593c3c,
        transparent = 0x00000000,
        border = 0xff32312f,
        secondary = 0xff61817f,
        white_transparent = 0x8faeaeae,
        inactive = 0xff727272,
        icons = 0xff61817f,
        foreground_alt = 0xff61817f,
        foreground_dimmed = 0xff654242,
        bg2 = 0xff547573,
        hover = 0x66ffffff,
    },
    popup = {
        bg = 0xd9191919,
        border = 0xD93f3f3f,
        icons = 0xff547573,
        slider = 0xff547573,
        slider_bg = 0xff252525,
    },
    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color and 0x001e1e1e) or (math.floor(alpha * 255.0) < 24)
    end
}
