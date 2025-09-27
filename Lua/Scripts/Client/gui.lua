--[[local modPath = ...

-- our main frame where we will put our custom GUI
local frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
frame.CanBeFocused = false

-- menu frame
local menu = GUI.Frame(GUI.RectTransform(Vector2(1, 1), frame.RectTransform, GUI.Anchor.Center), nil)
menu.CanBeFocused = false
menu.Visible = false

-- put a button that goes behind the menu content, so we can close it when we click outside
local closeButton = GUI.Button(GUI.RectTransform(Vector2(1, 1), menu.RectTransform, GUI.Anchor.Center), "", GUI.Alignment.Center, nil)
closeButton.OnClicked = function ()
    menu.Visible = not menu.Visible
end

-- a button top right of our screen to open a sub-frame menu
local button = GUI.Button(GUI.RectTransform(Vector2(0.2, 0.2), frame.RectTransform, GUI.Anchor.TopRight), "Custom GUI Example", GUI.Alignment.Center, "GUIButtonSmall")
button.RectTransform.AbsoluteOffset = Point(25, 70)
button.OnClicked = function ()
    menu.Visible = not menu.Visible
end

local menuContent = GUI.Frame(GUI.RectTransform(Vector2(0.2, 0.3), menu.RectTransform, GUI.Anchor.TopRight))
local menuList = GUI.ListBox(GUI.RectTransform(Vector2(1, 1), menuContent.RectTransform, GUI.Anchor.BottomCenter))
menuContent.RectTransform.AbsoluteOffset = Point(25, 95)
menuList.Spacing = 19

local rolebanDropDown = GUI.DropDown(GUI.RectTransform(Vector2(1, 0.05), menuList.Content.RectTransform), "Select a Role", 3, nil, false)
rolebanDropDown.Visible = false
rolebanDropDown.AddItem("Captain", 0)
rolebanDropDown.AddItem("Crew", 1)
rolebanDropDown.AddItem("Guard", 2)
rolebanDropDown.AddItem("Warden", 3)
rolebanDropDown.AddItem("Doctor", 4)
rolebanDropDown.AddItem("Scientist", 5)
rolebanDropDown.AddItem("Staff", 6)
rolebanDropDown.AddItem("Janitor", 7)
rolebanDropDown.AddItem("Prisoner", 8)
rolebanDropDown.OnSelected = function (guiComponent, object) end

local punishmentTypeDropDown = GUI.DropDown(GUI.RectTransform(Vector2(1, 0.05), menuList.Content.RectTransform), "Select a punishment type", 3, nil, false)
punishmentTypeDropDown.ListBox.RectTransform.Resize(Vector2(1, 3),false)
punishmentTypeDropDown.AddItem("Ban", 0)
punishmentTypeDropDown.AddItem("Kick", 1)
punishmentTypeDropDown.AddItem("Warn", 2)
punishmentTypeDropDown.AddItem("Roleban", 3)
punishmentTypeDropDown.OnSelected = function (guiComponent, object)
    if guiComponent.UserData == 3 then
        if not rolebanDropDown then return end
        rolebanDropDown.Visible = true
        --rolebanDropDown.RectTransform.RepositionChildInHierarchy(3)
        if rolebanDropDown then
            rolebanDropDown.Visible = false
        end
    end
end

local clientSelectDropDown = GUI.DropDown(GUI.RectTransform(Vector2(1, 0.05), menuList.Content.RectTransform), "Select a Player", 3, nil, false)
for i,client in pairs(Client.ClientList) do
    clientSelectDropDown.AddItem(client.Name, client.SteamID, tostring(client.SteamID))
end
clientSelectDropDown.OnSelected = function (guiComponent, object)
end

local textBox = GUI.TextBox(GUI.RectTransform(Vector2(1, 0.2), menuList.Content.RectTransform), "Reason")
textBox.OnTextChangedDelegate = function (textBox)
end

local someButton = GUI.Button(GUI.RectTransform(Vector2(1, 0.1), menuList.Content.RectTransform), "Execute Punishment", GUI.Alignment.Center, "GUIButtonSmall")
someButton.OnClicked = function ()
    if not clientSelectDropDown.SelectedComponent then return end
    print(clientSelectDropDown.SelectedComponent.UserData)
    local message = Networking.Start("guiPunishment")
    message.WriteInt64(tonumber(clientSelectDropDown.SelectedComponent.UserData)) -- client steam id
    message.WriteInt64(tonumber(punishmentTypeDropDown.SelectedComponent.UserData)) -- punishment type
    if punishmentTypeDropDown.SelectedComponent.UserData == 3 then
        message.WriteInt64(tonumber(rolebanDropDown.SelectedComponent.UserData)) -- roleban role
    end
    message.WriteString(textBox.Text) -- reason
    Networking.Send(message)
end

Hook.Patch("Barotrauma.GameScreen", "AddToGUIUpdateList", function()
    frame.AddToGUIUpdateList()
end)

Hook.Patch("Barotrauma.SubEditorScreen", "AddToGUIUpdateList", function()
    frame.AddToGUIUpdateList()
end)]]