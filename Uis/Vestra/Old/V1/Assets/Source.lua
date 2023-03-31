-- init
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- services
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new

-- additional
local utility = {}

-- themes
local objects = {}
local themes = {
	Background = Color3.fromRGB(21, 21, 21), 
	LightContrast = Color3.fromRGB(37, 37, 37), 
	DarkContrast = Color3.fromRGB(27, 27, 27),  
	TextColor = Color3.fromRGB(255, 255, 255)
}



do

function utility:Create(instance, properties, children)
    local object = Instance.new(instance)
    
    for i, v in pairs(properties or {}) do
        object[i] = v
        
        if typeof(v) == "Color3" then -- save for theme changer later
            local theme = utility:Find(themes, v)
            
            if theme then
                objects[theme] = objects[theme] or {}
                objects[theme][i] = objects[theme][i] or setmetatable({}, {_mode = "k"})
                
                table.insert(objects[theme][i], object)
            end
        end
    end
    
    for i, module in pairs(children or {}) do
        module.Parent = object
    end
    
    return object
end

function utility:Find(table, value) -- table.find doesn't work for dictionaries
    for i, v in pairs(table) do
        if v == value then
            return i
        end
    end
end

function utility:Tween(instance, properties, duration, ...)
    tween:Create(instance, tweeninfo(duration, ...), properties):Play()
end

function utility:Wait()
    run.RenderStepped:Wait()
    return true
end

function utility:DraggingEnabled(frame, parent)
	
    parent = parent or frame
    
    -- stolen from wally or kiriot, kek
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

end

end

local library = {}

spawn(function()
        while true do
            for Rainbow_Value = 0, 255 do
                library.RainbowColorValue = Color3.fromHSV(Rainbow_Value / 255, 1, 1)
                wait()
            end
        end
end)


function library:setTheme(theme, color3)
    themes[theme] = color3
    
    for property, objects in pairs(objects[theme]) do
        for i, object in pairs(objects) do
            if not object.Parent or (object.Name == "Button" and object.Parent.Name == "ColorPicker") then
                objects[i] = nil -- i can do this because weak tables :D
            else
                object[property] = color3
            end
        end
    end
end

function library:load(Titlee)


local closed_gui = false
fs = false
    local tabhold = {}

    local Gui_Name = Titlee or "Unknown"
	fs = false
    pcall(function() VestraLib:Destroy() end);

    pcall(function() 
    for i,v in pairs(VestraLib_Con) do
    v:Disconnect()
    end
    end);
    
getgenv()["VestraLib"] = utility:Create("ScreenGui", {
    Name = "Vestra_Lib",
    Parent = game.CoreGui
})

getgenv()["VestraLib_Con"] = {}

local MainFrame = utility:Create("Frame", {
    Name = "MainFrame",
    Parent = VestraLib,
    BackgroundColor3 = themes.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0.323, 0,0.273, 0),
    Size = UDim2.new(0, 582, 0, 44),
    ClipsDescendants = true
},{
    utility:Create("UICorner", {
    CornerRadius = UDim.new(0, 10),
}),
utility:Create("ImageLabel", {
    Name = "Selector_Tab",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(1.0385015, 0, -0.000869333744, 0),
    Size = UDim2.new(0, 153, 0, 127),
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(27, 27, 27),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.120,
    Visible = false
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Size = UDim2.new(0, 153, 0, 40),
    Font = Enum.Font.Gotham,
    Text = "Selector",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 20.000
}),
utility:Create("UIListLayout", {
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 4)
}),
utility:Create("TextButton", {
    Name = "Settings_Btn",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0, 0, 0.985714257, 0),
    Size = UDim2.new(0, 153, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Settings",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14.000
}),
utility:Create("TextButton", {
    Name = "Music_Btn",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0, 0, 0.755102336, 0),
    Size = UDim2.new(0, 153, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Music",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14.000
})
}),
utility:Create("ImageLabel", {
    Name = "Music_Tab",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    ClipsDescendants = true,
    Position = UDim2.new(1.03900003, 0, -0.00100000005, 0),
    Size = UDim2.new(0, 243, 0, 295),
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(21, 21, 21),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.120,
    Visible = false
},{utility:Create("UIListLayout", {
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 6)
}),
utility:Create("TextLabel", {
    Name = "Music_Title",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(-0.0165289249, 0, 0.375, 0),
    Size = UDim2.new(0, 242, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Music",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 20.000
},{utility:Create("ImageButton", {
    Name = "close",
    BackgroundTransparency = 1.000,
    LayoutOrder = 2,
    Position = UDim2.new(0.859504163, 0, 0.142857164, 0),
    Size = UDim2.new(0, 25, 0, 25),
    ZIndex = 2,
    Image = "rbxassetid://3926305904",
    ImageRectOffset = Vector2.new(284, 4),
    ImageRectSize = Vector2.new(24, 24)
})}),
utility:Create("ImageButton", {
    Name = "dropdown",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Position = UDim2.new(0.0329218097, 0, 0.169491529, 0),
    Size = UDim2.new(0, 227, 0, 32),
    AutoButtonColor = false,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(27, 27, 27),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.080
},{utility:Create("TextLabel", {
    Name = "title_a",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.021512568, 0, 0.0268573761, 0),
    Size = UDim2.new(0, 172, 0, 29),
    Font = Enum.Font.Gotham,
    Text = "Default Music",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16.000,
    TextXAlignment = Enum.TextXAlignment.Left
},{utility:Create("ImageButton", {
    Name = "iconn",
    BackgroundTransparency = 1.000,
    Position = UDim2.new(1.1351974, 0, 0.0425517261, 0),
    Size = UDim2.new(0, 25, 0, 25),
    Image = "rbxassetid://6035047377",
    ScaleType = Enum.ScaleType.Fit,
    ImageTransparency = 0
}),
utility:Create("TextBox", {
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderColor3 = Color3.fromRGB(202, 202, 202),
    BorderSizePixel = 0,
    Position = UDim2.new(0.61656791, 0, 0.103448272, 0),
    Size = UDim2.new(0, 89, 0, 24),
    Font = Enum.Font.Gotham,
    Text = "",
    TextColor3 = Color3.fromRGB(178, 178, 178),
    TextSize = 14.000,
    Visible = false,
    PlaceholderText = "Search",
    PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
    TextTransparency = 1,
},{utility:Create("UICorner", {
    CornerRadius = UDim.new(0, 4)
})}),
utility:Create("ScrollingFrame", {
    Name = "ItemHolder",
    Active = true,
    BackgroundColor3 = Color3.fromRGB(0, 0, 255),
    BackgroundTransparency = 1.000,
    BorderColor3 = Color3.fromRGB(27, 27, 27),
    Position = UDim2.new(-0.0703323707, 0, 1.21846688, 0),
    Size = UDim2.new(0, 243, 0, 118),
    CanvasSize = UDim2.new(0, 0, 8, 0),
    ScrollBarThickness = 5
},{utility:Create("UIListLayout", {
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 4)
})})

}),

}),

--slider

utility:Create("ImageButton", {
    Name = "Slider",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.0409538373, 0, 0.434980184, 0),
    Size = UDim2.new(0, 227, 0, 32),
    AutoButtonColor = false,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(27, 27, 27),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.080
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.0166918729, 0, 0.055142872, 0),
    Size = UDim2.new(0, 170, 0, 29),
    Font = Enum.Font.Gotham,
    Text = "Volume",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16.000,
    TextXAlignment = Enum.TextXAlignment.Left
}),
utility:Create("Frame", {
    Name = "Bar",
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderSizePixel = 0,
    Position = UDim2.new(0.296160519, 0, 0.427143216, 0),
    Size = UDim2.new(0.494999975, -20, 0.00585727673, 5)
},{utility:Create("UICorner", {
    CornerRadius = UDim.new(0, 4)
}),
utility:Create("Frame", {
    Name = "Inner",
    BackgroundColor3 = Color3.fromRGB(178, 178, 178),
    BorderSizePixel = 0,
    Size = UDim2.new(0.689705372, -20, 0.0393889137, 5)
},{utility:Create("UICorner", {
    CornerRadius = UDim.new(0, 4)
})})
}),

utility:Create("TextBox", {
    Name = "Value_txt",
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderSizePixel = 0,
    Position = UDim2.new(0.731823564, 0, 0.166197807, 0),
    Size = UDim2.new(0, 55, 0, 23),
    Font = Enum.Font.Gotham,
    PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
    PlaceholderText = "100",
    Text = "",
    TextColor3 = Color3.fromRGB(178, 178, 178),
    TextSize = 14.000
},{utility:Create("UICorner", {
    CornerRadius = UDim.new(0, 4)
})})

}),

