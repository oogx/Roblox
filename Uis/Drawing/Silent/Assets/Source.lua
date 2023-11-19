local services = setmetatable({}, {
    __index = function(_, k)
        k = (k == "InputService" and "UserInputService") or k
        return game:GetService(k)
    end
})
local themes = {
    ["Default"] = {
        ["Main Background"] = Color3.fromRGB(36, 36, 36),
        ["Left Background"] = Color3.fromRGB(28, 28, 28),
        ["Object Background"] = Color3.fromRGB(41, 41, 50),
        ["Section Background"] = Color3.fromRGB(25, 25, 25),
        ["Window Border"] = Color3.fromRGB(58, 58, 67),
        ["Inner Border"] = Color3.fromRGB(50, 50, 58),
        ["Outer Border"] = Color3.fromRGB(19, 19, 27),
        ["Text"] = Color3.fromRGB(255, 255, 255),
        ["Risky"] = Color3.fromRGB(255, 0, 0),
        ["Accent"] = Color3.fromRGB(51, 91, 232),
    }
}
local library = {
    Folder = "SilentSolutions", 
    Open = true, 
    Performance = true, 
    Initialised = false,
    Risky = false,
    Connections = {},
    Holder = nil,
    KeybindList = nil,
    Theme = table.clone(themes.Default),
    Flags = {}
}
getgenv().SilentFolder = library.Folder
if not isfolder(library.Folder) then
    makefolder(library.Folder)
    makefolder(library.Folder.."/Configs")
    makefolder(library.Folder.."/Assets")
    makefolder(library.Folder.."/Utility")
    writefile(library.Folder.."/Utility/Extension.lua",game:HttpGet("https://raw.githubusercontent.com/VestraTech/Roblox/main/Uis/Drawing/Silent/Utility/Extension.lua"))
    writefile(library.Folder.."/Utility/Signal.lua",game:HttpGet("https://raw.githubusercontent.com/VestraTech/Roblox/main/Uis/Drawing/Silent/Utility/Signal.lua"))
end
local drawing = loadstring(readfile(tostring(library.Folder.."/Utility/Extension.lua")))()
local themeobjects = {}
local images = {
    ['gradient3'] = "https://raw.githubusercontent.com/VestraTech/Roblox/main/Uis/Drawing/DeadCell/Assets/Gradient3.png",
    ['gradient4'] = "https://raw.githubusercontent.com/VestraTech/Roblox/main/Uis/Drawing/DeadCell/Assets/Gradient4.png",
    ['down'] = "https://raw.githubusercontent.com/VestraTech/Roblox/main/Uis/Drawing/DeadCell/Assets/Down.png",
    ['up'] = "https://raw.githubusercontent.com/VestraTech/Roblox/main/Uis/Drawing/DeadCell/Assets/Up.png",
}
for i,v in pairs(images) do
    if not isfile(library.Folder..'/Assets/'..i..'.png') then
        writefile(library.Folder..'/Assets/'..i..'.png', game:HttpGet(v))
    end
    images[i] = readfile(library.Folder..'/Assets/'..i..'.png')
end
local keys = {
    [Enum.KeyCode.LeftShift] = "LeftShift",
    [Enum.KeyCode.RightShift] = "RightShift",
    [Enum.KeyCode.LeftControl] = "LeftControl",
    [Enum.KeyCode.RightControl] = "RightControl",
    [Enum.KeyCode.LeftAlt] = "LeftAlt",
    [Enum.KeyCode.RightAlt] = "RightAlt",
    [Enum.KeyCode.CapsLock] = "CAPS",
    [Enum.KeyCode.One] = "1",
    [Enum.KeyCode.Two] = "2",
    [Enum.KeyCode.Three] = "3",
    [Enum.KeyCode.Four] = "4",
    [Enum.KeyCode.Five] = "5",
    [Enum.KeyCode.Six] = "6",
    [Enum.KeyCode.Seven] = "7",
    [Enum.KeyCode.Eight] = "8",
    [Enum.KeyCode.Nine] = "9",
    [Enum.KeyCode.Zero] = "0",
    [Enum.KeyCode.KeypadOne] = "Numpad1",
    [Enum.KeyCode.KeypadTwo] = "Numpad2",
    [Enum.KeyCode.KeypadThree] = "Numpad3",
    [Enum.KeyCode.KeypadFour] = "Numpad4",
    [Enum.KeyCode.KeypadFive] = "Numpad5",
    [Enum.KeyCode.KeypadSix] = "Numpad6",
    [Enum.KeyCode.KeypadSeven] = "Numpad7",
    [Enum.KeyCode.KeypadEight] = "Numpad8",
    [Enum.KeyCode.KeypadNine] = "Numpad9",
    [Enum.KeyCode.KeypadZero] = "Numpad0",
    [Enum.KeyCode.Minus] = "-",
    [Enum.KeyCode.Equals] = "=",
    [Enum.KeyCode.Tilde] = "~",
    [Enum.KeyCode.LeftBracket] = "[",
    [Enum.KeyCode.RightBracket] = "]",
    [Enum.KeyCode.RightParenthesis] = ")",
    [Enum.KeyCode.LeftParenthesis] = "(",
    [Enum.KeyCode.Semicolon] = ",",
    [Enum.KeyCode.Quote] = "'",
    [Enum.KeyCode.BackSlash] = "\\",
    [Enum.KeyCode.Comma] = ",",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Slash] = "/",
    [Enum.KeyCode.Asterisk] = "*",
    [Enum.KeyCode.Plus] = "+",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Backquote] = "`",
    [Enum.UserInputType.MouseButton1] = "MouseButton1",
    [Enum.UserInputType.MouseButton2] = "MouseButton2",
    [Enum.UserInputType.MouseButton3] = "MouseButton3"
}
local utility = {}
local totalunnamedflags = 0
function utility.textlength(str, font, fontsize)
    local text = Drawing.new("Text")
    text.Text = str
    text.Font = font
    text.Size = fontsize
    local textbounds = text.TextBounds
    text:Remove()
    return textbounds
end
function utility.getcenter(sizeX, sizeY)
    return UDim2.new(0.5, -(sizeX / 2), 0.5, -(sizeY / 2))
end
function utility.round(number, float)
    return float * math.floor(number / float)
end
function utility.nextflag()
    totalunnamedflags = totalunnamedflags + 1
    return string.format("%.14g", totalunnamedflags)
end
function utility.table(tbl, usemt)
    tbl = tbl or {}
    local oldtbl = table.clone(tbl)
    table.clear(tbl)
    for i, v in pairs(oldtbl) do
        if type(i) == "string" then
            tbl[i:lower()] = v
        else
            tbl[i] = v
        end
    end
    if usemt == true then
        setmetatable(tbl, {
            __index = function(t, k)
                return rawget(t, k:lower()) or rawget(t, k)
            end,
            __newindex = function(t, k, v)
                if type(k) == "string" then
                    rawset(t, k:lower(), v)
                else
                    rawset(t, k, v)
                end
            end
        })
    end
    return tbl
end
function utility.rgb(r, g, b)
    local rgb = Color3.fromRGB(r, g, b)
    return rgb
end

local Flags = {}
function utility.outline(obj, color)
    local outline = drawing:new("Square")
    outline.Parent = obj
    outline.Size = UDim2.new(1, 2, 1, 2)
    outline.Position = UDim2.new(0, -1, 0, -1)
    outline.ZIndex = obj.ZIndex - 1
    if typeof(color) == "Color3" then
        outline.Color = color
    else
        outline.Color = library.Theme[color]
        themeobjects[outline] = color
    end
    outline.Parent = obj
    outline.Filled = false
    outline.Thickness = 1
    return outline
end
function utility.create(class, properties)
    local obj = drawing:new(class)
    for prop, v in pairs(properties) do
        if prop == "Theme" then
            themeobjects[obj] = v
            obj.Color = library.Theme[v]
        else
            obj[prop] = v
        end
    end
    return obj
