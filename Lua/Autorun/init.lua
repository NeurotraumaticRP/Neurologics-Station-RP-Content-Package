Neurologics = {}

Neurologics.Name="Neurologics"
Neurologics.Version = "1.0"
Neurologics.VersionNum = 1


print("\n/// Running Neurologics V "..Neurologics.Version.." ///\n")
print("Neurologics Content Package Loaded")
print("credits - Evilfactory for traitormod")
print("Television - Owner/Developer")
print("Dr. Javier - Co-Owner/Developer")
local FilePath = table.pack(...)[1]


--server side (probably not needed)
if not CLIENT then
    
end
-- client side
if CLIENT then
    dofile(FilePath.."/Lua/Scripts/Client/gui.lua")
end
-- shared