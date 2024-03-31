local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", { width = 5 })

local apple = sbar.add("item", {
  icon = {
    font = { size = 12.0 },
    string = icons.aqi,
    padding_right = 8,
    padding_left = 8,
    color = colors.yellow,
    width = 50,
  },
  label = { drawing = false },
  background = {
    color = colors.transparent,
    border_color = colors.transparent,
    border_width = 0,
  },
  padding_left = 1,
  padding_right = 1,
  click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})

-- Double border for apple using a single item bracket
sbar.add("bracket", { apple.name }, {
  background = {
    color = colors.transparent,
    height = 28,
    border_color = colors.transparent,
    border_width = 0,
  }
})

-- Padding item required because of bracket
sbar.add("item", { width = 7 })