end
function utility.changeobjecttheme(object, color)
    themeobjects[object] = color
    object.Color = library.Theme[color]
end
function utility.connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(library.Connections, connection)
    return connection
end
function utility.disconnect(connection)
    local index = table.find(library.Connections, connection)
    connection:Disconnect()
    if index then
        table.remove(library.Connections, index)
    end
end
function library:HideUi()
    if self.Initialised then
        self.Open = not self.Open
        if self.Holder then
            self.Holder.Visible = self.Open
        end
    end
end
function library:ChangeThemeOption(option, r,g,b)
    for obj, theme in pairs(themeobjects) do
        if rawget(obj, "exists") == true and theme == option then
            library.Theme[option] = utility.rgb(r,g,b)
            obj.Color = utility.rgb(r,g,b)
        end
    end
end
function library:DeleteUi()
    self.Initialised = false
    if self.Holder and self.KeybindList then
        self.Holder.Visible = false
        self.KeybindList.Visible = false
        wait()
        self.Holder:Remove()
        self.KeybindList:Remove()     
    end
end
function utility.dragify(main, dragoutline, object)
    local start, objectposition, dragging, currentpos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            start = input.Position
            objectposition = object.Position
            if library.Performance then
                dragoutline.Visible = true
                dragoutline.Position = objectposition
            end
        end
    end)
    utility.connect(services.InputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            currentpos = UDim2.new(objectposition.X.Scale, objectposition.X.Offset + (input.Position - start).X, objectposition.Y.Scale, objectposition.Y.Offset + (input.Position - start).Y)
            if library.Performance then
                dragoutline.Position = currentpos
            else
                object.Position = currentpos
            end
        end
    end)
    utility.connect(services.InputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then 
            dragging = false
            if library.Performance then
                dragoutline.Visible = false
                object.Position = currentpos
            end
        end
    end)
end
local allowedcharacters = {}
local shiftcharacters = {
    ["1"] = "!",
    ["2"] = "@",
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
    ["7"] = "&",
    ["8"] = "*",
    ["9"] = "(",
    ["0"] = ")",
    ["-"] = "_",
    ["="] = "+",
    ["["] = "{",
    ["\\"] = "|",
    [";"] = ":",
    ["'"] = "\"",
    [","] = "<",
    ["."] = ">",
    ["/"] = "?",
    ["`"] = "~"
}
for i = 32, 126 do
    table.insert(allowedcharacters, utf8.char(i))
end
function library.CreateTextbox(box, text, callback, finishedcallback)
    box.MouseButton1Click:Connect(function()
        services.ContextActionService:BindActionAtPriority("disablekeyboard", function() return Enum.ContextActionResult.Sink end, false, 3000, Enum.UserInputType.Keyboard)
        local connection
        local backspaceconnection
        local keyqueue = 0
        if not connection then
            connection = utility.connect(services.InputService.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    if input.KeyCode ~= Enum.KeyCode.Backspace then
                        local str = services.InputService:GetStringForKeyCode(input.KeyCode)
                        if table.find(allowedcharacters, str) then
                            keyqueue = keyqueue + 1
                            local currentqueue = keyqueue
                            if not services.InputService:IsKeyDown(Enum.KeyCode.RightShift) and not services.InputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                                text.Text = text.Text .. str:lower()
                                callback(text.Text)
                                local ended = false
                                coroutine.wrap(function()
                                    task.wait(0.5)
                                    while services.InputService:IsKeyDown(input.KeyCode) and currentqueue == keyqueue  do
                                        text.Text = text.Text .. str:lower()
                                        callback(text.Text)
                                        task.wait(0.02)
                                    end
                                end)()
                            else
                                text.Text = text.Text .. (shiftcharacters[str] or str:upper())
                                callback(text.Text)
                                coroutine.wrap(function()
                                    task.wait(0.5)
                                    while services.InputService:IsKeyDown(input.KeyCode) and currentqueue == keyqueue  do
                                        text.Text = text.Text .. (shiftcharacters[str] or str:upper())
                                        callback(text.Text)
                                        task.wait(0.02)
                                    end
                                end)()
                            end
                        end
                    end
                    if input.KeyCode == Enum.KeyCode.Return then
                        services.ContextActionService:UnbindAction("disablekeyboard")
                        utility.disconnect(backspaceconnection)
                        utility.disconnect(connection)
                        finishedcallback(text.Text)
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    services.ContextActionService:UnbindAction("disablekeyboard")
                    utility.disconnect(backspaceconnection)
                    utility.disconnect(connection)
                    finishedcallback(text.Text)
                end
            end)
            local backspacequeue = 0
            backspaceconnection = utility.connect(services.InputService.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Backspace then
                    backspacequeue = backspacequeue + 1
                    text.Text = text.Text:sub(1, -2)
                    callback(text.Text)
                    local currentqueue = backspacequeue
                    coroutine.wrap(function()
                        task.wait(0.5)
                        if backspacequeue == currentqueue then
                            while services.InputService:IsKeyDown(Enum.KeyCode.Backspace) do
                                text.Text = text.Text:sub(1, -2)
                                callback(text.Text)
                                task.wait(0.02)
                            end
                        end
                    end)()
                end
            end)
        end
    end)