utility:Create("TextBox", {
    Name = "Music_id_txt",
    BackgroundColor3 = Color3.fromRGB(27, 27, 27),
    BorderSizePixel = 0,
    Position = UDim2.new(0.0368386097, 0, 0.149152547, 0),
    Size = UDim2.new(0, 227, 0, 35),
    Font = Enum.Font.Gotham,
    PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
    PlaceholderText = "Music Id Here",
    Text = "",
    TextColor3 = Color3.fromRGB(178, 178, 178),
    TextSize = 14.000
},{utility:Create("UICorner", {
    CornerRadius = UDim.new(0, 4)
})}),

--things
utility:Create("ImageLabel", {
    Name = "Start",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.0409538373, 0, 0.71021086, 0),
    Size = UDim2.new(0, 226, 0, 31),
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(27, 27, 27),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.120
},{utility:Create("TextButton", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Size = UDim2.new(0, 220, 0, 31),
    Font = Enum.Font.Gotham,
    Text = "Start",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18.000
})}),
utility:Create("ImageLabel", {
    Name = "Stop",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.0409538373, 0, 0.71021086, 0),
    Size = UDim2.new(0, 226, 0, 31),
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(27, 27, 27),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.120
},{utility:Create("TextButton", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Size = UDim2.new(0, 220, 0, 31),
    Font = Enum.Font.Gotham,
    Text = "Stop",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18.000
})})


}),
utility:Create("ImageLabel", {
    Name = "Settings_Tab",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    Position = UDim2.new(1.03900003, 0, -0.00100000005, 0),
    Size = UDim2.new(0, 242, 0, 296),
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(21, 21, 21),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.120,
    Visible = false
},{utility:Create("UIListLayout", {
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 5)
}),
utility:Create("TextLabel", {
    Name = "Tittle_S",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(-0.0165289249, 0, 0.375, 0),
    Size = UDim2.new(0, 242, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Settings",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 20.000
},{utility:Create("ImageButton", {
    Name = "close",
    BackgroundTransparency = 1.000,
    LayoutOrder = 2,
    Position = UDim2.new(0.859504163, 0, 0.142857164, 0),
    Size = UDim2.new(0, 25, 0, 25),
    ZIndex = 2,
    Image = "rbxassetid://3926305904",
    ImageRectOffset = Vector2.new(284, 4),
    ImageRectSize = Vector2.new(24, 24)
})}),
utility:Create("ImageButton", {
    Name = "Des",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Size = UDim2.new(0, 220, 0, 35),
    AutoButtonColor = false,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(27, 27, 27),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.080
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Size = UDim2.new(0, 220, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Destroy Ui",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16.000
})}),
utility:Create("ImageButton", {
    Name = "Tog_Ui",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Position = UDim2.new(0.0909090936, 0, 0.270270258, 0),
    Size = UDim2.new(0, 220, 0, 35),
    AutoButtonColor = false,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(27, 27, 27),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.080
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.0570578501, 0, 0.0837142915, 0),
    Size = UDim2.new(0, 170, 0, 29),
    Font = Enum.Font.Gotham,
    Text = "Toggle Ui",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16.000,
    TextXAlignment = Enum.TextXAlignment.Left
},{utility:Create("TextLabel", {
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(1.1823529, 0, 0.48206833, 0),
    Size = UDim2.new(0, 45, 0, 29),
    Font = Enum.Font.Gotham,
    Text = "RightControl",
    TextColor3 = Color3.fromRGB(178, 178, 178),
    TextSize = 16.000
})})}),
utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(-0.0165289249, 0, 0.375, 0),
    Size = UDim2.new(0, 242, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Credits",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 20.000
}),
utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(-0.0165289249, 0, 0.375, 0),
    Size = UDim2.new(0, 242, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Vestra#0001",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14.000
}),
utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(-0.0165289249, 0, 0.375, 0),
    Size = UDim2.new(0, 242, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Cipher#3569",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14.000
}),
utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(-0.0165289249, 0, 0.375, 0),
    Size = UDim2.new(0, 242, 0, 35),
    Font = Enum.Font.Gotham,
    Text = "Aamericq#3344",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14.000
})
}),
utility:Create("ImageLabel", {
    Name = "Categories",
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0.0851001069, 0),
    Size = UDim2.new(1, 0, 0.914899826, 0),
    ImageTransparency = 1
}),
utility:Create("Frame", {
    Name = "Tab_List",
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0.110552765, 0),
    Size = UDim2.new(0, 0,0, 354),
    ClipsDescendants = true
},{utility:Create("ScrollingFrame", {
    Name = "Tab_Holder",
    Active = true,
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0.0169971939, 0),
    Size = UDim2.new(0, 187, 0, 348),
    ZIndex = 2,
    ScrollBarThickness = 4
},{
    utility:Create("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
})}),
utility:Create("ImageLabel", {
    Name = "TopBar",
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 582, 0, 44),
    ZIndex = 2,
    Image = "rbxassetid://3570695787",
    ImageColor3 = themes.Background,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.120
},{utility:Create("TextLabel", {
    Name = "Title",
    BackgroundColor3 = themes.DarkContrast,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.0891069248, 0, 0.143374011, 0),
    Size = UDim2.new(0, 170, 0, 25),
    ZIndex = 4,
    Font = Enum.Font.Gotham,
    Text = Gui_Name,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 21,
    TextXAlignment = Enum.TextXAlignment.Left
}),
utility:Create("ImageButton", {
    Name = "TabButton",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.0136333602, 0, 0.195715889, 0),
    Size = UDim2.new(0, 25, 0, 25),
    ZIndex = 3,
    Image = "rbxassetid://3926305904",
    ImageColor3 = themes.TextColor,
    ImageRectOffset = Vector2.new(604, 684),
    ImageRectSize = Vector2.new(36, 36)
}),
utility:Create("ImageButton", {
    Name = "more_vert",
    BackgroundTransparency = 1,
    LayoutOrder = 9,
    Position = UDim2.new(0.872215211, 0, 0.174735099, 0),
    Size = UDim2.new(0, 25, 0, 25),
    ZIndex = 2,
    ImageColor3 = themes.TextColor,
    Image = "rbxassetid://3926305904",
    ImageRectOffset = Vector2.new(764, 764),
    ImageRectSize = Vector2.new(36, 36)
}),
utility:Create("ImageButton", {
    Name = "Search_btn",
    BackgroundTransparency = 1,
    LayoutOrder = 2,
    Position = UDim2.new(0.829301238, 0, 0.174735099, 0),
    Size = UDim2.new(0, 25, 0, 25),
    ZIndex = 2,
    ImageColor3 = themes.TextColor,
    Image = "rbxassetid://3926305904",
    ImageRectOffset = Vector2.new(964, 324),
    ImageRectSize = Vector2.new(36, 36)
}),
utility:Create("ImageButton", {
    Name = "Min_Btn",
    BackgroundTransparency = 1,
    ImageTransparency = 0,
    LayoutOrder = 3,
    ImageColor3 = themes.TextColor,
    Position = UDim2.new(0.919336915, 0, 0.166101262, 0),
    Size = UDim2.new(0, 26, 0, 26),
    ZIndex = 2,
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(884, 284),
    ImageRectSize = Vector2.new(36, 36)
}),
utility:Create("TextBox", {
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderColor3 = Color3.fromRGB(202, 202, 202),
    BorderSizePixel = 0,
    Position = UDim2.new(0.814281762, 0, 0.438272655, 0),
    Size = UDim2.new(0, 0, 0, 25),
    ZIndex = 4,
    Font = Enum.Font.Gotham,
    Text = "",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Visible = false,
    TextTransparency = 1,
    PlaceholderText = "Search",
    PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
},{utility:Create("UICorner", {
    CornerRadius = UDim.new(0, 4)
})})

})
})
wait(0.5)
utility:Tween(MainFrame, {Size = UDim2.new(0, 582, 0, 398)}, 0.4)

_G.Tab_opend = false

MainFrame.TopBar.more_vert.MouseButton1Click:Connect(function()
    if closed_gui then 
        return
    end
    MainFrame.ClipsDescendants = not MainFrame.ClipsDescendants
    MainFrame.Selector_Tab.Visible = not MainFrame.Selector_Tab.Visible
end)

MainFrame.Selector_Tab.Settings_Btn.MouseButton1Click:Connect(function()
    MainFrame.Selector_Tab.Visible = false
    MainFrame.Settings_Tab.Visible = true
end)

