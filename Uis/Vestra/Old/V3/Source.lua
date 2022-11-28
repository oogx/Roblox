local theme = {
	main = Color3.fromRGB(37, 37, 37),
	secondary = Color3.fromRGB(42, 42, 42),
	accent = Color3.fromRGB(255, 255, 255),
	accent2 = Color3.fromRGB(170, 170, 170)
}

if dark then
    getgenv().theme = {
        main = Color3.fromRGB(37, 37, 37),
        secondary = Color3.fromRGB(42, 42, 42),
        accent = Color3.fromRGB(255, 255, 255),
        accent2 = Color3.fromRGB(223, 223, 223)
    }
end


local services = setmetatable({}, {
	__index = function(index, service)
		return game:GetService(service)
	end,
	__newindex = function(index, value)
		index[value] = nil
		return
	end
})

local players = services.Players
local player = players.LocalPlayer
local mouse = player:GetMouse()

local library = {
	flags = {};
	binds = {};
	objstorage = {};
	funcstorage = {};
	binding = false;
	tabinfo = {button = nil, tab = nil};
	destroyed = false;
	ui = nil,
    toggleui = function() end
}

function library.destroy()
	library.ui:Destroy()
	library.destroyed = true
end

local function isreallypressed(bind, inp)
	local key = bind
	if typeof(key) == "Instance" then
		if key.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == key.KeyCode then
			return true;
		elseif tostring(key.UserInputType):find('MouseButton') and inp.UserInputType == key.UserInputType then
			return true
		end
	end
	if tostring(key):find'MouseButton1' then
		return key == inp.UserInputType
	else
		return key == inp.KeyCode
	end
end

pcall(function()
	services.UserInputService.InputBegan:Connect(function(input, gp)
		if library.destroyed then return end
		if gp then else
			if (not library.binding) then
				for idx, binds in next, library.binds do
					local real_binding = binds.location[idx];
					if real_binding and isreallypressed(real_binding, input) then
						binds.callback()
					end
				end
			end
		end
	end)
end)

local utils = {};

function utils:Tween(obj, t, data)
	services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
	return true
end

function utils:HoverEffect(obj)
    Btn.MouseEnter:Connect(function()
        self:Tween(Btn, {0.15, 'Sine', 'InOut'}, {
            BackgroundTransparency = 0.3
        })
    end)

    Btn.MouseLeave:Connect(function()
        self:Tween(Btn, {0.15, 'Sine', 'InOut'}, {
            BackgroundTransparency = 0
        })
    end)
end

function utils:Ripple(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local Ripple = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://2708891598"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = theme.accent
		Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
		self:Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
		wait(0.15)
		self:Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
		wait(.3)
		Ripple:Destroy()
	end)
end

function utils:Drag(frame, hold)
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

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

	services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

local changingTab = false
function utils:ChangeTab(newData)
	if changingTab then return end
	local btn, tab = newData[1], newData[2]
	if not btn or not tab then return end
	if library.tabinfo.button == btn then return end
	changingTab = true
	local oldbtn, oldtab = library.tabinfo.button, library.tabinfo.tab
	local oldicon, newicon = oldbtn.TabIcon, btn.TabIcon
	library.tabinfo = {button = btn, tab = tab}
	local container = tab.Parent
	if container.ClipsDescendants == false then container.ClipsDescendants = true end
	local beforeSize = container.Size

	self:Tween(container, {0.3, 'Sine', 'InOut'}, {Size = UDim2.new(beforeSize.X.Scale, beforeSize.X.Offset, 0, 0)})
	self:Tween(oldbtn, {0.3, 'Sine', 'InOut'}, {TextColor3 = theme.accent2})
	self:Tween(oldicon, {0.3, 'Sine', 'InOut'}, {ImageColor3 = theme.accent2})
	wait(0.3)
	oldtab.Visible = false
	tab.Visible = true
	self:Tween(container, {0.3, 'Sine', 'InOut'}, {Size = beforeSize})
	self:Tween(btn, {0.3, 'Sine', 'InOut'}, {TextColor3 = theme.accent})
	self:Tween(newicon, {0.3, 'Sine', 'InOut'}, {ImageColor3 = theme.accent})
	wait(0.3)
	changingTab = false
end

function library:UpdateSlider(flag, value, min, max)
	local slider = self.objstorage[flag]
	local bar = slider.SliderBar
	local box = slider.SliderValHolder.SliderVal

	local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X

	if value then
		percent = (value - min) / (max - min)
	end

	percent = math.clamp(percent, 0, 1)
	value = value or math.floor(min + (max - min) * percent)

	box.Text = tostring(value)

	utils:Tween(bar.SliderFill, {0.05, 'Linear', 'InOut'}, {Size = UDim2.new(percent, 0, 1, 0)})

    self.flags[flag] = tonumber(value)

	self.funcstorage[flag](tonumber(value))
end

