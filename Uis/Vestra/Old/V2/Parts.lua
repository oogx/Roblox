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