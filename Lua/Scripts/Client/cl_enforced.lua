if SERVER then return end
if Game.IsSingleplayer then return end

local message = Networking.Start("client_side_enforced")
Networking.Send(message)