local module = {}

local DURATION = 1
local apps = {"Firefox", "kitty", "Emacs"}
local timer = {}
local onKeyDown = function()
   local app = hs.application.frontmostApplication()
   for _, appName in pairs(apps) do
      if app:name() == appName then
         timer = hs.timer.delayed.new(DURATION, module.killCurrentApp)
         timer.start()
         return
      end
   end
   module.killCurrentApp()
end

local onKeyUp = function()
   if timer:running() then
      timer:stop()
      local app = hs.application.frontmostApplication()
      hs.alert.show("Hold ⌘Q to quit " .. app:name())
   end
end


module.killCurrentApp = function()
   local app = hs.application.frontmostApplication()
   app:kill()
end

module.bind = function()
   local bind = hs.hotkey.bind("cmd", "q", function() onKeyDown() end, function() onKeyUp() end)
   local wf=hs.window.filter
   local ignoreWF = wf.new("Emacs")
   ignoreWF:subscribe(wf.windowFocused, function()
                        bind:disable()
   end):subscribe(wf.windowUnfocused, function()
                     bind:enable()
                 end)
end


return module
