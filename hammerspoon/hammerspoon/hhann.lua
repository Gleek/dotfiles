-- https://github.com/szymonkaliski/hhann
local cache = {}
local module = {cache = cache}

-- Add a flag for eraser mode
cache.isErasing = false


module.interactives = {"start", "exit", "changeToGreen", "changeToRed",
                       "changeToBlue", "clear", "activateEraser",
                       "deactivateEraser"}

local COLOR = {red = 200, green = 0, blue = 0, alpha = 0.8}
local COLOR_DIM = {red = 200, green = 0, blue = 0, alpha = 0.4}

local STROKE_WIDTH = 10

-- grabs screen with active window, unless it's Finder's desktop - then defaults to mouse position
local activeScreen = function()
    local activeWindow = hs.window.focusedWindow()

    if activeWindow and activeWindow:role() ~= "AXScrollArea" then
        return activeWindow:screen()
    else
        return hs.mouse.getCurrentScreen()
    end
end

local moveIndicator = function(x, y)
    if cache.isErasing then
        cache.canvas[1].frame = {x = x + 6, y = y - 18, w = 20, h = 24}
    else
        cache.canvas[1].center = {x = x + 6, y = y - 6}
    end
end

local updateMode = function()
    local color = cache.isAnnotating and COLOR or COLOR_DIM

    cache.canvas[1] = cache.isErasing and {
        type = "text",
        text = "E",
        textSize = 18,
        textColor = color
    } or {
        type = "circle",
        radius = 3,
        action = "fill",
        fillColor = color
    }
    local mouse = hs.mouse.getRelativePosition()
    moveIndicator(mouse.x, mouse.y)
end

local updateColor = function(r, g, b)
    COLOR["red"] = r
    COLOR["green"] = g
    COLOR["blue"] = b

    COLOR_DIM["red"] = r
    COLOR_DIM["green"] = g
    COLOR_DIM["blue"] = b
    updateMode()
    -- If currently erasing, turn off eraser mode
    if cache.isErasing and module.deactivateEraser then
        module.deactivateEraser()
    end
end

module.changeToGreen = function()
    updateColor(0, 200, 0)
end

module.changeToRed = function()
    updateColor(200, 0, 0)
end

module.changeToBlue = function()
    updateColor(0, 0, 200)
end

module.changeToYellow = function()
    updateColor(200, 200, 0)
end

module.changeToWhite = function()
    updateColor(200, 200, 200)
end


module.increaseStrokeWidth = function()
    if STROKE_WIDTH >= 100 then
        return
    end
    STROKE_WIDTH = STROKE_WIDTH + 2
end

module.decreaseStrokeWidth = function()
    if STROKE_WIDTH <= 2 then
        return
    end
    STROKE_WIDTH = STROKE_WIDTH - 2
end

