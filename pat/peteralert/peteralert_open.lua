local id = player.id()
if id ~= 0 then
  world.sendEntityMessage(id, "PeterAlert.exe")
end