end
local ColourPickers = {}
function library.CreateColourPicker(default, parent, count, flag, callback, offsetX, offsetY)
    local icon = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Color = default,
        Parent = parent,
        Transparency = defaultalpha,
        Size = UDim2.new(0, 17, 0, 9),
        Position = UDim2.new(1, -17 - (count * 17) - (count * 6), offsetX, offsetY),
        ZIndex = 8
    })
    local outline = utility.outline(icon, "Inner Border")
    utility.outline(outline, "Outer Border")
    local window = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = icon,
        Theme = "Object Background",
        Size = UDim2.new(0, 185, 0, 180),
        Visible = false,
        Position = UDim2.new(1,0 + (count * 20) + (count * 6), 1, 6),
        ZIndex = 20
    })
    table.insert(ColourPickers, window)
    local outline1 = utility.outline(window, "Inner Border")
    utility.outline(outline1, "Outer Border")
    local saturation = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = window,
        Color = default,
        Size = UDim2.new(0, 154, 0, 150),
        Position = UDim2.new(0, 6, 0, 6),
        ZIndex = 24
    })
    utility.outline(saturation, "Inner Border")
    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 25,
        Parent = saturation,
        Data = images.gradient3,
    })
    local saturationpicker = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = saturation,
        Color = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0, 2, 0, 2),
        ZIndex = 26
    })
    utility.outline(saturationpicker, Color3.fromRGB(0, 0, 0))
    local hueframe = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = window,
        Size = UDim2.new(0,15, 0, 150),
        Position = UDim2.new(0, 165, 0, 6),
        ZIndex = 24
    })
    utility.outline(hueframe, "Inner Border")
    utility.create("Image", {
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 25,
        Parent = hueframe,
        Data = images.gradient4,
    })
    local huepicker = utility.create("Square", {
        Filled = true,
        Thickness = 0,
        Parent = hueframe,
        Color = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1,0,0,1),
        ZIndex = 26
    })
    utility.outline(huepicker, Color3.fromRGB(0, 0, 0))
    local rgbinput = utility.create("Square", {
        Filled = true,
        Transparency = 1,
        Thickness = 1,
        Theme = "Object Background",
        Size = UDim2.new(1, -12, 0, 14),
        Position = UDim2.new(0, 6, 0, 160),
        ZIndex = 24,
        Parent = window
    })

    local outline2 = utility.outline(rgbinput, "Inner Border")
    utility.outline(outline2, "Outer Border")
    local text = utility.create("Text", {
        Text = string.format("%s,%s,%s", math.floor(default.R * 255), math.floor(default.G * 255), math.floor(default.B * 255)),
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0.5, 0, 0, 0),
        Center = true,
        Theme = "Text",
        ZIndex = 26,
        Outline = true,
        Parent = rgbinput
    })
    local function set(color)
        if type(color) == "table" then
            color = Color3.fromHex(color.color)
        end
        if type(color) == "string" then
            color = Color3.fromHex(color)
        end
        local oldcolor = hsv
        hue, sat, val = color:ToHSV()
        hsv = Color3.fromHSV(hue, sat, val)
        if hsv ~= oldcolor then
            icon.Color = hsv
            saturationpicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 2)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 2)))
            huepicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4))
            saturation.Color = hsv
            text.Text = string.format("%s,%s,%s", math.round(hsv.R * 255), math.round(hsv.G * 255), math.round(hsv.B * 255))
            local currentvalue = (""..math.round(hsv.R * 255)..","..math.round(hsv.G * 255)..","..math.round(hsv.B * 255).."")
            if flag then
                library.Flags[flag] = currentvalue
            end
            callback(math.round(hsv.R * 255),math.round(hsv.G * 255),math.round(hsv.B * 255))
        end
    end
    Flags[flag] = set
    set(default)
    local defhue, _, _ = default:ToHSV()
    local curhuesizey = defhue
    local function updatesatval(input)
        local sizeX = math.clamp((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X, 0, 1)
        local sizeY = 1 - math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) + 36) / saturation.AbsoluteSize.Y, 0, 1)
        local posY = math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y) * saturation.AbsoluteSize.Y + 36, 0, saturation.AbsoluteSize.Y - 2)
        local posX = math.clamp(((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X) * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 2)
        saturationpicker.Position = UDim2.new(0, posX, 0, posY)
        set(Color3.fromHSV(curhuesizey or hue, sizeX, sizeY), true, false)
    end
    local slidingsaturation = false
    saturation.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then slidingsaturation = true updatesatval(input) end end)
    saturation.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then slidingsaturation = false end end)
    local slidinghue = false
    local function updatehue(input)
        local sizeY = 1 - math.clamp(((input.Position.Y - hueframe.AbsolutePosition.Y) + 36) / hueframe.AbsoluteSize.Y, 0, 1)
        local posY = math.clamp(((input.Position.Y - hueframe.AbsolutePosition.Y) / hueframe.AbsoluteSize.Y) * hueframe.AbsoluteSize.Y + 36, 0, hueframe.AbsoluteSize.Y - 2)
        huepicker.Position = UDim2.new(0, 0, 0, posY)
        saturation.Color = Color3.fromHSV(sizeY, 1, 1)
        curhuesizey = sizeY
        set(Color3.fromHSV(sizeY, sat, val))
    end
    hueframe.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then slidinghue = true updatehue(input) end end)
    hueframe.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then slidinghue = false end end)
    utility.connect(services.InputService.InputChanged, function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then if slidinghue then updatehue(input) end if slidingsaturation then updatesatval(input) end end end)
    icon.MouseButton1Click:Connect(function() for _, picker in pairs(ColourPickers) do if picker ~= window then picker.Visible = false end end window.Visible = not window.Visible if slidinghue then slidinghue = false end if slidingsaturation then slidingsaturation = false end end)
    local colorpickertypes = {}
    function colorpickertypes:Set(color) set(color) end
    return colorpickertypes, window
