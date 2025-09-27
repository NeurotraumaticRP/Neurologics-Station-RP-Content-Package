-- client side controller for fists, handles client to server networking and keybinds

Hook.Add("keyUpdate", "fistsKeybindListener", function()

    if PlayerInput.KeyHit(Keys.K) then -- we wont write a message at the moment since all we need is the client from the sent packet.
        local message = Networking.Start("attemptActivateFists")
        Networking.Send(message)
    end

end)

--[[Hook.Add("chatMessage", "ChangeKeybind", function(message, sender)
    print(Game.Client.Character.Name)
    if sender ~= Game.Client then return end
    local words = message:split(" ")
    if words[1] == "!fistskey" then
        local keyname = words[2]
        if keyname and #keyname == 1 then
            -- look up the value dynamically in the Keys table
            local key = Keys[keyname:upper()]
            if key then
                NeurologicsContent.Config.Fists = key
                Game.SendMessage("Fists keybind changed to " .. keyname:upper(),ChatMessageType.MessageBox, sender)
            else
                Game.SendMessage("Unknown key: " .. tostring(keyname),ChatMessageType.MessageBox, sender)
            end
        end
    end
end)]]