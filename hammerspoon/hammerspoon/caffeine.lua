local menu = hs.menubar.new(true, "caffeine")
local icons = {}

for _, state in ipairs({"on", "off"}) do
   local canvas = hs.canvas.new({x = 0, y = 0, w = 20, h = 20})
   canvas:canvasDefaultFor("strokeColor", {white = state == "on" and 1 or 0.5})
   canvas:canvasDefaultFor("strokeWidth", 1.8)
   canvas:canvasDefaultFor("action", "stroke")
   canvas:appendElements(
      {type = "rectangle", frame = {x = 12, y = 6, w = 5, h = 6},
       roundedRectRadii = {xRadius = 2, yRadius = 2}},
      {type = "rectangle", frame = {x = 3, y = 5, w = 10, h = 10},
       roundedRectRadii = {xRadius = 2, yRadius = 2}},
      {type = "segments", coordinates = {{x = 2, y = 18}, {x = 15, y = 18}}}
   )
   icons[state] = canvas:imageFromCanvas()
   canvas:delete()
end

local function update()
   local enabled = hs.caffeinate.get("systemIdle")
   menu:setIcon(icons[enabled and "on" or "off"], false)
   menu:setTooltip(enabled and "Caffeinate on: click to turn off" or "Caffeinate off: click to turn on")
end

menu:setClickCallback(function()
   hs.caffeinate.toggle("systemIdle")
   update()
end)
update()

return menu