function library:UpdateToggle(flag, value)
	if not library.objstorage[flag] then return end
	local oldval = library.flags[flag]
	local obj = library.objstorage[flag]
	local func = library.funcstorage[flag]
	if oldval == value then return end
	if not value then value = not oldval end
	library.flags[flag] = value
	local fill = obj.ToggleDisplay.ToggleDisplayFill
	local toggleoff = UDim2.new(0, 3, 0.5, 0)
	local toggleon = UDim2.new(0, 17, 0.5, 0)
	spawn(function()
		utils:Tween(fill, {0.15, 'Sine', 'InOut'}, {Size = UDim2.new(0, 24, 0, 16)})
		wait(.15)
		utils:Tween(fill, {0.15, 'Sine', 'InOut'}, {Size = UDim2.new(0, 24, 0, 20)})
	end)
	utils:Tween(fill, {0.3,'Sine', 'InOut'}, {Position = value and toggleon or toggleoff, BackgroundColor3 = value and theme.accent or theme.main}) 
	spawn(function()
		func(value)
	end)
end

function library:Init(title)
	local Library = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainC = Instance.new("UICorner")
	local Top = Instance.new("Frame")
	local TopC = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local Side = Instance.new("Frame")
	local SideC = Instance.new("UICorner")
	local BtnHolder = Instance.new("ScrollingFrame")
	local BtnHolderL = Instance.new("UIListLayout")
	local BtnHolderP = Instance.new("UIPadding")
	local TabHolder = Instance.new("Frame")
	local TabHolderC = Instance.new("UICorner")
    if syn and syn.protect_gui then
        syn.protect_gui(Library)
    end
	Library.Name = services.HttpService:GenerateGUID()
	Library.Parent = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or services.CoreGui
	Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    library.ui = Library

	Main.Name = "Main"
	Main.Parent = Library
	Main.BackgroundColor3 = theme.secondary
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.297788322, 0, 0.0769230798, 0)
	Main.Size = UDim2.new(0, 609, 0, 505)
	Main.ClipsDescendants = true
	local toggled = true
	function library.toggleui()
		toggled = not toggled
		spawn(function()
			if toggled then wait(0.3) end
		end)
		utils:Tween(Main, {0.3, 'Sine', 'InOut'}, {
			Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
		})
	end

	MainC.CornerRadius = UDim.new(0, 4)
	MainC.Name = "MainC"
	MainC.Parent = Main

	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = theme.main
	Top.BorderSizePixel = 0
	Top.Position = UDim2.new(0, 6, 0, 6)
	Top.Size = UDim2.new(0, 597, 0, 46)

    utils:Drag(Main, Top)

	TopC.CornerRadius = UDim.new(0, 4)
	TopC.Name = "TopC"
	TopC.Parent = Top

	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = theme.accent
	Title.BackgroundTransparency = 1.000
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0234505869, 0, 0, 0)
	Title.Size = UDim2.new(0, 186, 0, 46)
	Title.Font = Enum.Font.GothamSemibold
	Title.Text = title
	Title.TextColor3 = theme.accent
	Title.TextSize = 16.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Side.Name = "Side"
	Side.Parent = Main
	Side.BackgroundColor3 = theme.main
	Side.BorderSizePixel = 0
	Side.Position = UDim2.new(0, 6, 0, 58)
	Side.Size = UDim2.new(0, 180, 0, 441)

	SideC.CornerRadius = UDim.new(0, 4)
	SideC.Name = "SideC"
	SideC.Parent = Side

	BtnHolder.Name = "BtnHolder"
	BtnHolder.Parent = Side
	BtnHolder.Active = true
	BtnHolder.BackgroundColor3 = theme.accent
	BtnHolder.BackgroundTransparency = 1.000
	BtnHolder.BorderSizePixel = 0
	BtnHolder.Size = UDim2.new(0, 180, 0, 441)
	BtnHolder.ScrollBarThickness = 2

	BtnHolderL.Name = "BtnHolderL"
	BtnHolderL.Parent = BtnHolder
	BtnHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	BtnHolderL.SortOrder = Enum.SortOrder.LayoutOrder
	BtnHolderL.Padding = UDim.new(0, 4)

	BtnHolderP.Name = "BtnHolderP"
	BtnHolderP.Parent = BtnHolder
	BtnHolderP.PaddingTop = UDim.new(0, 4)
	
	TabHolder.Name = "TabHolder"
	TabHolder.Parent = Main
	TabHolder.BackgroundColor3 = theme.main
	TabHolder.BorderSizePixel = 0
	TabHolder.Position = UDim2.new(0, 192, 0, 58)
	TabHolder.Size = UDim2.new(0, 411, 0, 441)

	TabHolderC.CornerRadius = UDim.new(0, 4)
	TabHolderC.Name = "TabHolderC"
	TabHolderC.Parent = TabHolder

    BtnHolderL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        BtnHolder.CanvasSize = UDim2.new(0, 0, 0, BtnHolderL.AbsoluteContentSize.Y + 6) -- 1
    end)
	
	local tabs = {}
	function tabs:Tab(tabName, icon)
		local TabOpen = Instance.new("TextButton")
		local TabOpenC = Instance.new("UICorner")
		local TabIcon = Instance.new("ImageLabel")
		local Tab = Instance.new("ScrollingFrame")
		local TabL = Instance.new("UIListLayout")
		local TabP = Instance.new("UIPadding")
		
		TabOpen.Name = "TabOpen"
		TabOpen.Parent = BtnHolder
		TabOpen.BackgroundColor3 = theme.secondary
		TabOpen.BackgroundTransparency = 1.000
		TabOpen.BorderSizePixel = 0
		TabOpen.Position = UDim2.new(-0.00277777785, 0, 0.00907029491, 0)
		TabOpen.Size = UDim2.new(0, 164, 0, 30)
		TabOpen.AutoButtonColor = false
		TabOpen.Font = Enum.Font.GothamSemibold
		TabOpen.Text = ("       %s"):format(tabName)
		TabOpen.TextColor3 = (library.tabinfo.button == nil and theme.accent) or theme.accent2
		TabOpen.TextSize = 14.000
		TabOpen.TextXAlignment = Enum.TextXAlignment.Left

		TabOpenC.CornerRadius = UDim.new(0, 4)
		TabOpenC.Name = "TabOpenC"
		TabOpenC.Parent = TabOpen

		TabIcon.Name = "TabIcon"
		TabIcon.Parent = TabOpen
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.Position = UDim2.new(0, 0, 0.166666672, 0)
		TabIcon.Size = UDim2.new(0, 20, 0, 20)
		TabIcon.Image = ("rbxassetid://%s"):format((icon or 4370341699))
		TabIcon.ScaleType = Enum.ScaleType.Fit
		TabIcon.ImageColor3 = (library.tabinfo.button == nil and theme.accent) or theme.accent2
			
		Tab.Name = "Tab"
		Tab.Parent = TabHolder
		Tab.Active = true
		Tab.BackgroundColor3 = theme.accent
		Tab.BackgroundTransparency = 1.000
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(0, 411, 0, 441)
		Tab.ScrollBarThickness = 2
		Tab.Visible = (library.tabinfo.button == nil)

		TabL.Name = "TabL"
		TabL.Parent = Tab
		TabL.HorizontalAlignment = Enum.HorizontalAlignment.Center
		TabL.SortOrder = Enum.SortOrder.LayoutOrder
		TabL.Padding = UDim.new(0, 8)

		TabP.Name = "TabP"
		TabP.Parent = Tab
		TabP.PaddingTop = UDim.new(0, 8)
		
		if library.tabinfo.button == nil then
			library.tabinfo.button = TabOpen
			library.tabinfo.tab = Tab
		end

        TabOpen.MouseButton1Click:Connect(function()
            spawn(function()
                utils:Ripple(TabOpen)
            end)
            utils:ChangeTab({TabOpen, Tab})
        end)

        TabL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 16)
        end)

        local sections = {}

        function sections:Section(name)
            local Section = Instance.new("Frame")
            local SectionC = Instance.new("UICorner")
            local SectionP = Instance.new("UIPadding")
            local SectionL = Instance.new("UIListLayout")
            local SectionTitle = Instance.new("TextLabel")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = theme.secondary
            Section.BorderSizePixel = 0
            Section.Position = UDim2.new(0.0231143553, 0, -0.981859386, 0)
            Section.Size = UDim2.new(0, 392, 0, 568)
            
            SectionC.CornerRadius = UDim.new(0, 4)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section
            
            SectionP.Name = "SectionP"
            SectionP.Parent = Section
            SectionP.PaddingTop = UDim.new(0, 8)
            
            SectionL.Name = "SectionL"
            SectionL.Parent = Section
            SectionL.HorizontalAlignment = Enum.HorizontalAlignment.Center
            SectionL.SortOrder = Enum.SortOrder.LayoutOrder
            SectionL.Padding = UDim.new(0, 8)
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = theme.accent
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.BorderSizePixel = 0
            SectionTitle.Position = UDim2.new(0.00255102036, 0, 0.0355555564, 0)
            SectionTitle.Size = UDim2.new(0, 390, 0, 18)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = ("   %s"):format(name)
            SectionTitle.TextColor3 = theme.accent
            SectionTitle.TextSize = 14.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectionL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Section.Size = UDim2.new(0, 392, 0, SectionL.AbsoluteContentSize.Y + 13)
            end)

            local modules = {}

            function modules:Button(text, callback)
                assert(text, 'text is a required arg')
                local callback = callback or function() end

                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                
                Btn.Name = "Btn"
                Btn.Parent = Section
                Btn.BackgroundColor3 = theme.main
                Btn.BorderSizePixel = 0
                Btn.Position = UDim2.new(-0.00382653065, 0, 0.568888903, 0)
                Btn.Size = UDim2.new(0, 382, 0, 42)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = ("   %s"):format(text)
                Btn.TextColor3 = theme.accent
                Btn.TextSize = 14.000
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                
                BtnC.CornerRadius = UDim.new(0, 4)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn

                Btn.MouseButton1Click:Connect(function()
                    spawn(function()
                        utils:Ripple(Btn)
                    end)
                    spawn(callback)
                end)
            end

            function modules:Label(text)
                local Label = Instance.new("TextLabel")
                local LabelC = Instance.new("UICorner")

                Label.Name = "Label"
                Label.Parent = Section
                Label.BackgroundColor3 = theme.main
                Label.BackgroundTransparency = 0
                Label.BorderSizePixel = 0
                Label.Position = UDim2.new(0.00255102036, 0, 0.0355555564, 0)
                Label.Size = UDim2.new(0, 382, 0, 26)
                Label.Font = Enum.Font.GothamSemibold
                Label.TextColor3 = theme.accent
                Label.TextSize = 14.000
                Label.Text = text

                LabelC.Name = "LabelC"
                LabelC.Parent = Label
                LabelC.CornerRadius = UDim.new(0, 4)
                return Label
            end

            function modules:Toggle(text, flag, enabled, callback)
                assert(text, 'text is a required arg')
                assert(flag, 'flag is a required arg')

                local enabled = enabled or false
                local callback = callback or function() end

                local Toggle = Instance.new("TextButton")
                local ToggleC = Instance.new("UICorner")
                local ToggleDisplay = Instance.new("Frame")
                local ToggleDisplayC = Instance.new("UICorner")
                local ToggleDisplayFill = Instance.new("Frame")
                local ToggleDisplayFillC = Instance.new("UICorner")

                Toggle.Name = "Toggle"
                Toggle.Parent = Section
                Toggle.BackgroundColor3 = theme.main
                Toggle.BorderSizePixel = 0
                Toggle.Position = UDim2.new(-0.00382653065, 0, 0.346666664, 0)
                Toggle.Size = UDim2.new(0, 382, 0, 42)
                Toggle.AutoButtonColor = false
                Toggle.Font = Enum.Font.GothamSemibold
                Toggle.Text = ("   %s"):format(text)
                Toggle.TextColor3 = theme.accent
                Toggle.TextSize = 14.000
                Toggle.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleC.CornerRadius = UDim.new(0, 4)
                ToggleC.Name = "ToggleC"
                ToggleC.Parent = Toggle
                
                ToggleDisplay.Name = "ToggleDisplay"
                ToggleDisplay.Parent = Toggle
                ToggleDisplay.BackgroundColor3 = theme.secondary
                ToggleDisplay.BorderSizePixel = 0
                ToggleDisplay.Position = UDim2.new(0.846311867, 0, 0.190476194, 0)
                ToggleDisplay.Size = UDim2.new(0, 45, 0, 26)
                
                ToggleDisplayC.CornerRadius = UDim.new(0, 4)
                ToggleDisplayC.Name = "ToggleDisplayC"
                ToggleDisplayC.Parent = ToggleDisplay
                
                ToggleDisplayFill.Name = "ToggleDisplayFill"
                ToggleDisplayFill.Parent = ToggleDisplay
                ToggleDisplayFill.AnchorPoint = Vector2.new(0, 0.5)
                ToggleDisplayFill.BackgroundColor3 = theme.main
                ToggleDisplayFill.BorderSizePixel = 0
                ToggleDisplayFill.Position = UDim2.new(0, 3, 0.5, 0)
                ToggleDisplayFill.Size = UDim2.new(0, 24, 0, 20)
                
                ToggleDisplayFillC.CornerRadius = UDim.new(0, 4)
                ToggleDisplayFillC.Name = "ToggleDisplayFillC"
                ToggleDisplayFillC.Parent = ToggleDisplayFill

                library.flags[flag] = false
                library.funcstorage[flag] = callback
                library.objstorage[flag] = Toggle

                if enabled ~= false then
                    library:UpdateToggle(flag, true)
                end

                ToggleDisplay.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        library:UpdateToggle(flag)
                    end
                end)
            end

            function modules:Textbox(text, flag, default, callback)
                assert(text, 'text is a required arg')
                assert(flag, 'flag is a required arg')

                local default = default or ''
                local callback = callback or function() end

                library.flags[flag] = default

                local Textbox = Instance.new("TextButton")
                local TextboxC = Instance.new("UICorner")
                local TextboxValHolder = Instance.new("Frame")
                local TextboxValHolderL = Instance.new("UIListLayout")
                local TextInp = Instance.new("TextBox")
                local TextInpC = Instance.new("UICorner")
                
                Textbox.Name = "Textbox"
                Textbox.Parent = Section
                Textbox.BackgroundColor3 = theme.main
                Textbox.BorderSizePixel = 0
                Textbox.Position = UDim2.new(-0.0382653065, 0, 0.903660059, 0)
                Textbox.Size = UDim2.new(0, 382, 0, 42)
                Textbox.AutoButtonColor = false
                Textbox.Font = Enum.Font.GothamSemibold
                Textbox.Text = ("   %s"):format(text)
                Textbox.TextColor3 = theme.accent
                Textbox.TextSize = 14.000
                Textbox.TextXAlignment = Enum.TextXAlignment.Left
                
                TextboxC.CornerRadius = UDim.new(0, 4)
                TextboxC.Name = "TextboxC"
                TextboxC.Parent = Textbox
                
                TextboxValHolder.Name = "TextboxValHolder"
                TextboxValHolder.Parent = Textbox
                TextboxValHolder.BackgroundColor3 = theme.accent
                TextboxValHolder.BackgroundTransparency = 1.000
                TextboxValHolder.BorderSizePixel = 0
                TextboxValHolder.Position = UDim2.new(0.746835411, 0, 0, 0)
                TextboxValHolder.Size = UDim2.new(0, 84, 0, 42)
                
                TextboxValHolderL.Name = "TextboxValHolderL"
                TextboxValHolderL.Parent = TextboxValHolder
                TextboxValHolderL.FillDirection = Enum.FillDirection.Horizontal
                TextboxValHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                TextboxValHolderL.SortOrder = Enum.SortOrder.LayoutOrder
                TextboxValHolderL.VerticalAlignment = Enum.VerticalAlignment.Center
                
                TextInp.Name = "TextInp"
                TextInp.Parent = TextboxValHolder
                TextInp.BackgroundColor3 = theme.secondary
                TextInp.BorderSizePixel = 0
                TextInp.Position = UDim2.new(-0.190476194, 0, 0.190476194, 0)
                TextInp.Size = UDim2.new(0, 100, 0, 26)
                TextInp.Font = Enum.Font.Gotham
                TextInp.Text = default
                TextInp.TextColor3 = theme.accent
                TextInp.TextSize = 14.000
                
                TextInp.Size = UDim2.new(0, TextInp.TextBounds.X + 14, 0, 26)

                TextInpC.CornerRadius = UDim.new(0, 4)
                TextInpC.Name = "TextInpC"
                TextInpC.Parent = TextInp

                TextInp.FocusLost:Connect(function()
                    if TextInp.Text == "" then
                        TextInp.Text = library.flags[flag]
                    end
                    library.flags[flag] = TextInp.Text
                    callback(TextInp.Text)
                end)
    
                TextInp:GetPropertyChangedSignal('TextBounds'):Connect(function()
                    utils:Tween(TextInp, {0.1, 'Linear', 'InOut'}, {
                        Size = UDim2.new(0, TextInp.TextBounds.X + 14, 0, 26)
                    })
                end)
            end

            function modules:Slider(text, flag, default, min, max, callback)
                assert(text, 'text is a required arg')
                assert(flag, 'flag is a required arg')
                assert(default, 'default is a required arg')
                assert(min, 'min is a required arg')
                assert(max, 'min is a required arg')
                
                local value = default or min
			    library.flags[flag] = value
                
                local callback = callback or function() end 

                local Slider = Instance.new("TextButton")
                local SliderC = Instance.new("UICorner")
                local SliderText = Instance.new("TextLabel")
                local SliderBar = Instance.new("Frame")
                local SliderBarC = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillC = Instance.new("UICorner")
                local SliderValHolder = Instance.new("Frame")
                local SliderValHolderL = Instance.new("UIListLayout")
                local SliderVal = Instance.new("TextBox")
                local SliderValC = Instance.new("UICorner")
                
                Slider.Name = "Slider"
                Slider.Parent = Section
                Slider.BackgroundColor3 = theme.main
                Slider.BorderSizePixel = 0
                Slider.Position = UDim2.new(-0.00382653065, 0, 0.0355555564, 0)
                Slider.Size = UDim2.new(0, 382, 0, 62)
                Slider.AutoButtonColor = false
                Slider.Font = Enum.Font.GothamSemibold
                Slider.Text = ""
                Slider.TextColor3 = theme.accent
                Slider.TextSize = 14.000
                Slider.TextXAlignment = Enum.TextXAlignment.Left

                library.objstorage[flag] = Slider
			    library.funcstorage[flag] = callback
                
                SliderC.CornerRadius = UDim.new(0, 4)
                SliderC.Name = "SliderC"
                SliderC.Parent = Slider
                
                SliderText.Name = "SliderText"
                SliderText.Parent = Slider
                SliderText.BackgroundColor3 = theme.accent
                SliderText.BackgroundTransparency = 1.000
                SliderText.BorderSizePixel = 0
                SliderText.Size = UDim2.new(0, 200, 0, 42)
                SliderText.Font = Enum.Font.GothamSemibold
                SliderText.Text = ("   %s"):format(text)
                SliderText.TextColor3 = theme.accent
                SliderText.TextSize = 14.000
                SliderText.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = Slider
                SliderBar.BackgroundColor3 = theme.secondary
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0, 9, 0, 42)
                SliderBar.Size = UDim2.new(0, 363, 0, 10)
                
                SliderBarC.CornerRadius = UDim.new(0, 4)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar
                
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = theme.accent
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new(0, 0, 0, 10)
                
                SliderFillC.CornerRadius = UDim.new(0, 4)
                SliderFillC.Name = "SliderFillC"
                SliderFillC.Parent = SliderFill
                
                SliderValHolder.Name = "SliderValHolder"
                SliderValHolder.Parent = Slider
                SliderValHolder.BackgroundColor3 = theme.accent
                SliderValHolder.BackgroundTransparency = 1.000
                SliderValHolder.BorderSizePixel = 0
                SliderValHolder.Position = UDim2.new(0.746835411, 0, 0, 0)
                SliderValHolder.Size = UDim2.new(0, 84, 0, 42)
                
                SliderValHolderL.Name = "SliderValHolderL"
                SliderValHolderL.Parent = SliderValHolder
                SliderValHolderL.FillDirection = Enum.FillDirection.Horizontal
                SliderValHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                SliderValHolderL.SortOrder = Enum.SortOrder.LayoutOrder
                SliderValHolderL.VerticalAlignment = Enum.VerticalAlignment.Center
                
                SliderVal.Name = "SliderVal"
                SliderVal.Parent = SliderValHolder
                SliderVal.BackgroundColor3 = theme.secondary
                SliderVal.BorderSizePixel = 0
                SliderVal.Position = UDim2.new(0.452380955, 0, 0.142857149, 0)
                SliderVal.Size = UDim2.new(0, 46, 0, 26)
                SliderVal.Font = Enum.Font.Gotham
                SliderVal.Text = value
                SliderVal.TextColor3 = theme.accent
                SliderVal.TextSize = 14.000
                
                SliderValC.CornerRadius = UDim.new(0, 4)
                SliderValC.Name = "SliderValC"
                SliderValC.Parent = SliderVal

                SliderVal.Size = UDim2.new(0, SliderVal.TextBounds.X + 14, 0, 26)

                SliderVal:GetPropertyChangedSignal('TextBounds'):Connect(function()
                    utils:Tween(SliderVal, {0.1, 'Linear', 'InOut'}, {
                        Size = UDim2.new(0, SliderVal.TextBounds.X + 14, 0, 26)
                    })
                end)

                library:UpdateSlider(flag, value, min, max)
                local dragging = false

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        library:UpdateSlider(flag, nil, min, max)
                        dragging = true
                    end
                end)

                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        library:UpdateSlider(flag, nil, min, max)
                    end
                end)

                local boxFocused = false
                local allowed = {
                    [""] = true,
                    ["-"] = true
                }

                SliderVal.Focused:Connect(function()
                    boxFocused = true
                end)

                SliderVal.FocusLost:Connect(function()
                    boxFocused = false
                    if not tonumber(SliderVal.Text) then
                        library:UpdateSlider(flag, default or min, min, max)
                    end
                end)

                SliderVal:GetPropertyChangedSignal('Text'):Connect(function()
                    if not boxFocused then return end
                    SliderVal.Text = SliderVal.Text:gsub('%D+', '')
                    local text = SliderVal.Text

                    if not tonumber(text) then
                        SliderVal.Text = SliderVal.Text:gsub('%D+', '')
                    elseif not allowed[text] then
                        if tonumber(text) > max then
                            text = max
                            SliderVal.Text = tostring(max)
                        end
                        library:UpdateSlider(flag, tonumber(text) or value, min, max)
                    end
                end)
            end

            function modules:Keybind(text, flag, default, callback)
                assert(text, 'text is a required arg')
                assert(flag, 'flag is a required arg')
                assert(default, 'default is a required arg')
                
                local callback = callback or function() end
                
                local banned = {
                    Return = true;
                    Space = true;
                    Tab = true;
                    Unknown = true;
                }

                local shortNames = {
                    RightControl = 'Right Ctrl',
                    LeftControl = 'Left Ctrl',
                    LeftShift = 'Left Shift',
                    RightShift = 'Right Shift',
                    Semicolon = ";",
                    Quote = '"',
                    LeftBracket = '[',
                    RightBracket = ']',
                    Equals = '=',
                    Minus = '-',
                    RightAlt = 'Right Alt',
                    LeftAlt = 'Left Alt'
                }

                local allowed = {
                    MouseButton1 = false,
                    MouseButton2 = false
                }   

                local nm = (default and (shortNames[default.Name] or default.Name) or "None")
                library.flags[flag] = default or "None"

                local Keybind = Instance.new("TextButton")
                local KeybindC = Instance.new("UICorner")
                local KeybindHolder = Instance.new("Frame")
                local KeybindHolderL = Instance.new("UIListLayout")
                local KeybindVal = Instance.new("TextButton")
                local KeybindValC = Instance.new("UICorner")

                Keybind.Name = "Keybind"
                Keybind.Parent = Section
                Keybind.BackgroundColor3 = theme.main
                Keybind.BorderSizePixel = 0
                Keybind.Position = UDim2.new(-0.00382653065, 0, 0.346666664, 0)
                Keybind.Size = UDim2.new(0, 382, 0, 42)
                Keybind.AutoButtonColor = false
                Keybind.Font = Enum.Font.GothamSemibold
                Keybind.Text = ("   %s"):format(text)
                Keybind.TextColor3 = theme.accent
                Keybind.TextSize = 14.000
                Keybind.TextXAlignment = Enum.TextXAlignment.Left
                
                KeybindC.CornerRadius = UDim.new(0, 4)
                KeybindC.Name = "KeybindC"
                KeybindC.Parent = Keybind
                
                KeybindHolder.Name = "SliderValHolder"
                KeybindHolder.Parent = Keybind
                KeybindHolder.BackgroundColor3 = theme.accent
                KeybindHolder.BackgroundTransparency = 1.000
                KeybindHolder.BorderSizePixel = 0
                KeybindHolder.Position = UDim2.new(0.746835411, 0, 0, 0)
                KeybindHolder.Size = UDim2.new(0, 84, 0, 42)
                
                KeybindHolderL.Name = "SliderValHolderL"
                KeybindHolderL.Parent = KeybindHolder
                KeybindHolderL.FillDirection = Enum.FillDirection.Horizontal
                KeybindHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindHolderL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindHolderL.VerticalAlignment = Enum.VerticalAlignment.Center
                
                KeybindVal.Parent = KeybindHolder
                KeybindVal.BackgroundColor3 = theme.secondary
                KeybindVal.BorderSizePixel = 0
                KeybindVal.Position = UDim2.new(0.357142866, 0, 0.190476194, 0)
                KeybindVal.Size = UDim2.new(0, 0, 0, 26)
                KeybindVal.AutoButtonColor = false
                KeybindVal.Font = Enum.Font.Gotham
                KeybindVal.Text = nm
                KeybindVal.TextColor3 = theme.accent
                KeybindVal.TextSize = 14.000
                
                KeybindValC.CornerRadius = UDim.new(0, 4)
                KeybindValC.Name = "SliderValC"
                KeybindValC.Parent = Bind

                KeybindVal.Size = UDim2.new(0, KeybindVal.TextBounds.X + 14, 0, 26)
                
                KeybindVal:GetPropertyChangedSignal('TextBounds'):Connect(function()
                    utils:Tween(KeybindVal, {0.1, 'Linear', 'InOut'}, {
                        Size = UDim2.new(0, KeybindVal.TextBounds.X + 14, 0, 26)
                    })
                end)

                KeybindVal.MouseButton1Click:Connect(function()
                    library.binding = true
                    KeybindVal.Text = "..."
                    local a, b = services.UserInputService.InputBegan:wait()
                    local name = tostring(a.KeyCode.Name)
                    local typeName = tostring(a.UserInputType.Name)
                    if (a.UserInputType ~= Enum.UserInputType.Keyboard and (allowed[a.UserInputType.Name]) and (not data.KbOnly)) or (a.KeyCode and (not banned[a.KeyCode.Name])) then
                        local name = (a.UserInputType ~= Enum.UserInputType.Keyboard and a.UserInputType.Name or a.KeyCode.Name)
                        library.flags[flag] = (a)
                        KeybindVal.Text = shortNames[name] or name
                    else
                        if (library.flags[flag]) then
                            if (not pcall(function()
                                    return library.flags[flag].UserInputType
                                end)) then
                                local name = tostring(library.flags[flag])
                                KeybindVal.Text = shortNames[name] or name
                            else
                                local name = (library.flags[flag].UserInputType ~= Enum.UserInputType.Keyboard and library.flags[flag].UserInputType.Name or library.flags[flag].KeyCode.Name)
                                KeybindVal.Text = shortNames[name] or name
                            end
                        end
                    end
                    wait(0.1)  
                    library.binding = false
                end)
                if library.flags[flag] then
                    KeybindVal.Text = shortNames[tostring(library.flags[flag].Name)] or tostring(library.flags[flag].Name)
                end
                library.binds[flag] = {
                    location = library.flags,
                    callback = function()
                        callback()	
                    end
                }
            end

            function modules:Dropdown(text, flag, options, callback)
                assert(text, 'text is a required arg')
                assert(flag, 'flag is a required arg')
                assert(options, 'options is a required arg')
                
                if type(options) ~= 'table' then
                    options = {'No Options Found'}
                end
                if #options < 1 then
                    options = {'No Options Found'}
                end
                
                local optionStorage = {}
                local callback = callback or function() end
                library.flags[flag] = options[1]

                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local Back = Instance.new("ImageLabel")
                local DropdownBottom = Instance.new("TextButton")
                local DropdownBottomC = Instance.new("UICorner")
                local DropdownObjects = Instance.new("ScrollingFrame")
                local DropdownObjectsList = Instance.new("UIListLayout")
                local DropdownObjectsPadding = Instance.new("UIPadding")

                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = Section
                DropdownTop.BackgroundColor3 = theme.main
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Position = UDim2.new(-0.00382653065, 0, 0.346666664, 0)
                DropdownTop.Size = UDim2.new(0, 382, 0, 42)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamSemibold
                DropdownTop.Text = ("   %s"):format(library.flags[flag])
                DropdownTop.TextColor3 = theme.accent
                DropdownTop.TextSize = 14.000
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownTopC.CornerRadius = UDim.new(0, 4)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop
                
                Back.Name = "Back"
                Back.Parent = DropdownTop
                Back.BackgroundTransparency = 1.000
                Back.Position = UDim2.new(0.887434542, 0, 0.142857149, 0)
                Back.Rotation = -90.000
                Back.Size = UDim2.new(0, 30, 0, 30)
                Back.Image = "rbxassetid://4370337241"
                Back.ScaleType = Enum.ScaleType.Fit
                Back.ImageColor3 = theme.accent
                
                DropdownBottom.Name = "DropdownBottom"
                DropdownBottom.Parent = Section
                DropdownBottom.BackgroundColor3 = theme.main
                DropdownBottom.BorderSizePixel = 0
                DropdownBottom.Position = UDim2.new(0.0127551025, 0, 0.616632879, 0)
                DropdownBottom.Size = UDim2.new(0, 382, 0, 0)
                DropdownBottom.AutoButtonColor = false
                DropdownBottom.Font = Enum.Font.GothamSemibold
                DropdownBottom.Text = ""
                DropdownBottom.TextColor3 = theme.accent
                DropdownBottom.TextSize = 14.000
                DropdownBottom.TextXAlignment = Enum.TextXAlignment.Left
                DropdownBottom.Visible = false
                
                DropdownBottomC.CornerRadius = UDim.new(0, 4)
                DropdownBottomC.Name = "DropdownBottomC"
                DropdownBottomC.Parent = DropdownBottom
                
                DropdownObjects.Name = "DropdownObjects"
                DropdownObjects.Parent = DropdownBottom
                DropdownObjects.Active = true
                DropdownObjects.BackgroundColor3 = theme.accent
                DropdownObjects.BackgroundTransparency = 1.000
                DropdownObjects.BorderSizePixel = 0
                DropdownObjects.Size = UDim2.new(1, 0, 1, 0)
                DropdownObjects.ScrollBarThickness = 2
                
                DropdownObjectsList.Name = "DropdownObjectsList"
                DropdownObjectsList.Parent = DropdownObjects
                DropdownObjectsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
                DropdownObjectsList.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownObjectsList.Padding = UDim.new(0, 4)
                
                DropdownObjectsPadding.Name = "DropdownObjectsPadding"
                DropdownObjectsPadding.Parent = DropdownObjects
                DropdownObjectsPadding.PaddingTop = UDim.new(0, 4)                

                DropdownObjectsList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                    DropdownObjects.CanvasSize = UDim2.new(0, 0, 0, DropdownObjectsList.AbsoluteContentSize.Y + 7)
                end)

                local isOpen = false
                local function toggleDropdown()
                    isOpen = not isOpen
                    if not isOpen then
                        spawn(function()
                            wait(.3)
                            DropdownBottom.Visible = false
                        end)
                    else
                        DropdownBottom.Visible = true
                    end
                    local openTo = 183
                    if DropdownObjectsList.AbsoluteContentSize.Y < openTo then
                        openTo = DropdownObjectsList.AbsoluteContentSize.Y
                    end
                    DropdownTop.Text = ('   %s'):format(isOpen and text or library.flags[flag])
                    utils:Tween(Back, {0.3, 'Sine', 'InOut'}, {
                        Rotation = (isOpen and 90) or -90
                    })
                    utils:Tween(DropdownBottom, {0.3, 'Sine', 'InOut'}, {
                        Size = UDim2.new(0, 382, 0, isOpen and openTo + 3 or 0)
                    })
                end
                
                DropdownObjectsList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                    if not isOpen then return end
                    local openTo = 183
                    if DropdownObjectsList.AbsoluteContentSize.Y < openTo then
                        openTo = DropdownObjectsList.AbsoluteContentSize.Y
                    end
                    DropdownTop.Text = ('   %s'):format(isOpen and text or library.flags[flag])
                    utils:Tween(Back, {0.3, 'Sine', 'InOut'}, {
                        Rotation = (isOpen and 90) or -90
                    })
                    utils:Tween(DropdownBottom, {0.3, 'Sine', 'InOut'}, {
                        Size = UDim2.new(0, 382, 0, isOpen and openTo + 3 or 0)
                    })
                end)
                
                Back.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        toggleDropdown()
                    end
                end)
                
                local cnt = 0
                local selectedOption = nil
                for _, v in pairs(options) do
                    cnt = cnt + 1
                    local Option = Instance.new("TextButton")
                    table.insert(optionStorage, Option)
                    if cnt == 1 then selectedOption = Option end
                    
                    Option.Name = "Option"
                    Option.Parent = DropdownObjects
                    Option.BackgroundColor3 = theme.secondary
                    Option.BackgroundTransparency = 1.000
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0.285340309, 0, 0.0218579229, 0)
                    Option.Size = UDim2.new(0, 372, 0, 26)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamSemibold
                    Option.Text = v
                    Option.TextColor3 = (Option == selectedOption and theme.accent) or theme.accent2
                    Option.TextSize = 14.000
                    
                    Option.MouseButton1Click:Connect(function()
                        if Option ~= selectedOption then 
                            selectedOption.TextColor3 = theme.accent2 
                            Option.TextColor3 = theme.accent 
                            selectedOption = Option 
                        end
                        library.flags[flag] = v
                        spawn(toggleDropdown)
                        spawn(function()
                            callback(v)
                        end)
                    end)
                end
                local eee = {}
                function eee:refresh(new)
                    for _, v in pairs(optionStorage) do
                        v:Destroy()
                    end
                    optionStorage = {}
                    selectedOption = nil
                    cnt = 0
                    for _, v in pairs(new) do
                        cnt = cnt + 1
                        local Option = Instance.new("TextButton")
                        table.insert(optionStorage, Option)
                        if cnt == 1 then selectedOption = Option end
                        
                        Option.Name = "Option"
                        Option.Parent = DropdownObjects
                        Option.BackgroundColor3 = theme.secondary
                        Option.BackgroundTransparency = 1.000
                        Option.BorderSizePixel = 0
                        Option.Position = UDim2.new(0.285340309, 0, 0.0218579229, 0)
                        Option.Size = UDim2.new(0, 372, 0, 26)
                        Option.AutoButtonColor = false
                        Option.Font = Enum.Font.GothamSemibold
                        Option.Text = v
                        Option.TextColor3 = (Option == selectedOption and theme.accent) or theme.accent2
                        Option.TextSize = 14.000
                        
                        Option.MouseButton1Click:Connect(function()
                            if Option ~= selectedOption then 
                                selectedOption.TextColor3 = theme.accent2 
                                Option.TextColor3 = theme.accent 
                                selectedOption = Option 
                            end
                            library.flags[flag] = v
                            spawn(toggleDropdown)
                            spawn(function()
                                callback(v)
                            end)
                        end)
                    end
                end
                return eee                
            end

            return modules
        end
        return sections
	end
    return tabs
end
return library