end
function library.CreateDropdown(holder, content, flag, callback, default, max, scrollable, scrollingmax, islist, size, section, sectioncontent)
    local dropdown = utility.create("Square", {
        Filled = true,
        Visible = not islist,
        Thickness = 0,
        Theme = "Object Background",
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 0, 1, -15),
        ZIndex = 7,
        Parent = holder
    })
    local outline1 = utility.outline(dropdown, "Inner Border")
    utility.outline(outline1, "Outer Border")
    local value = utility.create("Text", {
        Text = "",
        Font = Drawing.Fonts.Plex,
        Size = 13,
        Position = UDim2.new(0, 2, 0, 0),
        Theme = "Text",
        ZIndex = 9,
        Outline = false,
        Parent = dropdown
    })
    local icon = utility.create("Image", {Data = images.down, Transparency = 0.5, Visible = true, Parent = dropdown, Size = UDim2.new(0,9,0,6), ZIndex = 9, Position = UDim2.new(1, -13, 0, 4)})
    local contentframe = utility.create("Square", {
        Filled = true,
        Visible = islist or false,
        Thickness = 0,
        Theme = "Object Background",
        Size = islist and size == "Fill" and UDim2.new(1, 0, 1, -30) or islist and size ~= "Fill" and UDim2.new(1,0,0,size) or UDim2.new(1,0,0,0),
        Position = islist and UDim2.new(0, 0, 0, 14) or UDim2.new(0, 0, 1, 6),
        ZIndex = 12,
        Parent = islist and holder or dropdown
    })
    local outline2 = utility.outline(contentframe, "Inner Border")
    utility.outline(outline2, "Outer Border")
    local contentholder = utility.create("Square", {
        Transparency = 0,
        Size = UDim2.new(1, -6, 1, -6),
        Position = UDim2.new(0, 3, 0, 3),
        Parent = contentframe
    })
    if scrollable then
        contentholder:MakeScrollable()
    end
    contentholder:AddListLayout(3)
    local opened = false
    if not islist then
        dropdown.MouseButton1Click:Connect(function()
            opened = not opened
            contentframe.Visible = opened
            icon.Data = opened and images.up or images.down
        end)
    end
    local optioninstances = {}
    local count = 0
    local countindex = {}
    local function createoption(name)
        optioninstances[name] = {}
        countindex[name] = count + 1
        local button = utility.create("Square", {
            Filled = true,
            Transparency = 0,
            Thickness = 1,
            Theme = "Object Background",
            Size = UDim2.new(1, 0, 0, 16),
            ZIndex = 14,
            Parent = contentholder
        })
        optioninstances[name].button = button
        local title = utility.create("Text", {
            Text = name,
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Position = UDim2.new(0, 8, 0, 1),
            Theme = "Text",
            ZIndex = 15,
            Outline = true,
            Parent = button
        })
        optioninstances[name].text = title
        if scrollable then
            if count < scrollingmax and not islist then
                contentframe.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 6)
            end
        else
            if not islist then
                contentframe.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 6)
            end
        end
        if islist then
            holder.Position = holder.Position
        end
        count = count + 1
        return button, title
    end
    local chosen = max and {}
    local function handleoptionclick(option, button, text)
        button.MouseButton1Click:Connect(function()
            if max then
                if table.find(chosen, option) then
                    table.remove(chosen, table.find(chosen, option))
                    local textchosen = {}
                    local cutobject = false
                    for _, opt in pairs(chosen) do
                        table.insert(textchosen, opt)
                        if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 18) then
                            cutobject = true
                            table.remove(textchosen, #textchosen)
                        end
                    end
                    value.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                    utility.changeobjecttheme(text, "Text")
                    library.Flags[flag] = chosen
                    callback(chosen)
                else
                    if #chosen == max then
                        utility.changeobjecttheme(optioninstances[chosen[1]].text, "Text")
                        table.remove(chosen, 1)
                    end
                    table.insert(chosen, option)
                    local textchosen = {}
                    local cutobject = false
                    for _, opt in pairs(chosen) do
                        table.insert(textchosen, opt)
                        if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 18) then
                            cutobject = true
                            table.remove(textchosen, #textchosen)
                        end
                    end
                    value.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                    utility.changeobjecttheme(text, "Accent")
                    library.Flags[flag] = chosen
                    callback(chosen)
                end
            else
                for opt, tbl in pairs(optioninstances) do
                    if opt ~= option then
                        utility.changeobjecttheme(tbl.text, "Text")
                    end
                end
                chosen = option
                value.Text = option
                utility.changeobjecttheme(text, "Accent")
                library.Flags[flag] = option
                callback(option)
            end
        end)
    end
    local function createoptions(tbl)
        for _, option in pairs(tbl) do
            local button, text = createoption(option)
            handleoptionclick(option, button, text)
        end
    end
    createoptions(content)
    local set
    set = function(option)
        if max then
            option = type(option) == "table" and option or {}
            table.clear(chosen)
            for opt, tbl in pairs(optioninstances) do
                if not table.find(option, opt) then
                    utility.changeobjecttheme(tbl.text, "Text")
                end
            end
            for i, opt in pairs(option) do
                if table.find(content, opt) and #chosen < max then
                    table.insert(chosen, opt)
                    utility.changeobjecttheme(optioninstances[opt].text, "Accent")
                end
            end
            local textchosen = {}
            local cutobject = false
            for _, opt in pairs(chosen) do
                table.insert(textchosen, opt)
                if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 6) then
                    cutobject = true
                    table.remove(textchosen, #textchosen)
                end
            end
            value.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
            library.Flags[flag] = chosen
            callback(chosen)
        end
        if not max then
            for opt, tbl in pairs(optioninstances) do
                if opt ~= option then
                    utility.changeobjecttheme(tbl.text, "Text")
                end
            end
            if table.find(content, option) then
                chosen = option
                value.Text = option
                utility.changeobjecttheme(optioninstances[option].text, "Accent")
                library.Flags[flag] = chosen
                callback(chosen)
            else
                chosen = nil
                value.Text = ""
                library.Flags[flag] = chosen
                callback(chosen)
            end
        end
    end
    Flags[flag] = set
    set(default)
    local dropdowntypes = utility.table({}, true)
    function dropdowntypes:set(option)
        set(option)
    end
    function dropdowntypes:refresh(tbl)
        content = table.clone(tbl)
        count = 0
        for _, opt in pairs(optioninstances) do
            coroutine.wrap(function()
                opt.button:Remove()
            end)()
        end
        table.clear(optioninstances)
        createoptions(tbl)
        if scrollable then
            contentholder:RefreshScrolling()
        end
        value.Text = ""
        if max then
            table.clear(chosen)
        else
            chosen = nil
        end
        library.Flags[flag] = chosen
        callback(chosen)
    end
    function dropdowntypes:add(option)
        table.insert(content, option)
        local button, text = createoption(option)
        handleoptionclick(option, button, text)
    end
    function dropdowntypes:remove(option)
        if optioninstances[option] then
            count = count - 1
            optioninstances[option].button:Remove()
            if scrollable then
                contentframe.Size = UDim2.new(1, 0, 0, math.clamp(contentholder.AbsoluteContentSize, 0, (scrollingmax * 16) + ((scrollingmax - 1) * 3)) + 6)
            else
                contentframe.Size = UDim2.new(1, 0, 0, contentholder.AbsoluteContentSize + 6)
            end
            optioninstances[option] = nil
            if max then
                if table.find(chosen, option) then
                    table.remove(chosen, table.find(chosen, option))
                    local textchosen = {}
                    local cutobject = false
                    for _, opt in pairs(chosen) do
                        table.insert(textchosen, opt)
                        if utility.textlength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (dropdown.AbsoluteSize.X - 6) then
                            cutobject = true
                            table.remove(textchosen, #textchosen)
                        end
                    end
                    value.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                    library.Flags[flag] = chosen
                    callback(chosen)
                end
            end
        end
    end
    return dropdowntypes
end
function library.KeybindList()
    local keybind_list_tbl = {keybinds = {}}
    local keybind_list_drawings = {}
    local list_outline = utility.create("Square", {Visible = true, Transparency = 1, Theme = "Main Background", Size = UDim2.new(0, 180, 0, 30), Position = UDim2.new(0, 20, 0.4, 0), Thickness = 1, Filled = true, ZIndex = 100}) do
        local outline = utility.outline(list_outline, "Window Border")
        utility.outline(outline, Color3.new(0,0,0))
    end
    library.KeybindList = list_outline
    local list_inline = utility.create("Square", {Parent = list_outline, Visible = true, Transparency = 1, Theme = "Main Background", Size = UDim2.new(1,-8,1,-8), Position = UDim2.new(0,4,0,4), Thickness = 1, Filled = true, ZIndex = 101}) do
        local outline = utility.outline(list_inline, "Window Border")
    end
    local list_accent = utility.create("Square", {Parent = list_inline, Visible = true, Transparency = 1, Theme = "Accent", Size = UDim2.new(1,-2,0,2), Position = UDim2.new(0,1,0,1), Thickness = 1, Filled = true, ZIndex = 101})
    local list_title = utility.create("Text", {Text = "Keybinds", Parent = list_inline, Visible = true, Transparency = 1, Theme = "Text", Size = 13, Center = true, Outline = false, OutlineColor = Color3.fromRGB(50,50,50), Font = Drawing.Fonts.Plex, Position = UDim2.new(0.5,0,0,5), ZIndex = 101})
    local list_content = utility.create("Square", {Parent = list_outline, Visible = true, Transparency = 0, Size = UDim2.new(1,0,0,10), Position = UDim2.new(0,0,0,33), Thickness = 1, Filled = true, ZIndex = 101})
    list_content:AddListLayout(1)
    function keybind_list_tbl:add_keybind(name, key)
        local key_settings = {}
        local key_holder = utility.create("Square", {Parent = list_content, Size = UDim2.new(1,0,0,22), ZIndex = 100, Transparency = 1, Visible = true, Filled = true, Thickness = 1, Theme = "Main Background"}) do
            local outline = utility.outline(key_holder, "Window Border")
            utility.outline(outline, Color3.new(0,0,0))
        end
        local list_title = utility.create("Text", {Text = tostring(name .." ["..key.."]"), Parent = key_holder, Visible = true, Transparency = 1, Theme = "Text", Size = 13, Center = false, Outline = true, Font = Drawing.Fonts.Plex, Position = UDim2.new(0,2,0,4), ZIndex = 101})
        function key_settings:is_active(state)
            if state then
                utility.changeobjecttheme(list_title, "Accent")
            else
                utility.changeobjecttheme(list_title, "Text")
            end
        end
        function key_settings:update_text(text)
            list_title.Text = text
        end
        function key_settings:Remove()
            key_holder:Remove()
            list_title:Remove()
            keybind_list_tbl.keybinds[name] = nil
            key_settings = nil
        end
        keybind_list_tbl.keybinds[name] = name
        return key_settings
    end
    function keybind_list_tbl:remove_keybind(name)
        if name and keybind_list_tbl.keybinds[name] then
            keybind_list_tbl.keybinds[name]:remove()
            keybind_list_tbl.keybinds[name] = nil
        end
    end
    function keybind_list_tbl:State(state)
        list_outline.Visible = state
    end
    return keybind_list_tbl
end
function library:Window(cfg)
    local WindowTable = {pages = {}, page_images = {}, page_holder = {}}
    local window_size = cfg.Size or Vector2.new(560,435)
    local autogamename = cfg.AutoGame or false
    local window_name = cfg.Name or "Silent Solutions"
    local gamename = cfg.Game or false
    if autogamename then
        window_name = ""..window_name.." | "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name..""
    elseif gamename ~= false then
        window_name = ""..window_name.." | "..gamename..""
    else
        window_name = window_name
    end
    local size_x = window_size.X 
    local size_y = window_size.Y 
    local window_outline = utility.create("Square", {Visible = true, Transparency = 1, Theme = "Main Background", Size = UDim2.new(0,size_x,0,size_y), Position = UDim2.new(0.5, -(size_x / 2), 0.5, -(size_y / 2)), Thickness = 1, Filled = true, ZIndex = 1}) do
        local outline = utility.outline(window_outline, "Window Border") 
        utility.outline(outline, Color3.new(0,0,0)) 
    end
    library.Holder = window_outline 
    local window_holder = utility.create("Square", {Parent = window_outline, Visible = true, Transparency = 1, Theme = "Main Background", Size = UDim2.new(0,460,0,399), Position = UDim2.new(0,100,0,35), Thickness = 1, Filled = true, ZIndex = 3})
    local topholder = utility.create("Square", {Parent = window_outline, Visible = true, Transparency = 1, Theme = "Left Background", Size = UDim2.new(0,560 ,0,36), Position = UDim2.new(0.5, -(size_x / 2), 0.498, -(size_y / 2)), Thickness = 1, Filled = true, ZIndex = 1})
    local leftholder = utility.create("Square", {Parent = window_outline, Visible = true, Transparency = 1, Theme = "Left Background", Size = UDim2.new(0,100 ,0,402), Position = UDim2.new(0.5, -(size_x - 280), 0.5, -(370 / 2)), Thickness = 1, Filled = true, ZIndex = 1})
    local window_title = utility.create("Text", {Text = window_name, Parent = topholder, Visible = true, Transparency = 1, Theme = "Text", Size = 13, Center = false, Outline = true, Font = Drawing.Fonts.Plex, Position = UDim2.new(0,8,0,8), ZIndex = 5}) 
    local window_drag = utility.create("Square", {Parent = window_outline, Visible = true, Transparency = 0, Size = UDim2.new(1,0,0,35), Position = UDim2.new(0,0,0,0), Thickness = 1, Filled = true, ZIndex = 10})
    local dragoutline = utility.create("Square", {
        Size = UDim2.new(0, size_x, 0, size_y),
        Position = utility.getcenter(size_x, size_y),
        Filled = false,
        Thickness = 1,
        Theme = "Accent",
        ZIndex = 100,
        Visible = false,
    })
    utility.dragify(window_drag, dragoutline, window_outline)
    local WindowKeybindList = library.KeybindList()
    WindowKeybindList:State(false)
    function WindowTable:Page(cfg)
        local PageTable = {sections = {}}
        local DefaultPage = cfg.Default or false
        local Image = game:HttpGet(cfg.Image)
        local imageplaceholder = utility.create("Square", {Parent = leftholder, Visible = true, Transparency = 0, Size = UDim2.new(0,50 ,0,50), Position = UDim2.new(0.5, -(size_x - 534), 0.5, -(380 / 2)), Thickness = 1, Filled = true, ZIndex = 3}) do
            table.insert(self.page_holder,imageplaceholder)
        end
        local page_image = utility.create("Image", {Parent = imageplaceholder, Visible = true, Transparency = 1,Size = UDim2.new(0,50 ,0,50),Position = UDim2.new(0.5, -(size_x - 534), 0.5, -(50 / 2)),Data = Image,ZIndex = 2}) do
            table.insert(self.page_images,page_image)
        end
        local page = utility.create("Square", {Parent = window_holder, Visible = false, Transparency = 0, Size = UDim2.new(1,-40,1,-45), Position = UDim2.new(0,20,0,40), Thickness = 1, Filled = false, ZIndex = 4}) do
            table.insert(self.pages, page) 
        end 
        local Left = utility.create("Square", {Transparency = 0,Filled = false,Thickness = 1,ZIndex = 4,Parent = page,Size = UDim2.new(0.5, -14, 1.1, -10),Position = UDim2.new(0, 0, 0, -30) }) 
        Left:AddListLayout(15)
        local Right = utility.create("Square", {Transparency = 0,Filled = false,Thickness = 1,Parent = page,ZIndex = 3,Size = UDim2.new(0.5, -14, 1.1, -10),Position = UDim2.new(0.5, 14, 0, -30) }) 
        Right:AddListLayout(15)
        utility.connect(imageplaceholder.MouseButton1Click, function()
            for i,v in pairs(self.pages) do
                if v ~= page then
                    v.Visible = false 
                end 
            end
            page.Visible = true
        end)
        for i,v in pairs(self.page_holder) do
            v.Position = UDim2.new(0.25,0.5,1 / (#self.page_holder / (i - 1)), 0)
        end
        if DefaultPage then
            page.Visible = true           
        end
        function PageTable:Section(cfg)
            local SectionTable = {}
            local Side = cfg.Side == "Left" and Left or cfg.Side == "Right" and Right or Left
            local Name = cfg.Name or "New Section"
            local FillSection = cfg.Fill or false
            local SectionSize = cfg.Size or 200
            local section = utility.create("Square", {Parent = Side, Visible = true, Transparency = 1, Theme = "Section Background", Size = SectionSize == "Fill" and UDim2.new(1,0,0,380) or UDim2.new(1,0,0,SectionSize), Position = UDim2.new(0,0,0,0), Thickness = 1, Filled = true, ZIndex = 5}) do
                local outline = utility.outline(section, "Window Border")
                utility.outline(outline, "Section Background")
            end
            local section_title = utility.create("Text", {Text = Name, Parent = section, Visible = true, Transparency = 1, Theme = "Text", Size = 13, Center = false, Outline = false, Font = Drawing.Fonts.Plex, Position = UDim2.new(0,10,0,2), ZIndex = 5}) 
            local section_content = utility.create("Square", {Transparency = 0,Size = UDim2.new(1, -32, 1, -10),Position = UDim2.new(0, 16, 0, 20),Parent = section,ZIndex = 6}) 
            section_content:AddListLayout(8)
            function SectionTable:Seperator(cfg)
                local seperator_text = cfg.Name or "new seperator"
                local separator = utility.create("Square", {Transparency = 0,Size = UDim2.new(1, 0, 0, 12),Parent = section_content})
                local separatorline = utility.create("Square", {Size = UDim2.new(1, 0, 0, 1),Position = UDim2.new(0, 0, 0.5, 0),Thickness = 0,Filled = true,ZIndex = 7,Theme = "Object Background",Parent = separator}) do
                    local outline = utility.outline(separatorline, "Inner Border")
                    utility.outline(outline, "Outer Border")
                end
                local sizeX = utility.textlength(seperator_text, Drawing.Fonts.Plex, 13).X
                local separatorcutoff = utility.create("Square", {Size = UDim2.new(0, sizeX + 12, 0, 5),Position = UDim2.new(0.5, (-sizeX / 2) - 7, 0.5, -2),ZIndex = 8,Filled = true,Theme = "Section Background",Parent = separator})
                local text = utility.create("Text", {Text = seperator_text,Font = Drawing.Fonts.Plex,Size = 13,Position = UDim2.new(0.5, 0, 0, -1),Theme = "Text",ZIndex = 9,Outline = false,Center = true,Parent = separator})
            end
            function SectionTable:Line()
                local separator = utility.create("Square", {Transparency = 0,Size = UDim2.new(1, 0, 0, 12),Parent = section_content})
                local separatorline = utility.create("Square", {Size = UDim2.new(1, 0, 0, 1),Position = UDim2.new(0, 0, 0.5, 0),Thickness = 0,Filled = true,ZIndex = 7,Theme = "Object Background",Parent = separator}) do
                    local outline = utility.outline(separatorline, "Inner Border")
                    utility.outline(outline, "Outer Border")
                end            
            end
            function SectionTable:Label(cfg)
                local LabelTable = {}
                local LabelText = cfg.Text or "new label"
                local Centered = cfg.Center or false
                local separator = utility.create("Square", {Transparency = 0,Size = UDim2.new(1, 0, 0, 12),Parent = section_content})
                local textlabel = utility.create("Text", {Text = LabelText,Font = Drawing.Fonts.Plex,Size = 13,Position = UDim2.new(Centered and 0.5 or 0, 0, 0, -1),Theme = "Text",ZIndex = 9,Outline = false,Center = Centered and true or false,Parent = separator})
                function LabelTable:Update(NewText)
                    textlabel.Text = NewText
                end
                return LabelTable
            end
            function SectionTable:Button(cfg)
                local button_tbl = {}
                local button_name = cfg.Name or "new button"
                local button_confirm = cfg.Confirm or false
                local callback = cfg.Callback or function() end
                local holder = utility.create("Square", {Parent = section_content, Visible = true, Transparency = 0, Size = UDim2.new(1,0,0,15), Thickness = 1, Filled = true, ZIndex = 6})
                local button_frame = utility.create("Square", {Parent = holder, Visible = true, Transparency = 1, Theme = "Object Background", Size = UDim2.new(1,0,1,0), Thickness = 1, Filled = true, ZIndex = 7}) do
                    local outline = utility.outline(button_frame, "Inner Border")
                    utility.outline(outline, "Outer Border")
                end
                local button_title = utility.create("Text", {Text = button_name, Parent = button_frame, Visible = true, Transparency = 1, Theme = "Text", Size = 13, Center = true, Outline = false, Font = Drawing.Fonts.Plex, Position = UDim2.new(0.5,0,0,0), ZIndex = 8})
                local clicked, counting = false, false
                utility.connect(button_frame.MouseButton1Click, function()
                    task.spawn(function()
                        if button_confirm then
                            if clicked then clicked = false counting = false utility.changeobjecttheme(button_title, "Text") button_title.Text = button_name callback() else clicked = true counting = true for i = 3,1,-1 do if not counting then break end button_title.Text = 'Confirm '..button_name..'? '..tostring(i) utility.changeobjecttheme(button_title, "Accent") wait(1) end clicked = false counting = false utility.changeobjecttheme(button_title, "Text") button_title.Text = button_name end
                        else 
                            callback()
                        end
                    end)
                end)
                utility.connect(button_frame.MouseButton1Down, function()
                    utility.changeobjecttheme(button_frame, "Accent")
                end)
                utility.connect(button_frame.MouseButton1Up, function()
                    utility.changeobjecttheme(button_frame, "Object Background")
                end)
            end
            function SectionTable:Slider(cfg)
                local SliderTable = {} 
                local name = cfg.Name or "new slider" 
                local min = cfg.Minimum or 0 
                local max = cfg.Maximum or 100 
                local float = cfg.Float or 1
                local default = cfg.Default and math.clamp(cfg.Default, min, max) or min
                local flag = cfg.Flag or utility.nextflag()
                local callback = cfg.Callback or function() end
                local text = ("[value]/"..max)
                local holder = utility.create("Square", {Parent = section_content, Visible = true, Transparency = 0, Size = UDim2.new(1,0,0,20), Thickness = 1, Filled = true, ZIndex = 6})
                local slider_frame = utility.create("Square", {Parent = holder, Visible = true, Transparency = 1, Theme = "Object Background", Size = UDim2.new(1,0,0,5), Thickness = 1, Filled = true, ZIndex = 7, Position = UDim2.new(0,0,0,15)}) do
                    local outline = utility.outline(slider_frame, "Inner Border")
                    utility.outline(outline, "Outer Border")
                end
                local slider_title = utility.create("Text", {Text = name, Parent = holder, Visible = true, Transparency = 1, Theme = "Text", Size = 13, Center = false, Outline = false, Font = Drawing.Fonts.Plex, Position = UDim2.new(0,-2,0,-2), ZIndex = 6})
                local slider_value = utility.create("Text", {Text = text, Parent = slider_frame, Visible = true, Transparency = 1, Theme = "Text", Size = 13, Center = true, Outline = true, Font = Drawing.Fonts.Plex, Position = UDim2.new(0.5,0,0.5,-6), ZIndex = 8})
                local slider_fill = utility.create("Square", {Parent = slider_frame, Visible = true, Transparency = 1, Theme = "Accent", Size = UDim2.new(1,0,1,0), Thickness = 1, Filled = true, ZIndex = 7, Position = UDim2.new(0,0,0,0)})
                local slider_drag = utility.create("Square", {Parent = slider_frame, Visible = true, Transparency = 0, Size = UDim2.new(1,0,1,0), Thickness = 1, Filled = true, ZIndex = 8, Position = UDim2.new(0,0,0,0)})
                local function set(value)
                    value = math.clamp(utility.round(value, float), min, max)
                    slider_value.Text = text:gsub("%[value%]", string.format("%.14g", value))
                    local sizeX = ((value - min) / (max - min))
                    slider_fill.Size = UDim2.new(sizeX, 0, 1, 0)
                    library.Flags[flag] = value
                    callback(value)
                end
                set(default) local sliding = false
                local function slide(input)
                    local sizeX = (input.Position.X - slider_frame.AbsolutePosition.X) / slider_frame.AbsoluteSize.X
                    local value = ((max - min) * sizeX) + min
                    set(value)
                end
                utility.connect(slider_drag.InputBegan, function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true slide(input) end end)
                utility.connect(slider_drag.InputEnded, function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
                utility.connect(slider_fill.InputBegan, function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true slide(input) end end)
                utility.connect(slider_fill.InputEnded, function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
                utility.connect(services.InputService.InputChanged, function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then if sliding then slide(input) end end end)
                Flags[flag] = set
                function SliderTable:Set(value)
                    set(value)
                end
                return SliderTable
            end
            function SectionTable:Toggle(cfg)
                local ToggleTypes = {}
                local ToggleTable = {colorpickers = 0} 
                local toggle_name = cfg.Name or "new toggle" 
                local toggle_risky = cfg.Risky or false 
                local toggle_state = cfg.State or false 
                local toggle_flag = cfg.Flag or utility.nextflag() 
                local callback = cfg.Callback or function() end 
                local toggled = false 
                local holder = utility.create("Square", {Parent = section_content, Visible = true, Transparency = 0, Size = UDim2.new(1,0,0,8), Thickness = 1, Filled = true, ZIndex = 8})
                local holdertoggle = utility.create("Square", {Parent = holder, Visible = true, Transparency = 0, Size = UDim2.new(0.7,0,0,8), Thickness = 1, Filled = true, ZIndex = 8})
                local toggle_frame = utility.create("Square", {Parent = holdertoggle, Visible = true, Transparency = 1, Theme = "Object Background", Size = UDim2.new(0,8,0,8), Position = UDim2.new(0,0,0,0), Thickness = 1, Filled = true, ZIndex = 7}) do
                    local outline = utility.outline(toggle_frame, "Inner Border")
                    utility.outline(outline, "Outer Border") 
                end 
                local toggle_title = utility.create("Text", {Text = toggle_name, Parent = holder, Visible = true, Transparency = 1, Theme = toggle_risky and "Risky" or "Text", Size = 13, Center = false, Outline = false, Font = Drawing.Fonts.Plex, Position = UDim2.new(0,13,0,-3), ZIndex = 6}) 
                local function setstate()
                    if library.Risky == false and toggle_risky then return end
                    toggled = not toggled
                    if toggled then
                        utility.changeobjecttheme(toggle_frame, "Accent")
                    else
                        utility.changeobjecttheme(toggle_frame, "Object Background")
                    end
                    library.Flags[toggle_flag] = toggled
                    callback(toggled)
                end 
                holdertoggle.MouseButton1Click:Connect(setstate) 
                local function set(bool)
                    bool = type(bool) == "boolean" and bool or false
                    if toggled ~= bool then
                        setstate()
                    end 
                end 
                set(toggle_state) 
                Flags[toggle_flag] = set 
                function ToggleTypes:set(bool)
                    set(bool)
                end 
                function ToggleTypes:ColourPicker(cfg)
                    local ColourPickerTable = {} 
                    local default = cfg.Default or Color3.fromRGB(255, 0, 0) 
                    local flag = cfg.Flag or utility.nextflag() 
                    local callback = cfg.Callback or function() end 
                    ToggleTable.colorpickers = ToggleTable.colorpickers + 1
                    local cp = library.CreateColourPicker(default, holder, ToggleTable.colorpickers - 1, flag, callback, 1, -8)
                    function ColourPickerTable:set(color)
                        cp:set(color, false, true)
                    end
                    return ColourPickerTable
                end 
                return ToggleTypes 
            end
            function SectionTable:ColourPicker(cfg)
                local colorpicker_tbl = {}
                local name = cfg.Name or "new colorpicker"
                local default = cfg.Default or Color3.fromRGB(255, 0, 0)
                local flag = cfg.Flag or utility.nextflag()
                local callback = cfg.Callback or function() end
                local holder = utility.create("Square", {
                    Transparency = 0,
                    Filled = true,
                    Thickness = 1,
                    Size = UDim2.new(1, 0, 0, 10),
                    Parent = section_content
                })
                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, -2, 0, -1),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = false,
                    Parent = holder
                })
                local colorpickers = 0
                local colorpickertypes = library.CreateColourPicker(default, holder, colorpickers, flag, callback, 0, 2)
                function colorpicker_tbl:set(color)
                    colorpickertypes:set(color, false, true)
                end
                return colorpicker_tbl
            end
            function SectionTable:Dropdown(cfg)
                local dropdown_tbl = {}
                local name = cfg.Name or "new dropdown"
                local default = cfg.Default or nil
                local content = type(cfg.Options) == "table" and cfg.Options or {}
                local max = cfg.Maximum and (cfg.Maximum > 1 and cfg.Maximum) or nil
                local scrollable = cfg.Scrollable or false
                local scrollingmax = cfg.ScrollingMax or 10
                local flag = cfg.Flag or utility.nextflag()
                local islist = cfg.List or false
                local size = cfg.Size or 100
                local callback = cfg.Callback or function() end
                if not max and type(default) == "table" then
                    default = nil
                end
                if max and default == nil then
                    default = {}
                end
                if type(default) == "table" then
                    if max then
                        for i, opt in pairs(default) do
                            if not table.find(content, opt) then
                                table.remove(default, i)
                            elseif i > max then
                                table.remove(default, i)
                            end
                        end
                    else
                        default = nil
                    end
                elseif default ~= nil then
                    if not table.find(content, default) then
                        default = nil
                    end
                end
                local holder = utility.create("Square", {Transparency = 0, ZIndex = 7,Size = islist and size == "Fill" and UDim2.new(1,0,1,0) or islist and UDim2.new(1,0,0,size+15) or UDim2.new(1, 0, 0, 29),Parent = section_content})
                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, -2, 0, -2),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = false,
                    Parent = holder
                })
                return library.CreateDropdown(holder, content, flag, callback, default, max, scrollable, scrollingmax, islist, size)
            end
            function SectionTable:Keybind(cfg)
                local dropdown_tbl = {}
                local name = cfg.Name or "new keybind"
                local key_name = cfg.KeyBind_Name or name
                local default = cfg.Default or nil
                local mode = cfg.Mode or "Hold"
                local blacklist = cfg.Blacklist or {}
                local flag = cfg.Flag or utility.nextflag()
                local callback = cfg.Callback or function() end
                local ignore_list = cfg.Ignore or false
                local key_mode = mode
                local holder = utility.create("Square", {Transparency = 0, ZIndex = 7,Size = UDim2.new(1, 0, 0, 29),Parent = section_content})
                local title = utility.create("Text", {
                    Text = name,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, -2, 0, -2),
                    Theme = "Text",
                    ZIndex = 7,
                    Outline = false,
                    Parent = holder
                })
                if not offset then
                    offset = -1
                end
                local keybindname = key_name or ""
                local frame = utility.create("Square",{
                    Theme = "Object Background",
                    Size = UDim2.new(1, 0, 0, 15),
                    Position = UDim2.new(0, 0, 1, -15),
                    Filled = true,
                    Parent = holder,
                    Thickness = 1,
                    ZIndex = 8
                })
                local outline1 = utility.outline(frame, "Inner Border")
                utility.outline(outline1, "Outer Border")
                local mode_frame = utility.create("Square",{
                    Theme = "Object Background",
                    Size = UDim2.new(0,44,0,35),
                    Position = UDim2.new(1,10,0,-10),
                    Filled = true,
                    Parent = frame,
                    Thickness = 1,
                    ZIndex = 8,
                    Visible = false
                })
                local mode_outline1 = utility.outline(mode_frame, "Inner Border")
                utility.outline(mode_outline1, "Outer Border")
                local holdtext = utility.create("Text", {
                    Text = "Hold",
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Theme = key_mode == "Hold" and "Accent" or "Text",
                    Position = UDim2.new(0.5,0,0,2),
                    ZIndex = 8,
                    Parent = mode_frame,
                    Outline = false,
                    Center = true
                })
                local toggletext = utility.create("Text", {
                    Text = "Toggle",
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Theme = key_mode == "Toggle" and "Accent" or "Text",
                    Position = UDim2.new(0.5,0,0,18),
                    ZIndex = 8,
                    Parent = mode_frame,
                    Outline = false,
                    Center = true
                })
                local holdbutton = utility.create("Square",{
                    Color = Color3.new(0,0,0),
                    Size = UDim2.new(0,44,0,12),
                    Position = UDim2.new(0,0,0,2),
                    Filled = false,
                    Parent = mode_frame,
                    Thickness = 1,
                    ZIndex = 8,
                    Transparency = 0
                })
                local togglebutton = utility.create("Square",{
                    Color = Color3.new(0,0,0),
                    Size = UDim2.new(0,44,0,12),
                    Position = UDim2.new(0,0,0,20),
                    Filled = false,
                    Parent = mode_frame,
                    Thickness = 1,
                    ZIndex = 8,
                    Transparency = 0
                })
                local keytext = utility.create("Text", {
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Theme = "Text",
                    Position = UDim2.new(0,2,0,0),
                    ZIndex = 8,
                    Parent = frame,
                    Outline = false,
                    Center = false
                })
                holdbutton.MouseButton1Click:Connect(function()
                    key_mode = "Hold"
                    utility.changeobjecttheme(holdtext, "Accent")
                    utility.changeobjecttheme(toggletext, "Text")
                    mode_frame.Visible = false
                end)
                togglebutton.MouseButton1Click:Connect(function()
                    key_mode = "Toggle"
                    utility.changeobjecttheme(holdtext, "Text")
                    utility.changeobjecttheme(toggletext, "Accent")
                    mode_frame.Visible = false
                end)
                local list_obj = nil
                if ignore_list == false then
                    list_obj = WindowKeybindList:add_keybind(keybindname, keytext.Text)
                end
                local removetext = utility.create("Text", {
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Color = Color3.fromRGB(245,245,245),
                    Position = UDim2.new(1,-20,0,0),
                    ZIndex = 8,
                    Parent = frame,
                    Outline = false,
                    Center = false,
                    Text = "...",
                    Transparency = 0.5
                })
                local removetext_bold = utility.create("Text", {
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Color = Color3.fromRGB(245,245,245),
                    Position = UDim2.new(1,-21,0,0),
                    ZIndex = 8,
                    Parent = frame,
                    Outline = false,
                    Center = false,
                    Text = "...",
                    Transparency = 0.5
                })
                local remove = utility.create("Square", {Filled = true, Position = UDim2.new(1,-20,0,3),Thickness = 1, Transparency = 0, Visible = true, Parent = frame, Size = UDim2.new(0,utility.textlength("x", 2, 13).X + 10, 0, 10), ZIndex = 13})
                remove.MouseButton1Click:Connect(function()
                    mode_frame.Visible = true
                end)
                local key
                local state = false
                local binding
                local function set(newkey)
                    if c then
                        c:Disconnect()
                        if flag then
                            library.Flags[flag] = false
                        end
                        callback(false)
                        if ignore_list == false then
                           list_obj:is_active(false)
                        end
                    end
                    if tostring(newkey):find("Enum.KeyCode.") then
                        newkey = Enum.KeyCode[tostring(newkey):gsub("Enum.KeyCode.", "")]
                    elseif tostring(newkey):find("Enum.UserInputType.") then
                        newkey = Enum.UserInputType[tostring(newkey):gsub("Enum.UserInputType.", "")]
                    end
                    if newkey ~= nil and not table.find(blacklist, newkey) then
                        key = newkey
                        local text = (keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))
                        keytext.Text = text
                        if ignore_list == false then
                            list_obj:update_text(tostring(keybindname.." ["..text.."]"))
                        end
                    else
                        key = nil
                        local text = ""
                        keytext.Text = text
                        if ignore_list == false then
                            list_obj:update_text(tostring(keybindname.." ["..text.."]"))
                        end
                    end
                    if bind ~= '' or bind ~= nil then
                        state = false
                        if flag then
                            library.Flags[flag] = state
                        end
                        callback(false)
                        if ignore_list == false then
                           list_obj:is_active(state)
                        end
                    end
                end
                utility.connect(services.InputService.InputBegan, function(inp)
                    if (inp.KeyCode == key or inp.UserInputType == key) and not binding then
                        if key_mode == "Hold" then
                            if flag then
                                library.Flags[flag] = true
                            end
                            if ignore_list == false then
                               list_obj:is_active(true)
                            end
                            c = utility.connect(game:GetService("RunService").RenderStepped, function()
                                if callback then
                                    callback(true)
                                end
                            end)
                        else
                            state = not state
                            if flag then
                                library.Flags[flag] = state
                            end
                            callback(state)
                            if ignore_list == false then
                               list_obj:is_active(state)
                            end
                        end
                    end
                end)
                set(default)
                frame.MouseButton1Click:Connect(function()
                    if not binding then
                        keytext.Text = "..."
                        binding = utility.connect(services.InputService.InputBegan, function(input, gpe)
                            set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType)
                            utility.disconnect(binding)
                            task.wait()
                            binding = nil
                        end)
                    end
                end)
                utility.connect(services.InputService.InputEnded, function(inp)
                    if key_mode == "Hold" then
                        if key ~= '' or key ~= nil then
                            if inp.KeyCode == key or inp.UserInputType == key then
                                if c then
                                    c:Disconnect()
                                    if ignore_list == false then
                                       list_obj:is_active(false)
                                    end
                                    if flag then
                                        library.Flags[flag] = false
                                    end
                                    if callback then
                                        callback(false)
                                    end
                                end
                            end
                        end
                    end
                end)
                local keybindtypes = {}
                function keybindtypes:set(newkey)
                    set(newkey)
                end
                return keybindtypes
            end
                   function SectionTable:Textbox(cfg)
                local textbox_tbl = {}
                local placeholder = cfg.Placeholder or "new textbox"
                local default = cfg.Default or ""
                local middle = cfg.Middle or false
                local flag = cfg.Flag or utility.nextflag()
                local callback = cfg.Callback or function() end
                local holder = utility.create("Square", {Transparency = 0, ZIndex = 7,Size = UDim2.new(1, 0, 0, 19),Parent = section_content})
                local textbox = utility.create("Square", {
                    Filled = true,
                    Visible = true,
                    Thickness = 0,
                    Theme = "Object Background",
                    Size = UDim2.new(1, 0, 0, 15),
                    Position = UDim2.new(0, 0, 1, -15),
                    ZIndex = 7,
                    Parent = holder
                })
                local outline1 = utility.outline(textbox, "Inner Border")
                utility.outline(outline1, "Outer Border")
                local text = utility.create("Text", {
                    Text = default,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Center = middle,
                    Position = middle and UDim2.new(0.5,0,0,0) or UDim2.new(0, 2, 0, 0),
                    Theme = "Text",
                    ZIndex = 9,
                    Outline = false,
                    Parent = textbox
                })
                local placeholder = utility.create("Text", {
                    Text = placeholder,
                    Font = Drawing.Fonts.Plex,
                    Transparency = 0.5,
                    Size = 13,
                    Center = middle,
                    Position = middle and UDim2.new(0.5,0,0,0) or UDim2.new(0, 2, 0, 0),
                    Theme = "Text",
                    ZIndex = 9,
                    Outline = false,
                    Parent = textbox
                })
                library.CreateTextbox(textbox, text,  function(str) 
                    if str == "" then
                        placeholder.Visible = true
                        text.Visible = false
                    else
                        placeholder.Visible = false
                        text.Visible = true
                    end
                end, function(str)
                    library.Flags[flag] = str
                    callback(str)
                end)
                local function set(str)
                    text.Visible = str ~= ""
                    placeholder.Visible = str == ""
                    text.Text = str
                    library.Flags[flag] = str
                    callback(str)
                end
                set(default)
                Flags[flag] = set
                function textbox_tbl:Set(str)
                    set(str)
                end
                return textbox_tbl
            end
            return SectionTable
        end
        return PageTable
    end
    function WindowTable:AddSettings()
        local Page3 = self:Page({Image = "https://raw.githubusercontent.com/Vestra-Tech/SilentSolutions/main/Images/Settings.jpg"})
        local SettingsSection = Page3:Section({Name = "Ui Settings",Side = "Left",Size = 300})
        SettingsSection:Keybind({Name = "Toggle Ui",Mode = "Toggle",Default = Enum.KeyCode.RightControl,Ignore = true,Callback = function()
            if library.Initialised then
                library:HideUi()
            end
        end})
        SettingsSection:Button({Name = "Delete Ui",Confirm = true,Callback = function()
            if library.Initialised then
                library:DeleteUi()
            end
        end})
        SettingsSection:Keybind({Name = "Emergency Mode",Mode = "Toggle",Default = Enum.KeyCode.F10,Callback = function()
            if library.Initialised then
                library:DeleteUi()
            end
        end})
        SettingsSection:Toggle({Name = "Performance Drag",State = library.Performance,Callback = function(value)
            library.Performance = value
        end})
        SettingsSection:Toggle({Name = "Allow Risky Features",State = false,Callback = function(value)
            library.Risky = value
        end})
        SettingsSection:Seperator({Name = "Lists"})
        SettingsSection:Toggle({Name = "Keybind",State = false,Callback = function(value)
            if library.Initialised then
                WindowKeybindList:State(value)
            end
        end})
        SettingsSection:Toggle({Name = "Watermark",State = false,Callback = function(value)
            if library.Initialised then
            end
        end})
        SettingsSection:Seperator({Name = "Game Options"})
        SettingsSection:Button({Name = "Rejoin",Confirm = true,Callback = function()
            if library.Initialised then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
            end
        end})
        SettingsSection:Button({Name = "Copy Join Script",Callback = function()
            if library.Initialised then
                setclipboard(([[game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s")]]):format(game.PlaceId, game.JobId))
            end
        end})
        local ColourSection = Page3:Section({Name = "Ui Colour",Side = "Right",Size = 300})
        ColourSection:ColourPicker({Name = "Main Background",Flag = "MainBackgroundColour",Default = Color3.fromRGB(36, 36, 36),Callback = function(r,g,b) 
            library:ChangeThemeOption("Main Background", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Left Background",Flag = "LeftBackgroundColour",Default = Color3.fromRGB(28, 28, 28),Callback = function(r,g,b)
            library:ChangeThemeOption("Left Background", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Object Background",Flag = "ObjectBackgroundColour",Default = Color3.fromRGB(41, 41, 50),Callback = function(r,g,b) 
            library:ChangeThemeOption("Object Background", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Section Background",Flag = "SectionBackgroundColour",Default = Color3.fromRGB(25, 25, 25),Callback = function(r,g,b) 
            library:ChangeThemeOption("Section Background", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Window Border",Flag = "WindowBorderColour",Default = Color3.fromRGB(58, 58, 67),Callback = function(r,g,b) 
            library:ChangeThemeOption("Window Border", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Inner Border",Flag = "InnerBorderColour",Default = Color3.fromRGB(50, 50, 58),Callback = function(r,g,b) 
            library:ChangeThemeOption("Inner Border", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Outer Border",Flag = "OuterBorderColour",Default = Color3.fromRGB(19, 19, 27),Callback = function(r,g,b) 
            library:ChangeThemeOption("Outer Border", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Text",Flag = "TextColour",Default = Color3.fromRGB(255,255,255),Callback = function(r,g,b) 
            library:ChangeThemeOption("Text", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Risky Text",Flag = "RiskyTextColour",Default = Color3.fromRGB(255, 0, 0),Callback = function(r,g,b) 
            library:ChangeThemeOption("Risky", r,g,b)
        end})
        ColourSection:ColourPicker({Name = "Accent",Flag = "AccentColour",Default = Color3.fromRGB(51, 91, 232),Callback = function(r,g,b) 
            library:ChangeThemeOption("Accent", r,g,b)
        end})
    end
    return WindowTable
end
return library, utility