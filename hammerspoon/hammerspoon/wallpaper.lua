local module = {}

-- -- Function to loop over all spaces and set the wallpaper
-- module.resetWallpaper = function()
--    local imagePath = "~/Pictures/The_Lake-6.jpg"
--    local screens = hs.screen.allScreens()
--    for _, screen in ipairs(screens) do
--       hs.screen.find(screen):desktopImageURL("file://" .. imagePath)
--    end
-- end


-- Function to loop over all spaces on a given screen and set the wallpaper
function setWallpapersForScreen(screen, imagePath)
    local screenSpaces = hs.fnutils.filter(hs.spaces.allSpaces(), function(space)
        return hs.screen.find(space["screenID"]) == screen
    end)

    for _, space in ipairs(screenSpaces) do
        hs.screen.find(space["screenID"]):desktopImageURL("file://" .. imagePath)
    end
end

-- Function to loop over all screens and set the wallpaper for each screen
module.resetWallpaper = function()
   hs.dialog.blockAlert("Doesn't work", "Resetting wallpaper doesn't work yet!!")
   return
    -- local imagePath = "/Users/umar/Pictures/The_Lake-6.jpg"
    -- local spaces = hs.spaces.allSpaces()
    -- for _, space in ipairs(spaces) do
    --    hs.spaces.changeToSpace(space['id'])
    --    hs.screen.find(space["screenID"]):desktopImageURL("file://" .. imagePath)
    -- end

end

return module
