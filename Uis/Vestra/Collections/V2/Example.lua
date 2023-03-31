local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/xandudiscord/Roblox/main/Uis/Vestra/Collections/V2/Assets/Source.lua'))()

local Gui_Lib = library:Load({Title = "Vestra Hub"})

Gui_Lib:Notification("Vestra","Notification","Yes")

local Button_tab = Gui_Lib:Tab({Title ="Test"})

Button_tab:Button("Button", function()
    print("Button Pressed")
end)

Button_tab:Toggle("Toggle", function(value)
    print(value)
end)

Button_tab:Slider("Slider", 10, 100 ,50 ,function(value)
    print(value)
end)
Button_tab:Dropdown("Dropdown", {"1","2","3","4"} ,function(value)
    print("Dropdown: "..value)
end)

Button_tab:ColorPicker("ColorPicker",Color3.fromRGB(66, 255, 255), function(value)
    print(value)
end)

Button_tab:KeyBind("KeyBind",Enum.KeyCode.Q, function(ui)
    print("Keybind")
end)

Button_tab:TextBox("TextBox","Type Here",function(value) 
    print(value)
end)

local Theme_Tab = Gui_Lib:Tab({Title = "Themes"})

for i,v in pairs(getgenv().theme) do
Theme_Tab:ColorPicker(i,v, function(value)
    Gui_Lib:ChangeColor(i, value)
end)
end