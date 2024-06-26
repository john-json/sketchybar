use framework "AppKit"
use scripting additions

-- Function to check current interface style
on getInterfaceStyle()
    tell application "System Events"
        tell appearance preferences
            return dark mode
        end tell
    end tell
end getInterfaceStyle

-- Main loop to monitor changes
repeat
    set currentMode to getInterfaceStyle()
    delay 10 -- Check every 10 seconds

    if (currentMode is not getInterfaceStyle()) then
        do shell script "/usr/local/bin/brew services restart sketchybar" with administrator privileges
    end if
end repeat
