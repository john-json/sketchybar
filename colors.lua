return {
  black = 0xff080808,
  white = 0x99D9E0E3,
  red = 0xffBF616A,
  green = 0xffA3BE8C,
  blue = 0xff8798A1,
  yellow = 0xff9F7F37,
  orange = 0xff3b3f46,
  magenta = 0xffB48EAD,
  grey = 0xff606060,
  transparent = 0x00000000,
  border = 0x3bD9E0E3,
  border2 = 0x3b000000,

  bar = {
    bg = 0xfa1e1e1e,
    border = 0xffD9E0E3,
  },
  popup = {
    bg = 0xff2e2e2e,
    border = 0x3bD9E0E3,
  },
  bg1 = 0xff1e1e1e,
  bg2 = 0xff2e2e2e,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