MainFrame.Selector_Tab.Music_Btn.MouseButton1Click:Connect(function()
    MainFrame.Selector_Tab.Visible = false
    MainFrame.Music_Tab.Visible = true
end)

local drop_yy = MainFrame.Music_Tab.dropdown;
local iconn = drop_yy.title_a.iconn
drop_yy.MouseButton1Click:Connect(function()

    if drop_yy.Size == UDim2.new(0, 227,0, 161) then
        utility:Tween(iconn, {ImageTransparency = 1}, 0.7)
        wait(0.01)
        iconn.ImageRectOffset = Vector2.new(0, 0)
        iconn.ImageRectSize = Vector2.new(0, 0)
        iconn.Image = "rbxassetid://6035047377"
        utility:Tween(iconn, {ImageTransparency = 0}, 0.7)
        utility:Tween(drop_yy.title_a.TextBox, {BackgroundTransparency = drop_yy.title_a.TextBox.BackgroundTransparency == 1 and 0 or 1,TextTransparency = drop_yy.title_a.TextBox.TextTransparency == 1 and 0 or 1}, 0.2)
        drop_yy.title_a.TextBox.Visible = not drop_yy.title_a.TextBox.Visible
    else
        --refreshh(list)
        utility:Tween(iconn, {ImageTransparency = 1}, 0.7)
        wait(0.01)
        iconn.ImageRectOffset = Vector2.new(884, 284)
        iconn.ImageRectSize = Vector2.new(36, 36)
        iconn.Image = "rbxassetid://3926307971"
        utility:Tween(iconn, {ImageTransparency = 0}, 0.7)
        utility:Tween(drop_yy.title_a.TextBox, {BackgroundTransparency = drop_yy.title_a.TextBox.BackgroundTransparency == 1 and 0 or 1,TextTransparency = drop_yy.title_a.TextBox.TextTransparency == 1 and 0 or 1}, 0.2)
        drop_yy.title_a.TextBox.Visible = not drop_yy.title_a.TextBox.Visible
    end
    utility:Tween(drop_yy, {Size = drop_yy.Size == UDim2.new(0, 227, 0, 32) and UDim2.new(0, 227,0, 161) or UDim2.new(0, 227, 0, 32)}, 0.4)
wait(0.4)
        MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)
end)
local list = {1,2,2,2}
local listtt = {}
for i,v in pairs(list) do

    table.insert(listtt, tostring(v))

    local owo_yy = utility:Create("ImageButton", {
        Name = "Item_" .. tostring(v),
        Parent = drop_yy.title_a.ItemHolder,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0295202956, 0, 0, 0),
        Size = UDim2.new(0, 200, 0, 30),
        AutoButtonColor = false,
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.fromRGB(37, 37, 37),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{
        utility:Create("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Size =  UDim2.new(0, 200, 0, 30),
            Font = Enum.Font.Gotham,
            Text = tostring(v),
            TextColor3 = themes.TextColor,
            TextSize = 16
        }) 
    })

owo_yy.MouseButton1Click:Connect(function()
    utility:Tween(iconn, {ImageTransparency = 1}, 0.7)
    wait(0.01)
    iconn.ImageRectOffset = Vector2.new(0, 0)
    iconn.ImageRectSize = Vector2.new(0, 0)
    iconn.Image = "rbxassetid://6035047377"
    utility:Tween(iconn, {ImageTransparency = 0}, 0.7)
    utility:Tween(drop_yy.title_a.TextBox, {BackgroundTransparency = drop_yy.title_a.TextBox.BackgroundTransparency == 1 and 0 or 1,TextTransparency = drop_yy.title_a.TextBox.TextTransparency == 1 and 0 or 1}, 0.2)
    drop_yy.title_a.TextBox.Visible = not drop_yy.title_a.TextBox.Visible
    utility:Tween(drop_yy, {Size = drop_yy.Size == UDim2.new(0, 227, 0, 32) and UDim2.new(0, 227,0, 161) or UDim2.new(0, 227, 0, 32)}, 0.4)
wait(0.4)
      MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)
end)

drop_yy.title_a.ItemHolder.CanvasSize = UDim2.new(0, 0, 0, drop_yy.title_a.ItemHolder.UIListLayout.AbsoluteContentSize.Y)

            end

            local SearchTxt = drop_yy.title_a.TextBox

            SearchTxt:GetPropertyChangedSignal("Text"):Connect(function()
        
                if SearchTxt.Text == "" then
                    for i,v in pairs(drop_yy.title_a.ItemHolder:GetChildren()) do
                        if v:IsA("ImageButton") then
                                v.Visible = true
                        end
                    end
                    drop_yy.title_a.ItemHolder.CanvasSize = UDim2.new(0, 0, 0, drop_yy.title_a.ItemHolder.UIListLayout.AbsoluteContentSize.Y)
                    return
                end
                
                    local Found = {}
                    for i, v in pairs(listtt) do
                        if string.find(string.lower(v), string.lower(SearchTxt.Text)) then
                            table.insert(Found, v)
                            warn(v)
                        end
                    end	
        
                    for i,v in pairs(drop_yy.title_a.ItemHolder:GetChildren()) do
                        if v:IsA("ImageButton") then
                                v.Visible = false
                        end
                    end
                
                    for i,v in pairs(drop_yy.title_a.ItemHolder:GetChildren()) do
                        if v:IsA("ImageButton") then
                            for c, d in pairs(Found) do
                                if d == (v.Name):split('_')[2] then
                                    v.Visible = true
                                end
                            end
                        end
                    end
                    drop_yy.title_a.ItemHolder.CanvasSize = UDim2.new(0, 0, 0, drop_yy.title_a.ItemHolder.UIListLayout.AbsoluteContentSize.Y)
                    
                end)

local musiiic_id = nil;

MainFrame.Music_Tab.Music_id_txt.FocusLost:Connect(function()
    musiiic_id = MainFrame.Music_Tab.Music_id_txt.Text
end)
local a;
MainFrame.Music_Tab.Start.TextButton.MouseButton1Click:Connect(function()
    if musiiic_id ~= nil then 
    a = Instance.new("Sound")
    a.SoundId = "rbxassetid://" ..musiiic_id
    a.Looped = true
    a.Volume = 0
    a.Parent = game.Workspace
    a:Play()
    end
end)

MainFrame.Music_Tab.Stop.TextButton.MouseButton1Click:Connect(function()
    if game.Workspace.Sound then
        game.Workspace.Sound:Destroy()
    end
end)

local value = 50 
local dragging = false
local stn_yy = MainFrame.Music_Tab.Slider
local callback = function() end

