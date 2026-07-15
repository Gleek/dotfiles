local module = {}

local orgClockMenu = hs.menubar.new(true, "org-clock-current-task")
local emacsclientPath = "/opt/homebrew/bin/emacsclient"
local timer = nil
local maxTaskChars = 10
local fallbackTitlePrefix = "◷ "
local clockIcon = hs.image.imageFromPath(hs.configdir .. "/org-clock-template.svg")

if clockIcon then
   clockIcon:size({w = 14, h = 14}, true):template(true)
end

local function cleanEmacsOutput(output)
   return (output or "")
      :gsub("%s+$", "")
      :gsub('^"', "")
      :gsub('"$', "")
      :gsub("^%s+", "")
end

local function truncateTask(task)
   local len = utf8 and utf8.len(task)
   if not len or len <= maxTaskChars then
      return task
   end

   local nextCharIndex = utf8.offset(task, maxTaskChars + 1)
   if not nextCharIndex then
      return task
   end

   return task:sub(1, nextCharIndex - 1) .. "…"
end

local function updateOrgClock()
   local elispExpr = [[
(if (and (fboundp 'org-clocking-p) (org-clocking-p))
    (substring-no-properties org-clock-current-task)
  "")
]]

   hs.task.new(emacsclientPath, function(exitCode, stdOut, _stdErr)
      if not orgClockMenu then
         return
      end

      if exitCode ~= 0 then
         orgClockMenu:setIcon(nil)
         orgClockMenu:setTitle("")
         return
      end

      local currentTask = cleanEmacsOutput(stdOut)
      if currentTask == "" then
         orgClockMenu:setIcon(nil)
         orgClockMenu:setTitle("")
      else
         if clockIcon then
            orgClockMenu:setIcon(clockIcon, true)
            orgClockMenu:setTitle(" " .. truncateTask(currentTask))
         else
            orgClockMenu:setTitle(fallbackTitlePrefix .. truncateTask(currentTask))
         end
      end
   end, {"--eval", elispExpr}):start()
end

function module.start()
   if not orgClockMenu then
      return
   end

   updateOrgClock()

   if timer then
      timer:stop()
   end
   timer = hs.timer.doEvery(30, updateOrgClock)
end

return module
