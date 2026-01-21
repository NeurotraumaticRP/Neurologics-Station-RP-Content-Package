-- client side controller for Implants, handles client to server networking and keybinds

NeuroContent.Implants = {}

Hook.Add("keyUpdate", "implantsKeybindListener", function()

    if PlayerInput.KeyHit(Keys.K) and GUI.KeyboardDispatcher.Subscriber == nil then 
        local message = Networking.Start("ImplantNetworkEvent")
        message.WriteString("Fists")
        Networking.Send(message)
    end

end)
