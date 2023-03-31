local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/xandudiscord/Roblox/main/Uis/Vestra/Old/V3/Assets/Source.lua'))()
local ui = library:Init('Ui Libary')

local tab1 = ui:Tab('Tab', 'icon id here, remove this arg for a page icon')
local tab2 = ui:Tab('Settings', 'icon id here, remove this arg for a page icon')

local Objects = tab1:Section('Section Title')

Objects:Button('Hello!', function() -- string <text>, function [callback]
    print('Hello!')
end)

Objects:Toggle('World!', 'World', false, function(state) -- string <text>, string <flag>, boolean <enabled>, function [callback]
    print(state)
end)

Objects:Slider('Speed', 'ws', 16, 16, 500, function(value) -- string <text>, string <flag>, int <default>, int <min>, ini <max>, function [callback]
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

Objects:Keybind('Suicide', 'suicide', Enum.KeyCode.O, function() -- string <text>, string <flag>, KeyCode <default>, function [callback]
    game.Players.LocalPlayer.Character:BreakJoints()
end)

Objects:Textbox('Print Input', 'pinput', 'Hello, World!', function(input) -- string <text>, string <flag>, string <default>, function [callback]
    print(input)
end)

local storeDropdown
storeDropdown = Objects:Dropdown('Exploits', 'exploits', {'Script-Ware', 'ProtoSmasher', 'Synapse X', 'KRNL', 'Fluxus', 'Shadow', 'Sentinel', 'Intriga'}, function(selected) -- string <text>, string <flag>, table <options>, function [callback]
    print(selected)
    if selected == 'Synapse X' then
        storeDropdown:refresh({'Synapse X Losing', 'Script-Ware Winning'})
    end
end)

local Settings = tab2:Section('Settings')

Settings:Button('Destroy UI', library.destroy) -- string <text>, function [callback]
Settings:Keybind('Toggle UI', 'toggleUi', Enum.KeyCode.RightShift, library.toggleui) -- string <text>, function [callback]