function init()
	PaneConfig = root.assetJson("/pat/peteralert/peteralert.config")
	Position = PaneConfig.gui.panefeature.offset
	Stack = math.random(PaneConfig.stackMax)

	local minTime, maxTime = table.unpack(PaneConfig.timerRange)
	function randomTimer() return math.random(minTime, maxTime) end
	Timer = randomTimer()

	script.setUpdateDelta(PaneConfig.playerScriptDelta or 150)
	message.setHandler("PeterAlert.exe", peterAlert)
end

function update(dt)
	Timer = Timer - dt
	if Timer <= 0 then
		Timer = randomTimer()

		if math.random() <= PaneConfig.alertChance then
			peterAlert()
		end
	end
end

function peterAlert()
	Stack = (Stack + 1) % PaneConfig.stackMax

	PaneConfig.gui.panefeature.offset = {
		Position[1] + (PaneConfig.stackOffset[1] * Stack),
		Position[2] + (PaneConfig.stackOffset[2] * Stack),
	}

	player.interact("ScriptPane", PaneConfig)

	if window and window.flash then
		pcall(function() window.flash("briefly") end)
	end
end
