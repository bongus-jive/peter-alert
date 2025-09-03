function init()
  Canvas = widget.bindCanvas("button")
  CanvasSize = Canvas:size()

  WindowScale = config.getParameter("gui.window.scale", 1)
  ButtonImages = config.getParameter("buttonImages")
  Sounds = config.getParameter("sounds")

  setPressed(false)

  if not widget.getData("_opened") then
    widget.setData("_opened", true)
    playSound("open")
  end
end

function click(mousePos, mouseButton, buttonDown)
  if mouseButton ~= 0 then return end

  if mousePos[1] <= 0 or mousePos[1] > CanvasSize[1]
  or mousePos[2] <= 0 or mousePos[2] > CanvasSize[2] then
    if IsPressed then setPressed(false) end
    return
  end
  
  if buttonDown then
    playSound("click")
  elseif IsPressed then
    CanDismiss = true
    pane.dismiss()
  end
  
  setPressed(buttonDown)
end

function setPressed(pressed)
  IsPressed = pressed
  drawButton()
end

function drawButton()
  local img = ButtonImages[IsPressed and "pressed" or "default"]
  Canvas:clear()
  Canvas:drawImage(img, { 0, 0 }, WindowScale)
end

function playSound(key)
  local sound = Sounds[key]
  if sound then
    pane.playSound(sound.file, 0, sound.volume)
  end
end

function uninit()
  if not CanDismiss then return reopen() end
end

function reopen()
  local peter = config.getParameter("")
  peter.gui._opened.data = true
  player.interact("ScriptPane", peter)
end