local function slider_u(value)
    local bar = stn_yy.Bar
    local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
    
    if value then -- support negative ranges
        percent = (value - 0) / (100 - 0)
    end
    
    percent = math.clamp(percent, 0, 1)
    value = value or math.floor(0 + (100 - 0) * percent)
    
   stn_yy.Value_txt.Text = value
    utility:Tween(bar.Inner, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
    return value
end
slider_u(tostring(value))

    stn_yy.MouseButton1Down:Connect(function(input)
        dragging = true
        while dragging do
            value = slider_u()
            a.Volume = value
            callback(value)
            utility:Wait()
        end
    end)

    input.InputEnded:Connect(function(key)
        if key.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local allowed = {
        [""] = true,
        ["-"] = true
    }

local textbox = stn_yy.Value_txt
    textbox.FocusLost:Connect(function()
        if not tonumber(textbox.Text) then
            value = slider_u(0)
            callback(value)
            a.Volume = value
        end
    end)
    
    textbox:GetPropertyChangedSignal("Text"):Connect(function()
        local text = textbox.Text
        
        if not allowed[text] and not tonumber(text) then
            textbox.Text = text:sub(1, #text - 1)
        elseif not allowed[text] then	
            value = slider_u(tonumber(text) or value)
            callback(value)
            a.Volume = value
        end
    end)


MainFrame.Music_Tab.Music_Title.close.MouseButton1Click:Connect(function()
    MainFrame.Music_Tab.Visible = false
    MainFrame.ClipsDescendants = not MainFrame.ClipsDescendants
end)

MainFrame.Settings_Tab.Tittle_S.close.MouseButton1Click:Connect(function()
    MainFrame.Settings_Tab.Visible = false
    MainFrame.ClipsDescendants = not MainFrame.ClipsDescendants
end)

MainFrame.Settings_Tab.Des.MouseButton1Click:Connect(function()
    pcall(function() VestraLib:Destroy() end);
    pcall(function() for i,v in pairs(VestraLib_Con) do v:Disconnect() end end);
end)

local input_con
local connection
local changing = false
local KEY = Enum.KeyCode.RightControl;
local key_holder = MainFrame.Settings_Tab.Tog_Ui.TextLabel.TextLabel

MainFrame.Settings_Tab.Tog_Ui.MouseButton1Click:Connect(function()
    changing = true
    key_holder.Text = "..."
    connection = game:GetService("UserInputService").InputBegan:Connect(function(i)
        if i.UserInputType.Name == "Keyboard" and i.KeyCode ~= Enum.KeyCode.Backspace and i.KeyCode ~= Enum.KeyCode.Tab then
            key_holder.Text = i.KeyCode.Name
            KEY = i.KeyCode
            if connection then
                connection:Disconnect()
                connection = nil
                utility:Wait()
                changing = false
            end
        elseif i.KeyCode == Enum.KeyCode.Backspace or i.KeyCode == Enum.KeyCode.Tab then
            key_holder.Text = "None"
            KEY = nil
            if connection then
                connection:Disconnect()
                connection = nil 
                utility:Wait()
                changing = false
            end
        end
    end)
end)

input_con = game:GetService("UserInputService").InputBegan:Connect(function(i, GPE)
    if KEY and i.KeyCode == KEY and not GPE and not connection then
        if not changing then
            pcall(function() VestraLib.Enabled = not VestraLib.Enabled end);
        end
    end
end)

table.insert(VestraLib_Con, input_con)
table.insert(VestraLib_Con, connection)

MainFrame.TopBar.Min_Btn.MouseButton1Click:Connect(function()
  if MainFrame.Size == UDim2.new(0, 582, 0, 398) then
    closed_gui = true
    utility:Tween(MainFrame.TopBar.Min_Btn, {ImageTransparency = 1}, 0.7)
    wait(0.01)
    MainFrame.TopBar.Min_Btn.ImageRectOffset = Vector2.new(324, 364)
    utility:Tween(MainFrame.TopBar.Min_Btn, {ImageTransparency = 0}, 0.7)
  else
    utility:Tween(MainFrame.TopBar.Min_Btn, {ImageTransparency = 1}, 0.7)
    wait(0.01)
    MainFrame.TopBar.Min_Btn.ImageRectOffset = Vector2.new(884, 284)
    utility:Tween(MainFrame.TopBar.Min_Btn, {ImageTransparency = 0}, 0.7)
    closed_gui = false
  end

  if MainFrame.Tab_List.Size == UDim2.new(0, 187,0, 354) then
    _G.Tab_opend = true
    utility:Tween(MainFrame.Tab_List, {Size = UDim2.new(0, 0,0, 354)}, 0.3)
    wait(0.4)
  end



    utility:Tween(MainFrame, {Size = MainFrame.Size == UDim2.new(0, 582, 0, 398) and UDim2.new(0, 582, 0, 44) or UDim2.new(0, 582, 0, 398)}, 0.4)
    wait(0.4)
    if _G.Tab_opend and closed_gui == false then
        utility:Tween(MainFrame.Tab_List, {Size = UDim2.new(0, 187,0, 354)}, 0.3)
        _G.Tab_opend = false
    end
end)

local Highlighted = {}

function searchhh_u(fdgdfgfd)

    for i,v in pairs(Highlighted) do 
        v.TextColor3 = themes.TextColor
    end

    Highlighted = {}

if #fdgdfgfd == 0 then
    return 
end
if fdgdfgfd == nil then
    return 
end

if type(fdgdfgfd) ~= "string" then
    return 
end

local hahahahahha_liibib = {}
    for i,v in pairs(VestraLib.MainFrame.Categories:GetDescendants()) do
        if v:IsA("ImageButton") or v:IsA("TextButton") or v:IsA("ImageLabel") then
        if string.find(v.Name, "_Button") or string.find(v.Name, "_Toggle") or string.find(v.Name, "_ColourPicker") or string.find(v.Name, "_Slider") or string.find(v.Name, "_Dropdown") or string.find(v.Name, "_Keybind") or string.find(v.Name, "_TextBox") or string.find(v.Name, "_Label") then
         
            if string.find(string.lower(fdgdfgfd), string.lower((v.Name):split('_')[1])) or string.lower((v.Name):split('_')[1]):sub(1, #fdgdfgfd) == fdgdfgfd then

--print(string.lower((v.Name):split('_')[1]))

for _,ss in pairs(VestraLib.MainFrame.Categories:GetChildren()) do
if ss.Visible == true then
    ss.Visible = false
end
end

if string.find(v.Name, "_ColourPicker") then
    local textgdfgfdfgd = v.Frame.TextLabel
    textgdfgfdfgd.TextColor3 = Color3.fromRGB(0,255,0)
    table.insert(Highlighted, textgdfgfdfgd)
end

pcall(function()
    local textgdfgfdfgd = v:FindFirstChildOfClass("TextLabel")
    textgdfgfdfgd.TextColor3 = Color3.fromRGB(0,255,0)
    table.insert(Highlighted, textgdfgfdfgd)
end)


VestraLib.MainFrame.Categories[v.Parent.Name].Visible = true
                        end
        end
    end
end
end

MainFrame.TopBar.TabButton.MouseButton1Click:Connect(function()
    if closed_gui then 
        return
    end
    utility:Tween(MainFrame.Tab_List, {Size = MainFrame.Tab_List.Size == UDim2.new(0, 187,0, 354) and UDim2.new(0, 0,0, 354) or UDim2.new(0, 187,0, 354)}, 0.4)
end)

local closed_q = nil;

MainFrame.TopBar.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    searchhh_u(MainFrame.TopBar.TextBox.Text)
end)

MainFrame.TopBar.Search_btn.MouseButton1Click:Connect(function()
    if closed_gui then 
        return
    end
    if MainFrame.TopBar.TextBox.Visible == false then
        MainFrame.TopBar.TextBox.Visible = true
        if closed_q ~= nil then
            pcall(function() closed_q:Disconnect() end);
            closed_q = nil
        end
        closed_q = MainFrame.TopBar.TextBox.Changed:Connect(function(ep)
            if ep then
                utility:Tween(MainFrame.TopBar.TextBox, {Size = UDim2.new(0, MainFrame.TopBar.TextBox.TextBounds.X + 18, 0, 24)}, 0.1)
            end
    end)

    end 
if MainFrame.TopBar.TextBox.Size == UDim2.new(0, 0, 0, 25) then
    utility:Tween(MainFrame.TopBar.TextBox, {TextTransparency = 0}, 0.2)
    utility:Tween(MainFrame.TopBar.TextBox, {Size = UDim2.new(0, 200,0, 25)}, 0.4)
else
    if closed_q ~= nil then
        pcall(function() closed_q:Disconnect() end)
        closed_q = nil
    end
    utility:Tween(MainFrame.TopBar.TextBox, {TextTransparency = 1}, 0.2)
    utility:Tween(MainFrame.TopBar.TextBox, {Size = UDim2.new(0, 0,0, 25)}, 0.4)
end

    wait(0.2)
    if MainFrame.TopBar.TextBox.TextTransparency ~= 1 then
    MainFrame.TopBar.TextBox:CaptureFocus()
    end
    if MainFrame.TopBar.TextBox.Visible == true and MainFrame.TopBar.TextBox.TextTransparency == 1 then
        MainFrame.TopBar.TextBox.Visible = false
    end 
end)

utility:DraggingEnabled(MainFrame.TopBar,MainFrame)
utility:DraggingEnabled(MainFrame,MainFrame)

function tabhold:Tab(Titlee)

local OldVestraUi = {}

local Tab_Name = Titlee or "Unknown"

local btn_tab = utility:Create("ImageButton", {
    Name = "Button",
    Parent = MainFrame.Tab_List.Tab_Holder,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.0721925125, 0, 0, 0),
    Size = UDim2.new(0, 149, 0, 31),
    ZIndex = 3,
    AutoButtonColor = false,
    Image = "rbxassetid://3570695787",
    ImageColor3 = themes.DarkContrast,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.080
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Position = UDim2.new(-0.029801324, 0, 0, 0),
    Size = UDim2.new(0, 149, 0, 31),
    ZIndex = 4,
    Font = Enum.Font.Gotham,
    Text = Titlee,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16
})})

local scrollingframe = utility:Create("ScrollingFrame", {
    Name = Tab_Name,
    Parent = MainFrame.Categories,
    Active = true,
    BackgroundColor3 = Color3.fromRGB(220, 220, 220),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0.0271157324, 0),
    Selectable = false,
    Size = UDim2.new(0, 582, 0, 344),
    CanvasSize = UDim2.new(0, 0, 8, 0),
    ScrollBarThickness = 6,
    Visible = false
},{utility:Create("UIListLayout", {
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 6)
})})

