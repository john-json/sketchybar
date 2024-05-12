-- Require the sketchybar module
sbar = require("sketchybar")

-- Set the bar name, if you are using another bar instance than sketchybar
-- sbar.set_bar_name("bottom_bar")

-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()
require("bar")

sbar.end_config()
-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()

require("default")

sbar.end_config()
-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()

require("items")
sbar.end_config()

-- Run the event loop of the sketchybar module (without this there will be no
-- callback functions executed in the lua module)
sbar.event_loop()
