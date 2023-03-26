local Tab = Main:AddTab("Tab")

local Section1 = Tab:AddSection{
    Name = "Section",
    Side = "Left",
}

local Section2 = Tab:AddSection{
    Name = "Section 2",
    Side = "Middle",
}

local Section3 = Tab:AddSection{
    Name = "Section 3",
    Side = "Right",
}

Section1:AddLabel("Label")

Section1:AddButton{
    Name = "Button",
    Callback  = function()
        
    end
}

Section1:Separator("Separator")

local Toggle = Section1:AddToggle{
    Name = "Toggle",
    Flag = "Toggle 1",
    Default = false,
    Callback  = function(bool)
        
    end
}

Toggle:AddColourPicker{
    Default = Color3.fromRGB(255,0,0), 
    Flag = "ToggleColourPicker1", 
    Callback = function(color)
        
    end
}

Toggle:AddColourPicker{
    Default = Color3.fromRGB(0,0,255), 
    Flag = "ToggleColourPicker2", 
    Callback = function(color)
        
    end
}
local Toggle2 = Section1:AddToggle{
    Name = "Toggle",
    Flag = "ToggleWithKeybind",
    --Default = true,
    Callback  = function(bool)
        
    end
}

Toggle2:AddKeybind{
    Default = Enum.KeyCode.A,
    Blacklist = {Enum.UserInputType.MouseButton1},
    Flag = "Toggle 2 Keybind 1",
    Mode = "Toggle", -- mode to nil if u dont want it to toggle the toggle
    Callback = function(key, fromsetting)
        if fromsetting then
            print("Toggle 2 Keybind 1 is now " .. tostring(key))
        else
            print("Toggle 2 Keybind 1 was pressed")
        end
    end
}

Section1:AddTextBox{
    Name = "Box",
    --Default = "hi",
    Placeholder = "Box Placeholder",
    Flag = "Box 1",
    Callback = function(text)
        print("Box 1 is now " .. text)
    end
}

Section1:AddSlider{
    Name = "Slider",
    Text = "[value]/1",
    --Default = 0.1,
    Min = 0,
    Max = 1,
    Float = 0.1,
    Flag = "Slider 1",
    Callback = function(value)
        print("Slider 1 is now " .. value)
    end
}

Section1:AddDropdown{
    Name = "Dropdown",
    --Default = {"Option 1"},
    --Scrollable = true,
    --ScrollingMax = 5,
    Max = 3, -- makes it multi
    Content = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    Flag = "Multi dropdown 1",
    Callback = function(option)
        print("Multi dropdown 1 is now " .. table.concat(option, ", "))
    end
}

Section1:AddKeybind{
    Name = "Keybind",
    --Default = Enum.KeyCode.A,
    --Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2},
    Flag = "Keybind 1",
    Callback = function(key, fromsetting)
        if fromsetting then
            print("Keybind 1 is now " .. tostring(key))
        else
            print("Keybind 1 was pressed")
        end
    end
}