btn_tab.MouseButton1Click:Connect(function()
    for i, v in next, MainFrame.Categories:GetChildren() do
        if v.Visible == true then
            v.Visible = false
        end
        scrollingframe.Visible = true
    end
    utility:Tween(MainFrame.Tab_List, {Size = MainFrame.Tab_List.Size == UDim2.new(0, 187,0, 354) and UDim2.new(0, 0,0, 354) or UDim2.new(0, 187,0, 354)}, 0.4)
end)

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

if fs == false then
    fs = true
    MainFrame.Categories[Tab_Name].Visible = true
end

MainFrame.Tab_List.Tab_Holder.CanvasSize = UDim2.new(0, 0, 0, MainFrame.Tab_List.Tab_Holder.UIListLayout.AbsoluteContentSize.Y)

function OldVestraUi:button(btn_title,callback)
    btn_title = btn_title or "Button"
    callback = callback or function() end

    local btn_yy = utility:Create("ImageButton", {
        Name = btn_title .. "_Button",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 546, 0, 35),
        AutoButtonColor = false,
        Image = "rbxassetid://3570695787",
        ImageColor3 = themes.DarkContrast,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0240000002, 0, 0.0837142915, 0),
        Size = UDim2.new(0, 170, 0, 29),
        Font = Enum.Font.Gotham,
        Text = btn_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })})

    btn_yy.MouseButton1Click:Connect(function()
        pcall(callback())
    end)

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end

function OldVestraUi:label(lbl_title)
    lbl_title = lbl_title or "Label"

    utility:Create("ImageLabel", {
        Name = lbl_title .. "_Label",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0212014131, 0, 0.0316091962, 0),
        Size = UDim2.new(0, 546, 0, 35),
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.fromRGB(27, 27, 27),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 546, 0, 36),
        Font = Enum.Font.Gotham,
        Text = lbl_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
    })})

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end

function OldVestraUi:dropdown(drop_title,list,callback)
    drop_title = drop_title or "Dropdown"
    list = list or {}
    callback = callback or function() end
    local listtt = {}

    local drop_yy = utility:Create("ImageButton", {
        Name = drop_title .. "_Dropdown",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 546, 0, 35),
        AutoButtonColor = false,
        ClipsDescendants = true,
        Image = "rbxassetid://3570695787",
        ImageColor3 = themes.DarkContrast,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{utility:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 38, 0, 35)
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.33978945, 0, 0.0839999989, 0),
        Size = UDim2.new(0, 170, 0, 29),
        Font = Enum.Font.Gotham,
        Text = drop_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    },{utility:Create("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(2.90547061, 0, 0.0425517187, 0),
        Size = UDim2.new(0, 25, 0, 25),
        Image = "rbxassetid://6035047377",
        ScaleType = Enum.ScaleType.Fit,
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }),
    utility:Create("ScrollingFrame", {
        Active = true,
        BackgroundColor3 = Color3.fromRGB(0, 0, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 27, 27),
        Position = UDim2.new(-0.070332244, 0, 1.21846688, 0),
        Size = UDim2.new(0, 542, 0, 118),
        CanvasSize = UDim2.new(0, 0, 8, 0),
        ScrollBarThickness = 5
    },{utility:Create("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    })}),
    utility:Create("TextBox", {
        BackgroundColor3 = Color3.fromRGB(37, 37, 37),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(202, 202, 202),
        BorderSizePixel = 0,
        Position = UDim2.new(2.81764722, 0, 0.482758641, 0),
        Size = UDim2.new(0, 200, 0, 25),
        Font = Enum.Font.Gotham,
        PlaceholderText = "Search",
        PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 1,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        AnchorPoint = Vector2.new(1, 0.5),
        Visible = false
    },{utility:Create("UICorner", {
        CornerRadius = UDim.new(0, 4)
    })}),
})})})

local function refreshh(gggggggggggggg)
    for i,v in pairs(drop_yy.Frame.TextLabel.ScrollingFrame:GetChildren()) do
        if v:IsA("ImageButton") then
        v:Destroy()
        end
    end
    
    listtt = {}

    for i,v in pairs(gggggggggggggg) do

        table.insert(listtt, tostring(v))

       local owo_yy = utility:Create("ImageButton", {
            Name = "Item_" .. tostring(v),
            Parent = drop_yy.Frame.TextLabel.ScrollingFrame,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.0295202956, 0, 0, 0),
            Size = UDim2.new(0, 510, 0, 30),
            AutoButtonColor = false,
            Image = "rbxassetid://3570695787",
            ImageColor3 = Color3.fromRGB(37, 37, 37),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.080
        },{
            utility:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 510, 0, 30),
                Font = Enum.Font.Gotham,
                Text = tostring(v),
                TextColor3 = themes.TextColor,
                TextSize = 16
            }) 
        })

owo_yy.MouseButton1Click:Connect(function()
            drop_yy.Frame.TextLabel.Text = drop_title .. " - " .. tostring(v)
            pcall(callback, v)

                utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
                wait(0.01)
                drop_yy.Frame.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(0, 0)
                drop_yy.Frame.TextLabel.ImageLabel.ImageRectSize = Vector2.new(0, 0)
                drop_yy.Frame.TextLabel.ImageLabel.Image = "rbxassetid://6035047377"
                utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
        
                utility:Tween(drop_yy, {Size = drop_yy.Size == UDim2.new(0, 546, 0, 200) and UDim2.new(0, 546, 0, 35) or UDim2.new(0, 546, 0, 200)}, 0.2)

                utility:Tween(drop_yy.Frame.TextLabel.TextBox, {BackgroundTransparency = drop_yy.Frame.TextLabel.TextBox.BackgroundTransparency == 1 and 0 or 1,TextTransparency = drop_yy.Frame.TextLabel.TextBox.TextTransparency == 1 and 0 or 1}, 0.2)
                drop_yy.Frame.TextLabel.TextBox.Visible = not drop_yy.Frame.TextLabel.TextBox.Visible

                MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end)

        drop_yy.Frame.TextLabel.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, drop_yy.Frame.TextLabel.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)

        MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)


