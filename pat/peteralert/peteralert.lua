function init()
	Canvas = widget.bindCanvas("ok")
	CanvasSize = Canvas:size()
	
	draw()
	
	if not config.getParameter("reopened") then
		pane.playSound("/pat/peteralert/open.ogg", 0, 0.75)
	end
end

function draw(pressed)
	Canvas:clear()
	Canvas:drawImage("/pat/peteralert/button"..(pressed and "_pressed.png" or ".png"), {0, 0}, 0.5)
end

function click(position, button, isButtonDown)
	if button ~= 0 then return end
	
	local inButton = position[1] > 0 and position[1] <= CanvasSize[1] and position[2] > 0 and position[2] <= CanvasSize[2]
	
	if isButtonDown and inButton then
		pane.playSound("/pat/peteralert/click.ogg", 0, 0.75)
	end
	
	if not isButtonDown or inButton then
		draw(isButtonDown)
		
		if not isButtonDown and lastButtonDown and inButton then
			CLOSED = true
			pane.dismiss()
		end
		
		lastButtonDown = isButtonDown
	end
	
	lastPosition = position
end

function uninit()
	if not CLOSED then
		local peter = root.assetJson("/pat/peteralert/peteralert.config")
		peter.gui.panefeature.offset = config.getParameter("gui").panefeature.offset
		peter.reopened = true
		player.interact("ScriptPane", peter)
	end
end
