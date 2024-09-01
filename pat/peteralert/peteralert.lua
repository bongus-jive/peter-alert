function init()
	Canvas = widget.bindCanvas("button")
	CanvasSize = Canvas:size()

	BoxScale = config.getParameter("gui").box.scale or 1
	ButtonImages = config.getParameter("buttonImages")
	Sounds = config.getParameter("sounds")

	setPressed(false)
	
	if not config.getParameter("reopened") then
		playSound("open")
	end
end

function click(mousePos, mouseButton, buttonDown)
	if mouseButton ~= 0 then
		return
	end
	
	if mousePos[1] <= 0 or mousePos[1] > CanvasSize[1]
	or mousePos[2] <= 0 or mousePos[2] > CanvasSize[2] then
		if ButtonPressing then
			setPressed()
		end
		return
	end
	
	if buttonDown then
		setPressed(true)
		playSound("click")
	elseif ButtonPressing then
		setPressed(false)
		reopen = n
		pane.dismiss()
	end
end

function setPressed(pressed)
	ButtonPressing = pressed
	drawButton(pressed)
end

function drawButton(pressed)
	local img = ButtonImages[pressed and "pressed" or "default"]
	Canvas:clear()
	Canvas:drawImage(img, {0, 0}, BoxScale)
end

function playSound(key)
	local sound = Sounds[key]
	if sound then
		pane.playSound(sound.file, 0, sound.volume)
	end
end

function dismissed()
	if type(reopen) == "function" then
		reopen()
	end
end

function reopen()
	local peter = config.getParameter("")
	peter.reopened = true
	player.interact("ScriptPane", peter)
end

