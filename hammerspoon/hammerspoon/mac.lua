local module = {}

module.lockScreen = function()
    hs.caffeinate.lockScreen()
    hs.caffeinate.systemSleep()
end

module.toggleDarkMode = function()
    hs.applescript.applescript([[
    tell application "System Events"
        tell appearance preferences
            set dark mode to not dark mode
        end tell
    end tell
    ]])
end

return module
