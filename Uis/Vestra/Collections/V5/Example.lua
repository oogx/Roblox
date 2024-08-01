local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/oogx/Roblox/main/Uis/Vestra/Collections/V5/Assets/Source.lua"))()
local lib = library.new({Name = "Vestra", Game = "Example"})

local tab1 = lib:AddTab({ Content = "Tab 1", Icon = 9108964006 })

local sec1 = tab1:AddSection({ Content = "Section 1",Left = true, Open = true })
local sec2 = tab1:AddSection({ Content = "Section 2",Right = true, Open = true })

sec1:AddLabel({ Content = "Example Label", Flag = "examplelabel" })

sec1:AddStatus({ Content = "Example Status", Flag = "examplestatuslabel", Status = "Gay", Colour = Color3.fromRGB(255, 0, 0)})

sec1:AddButton({ Content = "Example Button", Flag = "examplebutton", Callback = function()
	print("Button Clicked")
end })

sec1:AddToggle({ Content = "Example Toggle", Flag = "exampletoggle", Callback = function(state)
	print("Toggle Switched: " .. tostring(state))
end })

sec1:AddKeybind({ Content = "Example Bind", Flag = "examplebind", Keydown = function()
	print("Bind Pressed")
end, Keyup = function()
	print("Bind Released")
end, KeyChanged = function(old, new)
	print(string.format("Bind Changed From '%s' To '%s'", old, new))
end })

sec1:AddSlider({ Content = "Inventory Speed", Min = 1 ,Max = 10, Float = 1, Flag = "speed", Callback = function(state)
	print("Slider Value Changed: " .. tostring(state))
end })

sec1:AddTextBox({ Content = "Example Box", Flag = "examplebox", Callback = function(state)
	print("Box Value Changed: " .. state)
end })

sec1:AddTextBox({ Content = "Example Num Box", Flag = "examplenumbox", NumberOnly = true, Default = "5000", Callback = function(state)
	print("Number Only Box Value Changed: " .. state)
end })

sec2:AddColourPicker({ Content = "Example Picker", Flag = "examplepicker", Default = Color3.fromRGB(255,255,255), Callback = function(Colour)
	print("Colour Picker Changed: " .. tostring(Colour))
end })

sec2:AddDropdown({ Content = "Example Dropdown", Flag = "exampledrop", Items = { "Hi", "Bye", "Die", "Motherfucker", "Die Again" }, Callback = function(value)
	print("Dropdown Value Changed: " .. tostring(value))
end })

lib:SaveConfig("Hello")
lib:LoadConfig("Hello")

lib:AddSettings()

lib.items.examplebutton:fire()
lib.items.exampletoggle:switch()

print(lib.Flags.examplenumbox)

lib:Notify({ Content = "Kinda Gay Ngl" })