end
end

    drop_yy.MouseButton1Click:Connect(function()
        if drop_yy.Size == UDim2.new(0, 546, 0, 200) then
            utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            drop_yy.Frame.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(0, 0)
            drop_yy.Frame.TextLabel.ImageLabel.ImageRectSize = Vector2.new(0, 0)
            drop_yy.Frame.TextLabel.ImageLabel.Image = "rbxassetid://6035047377"
            utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
            utility:Tween(drop_yy.Frame.TextLabel.TextBox, {BackgroundTransparency = drop_yy.Frame.TextLabel.TextBox.BackgroundTransparency == 1 and 0 or 1,TextTransparency = drop_yy.Frame.TextLabel.TextBox.TextTransparency == 1 and 0 or 1}, 0.2)
            drop_yy.Frame.TextLabel.TextBox.Visible = not drop_yy.Frame.TextLabel.TextBox.Visible
        else
            refreshh(list)
            utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            drop_yy.Frame.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(884, 284)
            drop_yy.Frame.TextLabel.ImageLabel.ImageRectSize = Vector2.new(36, 36)
            drop_yy.Frame.TextLabel.ImageLabel.Image = "rbxassetid://3926307971"
            utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
            utility:Tween(drop_yy.Frame.TextLabel.TextBox, {BackgroundTransparency = drop_yy.Frame.TextLabel.TextBox.BackgroundTransparency == 1 and 0 or 1,TextTransparency = drop_yy.Frame.TextLabel.TextBox.TextTransparency == 1 and 0 or 1}, 0.2)
            drop_yy.Frame.TextLabel.TextBox.Visible = not drop_yy.Frame.TextLabel.TextBox.Visible
        end
          
            utility:Tween(drop_yy, {Size = drop_yy.Size == UDim2.new(0, 546, 0, 200) and UDim2.new(0, 546, 0, 35) or UDim2.new(0, 546, 0, 200)}, 0.4)
wait(0.4)
            MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)


    end)

    local SearchTxt = drop_yy.Frame.TextLabel.TextBox

    SearchTxt:GetPropertyChangedSignal("Text"):Connect(function()

        if SearchTxt.Text == "" then
            for i,v in pairs(drop_yy.Frame.TextLabel.ScrollingFrame:GetChildren()) do
                if v:IsA("ImageButton") then
                        v.Visible = true
                end
            end
            drop_yy.Frame.TextLabel.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, drop_yy.Frame.TextLabel.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
            return
        end
        
            local Found = {}
            for i, v in pairs(listtt) do
                if string.find(string.lower(v), string.lower(SearchTxt.Text)) then
                    table.insert(Found, v)
                    warn(v)
                end
            end	

            for i,v in pairs(drop_yy.Frame.TextLabel.ScrollingFrame:GetChildren()) do
                if v:IsA("ImageButton") then
                        v.Visible = false
                end
            end
        
            for i,v in pairs(drop_yy.Frame.TextLabel.ScrollingFrame:GetChildren()) do
                if v:IsA("ImageButton") then
                    for c, d in pairs(Found) do
                        if d == (v.Name):split('_')[2] then
                            v.Visible = true
                        end
                    end
                end
            end
            drop_yy.Frame.TextLabel.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, drop_yy.Frame.TextLabel.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
            
        end)

    for i,v in pairs(list) do

        table.insert(listtt, tostring(v))

        local owo_yy = utility:Create("ImageButton", {
            Name = "Item_" .. tostring(v),
            Parent = drop_yy.Frame.TextLabel.ScrollingFrame,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.0295202956, 0, 0, 0),
            Size = UDim2.new(0, 510, 0, 30),
            AutoButtonColor = false,
            Image = "rbxassetid://3570695787",
            ImageColor3 = Color3.fromRGB(37, 37, 37),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.080
        },{
            utility:Create("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 510, 0, 30),
                Font = Enum.Font.Gotham,
                Text = tostring(v),
                TextColor3 = themes.TextColor,
                TextSize = 16
            }) 
        })

        owo_yy.MouseButton1Click:Connect(function()
            drop_yy.Frame.TextLabel.Text = drop_title .. " - " .. tostring(v)
            pcall(callback, v)

            utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            drop_yy.Frame.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(0, 0)
            drop_yy.Frame.TextLabel.ImageLabel.ImageRectSize = Vector2.new(0, 0)
            drop_yy.Frame.TextLabel.ImageLabel.Image = "rbxassetid://6035047377"
            utility:Tween(drop_yy.Frame.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
    
            utility:Tween(drop_yy, {Size = drop_yy.Size == UDim2.new(0, 546, 0, 200) and UDim2.new(0, 546, 0, 35) or UDim2.new(0, 546, 0, 200)}, 0.2)

            utility:Tween(drop_yy.Frame.TextLabel.TextBox, {BackgroundTransparency = drop_yy.Frame.TextLabel.TextBox.BackgroundTransparency == 1 and 0 or 1,TextTransparency = drop_yy.Frame.TextLabel.TextBox.TextTransparency == 1 and 0 or 1}, 0.2)
            drop_yy.Frame.TextLabel.TextBox.Visible = not drop_yy.Frame.TextLabel.TextBox.Visible

            MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

        end)

        drop_yy.Frame.TextLabel.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, drop_yy.Frame.TextLabel.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)


                end

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end

function OldVestraUi:toggle(tgl_title,default,callback)
    tgl_title = tgl_title or "Toggle"
    default = default or false
    callback = callback or function() end
    local Toggled = default

    local tgl_yy = utility:Create("ImageButton", {
        Name = tgl_title .. "_Toggle",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 546, 0, 35),
        AutoButtonColor = false,
        Image = "rbxassetid://3570695787",
        ImageColor3 = themes.DarkContrast,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0240000002, 0, 0.0837142915, 0),
        Size = UDim2.new(0, 170, 0, 29),
        Font = Enum.Font.Gotham,
        Text = tgl_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    },{utility:Create("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(2.8998034, 0, 0.0425978377, 0),
        Size = UDim2.new(0, 25, 0, 25),
        Image = "rbxassetid://3926305904",
        ImageColor3 = themes.TextColor,
        ImageRectOffset = Vector2.new(4, 4),
        ImageRectSize = Vector2.new(24, 24)
    })})})


        if Toggled == true then
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            tgl_yy.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(284, 924)
            tgl_yy.TextLabel.ImageLabel.ImageRectSize = Vector2.new(36, 36)
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
          else
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            tgl_yy.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(4, 4)
            tgl_yy.TextLabel.ImageLabel.ImageRectSize = Vector2.new(24, 24)
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
          end
        pcall(callback, Toggled)


    tgl_yy.MouseButton1Click:Connect(function()
        Toggled = not Toggled
        if tgl_yy.TextLabel.ImageLabel.ImageRectOffset == Vector2.new(4, 4) then
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            tgl_yy.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(284, 924)
            tgl_yy.TextLabel.ImageLabel.ImageRectSize = Vector2.new(36, 36)
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
          else
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            tgl_yy.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(4, 4)
            tgl_yy.TextLabel.ImageLabel.ImageRectSize = Vector2.new(24, 24)
            utility:Tween(tgl_yy.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
          end
        pcall(callback, Toggled)
    end)

    MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end

function OldVestraUi:colourpicker(clr_title,default,callback)
    clr_title = clr_title or "ColourPicker"
    default = default or Color3.fromRGB(255, 255, 255)
    callback = callback or function() end
    local RainbowColorPicker = false
    
    local clr_yy = utility:Create("TextButton", {
        Name = clr_title.. "_ColourPicker",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundColor3 = Color3.fromRGB(27, 27, 27),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0.030927835, 0, 0.081395261, 0),
        Size = UDim2.new(0, 546, 0, 35),
        AutoButtonColor = false,
        Font = Enum.Font.Gotham,
        Text = "",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 14.000  
    },{utility:Create("UICorner", {
        CornerRadius = UDim.new(0, 6)
    }),
    utility:Create("Frame", {
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0, 38, 0, 35)
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.340000004, 0, 0.0839999989, 0),
        Size = UDim2.new(0, 170, 0, 29),
        Font = Enum.Font.Gotham,
        Text = clr_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    },{utility:Create("ImageLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        Position = UDim2.new(2.61735296, 0, 0.103448279, 0),
        Size = UDim2.new(0, 69, 0, 23),
        Image = "rbxassetid://3570695787",
        ImageColor3 = default,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.120
    }),
    utility:Create("ImageButton", {
        Name = "Color",
        BorderSizePixel = 0,
        Position = UDim2.new(0.0659999996, 0, 3.44168973, 0),
        Size = UDim2.new(0, 500, 0, 26),
        AutoButtonColor = false,
        Image = "rbxassetid://5028857472",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 298, 298)
    },{utility:Create("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }),
    utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), 
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)), 
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), 
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), 
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), 
            ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255, 0, 255)), 
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
        })
    }),
    utility:Create("Frame", {
        Name = "Select",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0.00800000038, 0, 0, 0),
        Size = UDim2.new(0, 3, 0, 26)
    })
}),
utility:Create("ImageButton", {
    Name = "Canvas",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    Position = UDim2.new(0.0659999996, 0, 1.30375862, 0),
    Size = UDim2.new(0, 500, 0, 52),
    AutoButtonColor = false,
    Image = "rbxassetid://5108535320",
    ImageColor3 = default,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(2, 2, 298, 298)
},{utility:Create("ImageLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 5.86876524e-07, 0),
    Size = UDim2.new(0, 500, 0, 52),
    Image = "rbxassetid://5107152351",
    SliceCenter = Rect.new(2, 2, 298, 298)
}),
utility:Create("ImageLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderColor3 = Color3.fromRGB(27, 42, 53),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 5.86876524e-07, 0),
    Size = UDim2.new(0, 500, 0, 52),
    Image = "rbxassetid://5107152095",
    SliceCenter = Rect.new(2, 2, 298, 298)
}),
utility:Create("ImageLabel", {
    Name = "Cursor",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.263888896, 0, 0.524999976, 0),
    Size = UDim2.new(0, 10, 0, 10),
    Image = "rbxassetid://5100115962",
    SliceCenter = Rect.new(2, 2, 298, 298)
})

}),
utility:Create("Frame", {
    Name = "Shesh",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    Position = UDim2.new(-0.0235294104, 0, 4.57962132, 0),
    Size = UDim2.new(0, 4, 0, 44)
},{utility:Create("Frame", {
    Name = "R",
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderSizePixel = 0,
    Position = UDim2.new(3.97579956, 0, 0.227272719, 0),
    Size = UDim2.new(0, 80, 0, 23)
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    Position = UDim2.new(0.0500000045, 0, 0, 0),
    Size = UDim2.new(0, 20, 0, 23),
    Font = Enum.Font.Gotham,
    Text = "R:",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 15.000,
    TextStrokeColor3 = Color3.fromRGB(255, 255, 255),
    TextWrapped = true
}),
utility:Create("TextBox", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.300000012, 0, 0, 0),
    Size = UDim2.new(0, 56, 0, 23),
    Font = Enum.Font.Gotham,
    PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
    Text = "255",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 15.000,
    TextStrokeColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})
}),
utility:Create("Frame", {
    Name = "G",
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderSizePixel = 0,
    Position = UDim2.new(25.4757996, 0, 0.227272719, 0),
    Size = UDim2.new(0, 80, 0, 23)
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    Position = UDim2.new(0.0500000045, 0, 0, 0),
    Size = UDim2.new(0, 20, 0, 23),
    Font = Enum.Font.Gotham,
    Text = "G:",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 15.000,
    TextStrokeColor3 = Color3.fromRGB(255, 255, 255),
    TextWrapped = true
}),
utility:Create("TextBox", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.300000012, 0, 0, 0),
    Size = UDim2.new(0, 56, 0, 23),
    Font = Enum.Font.Gotham,
    PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
    Text = "255",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 15.000,
    TextStrokeColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})
}),
utility:Create("Frame", {
    Name = "B",
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BorderSizePixel = 0,
    Position = UDim2.new(46.9757996, 0, 0.227272719, 0),
    Size = UDim2.new(0, 80, 0, 23)
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    Position = UDim2.new(0.0500000045, 0, 0, 0),
    Size = UDim2.new(0, 20, 0, 23),
    Font = Enum.Font.Gotham,
    Text = "B:",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 15.000,
    TextStrokeColor3 = Color3.fromRGB(255, 255, 255),
    TextWrapped = true
}),
utility:Create("TextBox", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.300000012, 0, 0, 0),
    Size = UDim2.new(0, 56, 0, 23),
    Font = Enum.Font.Gotham,
    PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
    Text = "255",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 15.000,
    TextStrokeColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})
}),
utility:Create("ImageButton", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(103.499985, 0, 0.204545468, 0),
    Size = UDim2.new(0, 101, 0, 23),
    AutoButtonColor = false,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(37, 37, 37),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.080
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Size = UDim2.new(0, 101, 0, 23),
    Font = Enum.Font.Gotham,
    Text = "Submit",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16.000
})}),
utility:Create("ImageButton", {
    Name = "Tog",
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Position = UDim2.new(71.9999847, 0, 0.227272734, 0),
    Size = UDim2.new(0, 120, 0, 23),
    AutoButtonColor = false,
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(37, 37, 37),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 0.080
},{utility:Create("TextLabel", {
    BackgroundColor3 = Color3.fromRGB(37, 37, 37),
    BackgroundTransparency = 1.000,
    BorderSizePixel = 0,
    Position = UDim2.new(0.0740000382, 0, -0.00324282446, 0),
    Size = UDim2.new(0, 111, 0, 23),
    Font = Enum.Font.Gotham,
    Text = "Rainbow",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16.000,
    TextXAlignment = Enum.TextXAlignment.Left
},{utility:Create("ImageLabel", {
    BackgroundTransparency = 1.000,
    Position = UDim2.new(0.707657695, 0, 0.0434782654, 0),
    Size = UDim2.new(0, 20, 0, 20),
    Image = "rbxassetid://3926305904",
    ImageRectOffset = Vector2.new(4, 4),
    ImageRectSize = Vector2.new(24, 24)
})})})
})
})
})
})

