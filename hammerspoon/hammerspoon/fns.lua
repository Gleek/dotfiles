-- Interactive fns to be called directly or binded

-- open each module
-- iterate overall all functions
--

local module = {}
local imports = {"yabai", "hhann"}

local log = hs.logger.new('', 'debug');
local mapping = {}
local chooser = {}

local populatePairs = function()
   for _, import in pairs(imports) do
      local required = require(import)
      local interactives = {}
      local useInteractive = false
      if required.interactives then
         for _, value in pairs(required.interactives) do
            interactives[value] = true
            useInteractive = true
         end
      end
      for key, value in pairs(required) do
         if type(value) == "function" then
            if (useInteractive and interactives[key]) or not useInteractive then
               mapping[import..".".. key] = value
            end
         end
      end
   end
end

local runCommand = function(selectedTable)
   chooser:hide()
   if selectedTable then  module.exec(selectedTable.text) end
end

local commandList = function()
   local choices = {}
   for  key,_ in pairs(mapping) do
      table.insert(choices, {text=key})
   end
   return choices
end


module.choose = function()
   populatePairs()
   chooser = hs.chooser.new(runCommand)
   chooser:choices(commandList)
   chooser:show()
end


module.dump = function()
   populatePairs()
   for key, _ in pairs(mapping) do
      print(key)
   end
end

module.exec = function(selected)
   if selected then  mapping[selected]() end
end





return module
