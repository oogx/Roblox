local ButtonTab = lib:Tab("Buttons")
ButtonTab:button("Button",function() 
    print("Btn") 
end)

local ToggleTab = lib:Tab("Toggles")
ToggleTab:toggle("Toggle",false,function(gg) 
    print(gg) 
end)

local TextBoxTab = lib:Tab("Textboxs")
TextBoxTab:textbox("TextBox","Text", function(gg) 
    print(gg) 
end)

local KeyBindTab = lib:Tab("KeyBinds")
KeyBindTab:keybind("KeyBind",Enum.KeyCode.Q, function(ui)
    print("KeyBind") 
end)

local LabelTab = lib:Tab("Labels")
LabelTab:label("Sheeesh")

local DropdownTab = lib:Tab("Dropdowns")
DropdownTab:dropdown("Dropdown",{'1',true,false},function() end)

local SliderTab = lib:Tab("Sliders")
SliderTab:slider("Slider", 1, 200 ,100 ,function(ff) 
print(ff)
end)

local ColourPickerTab = lib:Tab("Colour Pickers")
ColourPickerTab:colourpicker("Colour Picker", Color3.fromRGB(111, 111, 111),function(ff) 

end)