local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/xandudiscord/Roblox/main/Uis/Vestra/Old/V1/Source.lua'))()
local lib = library:load("Example Hub")

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

local ThemeTab = lib:Tab("Theme")
for theme, color in pairs(themes) do
ThemeTab:colourpicker(theme, color,function(value)
    library:setTheme(theme, value)
end)
end