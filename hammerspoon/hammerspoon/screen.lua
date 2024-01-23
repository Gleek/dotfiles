local module = {}

module.toggleGray = function()
   hs.screen.setForceToGray(not hs.screen.getForceToGray())
end
return module