local draggingColor, draggingCanvas
local color3 = default or Color3.fromRGB(255, 255, 255)
local hue, sat, brightness = 0, 0, 1
local rgb = {
    r = 255,
    g = 255,
    b = 255
}

local color_fr = clr_yy.Frame.TextLabel.Color
local color_ff = clr_yy.Frame.TextLabel.Canvas

local canvasSize, canvasPosition = color_ff.AbsoluteSize, color_ff.AbsolutePosition
local colorSize, colorPosition = color_fr.AbsoluteSize, color_fr.AbsolutePosition
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local function GetXY(GuiObject)
    local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
    local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
    return Px/Max, Py/May
end

local function chahahhaha(vallala)
if not vallala then
return
end
    local color3
    local hue, sat, brightness
    
    if type(vallala) == "table" then -- roblox is literally retarded x2
        hue, sat, brightness = unpack(vallala)
        color3 = Color3.fromHSV(hue, sat, brightness)
    else
        color3 = vallala
        hue, sat, brightness = Color3.toHSV(color3)
    end

    utility:Tween(clr_yy.Frame.TextLabel.Canvas, {ImageColor3 = color3}, 0.5)
    utility:Tween(clr_yy.Frame.TextLabel.Color.Select, {Position = UDim2.new(hue, 0, 0, 0)}, 0.1)

    utility:Tween(clr_yy.Frame.TextLabel.ImageLabel, {ImageColor3 = color3}, 0.5)
    
    for i, container in pairs(clr_yy.Frame.TextLabel.Shesh:GetChildren()) do
        if container:IsA("Frame") then
            local value = math.clamp(color3[container.Name], 0, 1) * 255

            container.TextBox.Text = math.floor(value)
            --callback(container.Name:lower(), value)
        end
    end

end
local lastColor;
if default then
    chahahhaha(default)

    hue, sat, brightness = Color3.toHSV(default)
    default = Color3.fromHSV(hue, sat, brightness)
    lastColor = Color3.fromHSV(hue, sat, brightness)
    for i, prop in pairs({"r", "g", "b"}) do
        rgb[prop] = default[prop:upper()] * 255
    end
end




color_fr.MouseButton1Down:Connect(function()
    draggingColor = true
    
    while draggingColor do

        hue = 1 - math.clamp(1 - GetXY(color_fr), 0, 1)
        color3 = Color3.fromHSV(hue, sat, brightness)
        
        for i, prop in pairs({"r", "g", "b"}) do
            rgb[prop] = color3[prop:upper()] * 255
        end

        local x = hue -- hue is updated
        chahahhaha({hue, sat, brightness}) -- roblox is literally retarded
        utility:Tween(clr_yy.Frame.TextLabel.Color.Select, {Position = UDim2.new(x, 0, 0, 0)}, 0.1) -- overwrite
        
        callback(color3)
        utility:Wait()
    end
end)

color_ff.MouseButton1Down:Connect(function()
    draggingCanvas = true
    
    while draggingCanvas do
        
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local Mouse = LocalPlayer:GetMouse()

        local x, y = Mouse.X, Mouse.Y
        
        sat = math.clamp((mouse.X - color_ff.AbsolutePosition.X) / color_ff.AbsoluteSize.X, 0, 1)
        brightness = 1 - math.clamp((mouse.Y - color_ff.AbsolutePosition.Y) / color_ff.AbsoluteSize.Y, 0, 1)
        
        color3 = Color3.fromHSV(hue, sat, brightness)
        
        for i, prop in pairs({"r", "g", "b"}) do
            rgb[prop] = color3[prop:upper()] * 255
        end
        
        chahahhaha({hue, sat, brightness}) -- roblox is literally retarded
        utility:Tween(clr_yy.Frame.TextLabel.Canvas.Cursor, {Position = UDim2.new(sat, 0, 1 - brightness, 0)}, 0.1) -- overwrite
        
        callback(color3)
        utility:Wait()
    end
end)

clr_yy.Frame.TextLabel.Shesh.Tog.MouseButton1Down:Connect(function()
    RainbowColorPicker = not RainbowColorPicker

    if RainbowColorPicker then

            if clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectOffset == Vector2.new(4, 4) then
                utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
                wait(0.01)
                clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(284, 924)
                clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectSize = Vector2.new(36, 36)
                utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
              else
                utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
                wait(0.01)
                clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(4, 4)
                clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectSize = Vector2.new(24, 24)
                utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
              end


        OldColor = clr_yy.Frame.TextLabel.ImageLabel.ImageColor3

        while RainbowColorPicker do
            clr_yy.Frame.TextLabel.ImageLabel.ImageColor3 = library.RainbowColorValue

            chahahhaha(library.RainbowColorValue)

            pcall(callback, clr_yy.Frame.TextLabel.ImageLabel.ImageColor3)
            wait()
        end
    elseif not RainbowColorPicker then
        if clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectOffset == Vector2.new(4, 4) then
            utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(284, 924)
            clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectSize = Vector2.new(36, 36)
            utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
          else
            utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 1}, 0.7)
            wait(0.01)
            clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectOffset = Vector2.new(4, 4)
            clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel.ImageRectSize = Vector2.new(24, 24)
            utility:Tween(clr_yy.Frame.TextLabel.Shesh.Tog.TextLabel.ImageLabel, {ImageTransparency = 0}, 0.7)
          end

        clr_yy.Frame.TextLabel.ImageLabel.ImageColor3 = OldColor

        chahahhaha(OldColor)

        pcall(callback, OldColor)
    end