module.startAnnotating = function()
    local currentElementIndex = nil
    local upsertCurrentDrawing = function(x, y, addNew)
        table.insert(cache.currentSegments, {x = x, y = y})
        if addNew then
            cache.canvas:insertElement({
                type = "segments",
                coordinates = cache.currentSegments,
                action = "stroke",
                strokeColor = COLOR,
                strokeWidth = STROKE_WIDTH
            }, #cache.canvas + 1)
            currentElementIndex = #cache.canvas
        else
            if currentElementIndex then
                cache.canvas[currentElementIndex].coordinates = cache.currentSegments
            end
        end
    end

    cache.canvas:canvasMouseEvents(false, false, false, true):mouseCallback(
        function(_, _, _, _, _) end
    )

    cache.tapDrag = hs.eventtap.new(
        {
            hs.eventtap.event.types.leftMouseDown,
            hs.eventtap.event.types.leftMouseDragged,
            hs.eventtap.event.types.leftMouseUp
        },
        function(e)
            local frame = cache.canvas:frame()
            local eventType = e:getType()
            local eventLocation = e:location()
            local x = eventLocation["x"] - frame.x
            local y = eventLocation["y"] - frame.y

            if eventType == hs.eventtap.event.types.leftMouseDown then
                cache.currentSegments = {}
                upsertCurrentDrawing(x, y, true)
            elseif eventType == hs.eventtap.event.types.leftMouseDragged then
                upsertCurrentDrawing(x, y, false)
            elseif eventType == hs.eventtap.event.types.leftMouseUp then
                currentElementIndex = nil
            end

            moveIndicator(x, y)
        end
    )

    cache.tapDrag:start()
    cache.isAnnotating = true
    updateMode()
end

module.stopAnnotating = function()
    if cache.canvas then
        cache.canvas:canvasMouseEvents(false, false, false, false):mouseCallback(nil)
    end

    if cache.tapDrag then
        cache.tapDrag:stop()
        cache.tapDrag = nil
    end

    cache.isAnnotating = false

    updateMode()
end

local setup = function()
    if not cache.canvas then
        cache.canvas =
            hs.canvas.new({x = 0, y = 0, w = 0, h = 0}):level(hs.canvas.windowLevels.overlay):behavior(
            {
                hs.canvas.windowBehaviors.transient,
                hs.canvas.windowBehaviors.moveToActiveSpace
            }
        )
    end

    local screen = activeScreen()

    cache.canvas:size(screen:frame()):frame(screen:frame()):show()

    cache.currentId = math.max(#cache.canvas, 1)

    if cache.tapMove then
        cache.tapMove:stop()
    end

    cache.tapMove =
        hs.eventtap.new(
        {
            hs.eventtap.event.types.mouseMoved
        },
        function(e)
            local frame = cache.canvas:frame()
            local eventLocation = e:location()
            local x = eventLocation["x"] - frame.x
            local y = eventLocation["y"] - frame.y

            if cache.canvas[1] then
                moveIndicator(x, y)
            end
        end
    )

    cache.tapMove:start()

    updateMode()
end

module.start = function()
    setup()
    module.startAnnotating()
end

module.exit = function()
    module.hide()
    module.stopAnnotating()
end

module.clear = function()
    if cache.canvas then
        local wasAnnotating = cache.isAnnotating

        if wasAnnotating then
            module.stopAnnotating()
        end

        cache.canvas:delete()
        cache.canvas = nil

        setup()

        if wasAnnotating then
            module.startAnnotating()
        end
    end
end

module.toggleAnnotating = function()
    if cache.isAnnotating then
        module.stopAnnotating()
    else
        module.startAnnotating()
    end
end

module.hide = function()
    cache.canvas:hide()
    cache.tapMove:stop()
end

module.stop = function()
    if cache.canvas then
        cache.canvas:delete()
        cache.canvas = nil
    end

    if cache.tapDrag then
        cache.tapDrag:stop()
        cache.tapDrag = nil
    end

    if cache.tapMove then
        cache.tapMove:stop()
        cache.tapMove = nil
    end
end

-- Eraser handler
local eraserCallback = function(canvasObj, message, id, x, y)
    print("Eraser callback:", message, id, "x=", x, "y=",y)
    if not cache.isErasing then return end
    if message ~= "mouseDown" then return end
    if type(x) ~= "number" or type(y) ~= "number" then return end
    for i = #cache.canvas, 1, -1 do
        local stroke = cache.canvas[i]
        if type(stroke) == "table" and stroke.type == "segments" and stroke.coordinates then
            for _, point in ipairs(stroke.coordinates) do
                local dx = point.x - x
                local dy = point.y - y
                local dist = math.sqrt(dx * dx + dy * dy)
                if dist < (stroke.strokeWidth or 10) then
                    cache.canvas:removeElement(i)
                    updateMode()
                    return
                end
            end
        end
    end
end

-- Activate Eraser mode
module.activateEraser = function()
    cache.isErasing = true
    if cache.tapDrag then
        cache.tapDrag:stop()
        cache.tapDrag = nil
    end
    cache.canvas:canvasMouseEvents(true, false, false, false):mouseCallback(eraserCallback)
    updateMode()
end

-- Deactivate Eraser mode
module.deactivateEraser = function()
    cache.isErasing = false
    cache.canvas:canvasMouseEvents(false, false, false, false):mouseCallback(nil)
    -- Optionally restore annotation state
    if cache.isAnnotating then
        module.startAnnotating()
    else
        updateMode()
    end
end

return module
