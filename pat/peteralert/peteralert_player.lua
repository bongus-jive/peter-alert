local peterAlerts = math.random(1, 8)
local peterTimer = math.random(60, 120)

function init()
	message.setHandler("PeterAlert.exe", peterAlert)
end

function update(dt)
	peterTimer = math.max(0, peterTimer - dt)
	if peterTimer == 0 then
		peterTimer = math.random(60, 120)
		if math.random(1, 3) == 1 then
			peterAlert()
		end
	end
end

function peterAlert()
	peterAlerts = (peterAlerts + 1) % 8
	local h = 8 * peterAlerts
	
	local peter = root.assetJson("/pat/peteralert/peteralert.config")
	peter.gui.panefeature.offset = {24 + h, -40 - h}
	player.interact("ScriptPane", peter)
end