end)

clr_yy.MouseButton1Click:Connect(function()
    if clr_yy.Size == UDim2.new(0, 546, 0, 180) then
        chahahhaha(lastColor)
        callback(lastColor)
    end
    utility:Tween(clr_yy, {Size = clr_yy.Size == UDim2.new(0, 546, 0, 180) and UDim2.new(0, 546, 0, 35) or UDim2.new(0, 546, 0, 180)}, 0.4)
end)

input.InputEnded:Connect(function(key)
    if key.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingColor = false
        draggingCanvas = false
    end
end)

clr_yy.Frame.TextLabel.Shesh.ImageButton.MouseButton1Click:Connect(function()
    lastColor = Color3.fromHSV(hue, sat, brightness)
    utility:Tween(clr_yy, {Size = clr_yy.Size == UDim2.new(0, 546, 0, 180) and UDim2.new(0, 546, 0, 35) or UDim2.new(0, 546, 0, 180)}, 0.4)
end)

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end

function OldVestraUi:slider(stn_title, min, max ,start ,callback)
    stn_title = stn_title or "Slider"
    min = min or 0
    max = max or 100
    start = start or min
    callback = callback or function() end
    local value = start
    local dragging = false
    
    local stn_yy = utility:Create("ImageButton", {
        Name = stn_title .. "_Slider",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 546, 0, 35),
        AutoButtonColor = false,
        Image = "rbxassetid://3570695787",
        ImageColor3 = themes.DarkContrast,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0240000002, 0, 0.0837142915, 0),
        Size = UDim2.new(0, 170, 0, 29),
        Font = Enum.Font.Gotham,
        Text = stn_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    },{utility:Create("TextBox", {
        BackgroundColor3 = Color3.fromRGB(37, 37, 37),
        BorderSizePixel = 0,
        Position = UDim2.new(2.61735296, 0, 0.103482753, 0),
        Size = UDim2.new(0, 69, 0, 23),
        Font = Enum.Font.Gotham,
        Text = tostring(value),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14.000,
    },{utility:Create("UICorner", {
        CornerRadius = UDim.new(0, 4)
    })})}),
    utility:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(37, 37, 37),
        BorderSizePixel = 0,
        Position = UDim2.new(0.357168466, 0, 0.398571789, 0),
        Size = UDim2.new(0.494999975, -20, 0.00585727673, 5)
    },{utility:Create("UICorner", {
        CornerRadius = UDim.new(0, 4)
    }),
    utility:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Size = UDim2.new(0.191327825, -20, 0.00579322269, 5)
    },{utility:Create("UICorner", {
        CornerRadius = UDim.new(0, 4)
    })})
})
})

local function slider_u(value)
    local bar = stn_yy.Frame
    local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
    
    if value then -- support negative ranges
        percent = (value - min) / (max - min)
    end
    
    percent = math.clamp(percent, 0, 1)
    value = value or math.floor(min + (max - min) * percent)
    
    stn_yy.TextLabel.TextBox.Text = value
    utility:Tween(bar.Frame, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
    return value
end

slider_u(tostring(value))

    stn_yy.MouseButton1Down:Connect(function(input)
        dragging = true
        while dragging do

            value = slider_u()
            callback(value)
            
            utility:Wait()
        end

    end)

    input.InputEnded:Connect(function(key)
        if key.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local allowed = {
        [""] = true,
        ["-"] = true
    }

local textbox = stn_yy.TextLabel.TextBox
    textbox.FocusLost:Connect(function()
        if not tonumber(textbox.Text) then
            value = slider_u(start or min)
            callback(value)
        end
    end)
    
    textbox:GetPropertyChangedSignal("Text"):Connect(function()
        local text = textbox.Text
        
        if not allowed[text] and not tonumber(text) then
            textbox.Text = text:sub(1, #text - 1)
        elseif not allowed[text] then	
            value = slider_u(tonumber(text) or value)
            callback(value)
        end
    end)

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end

function OldVestraUi:keybind(key_title,default,callback)
    key_title = key_title or "Button"
    default = default or Enum.KeyCode.D
    callback = callback or function() end
    local KEY = default.Name
    local binding = false

    local key_yy = utility:Create("ImageButton", {
        Name = key_title .. "_Keybind",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0.030927835, 0, 0.719375074, 0),
        Size = UDim2.new(0, 546, 0, 35),
        AutoButtonColor = false,
        Image = "rbxassetid://3570695787",
        ImageColor3 = themes.DarkContrast,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0240000002, 0, 0.0837142915, 0),
        Size = UDim2.new(0, 170, 0, 29),
        Font = Enum.Font.Gotham,
        Text = key_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(3.042, 0,0.481, 0),
        Size = UDim2.new(0, 45, 0, 29),
        Font = Enum.Font.Gotham,
        Text = KEY,
        TextColor3 = Color3.fromRGB(178, 178, 178),
        TextSize = 16,
        AnchorPoint = Vector2.new(1, 0.5)
    })}),
})


local key_holder = key_yy.TextLabel.TextLabel

local inputconnection
local connection
local changing = false

key_yy.MouseButton1Click:Connect(function()
    changing = true
    key_holder.Text = "..."
    connection = game:GetService("UserInputService").InputBegan:Connect(function(i)
        if i.UserInputType.Name == "Keyboard" and i.KeyCode ~= Enum.KeyCode.Backspace and i.KeyCode ~= Enum.KeyCode.Tab then
            key_holder.Text = i.KeyCode.Name
            KEY = i.KeyCode
            if connection then
                connection:Disconnect()
                connection = nil
                utility:Wait()
                changing = false
            end
        elseif i.KeyCode == Enum.KeyCode.Backspace or i.KeyCode == Enum.KeyCode.Tab then
            key_holder.Text = "None"
            KEY = nil
            if connection then
                connection:Disconnect()
                connection = nil 
                utility:Wait()
                changing = false
            end
        end
    end)
end)

inputconnection = game:GetService("UserInputService").InputBegan:Connect(function(i, GPE)
    if KEY and i.KeyCode == default and not GPE and not connection then
        if callback and not changing then
            callback(i.KeyCode)
        end
    end
end)

table.insert(VestraLib_Con, inputconnection)
table.insert(VestraLib_Con, connection)

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)

end

function OldVestraUi:textbox(txt_title,default,callback)
    txt_title = txt_title or "Button"
    default = default or "Text"
    callback = callback or function() end

    local txt_yy = utility:Create("ImageButton", {
        Name = txt_title .. "_TextBox",
        Parent = MainFrame.Categories[Tab_Name],
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 546, 0, 35),
        AutoButtonColor = false,
        Image = "rbxassetid://3570695787",
        ImageColor3 = themes.DarkContrast,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.080
    },{utility:Create("TextLabel", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0240000002, 0, 0.0837142915, 0),
        Size = UDim2.new(0, 170, 0, 29),
        Font = Enum.Font.Gotham,
        Text = txt_title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    },{
        utility:Create("TextBox", {
            BackgroundColor3 = Color3.fromRGB(37, 37, 37),
            BorderColor3 = Color3.fromRGB(202, 202, 202),
            BorderSizePixel = 0,
            Position = UDim2.new(3.02941179, 0, 0.482758611, 0),
            Size = UDim2.new(0, 121, 0, 24),
            Font = Enum.Font.Gotham,
            PlaceholderText = default,
            PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
            Text = "",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            AnchorPoint = Vector2.new(1, 0.5)
        },{utility:Create("UICorner", {
            CornerRadius = UDim.new(0, 4)
        })
    })  
    })})

local TextBox = txt_yy.TextLabel.TextBox


txt_yy.MouseButton1Click:Connect(function()
    TextBox:CaptureFocus()
end)

TextBox.Changed:Connect(function(ep)
        if ep then
            utility:Tween(TextBox, {Size = UDim2.new(0, TextBox.TextBounds.X + 18, 0, 24)}, 0.1)
        end
end)

TextBox.FocusLost:Connect(function(ep)
        if ep then
            if #TextBox.Text > 0 then
                pcall(callback, TextBox.Text)
            end
        end
end)

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
        if #TextBox.Text > 0 then
            pcall(callback, TextBox.Text)
        end
end)

MainFrame.Categories[Tab_Name].CanvasSize = UDim2.new(0, 0, 0, MainFrame.Categories[Tab_Name].UIListLayout.AbsoluteContentSize.Y)
end
return OldVestraUi
end
return tabhold
end
return library