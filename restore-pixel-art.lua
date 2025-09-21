-- Pixel Art Repair Helper Script (v5 - Resize Only)
-- This script ONLY performs the resizing step, because the color mode change is bugged
-- on your specific compiled version of Aseprite.

local dlg = Dialog {
  title = "Step 1: Resize Image"
}

dlg
  :number {
    id = "pixel_sizea",
    label = "Detected Pixel Block Size:",
    text = "9", -- Defaulted to the value from your image
    decimals = 0
  }
  :separator()
  :label {
    text = "This script will downscale your image to its original pixel art size."
  }
  :label {
    text = "After this, you must MANUALLY change the color mode."
  }
  :separator()
  :button {
    id = "ok",
    text = "Run Resize",
    focus = true,
    onclick = function()
      local sprite = app.activeSprite
      if not sprite then
        app.alert("There is no active sprite to process.")
        return
      end

      local args = dlg.data
      local pixelSize = tonumber(args.pixel_size)

      if pixelSize <= 1 then
        app.alert("Pixel size must be greater than 1.")
        return
      end

      -- This is a single, safe operation.
      local oldWidth = sprite.width
      local oldHeight = sprite.height
      local newWidth = math.floor(oldWidth / pixelSize)
      local newHeight = math.floor(oldHeight / pixelSize)
      sprite:resize(newWidth, newHeight)

      app.refresh()
      dlg:close()
    end
  }
  :button {
    id = "cancel",
    text = "Cancel"
  }

dlg:show { wait = false }