local runservice = game:GetService("RunService")
local userinputservice = game:GetService("UserInputService")
local tweenservice = game:GetService("TweenService")
local textservice = game:GetService("TextService")
local httpservice = game:GetService("HttpService")

local mouse = game:GetService("Players").LocalPlayer:GetMouse()

local hugevec2 = Vector2.new(math.huge, math.huge)

local emptybindsize = textservice:GetTextSize("None", 12, Enum.Font.Gotham, hugevec2).X + 12
local ellipsisbindsize = textservice:GetTextSize("...", 12, Enum.Font.Gotham, hugevec2).X + 12
local placeholderboxsize = textservice:GetTextSize("Enter Text...", 12, Enum.Font.Gotham, hugevec2).X + 12

local SoundNames = {
	"Android",
	"Bonk",
	"CsgoHeadshot",
	"Goof",
	"Headshot",
	"HitMarker",
	"Phonk",
	"Punch",
	"Slap",
}

local blacklistedkeys = {
	[Enum.KeyCode.Unknown] = true
}

local whitelistedtypes = { 
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.MouseButton2] = true,
	[Enum.UserInputType.MouseButton3] = true
}

local theme = setmetatable({
	Items = {
		mainbackground = {},
		titlebackground = {},
		leftbackground = {},
		sectionbackground = {},
		foreground = {},
		highlight = {},
		dynamic = {}
	},
    values = {
		mainbackground = Color3.fromRGB(36, 36, 36),
		titlebackground = Color3.fromRGB(28, 28, 28),
		leftbackground = Color3.fromRGB(28, 28, 28),
		sectionbackground = Color3.fromRGB(25, 25, 25),
		foreground = Color3.fromRGB(235, 235, 235),
		highlight = Color3.fromRGB(51, 91, 232)
    }
}, {
	__index = function(t, k)
		return t.values[k]
	end,
	__newindex = function(t, k, v)
		t.values[k] = v
		for inst, prop in next, t.Items[k] do
			inst[prop] = v
		end
		for inst, data in next, t.Items.dynamic do
			local item = data.func()
			if item == k then
				inst[data.prop] = v
			end
		end
	end
})

--[[ Functions ]]--

local function create(classname, properties, children)
	local inst = Instance.new(classname)
	for i, v in next, properties do
		if i == "Theme" then
			for prop, item in next, v do
				if type(item) == "function" then
					theme.Items.dynamic[inst] = {
						prop = prop,
						func = item
					}
					inst[prop] = theme[item()]
				else
					theme.Items[item][inst] = prop
					inst[prop] = theme[item]
				end
			end
	    elseif i ~= "Parent" then
	       	inst[i] = v
	    end
	end
	if children then
		for i, v in next, children do
			v.Parent = inst
		end
	end
	inst.Parent = properties.Parent
	return inst
end

local function tween(instance, duration, properties, style)
	local t = tweenservice:Create(instance, TweenInfo.new(duration, style or Enum.EasingStyle.Sine), properties)
	t:Play()
	return t
end

local function customscroll(frame, scroll, jump)
    scroll.ScrollingEnabled = false
    frame.MouseWheelForward:Connect(function()
        scroll.CanvasPosition = scroll.CanvasPosition - Vector2.new(0, math.min(jump, scroll.CanvasPosition.Y))
    end)
    frame.MouseWheelBackward:Connect(function()
        scroll.CanvasPosition = scroll.CanvasPosition + Vector2.new(0, math.min(jump, scroll.AbsoluteCanvasSize.Y - scroll.AbsoluteSize.Y - scroll.CanvasPosition.Y))
    end)
end

local function ripple(inst)
	local radius = inst.AbsoluteSize[inst.AbsoluteSize.X > inst.AbsoluteSize.Y and "X" or "Y"]
	local item = create("Frame", {
		Theme = { BackgroundColor3 = "highlight" },
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 0.4,
		Parent = inst,
		Position = UDim2.new(0, mouse.X - inst.AbsolutePosition.X, 0, mouse.Y - inst.AbsolutePosition.Y),
		Size = UDim2.new()
	}, {
		create("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	})
	tween(item, 0.8, { Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, radius, 0, radius), Transparency = 1 }).Completed:Connect(function()
		item:Destroy()
	end)
end

local function round(val, nearest)
	local mul = 1 / nearest
    return math.floor(val * mul + 0.5) / mul
end

--[[ Label ]]--

local label = {}
label.__index = label

function label.new()
	local newlabel = setmetatable({
		itemtype = "label"
	}, label)

	newlabel.frame = create("TextLabel", { 
		Theme = {
			TextColor3 = "foreground"
		},
		Font = Enum.Font.Gotham, 
		FontSize = Enum.FontSize.Size14, 
		Text = "Label", 
		TextSize = 13, 
		TextWrap = true, 
		TextWrapped = true, 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 21), 
		Name = "label"
	})
	
	return newlabel
end

function label:update(Content)
	self.Content = Content
	self.frame.Name = Content
	self.frame.Text = Content
	self.frame.Size = UDim2.new(1, 0, 0, textservice:GetTextSize(Content, 13, Enum.Font.Gotham, Vector2.new(self.frame.AbsoluteSize.X, math.huge)).Y + 8)
end

--[[ Status Label ]]--

local statuslabel = {}
statuslabel.__index = statuslabel

function statuslabel.new(Content)
	local newstatuslabel = setmetatable({
		itemtype = "statuslabel",
		Content = Content
	}, statuslabel)
	
	newstatuslabel.frame = create("Frame", { 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 21), 
		Name = Content
	}, {
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, 0, 1, 0), 
			Name = "label"
		}),
		create("TextLabel", { 
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = "Undefined", 
			TextColor3 = Color3.new(235, 235, 235), 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Right, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, 0, 1, 0), 
			Name = "status"
		})
	})

	return newstatuslabel
end

function statuslabel:update(status, Colour)
	self.status = status
	self.frame.status.Text = status
	if Colour then
		self.Colour = Colour
		self.frame.status.TextColor3 = Colour
	end
end

--[[ Button ]]--

local button = {}
button.__index = button

function button.new(Content, Callback)
	local newbutton = setmetatable({
		itemtype = "button",
		Content = Content,
		Callback = Callback or function() end
	}, button)

	newbutton.frame = create("TextButton", { 
		Theme = {
			BackgroundColor3 = "mainbackground",
			TextColor3 = "foreground"
		},
		Font = Enum.Font.Gotham, 
		FontSize = Enum.FontSize.Size14, 
		Text = Content,
		TextSize = 13, 
		AutoButtonColor = false, 
		ClipsDescendants = true,
		Size = UDim2.new(1, 0, 0, 24), 
		Name = Content
	}, {
		create("UICorner", { 
			CornerRadius = UDim.new(0, 4), 
			Name = "corner"
		})
	})
	
	newbutton.frame.MouseButton1Down:Connect(function()
		task.spawn(ripple, newbutton.frame)
		newbutton:fire()
	end)
	
	return newbutton
end

function button:fire(...)
	self.Callback(...)
end

--[[ Toggle ]]--

local toggle = {}
toggle.__index = toggle

function toggle.new(Content, Callback)
	local newtoggle = setmetatable({
		itemtype = "toggle",
		Content = Content,
		Callback = Callback or function() end
	}, toggle)

	newtoggle.frame = create("Frame", { 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 24), 
		Name = Content
	}, {
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, -30, 1, 0), 
			Name = "label"
		}),
		create("Frame", { 
			Theme = {
				BackgroundColor3 = function()
					return newtoggle.library and newtoggle.library.Flags[newtoggle.Flag] and "highlight" or "mainbackground"
				end
			},
			AnchorPoint = Vector2.new(1, 0), 
			Position = UDim2.new(1, 0, 0, 0), 
			Size = UDim2.new(0, 24, 0, 24), 
			Name = "indicator"
		},     
         {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
		})
	})
	
	newtoggle.frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			newtoggle:switch()
		end
	end)

	return newtoggle
end

function toggle:set(bool)
	self.library.Flags[self.Flag] = bool
	tween(self.frame.indicator, 0.25, { BackgroundColor3 = bool and theme.highlight or theme.mainbackground })
	self.Callback(bool)
end

function toggle:switch()
	self:set(not self.library.Flags[self.Flag])
end

--[[ Bind ]]--

local bind = {}
bind.__index = bind

function bind.new(Content, Keydown, Keyup, keychanged)
	local newbind = setmetatable({
		itemtype = "bind",
		Content = Content,
		Keydown = Keydown or function() end,
		Keyup = Keyup or function() end,
		keychanged = keychanged or function() end
	}, bind)

	newbind.frame = create("Frame", { 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 24), 
		Name = Content
	}, {
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, 0, 1, 0), 
			Name = "label"
		}),
		create("TextLabel", { 
			Theme = {
				BackgroundColor3 = "mainbackground",
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size12, 
			Text = "None", 
			TextSize = 12, 
			TextWrap = true, 
			TextWrapped = true, 
			AnchorPoint = Vector2.new(1, 0), 
			Position = UDim2.new(1, 0, 0, 0), 
			Size = UDim2.new(0, emptybindsize, 1, 0), 
			Name = "indicator"
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			})
		})
	})

	newbind.frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and newbind.library.settings.binding == false then
			newbind.library.settings.binding = true
			newbind.frame.indicator.Size = UDim2.new(0, ellipsisbindsize, 1, 0)
			newbind.frame.indicator.Text = "..."
			task.wait(0.1)
			while true do
				local input = userinputservice.InputBegan:Wait()
				if (input.UserInputType == Enum.UserInputType.Keyboard and not blacklistedkeys[input.KeyCode]) or whitelistedtypes[input.UserInputType] then
					newbind:set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name or input.UserInputType.Name)
					break
				end
			end
			task.wait(0.1)
			newbind.library.settings.binding = false
		end
	end)

	return newbind
end

function bind:set(inputname)
	local value = (inputname == "Escape" or inputname == "") and "None" or inputname
	local oldvalue = self.library.Flags[self.Flag]
	self.library.Flags[self.Flag] = value
	self.frame.indicator.Size = UDim2.new(0, textservice:GetTextSize(value, 12, Enum.Font.Gotham, hugevec2).X + 12, 1, 0)
	self.frame.indicator.Text = value
	self.keychanged(oldvalue, value)
end

--[[ Slider ]]--

local slider = {}
slider.__index = slider

function slider.new(Content, Min, Max, Float, Prefix, Suffix, Callback)
	local newslider = setmetatable({
		itemtype = "slider",
		Content = Content,
		Min = Min or 0,
		Max = Max or 100,
		Float = Float or 1,
		Prefix = Prefix or "",
		Suffix = Suffix or "",
		Callback = Callback or function() end
	}, slider)

	newslider.frame = create("Frame", { 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 24), 
		Name = Content
	}, {
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, -90, 1, 0), 
			Name = "label"
		}),
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = tostring(newslider.Min), 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Right, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, -90, 1, 0), 
			Name = "value"
		}),
		create("Frame", { 
			AnchorPoint = Vector2.new(1, 0.5), 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(1, 0, 0.5, 0), 
			Size = UDim2.new(0, 86, 1, 0), 
			Name = "container"
		}, {
			create("Frame", {
				Theme = {
					BackgroundColor3 = "mainbackground"
				},
				AnchorPoint = Vector2.new(0.5, 0.5), 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				Size = UDim2.new(1, -6, 0, 4), 
				Name = "track"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(1, 0), 
					Name = "corner"
				}),
				create("Frame", { 
					Theme = {
						BackgroundColor3 = "highlight"
					},
					AnchorPoint = Vector2.new(0, 0.5), 
					Position = UDim2.new(0, 0, 0.5, 0), 
					Size = UDim2.new(0, 0, 0, 4), 
					Name = "highlight"
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					}),
					create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.new(0.054902, 0.054902, 0.054902), 
						Position = UDim2.new(1, 0, 0.5, 0), 
						Size = UDim2.new(0, 6, 0, 16), 
						Name = "drag"
					}, {
						create("UICorner", { 
							CornerRadius = UDim.new(1, 0), 
							Name = "corner"
						})
					})
				})
			})
		})
	})

	newslider.frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and newslider.library.settings.dragging == false then
            newslider.library.settings.dragging = true
            local slideconn; slideconn = mouse.Move:Connect(function()
				newslider:set(newslider.Min + ((newslider.Max - newslider.Min) * ((mouse.X - newslider.frame.container.track.AbsolutePosition.X) / newslider.frame.container.track.AbsoluteSize.X)))
			end)
			local inputconn; inputconn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					slideconn:Disconnect()
					inputconn:Disconnect()
					newslider.library.settings.dragging = false
				end
			end)
        end
    end)

	return newslider
end

function slider:set(value)
	local val = math.clamp(round(value, self.Float), self.Min, self.Max)
	if val ~= self.library.Flags[self.Flag] then
		self.library.Flags[self.Flag] = val
		tween(self.frame.container.track.highlight, 0.2, { Size = UDim2.new((val - self.Min) / (self.Max - self.Min), 0, 0, 4) })
		self.frame.value.Text = self.Prefix .. tostring(val) .. self.Suffix
		self.Callback(val)
	end
end

--[[ Box ]]--

local box = {}
box.__index = box

function box.new(Content, NumberOnly, Callback)
	local newbox = setmetatable({
		itemtype = "box",
		Content = Content,
		NumberOnly = NumberOnly or false,
		Callback = Callback or function() end
	}, box)

	newbox.frame = create("Frame", { 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 24), 
		Name = Content
	}, {
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, 0, 1, 0), 
			Name = "label"
		}),
		create("Frame", { 
			Theme = {
				BackgroundColor3 = "mainbackground"
			},
			AnchorPoint = Vector2.new(1, 0.5), 
			Position = UDim2.new(1, 0, 0.5, 0), 
			Size = UDim2.new(0, placeholderboxsize, 1, 0), 
			Name = "outline"
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("TextBox", { 
				Theme = {
					TextColor3 = "foreground"
				},
				Font = Enum.Font.Gotham, 
				FontSize = Enum.FontSize.Size12, 
				PlaceholderText = "Enter Text...", 
				Text = "", 
				TextSize = 12, 
				TextWrap = true, 
				TextWrapped = true, 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				Size = UDim2.new(1, 0, 1, 0), 
				ZIndex = 2, 
				Name = "input"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				})
			}),
			create("Frame", { 
				Theme = {
					BackgroundColor3 = "highlight"
				},
				AnchorPoint = Vector2.new(0.5, 1), 
				Position = UDim2.new(0.5, 0, 1, 0), 
				Size = UDim2.new(1, 0, 0, 4), 
				Name = "bottom"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				create("Frame", {
					Theme = {
						BackgroundColor3 = "mainbackground"
					},
					BorderSizePixel = 0, 
					Size = UDim2.new(1, 0, 0, 2), 
					Name = "cover"
				})
			})
		})
	})
	
	newbox.frame.outline.input:GetPropertyChangedSignal("Text"):Connect(function()
        newbox:resize()
    end)

    newbox.frame.outline.input.FocusLost:Connect(function()
		newbox:set(newbox.frame.outline.input.Text)
	end)

    newbox.frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            newbox.frame.outline.input:CaptureFocus()
        end
    end)

	return newbox
end

function box:set(value)
	if value ~= "" and self.NumberOnly and not tonumber(value) then
		self.frame.outline.input.Text = self.library.Flags[self.Flag]
	else
		self.frame.outline.input.Text = value
		self.library.Flags[self.Flag] = value
		self.Callback(value)
	end
end

function box:resize()
	if self.frame.outline.input.Text == "" then
		self.frame.outline.Size = UDim2.new(0, placeholderboxsize, 1, 0)
		self.frame.Size = UDim2.new(1, 0, 0, 24)
	else
		local size = textservice:GetTextSize(self.frame.outline.input.Text, 12, Enum.Font.Gotham, Vector2.new(self.maxsize - 12, math.huge))
		self.frame.outline.Size = UDim2.new(0, size.X + 12, 1, 0)
		self.frame.Size = UDim2.new(1, 0, 0, math.max(size.Y + 12, 24))
	end
end

--[[ Colour Picker ]]--

local picker = {}
picker.__index = picker

function picker.new(Content, Callback)
	local newpicker = setmetatable({
		itemtype = "picker",
		Content = Content,
		Callback = Callback or function() end,
		settings = {
			open = false
		}
	}, picker)
	
	newpicker.frame = create("Frame", { 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		ClipsDescendants = true, 
		Size = UDim2.new(1, 0, 0, 24), 
		Name = Content
	}, {
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, 0, 0, 24), 
			Name = "label"
		}),
		create("Frame", { 
			Theme = {
				BackgroundColor3 = "mainbackground"
			},
			AnchorPoint = Vector2.new(1, 0), 
			Position = UDim2.new(1, 0, 0, 0), 
			Size = UDim2.new(0, 24, 0, 24), 
			Name = "indicator"
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("TextLabel", { 
				Theme = {
					TextColor3 = "foreground"
				},
				Font = Enum.Font.Gotham, 
				FontSize = Enum.FontSize.Size14, 
				Text = "▼", 
				TextSize = 13, 
				TextWrap = true, 
				TextWrapped = true, 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				BackgroundTransparency = 1, 
				Size = UDim2.new(0, 24, 0, 24), 
				Name = "indicator"
			})
		}),
		create("Frame", { 
			Theme = {
				BackgroundColor3 = "mainbackground"
			},
			Position = UDim2.new(0, 0, 0, 28), 
			Size = UDim2.new(1, 0, 0, 144), 
			Name = "container"
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("Frame", { 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				Position = UDim2.new(0, 6, 0, 6), 
				Size = UDim2.new(0, 130, 0, 74), 
				Name = "sat"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				create("UIGradient", { 
					Color = ColorSequence.new({ 
						ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), 
						ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
					}), 
					Name = "gradient"
				}),
				create("Frame", { 
					BackgroundColor3 = Color3.new(1, 1, 1), 
					Size = UDim2.new(1, 0, 1, 0), 
					Name = "val"
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 3), 
						Name = "corner"
					}),
					create("UIGradient", { 
						Color = ColorSequence.new({ 
							ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), 
							ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
						}), 
						Rotation = 270, 
						Transparency = NumberSequence.new({ 
							NumberSequenceKeypoint.new(0, 0), 
							NumberSequenceKeypoint.new(1, 1)
						}), 
						Name = "gradient"
					}),
					create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.new(1, 1, 1), 
						BackgroundTransparency = 1, 
						Position = UDim2.new(1, 0, 0, 0), 
						Size = UDim2.new(0, 16, 0, 16), 
						Name = "indicator"
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.new(0.054902, 0.054902, 0.054902), 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 2), 
							Name = "horizontal"
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							})
						}),
						create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.new(0.054902, 0.054902, 0.054902), 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(0, 2, 1, 0), 
							Name = "vertical"
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							})
						})
					})
				})
			}),
			create("TextBox", { 
				Theme = {
					BackgroundColor3 = "sectionbackground",
					TextColor3 = "foreground"
				},
				Font = Enum.Font.Gotham, 
				FontSize = Enum.FontSize.Size12, 
				PlaceholderText = "Red", 
				Text = "255", 
				TextSize = 12, 
				AnchorPoint = Vector2.new(1, 0), 
				Position = UDim2.new(1, -6, 0, 6), 
				Size = UDim2.new(0, 71, 0, 22), 
				Name = "red"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				})
			}),
			create("TextBox", { 
				Theme = {
					BackgroundColor3 = "sectionbackground",
					TextColor3 = "foreground"
				},
				Font = Enum.Font.Gotham, 
				FontSize = Enum.FontSize.Size12, 
				PlaceholderText = "Green", 
				Text = "0", 
				TextSize = 12, 
				AnchorPoint = Vector2.new(1, 0), 
				Position = UDim2.new(1, -6, 0, 32), 
				Size = UDim2.new(0, 71, 0, 22), 
				Name = "green"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				})
			}),
			create("TextBox", { 
				Theme = {
					BackgroundColor3 = "sectionbackground",
					TextColor3 = "foreground"
				},
				Font = Enum.Font.Gotham, 
				FontSize = Enum.FontSize.Size12, 
				PlaceholderText = "Blue", 
				Text = "0", 
				TextSize = 12, 
				AnchorPoint = Vector2.new(1, 0), 
				Position = UDim2.new(1, -6, 0, 58), 
				Size = UDim2.new(0, 71, 0, 22), 
				Name = "blue"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				})
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				Position = UDim2.new(0.5, 0, 0, 86), 
				Size = UDim2.new(1, -12, 0, 22), 
				Name = "hue"
			}, {
				create("UIGradient", { 
					Color = ColorSequence.new({ 
						ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)), 
						ColorSequenceKeypoint.new(0.1666666666666666, Color3.new(1, 1, 0)), 
						ColorSequenceKeypoint.new(0.3333333333333333, Color3.new(0, 1, 0)), 
						ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 1)), 
						ColorSequenceKeypoint.new(0.6666666666666666, Color3.new(0, 0, 1)), 
						ColorSequenceKeypoint.new(0.8333333333333333, Color3.new(1, 0, 1)), 
						ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
					}), 
					Name = "gradient"
				}),
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.new(0.054902, 0.054902, 0.054902), 
					Position = UDim2.new(0, 0, 0.5, 0), 
					Size = UDim2.new(0, 4, 1, 4), 
					Name = "drag"
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(1, 0), 
						Name = "corner"
					})
				})
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(0.5, 0, 0, 114), 
				Size = UDim2.new(1, -12, 0, 24), 
				Name = "rainbow"
			}, {
				create("TextLabel", { 	
				Theme = {
					TextColor3 = "foreground"
				},
					Font = Enum.Font.Gotham, 
					FontSize = Enum.FontSize.Size14, 
					Text = "Rainbow", 
					TextSize = 13, 
					TextWrap = true, 
					TextWrapped = true, 
					TextXAlignment = Enum.TextXAlignment.Left, 
					BackgroundColor3 = Color3.new(1, 1, 1), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(1, -30, 1, 0), 
					Name = "label"
				}),
				create("Frame", { 		
					Theme = {
						BackgroundColor3 = function()
							return newpicker.library and newpicker.library.Flags[newpicker.Flag].rainbow and "highlight" or "sectionbackground"
						end
					},
					AnchorPoint = Vector2.new(1, 0), 
					Position = UDim2.new(1, 0, 0, 0), 
					Size = UDim2.new(0, 24, 0, 24), 
					Name = "indicator"
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				})
			})
		})
	})
	
	newpicker.frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and mouse.Y - newpicker.frame.AbsolutePosition.Y < 24 then
			if newpicker.settings.open then
				newpicker:close()
			else
				newpicker:open()
			end
		end
	end)

	newpicker.frame.container.hue.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and newpicker.library.settings.dragging == false then
            newpicker.library.settings.dragging = true
            if newpicker.library.Flags[newpicker.Flag].rainbow then
                newpicker:setrainbow(false)
            end
            local moveconn; moveconn = mouse.Move:Connect(function()
                newpicker:set(math.clamp((mouse.X - newpicker.frame.container.hue.AbsolutePosition.X) / newpicker.frame.container.hue.AbsoluteSize.X, 0, 1), newpicker.library.Flags[newpicker.Flag].s, newpicker.library.Flags[newpicker.Flag].v)
            end)
            local inputconn; inputconn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    moveconn:Disconnect()
					inputconn:Disconnect()
                    newpicker.library.settings.dragging = false
                end
            end)
        end
    end)

    newpicker.frame.container.sat.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and newpicker.library.settings.dragging == false then
            newpicker.library.settings.dragging = true
            local moveconn; moveconn = mouse.Move:Connect(function()
                newpicker:set(newpicker.library.Flags[newpicker.Flag].h, math.clamp((mouse.X - newpicker.frame.container.sat.AbsolutePosition.X) / newpicker.frame.container.sat.AbsoluteSize.X, 0, 1), 1 - math.clamp((mouse.Y - newpicker.frame.container.sat.AbsolutePosition.Y) / newpicker.frame.container.sat.AbsoluteSize.Y, 0, 1))
            end)
            local inputconn; inputconn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    moveconn:Disconnect()
					inputconn:Disconnect()
                    newpicker.library.settings.dragging = false
                end
            end)
        end
    end)
	
	newpicker.frame.container.red.FocusLost:Connect(function()
        local num = tonumber(newpicker.frame.container.red.Text)
        local Colour = Color3.fromHSV(newpicker.library.Flags[newpicker.Flag].h, newpicker.library.Flags[newpicker.Flag].s, newpicker.library.Flags[newpicker.Flag].v)
        if num and math.floor(num) == num and num >= 0 and num <= 255 then
            newpicker:set(Color3.new(num / 255, Colour.G, Colour.B):ToHSV())
        else
            newpicker.frame.container.red.Text = math.floor(Colour.R * 255 + 0.5)
        end
    end)

    newpicker.frame.container.green.FocusLost:Connect(function()
        local num = tonumber(newpicker.frame.container.green.Text)
        local Colour = Color3.fromHSV(newpicker.library.Flags[newpicker.Flag].h, newpicker.library.Flags[newpicker.Flag].s, newpicker.library.Flags[newpicker.Flag].v)
        if num and math.floor(num) == num and num >= 0 and num <= 255 then
            newpicker:set(Color3.new(Colour.R, num / 255, Colour.B):ToHSV())
        else
            newpicker.frame.container.green.Text = math.floor(Colour.R * 255 + 0.5)
        end
    end)

    newpicker.frame.container.blue.FocusLost:Connect(function()
        local num = tonumber(newpicker.frame.container.blue.Text)
        local Colour = Color3.fromHSV(newpicker.library.Flags[newpicker.Flag].h, newpicker.library.Flags[newpicker.Flag].s, newpicker.library.Flags[newpicker.Flag].v)
        if num and math.floor(num) == num and num >= 0 and num <= 255 then
            newpicker:set(Color3.new(Colour.R, Colour.G, num / 255):ToHSV())
        else
            newpicker.frame.container.blue.Text = math.floor(Colour.R * 255 + 0.5)
        end
    end)

	newpicker.frame.container.rainbow.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            newpicker:setrainbow(not newpicker.library.Flags[newpicker.Flag].rainbow)
        end
    end)

	return newpicker
end

function picker:open()
	self.settings.open = true
	tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, 172) })
	tween(self.frame.indicator.indicator, 0.25, { Rotation = 360 })
end

function picker:close()
	self.settings.open = false
	tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, 24) })
	tween(self.frame.indicator.indicator, 0.25, { Rotation = 0 })
end

function picker:set(h, s, v)
	local Colour = Color3.fromHSV(h, s, v)
	self.library.Flags[self.Flag].h = h
	self.library.Flags[self.Flag].s = s
	self.library.Flags[self.Flag].v = v
	self.frame.container.red.Text = round(Colour.R * 255, 1)
	self.frame.container.green.Text = round(Colour.G * 255, 1)
	self.frame.container.blue.Text = round(Colour.B * 255, 1)
	self.frame.container.sat.gradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromHSV(h, 1, 1))
	tween(self.frame.container.sat.val.indicator, 0.2, { Position = UDim2.new(s, 0, 1 - v, 0) })
	if self.library.Flags[self.Flag].rainbow then
		self.frame.container.hue.drag.Position = UDim2.new(h, 0, 0.5, 0)
	else
		tween(self.frame.container.hue.drag, 0.2, { Position = UDim2.new(h, 0, 0.5, 0) })
	end
	self.Callback(Colour)
end

function picker:setrainbow(bool)
	self.library.Flags[self.Flag].rainbow = bool
	tween(self.frame.container.rainbow.indicator, 0.25, { BackgroundColor3 = bool and theme.highlight or theme.sectionbackground })
	if self.rainbowconn then
		self.rainbowconn:Disconnect()
		self.rainbowconn = nil
	end
	if self.library.Flags[self.Flag].rainbow then
		self.rainbowconn = runservice.Heartbeat:Connect(function()
			self:set(tick() % self.library.settings.rainbowspeed / self.library.settings.rainbowspeed, self.library.Flags[self.Flag].s, self.library.Flags[self.Flag].v)
		end)
	end
end

--[[ Dropdown ]]--

local dropdown = {}
dropdown.__index = dropdown

function dropdown.new(Content, Callback)
	local newdropdown = setmetatable({
		itemtype = "dropdown",
		Content = Content,
		Callback = Callback or function() end,
		settings = {
			open = false
		}
	}, dropdown)
	
	newdropdown.frame = create("Frame", { 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 48), 
		Name = Content
	}, {
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			TextWrap = true, 
			TextWrapped = true, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(1, 0, 0, 24), 
			Name = "label"
		}),
		create("Frame", {
			Theme = {
				BackgroundColor3 = "mainbackground"
			},
			AnchorPoint = Vector2.new(0, 1), 
			ClipsDescendants = true, 
			Position = UDim2.new(0, 0, 1, 0), 
			Size = UDim2.new(1, 0, 1, -24), 
			Name = "drop"
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("TextLabel", { 
				Theme = {
					TextColor3 = "foreground"
				},
				Font = Enum.Font.Gotham, 
				FontSize = Enum.FontSize.Size12, 
				Text = "", 
				TextSize = 12, 
				TextXAlignment = Enum.TextXAlignment.Left, 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(0, 6, 0, 0), 
				Size = UDim2.new(1, -38, 0, 24), 
				Name = "selected"
			}),
			create("TextLabel", {
				Theme = {
					TextColor3 = "foreground"
				},
				Font = Enum.Font.Gotham, 
				FontSize = Enum.FontSize.Size14, 
				Text = "▼", 
				TextSize = 13, 
				TextWrap = true, 
				TextWrapped = true, 
				AnchorPoint = Vector2.new(1, 0), 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(1, -2, 0, 0), 
				Size = UDim2.new(0, 24, 0, 24), 
				Name = "indicator"
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				BackgroundTransparency = 1, 
				ClipsDescendants = true, 
				Position = UDim2.new(0.5, 0, 0, 24), 
				Size = UDim2.new(1, -8, 0, 0), 
				Name = "container"
			}, {
				create("Frame", { 
					Theme = {
						BackgroundColor3 = "sectionbackground"
					},
					Size = UDim2.new(1, 0, 1, 0), 
					Name = "background"
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("ScrollingFrame", { 
						CanvasSize = UDim2.new(0, 0, 0, 0), 
						ScrollBarImageColor3 = Color3.new(0, 0, 0), 
						ScrollBarImageTransparency = 1, 
						ScrollBarThickness = 0, 
						Active = true, 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.new(1, 1, 1), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						ClipsDescendants = true, 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -8, 1, -8), 
						Name = "container"
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0), 
							BackgroundColor3 = Color3.new(1, 1, 1), 
							BackgroundTransparency = 1, 
							ClipsDescendants = true, 
							Position = UDim2.new(0.5, 0, 0, 0), 
							Size = UDim2.new(1, 0, 0, 86), 
							Name = "holder"
						}, {
							create("UIListLayout", { 
								Padding = UDim.new(0, 2), 
								SortOrder = Enum.SortOrder.LayoutOrder, 
								Name = "layout"
							})
						})
					})
				})
			})
		})
	})

	newdropdown.frame.drop.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and mouse.Y - newdropdown.frame.drop.AbsolutePosition.Y < 24 then
			if newdropdown.settings.open then
				newdropdown:close()
			else
				newdropdown:open()
			end
		end
	end)
	
	local container = newdropdown.frame.drop.container.background.container
	container.holder.ChildAdded:Connect(function()
        container.holder.Size = UDim2.new(1, 0, 0, (#container.holder:GetChildren() - 1) * 22 - 2)
    end)

	local list = container.holder.layout
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        container.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
    end)
	
	customscroll(container.holder, container, 22)
	
	return newdropdown
end

function dropdown:open()
	self.settings.open = true
	tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, math.min(58 + ((#self.frame.drop.container.background.container.holder:GetChildren() - 1) * 22), 146)) })
	tween(self.frame.drop.container, 0.25, { Size = UDim2.new(1, -8, 1, -28) })
	tween(self.frame.drop.indicator, 0.25, { Rotation = 360 })
end

function dropdown:close()
	self.settings.open = false
	tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, 48) })
	tween(self.frame.drop.container, 0.25, { Size = UDim2.new(1, -8, 0, 0) })
	tween(self.frame.drop.indicator, 0.25, { Rotation = 0 })
end

function dropdown:set(value)
	local name = tostring(value)
	if name ~= self.library.Flags[self.Flag] then
		local new = self.frame.drop.container.background.container.holder:FindFirstChild(name)
		if new then
			local old = self.frame.drop.container.background.container.holder:FindFirstChild(self.library.Flags[self.Flag])
			if old then
				tween(old, 0.25, { BackgroundTransparency = 1 })
			end
			self.frame.drop.selected.Text = name
			tween(new, 0.25, { BackgroundTransparency = 0 })
			self.library.Flags[self.Flag] = name
			self.Callback(value)
		end
	end
end
function dropdown:additem(item)
	local name = tostring(item)
	local btn = create("TextButton", { 
		Theme = {
			BackgroundColor3 = "mainbackground",
			TextColor3 = "foreground"
		},
		Font = Enum.Font.Gotham, 
		FontSize = Enum.FontSize.Size12, 
		Text = name, 
		TextSize = 12, 
		AutoButtonColor = false,
		BackgroundTransparency = 1, 
		Parent = self.frame.drop.container.background.container.holder,
		Size = UDim2.new(1, 0, 0, 20), 
		Name = name
	}, {
		create("UICorner", { 
			CornerRadius = UDim.new(0, 4), 
			Name = "corner"
		})
	})

	btn.MouseButton1Click:Connect(function()
		self:set(item)
	end)

	if self.settings.open then
		tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, math.min(58 + ((#self.frame.drop.container.background.container.holder:GetChildren() - 1) * 22), 146)) })
	end
end

function dropdown:removeitem(item)
	local name = tostring(item)
	local listitem = self.frame.drop.container.background.container.holder:FindFirstChild(name)
	if listitem then
		listitem:Destroy()
		if self.library.Flags[self.Flag] == name then
			self.library.Flags[self.Flag] = ""
		end
		if self.settings.open then
			tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, math.min(58 + ((#self.frame.drop.container.background.container.holder:GetChildren() - 1) * 22), 146)) })
		end
	end
end
local function removeDuplicates(arr)
	local newArray = {}
	local checkerTbl = {}
	for _,element in ipairs(arr) do
	    if not checkerTbl[element] then
	       checkerTbl[element] = true
	       table.insert(newArray, element)
	   end
	end
	return newArray
end
function dropdown:UpdateTable(table)
    for i,v in pairs(self.frame.drop.container.background.container.holder:GetChildren()) do
        if v.ClassName == "TextButton" then
            self:removeitem(v.Name)
        end
    end
    for i,v in pairs(removeDuplicates(table)) do
        self:additem(v)
    end
end
--[[ Section ]]--

local section = {}
section.__index = section

function section.new(Content)
	local newsection = setmetatable({
		Content = Content,
		settings = {
			open = false
		}
	}, section)

	newsection.frame = create("Frame", { 
		Theme = {
			BackgroundColor3 = "sectionbackground"
		},
		ClipsDescendants = true,
		Size = UDim2.new(1, 0, 0, 34), 
		Name = Content
	}, {
		create("UICorner", { 
			CornerRadius = UDim.new(0, 4), 
			Name = "corner"
		}),
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.GothamSemibold, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 14, 
			TextXAlignment = Enum.TextXAlignment.Left, 
			AnchorPoint = Vector2.new(0.5, 0), 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(0.5, 0, 0, 10), 
			Size = UDim2.new(1, -20, 0, 14), 
			Name = "title"
		}),
		create("TextLabel", { 
			Theme = {
				TextColor3 = "foreground"
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = "▼", 
			TextSize = 13, 
			TextWrap = true, 
            TextWrapped = true, 
			AnchorPoint = Vector2.new(1, 0), 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(1, -5, 0, 5),
			Size = UDim2.new(0, 24, 0, 24), 
			Name = "indicator"
		}),
		create("Frame", { 
			AnchorPoint = Vector2.new(0.5, 0), 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(0.5, 0, 0, 34), 
			Size = UDim2.new(1, -12, 0, 0), 
			Name = "container"
		}, {
			create("UIListLayout", { 
				Padding = UDim.new(0, 4), 
				SortOrder = Enum.SortOrder.LayoutOrder, 
				Name = "layout"
			})
		})
	})

	local list = newsection.frame.container.layout
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if newsection.settings.open then
			newsection.frame.container.Size = UDim2.new(1, -12, 0, list.AbsoluteContentSize.Y)
			newsection.frame.Size = UDim2.new(1, 0, 0, list.AbsoluteContentSize.Y + 40)
		end
    end)
	
	newsection.frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and mouse.Y - newsection.frame.AbsolutePosition.Y < 34 then
			if newsection.settings.open then
				newsection:Close()
			else
				newsection:Open()
			end
		end
	end)

	return newsection
end

function section:Open()
	self.settings.open = true
	tween(self.frame.container, 0.25, { Size = UDim2.new(1, -12, 0, self.frame.container.layout.AbsoluteContentSize.Y) })
	tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, self.frame.container.layout.AbsoluteContentSize.Y + 40) })
	tween(self.frame.indicator, 0.25, { Rotation = 360 })
end

function section:Close()
	self.settings.open = false
	tween(self.frame.container, 0.25, { Size = UDim2.new(1, -12, 0, 0) })
	tween(self.frame, 0.25, { Size = UDim2.new(1, 0, 0, 34) })
	tween(self.frame.indicator, 0.25, { Rotation = 0 })
end

function section:AddLabel(options)
	local newlabel = label.new()
	
	newlabel.frame.Parent = self.frame.container
	newlabel.library = self.library
	newlabel.Flag = options.Flag
	self.library.Items[options.Flag] = newlabel

	newlabel:update(options.Content)

	return newlabel
end

function section:AddStatus(options)
	local newstatuslabel = statuslabel.new(options.Content)

	newstatuslabel.frame.Parent = self.frame.container
	newstatuslabel.library = self.library
	newstatuslabel.Flag = options.Flag
	self.library.Items[options.Flag] = newstatuslabel

	newstatuslabel:update(options.Status, options.Colour)

	return newstatuslabel
end

function section:AddButton(options)
	local newbutton = button.new(options.Content, options.Callback)
	
	newbutton.frame.Parent = self.frame.container
	newbutton.library = self.library
	newbutton.Flag = options.Flag
	self.library.Items[options.Flag] = newbutton
	
	return newbutton
end

function section:AddToggle(options)
	local newtoggle = toggle.new(options.Content, options.Callback)

	newtoggle.frame.Parent = self.frame.container
	newtoggle.library = self.library
	newtoggle.Flag = options.Flag
	newtoggle.ignore = options.ignore
	self.library.Flags[options.Flag] = false
	self.library.Items[options.Flag] = newtoggle
	
	if options.enabled then
		newtoggle:switch()
	end
	
	return newtoggle
end

function section:AddKeybind(options)
	local newbind = bind.new(options.Content, options.Keydown, options.Keyup, options.keychanged)

	newbind.frame.Parent = self.frame.container
	newbind.library = self.library
	newbind.Flag = options.Flag
	newbind.ignore = options.ignore
	self.library.Flags[options.Flag] = "None"
	self.library.Items[options.Flag] = newbind
	
	if options.Default then
		newbind:set(options.Default)
	end
	
	return newbind
end

function section:AddSlider(options)
	local newslider = slider.new(options.Content, options.Min, options.Max, options.Float, options.Prefix, options.Suffix, options.Callback)

	newslider.frame.Parent = self.frame.container
	newslider.library = self.library
	newslider.Flag = options.Flag
	newslider.ignore = options.ignore
	self.library.Flags[options.Flag] = newslider.Min
	self.library.Items[options.Flag] = newslider

	if options.Default then
		newslider:set(options.Default)
	end
	
	return newslider
end

function section:AddTextBox(options)
	local newbox = box.new(options.Content, options.NumberOnly, options.Callback)

	newbox.frame.Parent = self.frame.container
	newbox.library = self.library
	newbox.Flag = options.Flag
	newbox.ignore = options.ignore
	newbox.maxsize = newbox.frame.AbsoluteSize.X - (textservice:GetTextSize(options.Content, 12, Enum.Font.Gotham, hugevec2).X + 12)
	self.library.Flags[options.Flag] = ""
	self.library.Items[options.Flag] = newbox

	if options.Default then
		newbox:set(options.Default)
	end
	
	return newbox
end

function section:AddColourPicker(options)
	local newpicker = picker.new(options.Content, options.Callback)

	newpicker.frame.Parent = self.frame.container
	newpicker.library = self.library
	newpicker.Flag = options.Flag
	newpicker.ignore = options.ignore
	self.library.Flags[options.Flag] = { h = 0, s = 1, v = 1, rainbow = false }
	self.library.Items[options.Flag] = newpicker

	if options.Default then
		newpicker:set(options.Default:ToHSV())
	end

	if options.rainbow then
		newpicker:setrainbow(true)
	end
	
	return newpicker
end

function section:AddDropdown(options)
	local newdropdown = dropdown.new(options.Content, options.Callback)

	newdropdown.frame.Parent = self.frame.container
	newdropdown.library = self.library
	newdropdown.Flag = options.Flag
	newdropdown.ignore = options.ignore
	self.library.Flags[options.Flag] = ""
	self.library.Items[options.Flag] = newdropdown

	for i, v in next, options.Items do
		newdropdown:additem(v)
	end

	if options.Default then
		newdropdown:set(options.Default)
	end
	
	return newdropdown
end

--[[ Tab ]]--

local tab = {}
tab.__index = tab

function tab.new(Content, Icon)
	local newtab = setmetatable({
		Content = Content,
		Icon = Icon
	}, tab)
	
	newtab.indicator = create("Frame", { 
		Theme = {
			BackgroundColor3 = "titlebackground"
		},
		BackgroundTransparency = 1, 
		BorderSizePixel = 0,
		Size = UDim2.new(0, 80, 0, 60), 
		Name = Content
	}, {
		create("ImageLabel", { 
			Theme = {
				ImageColor3 = function()
					return newtab.library and newtab.library.selected == newtab and "highlight" or "foreground"
				end
			},
			Image = "rbxassetid://" .. tostring(Icon), 
			AnchorPoint = Vector2.new(0.5, 0), 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(0.5, 0, 0, 5), 
			Size = UDim2.new(0, 32, 0, 32), 
			Name = "Icon"
		}),
		create("TextLabel", { 
			Theme = {
				TextColor3 = function()
					return newtab.library and newtab.library.selected == newtab and "highlight" or "foreground"
				end
			},
			Font = Enum.Font.Gotham, 
			FontSize = Enum.FontSize.Size14, 
			Text = Content, 
			TextSize = 13, 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			Position = UDim2.new(0, 0, 0, 40), 
			Size = UDim2.new(1, 0, 1, -40), 
			Name = "text"
		})
	})

	newtab.frame = create("Frame", { 
		AnchorPoint = Vector2.new(1, 1), 
		BackgroundColor3 = Color3.new(1, 1, 1), 
		BackgroundTransparency = 1, 
		Position = UDim2.new(1, 0, 1, 0), 
		Size = UDim2.new(1, -80, 1, -40), 
		Name = Content,
		Visible = false
	}, {
		create("ScrollingFrame", { 
			ScrollBarImageColor3 = Color3.new(0, 0, 0), 
			ScrollBarImageTransparency = 1, 
			ScrollBarThickness = 0, 
			Active = true, 
			AnchorPoint = Vector2.new(0, 0.5), 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			BorderSizePixel = 0, 
			Position = UDim2.new(0, 6, 0.5, 0), 
			Size = UDim2.new(0.5, -9, 1, -12), 
			Name = "left"
		}, {
			create("UIListLayout", { 
				Padding = UDim.new(0, 6), 
				SortOrder = Enum.SortOrder.LayoutOrder, 
				Name = "layout"
			})
		}),
		create("ScrollingFrame", { 
			ScrollBarImageColor3 = Color3.new(0, 0, 0), 
			ScrollBarImageTransparency = 1, 
			ScrollBarThickness = 0, 
			Active = true, 
			AnchorPoint = Vector2.new(1, 0.5), 
			BackgroundColor3 = Color3.new(1, 1, 1), 
			BackgroundTransparency = 1, 
			BorderSizePixel = 0, 
			Position = UDim2.new(1, -6, 0.5, 0), 
			Size = UDim2.new(0.5, -9, 1, -12), 
			Name = "right"
		}, {
			create("UIListLayout", { 
				Padding = UDim.new(0, 6), 
				SortOrder = Enum.SortOrder.LayoutOrder, 
				Name = "layout"
			})
		})
	})

	newtab.indicator.MouseEnter:Connect(function()
		tween(newtab.indicator, 0.25, { BackgroundTransparency = 0 })
	end)
	
	newtab.indicator.MouseLeave:Connect(function()
		tween(newtab.indicator, 0.25, { BackgroundTransparency = 1 })
	end)

	local leftlist = newtab.frame.left.layout
    leftlist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        newtab.frame.left.CanvasSize = UDim2.new(0, 0, 0, leftlist.AbsoluteContentSize.Y)
    end)

    local rightlist = newtab.frame.right.layout
    rightlist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        newtab.frame.right.CanvasSize = UDim2.new(0, 0, 0, rightlist.AbsoluteContentSize.Y)
    end)

	return newtab
end

function tab:AddSection(options)
    local newsection = section.new(options.Content)
    newsection.library = self.library

    newsection.frame.Parent = self.frame[options.Right and "right" or "left"]
    
    if options.Open then
        newsection.settings.open = true
    end

    return newsection
end

--[[ Library ]]--

local library = {}
library.__index = library

function library.new(options)
	local newlibrary = setmetatable({
		Content = options.Content,
		name = options.Name,
		game = options.Game,
		Flags = {},
		Items = {},
		tabs = {},
		settings = {
			directory = ""..options.Name.."/Config/".. options.Game.."",
			theme = theme,
			dragging = false,
			binding = false,
			rainbowspeed = 5
		}
	}, library)
	getgenv().UiName = options.Name
	getgenv().GameName = options.Game
	if not isfolder(UiName) then
        makefolder(UiName)
    end
	if not isfolder(UiName.."\\Config") then
        makefolder(UiName.."\\Config")
	end
	if not isfolder(UiName.."\\Config\\"..GameName) then
        makefolder(UiName.."\\Config\\"..GameName)
    end
	newlibrary.gui = create("ScreenGui", { 
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling, 
		Name = UiName, 
		Parent = game:GetService("CoreGui")
	}, {
		create("TextButton", {
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundTransparency = 1,
			Name = "clickblock",
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			Size = UDim2.new(0, 560, 0, 435), 
			Text = ""
		}),
		create("Frame", { 
			Theme = {
				BackgroundColor3 = "mainbackground"
			},
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			Size = UDim2.new(0, 560, 0, 435), 
			Name = "main",
			ZIndex = 2
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("Frame", {
				Theme = {
					BackgroundColor3 = "titlebackground"
				},
				Size = UDim2.new(1, 0, 0, 40), 
				Name = "top"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				create("Frame", { 
					Theme = {
						BackgroundColor3 = "titlebackground"
					},
					AnchorPoint = Vector2.new(0, 1), 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0, 1, 0), 
					Size = UDim2.new(1, 0, 0, 4), 
					Name = "bottom"
				}),
				create("TextLabel", { 
					Theme = {
						TextColor3 = "foreground"
					},
					Font = Enum.Font.GothamSemibold, 
					FontSize = Enum.FontSize.Size18, 
					Text = UiName, 
					TextSize = 15, 
					TextXAlignment = Enum.TextXAlignment.Left, 
					AnchorPoint = Vector2.new(0.5, 0), 
					BackgroundColor3 = Color3.new(1, 1, 1), 
					BackgroundTransparency = 1, 
					Position = UDim2.new(0.5, 0, 0, 0), 
					Size = UDim2.new(1, -20, 1, 0), 
					Name = "title"
				}),
				create("TextLabel", { 
					Theme = {
						TextColor3 = "foreground"
					},
					Font = Enum.Font.GothamSemibold, 
					FontSize = Enum.FontSize.Size18, 
					Text = GameName, 
					TextSize = 15, 
					TextXAlignment = Enum.TextXAlignment.Right, 
					AnchorPoint = Vector2.new(0.5, 0), 
					BackgroundColor3 = Color3.new(1, 1, 1), 
					BackgroundTransparency = 1, 
					Position = UDim2.new(0.5, 0, 0, 0), 
					Size = UDim2.new(1, -20, 1, 0), 
					Name = "game"
				})
			}),
			create("Frame", { 
				Theme = {
					BackgroundColor3 = "leftbackground"
				},
				AnchorPoint = Vector2.new(0, 1), 
				Position = UDim2.new(0, 0, 1, 0), 
				Size = UDim2.new(0, 80, 1, -40), 
				Name = "left"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				create("Frame", { 
					Theme = {
						BackgroundColor3 = "leftbackground"
					},
					BorderSizePixel = 0, 
					Size = UDim2.new(1, 0, 0, 4), 
					Name = "top"
				}),
				create("Frame", { 
					Theme = {
						BackgroundColor3 = "leftbackground"
					},
					AnchorPoint = Vector2.new(1, 0), 
					BorderSizePixel = 0, 
					Position = UDim2.new(1, 0, 0, 0), 
					Size = UDim2.new(0, 4, 1, 0), 
					Name = "right"
				}),
				create("ScrollingFrame", { 
					CanvasSize = UDim2.new(0, 0, 0, 0), 
					ScrollBarImageColor3 = Color3.new(0, 0, 0), 
					ScrollBarImageTransparency = 1, 
					ScrollBarThickness = 0, 
					ScrollingEnabled = false, 
					Active = true, 
					AnchorPoint = Vector2.new(0, 0.5), 
					BackgroundColor3 = Color3.new(1, 1, 1), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					Position = UDim2.new(0, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, -10), 
					Name = "container"
				}, {
					create("Frame", { 
						BackgroundColor3 = Color3.new(1, 1, 1), 
						BackgroundTransparency = 1, 
						Size = UDim2.new(1, 0, 1, 0), 
						Name = "holder"
					}, {
						create("UIListLayout", { 
							Padding = UDim.new(0, 5), 
							SortOrder = Enum.SortOrder.LayoutOrder, 
							Name = "layout"
						})
					})
				})
			}),
			create("Folder", {
				Name = "container"
			})
		}),
		create("Folder", {
			Name = "notifications"
		})
	})

	local container = newlibrary.gui.main.left.container
	container.holder.ChildAdded:Connect(function()
        container.holder.Size = UDim2.new(1, 0, 0, #container.holder:GetChildren() * 65 - 5)
    end)

    local list = container.holder.layout
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        container.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
    end)

	newlibrary:MakeDraggable(newlibrary.gui.main)
	newlibrary.gui.main:GetPropertyChangedSignal("Position"):Connect(function()
		newlibrary.gui.clickblock.Position = newlibrary.gui.main.Position
	end)
	
	customscroll(newlibrary.gui.main.left.container.holder, newlibrary.gui.main.left.container, 65)
	
	userinputservice.InputBegan:Connect(function(input)
        if newlibrary.settings.binding == false and userinputservice:GetFocusedTextBox() == nil then
            local name = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name or input.UserInputType.Name
            for i, v in next, newlibrary.Items do
                if v.itemtype == "bind" and newlibrary.Flags[v.Flag] == name then
                    v.Keydown()
                end
            end
        end
    end)

    userinputservice.InputEnded:Connect(function(input)
        if newlibrary.settings.binding == false and userinputservice:GetFocusedTextBox() == nil then
            local name = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name or input.UserInputType.Name
            for i, v in next, newlibrary.Items do
                if v.itemtype == "bind" and newlibrary.Flags[v.Flag] == name then
                    v.Keyup()
                end
            end
        end
    end)

	return newlibrary
end

function library:Toggle()
	self.gui.Enabled = not self.gui.Enabled
end

function library:Destroy()
	self.gui:Destroy()
end

function library:ShowTab(Content)
	if self.selected then
		self:HideTab()
	end
	self.selected = self.tabs[Content]
	self.selected.frame.Visible = true
	tween(self.selected.indicator.Icon, 0.25, { ImageColor3 = theme.highlight })
	tween(self.selected.indicator.text, 0.25, { TextColor3 = theme.highlight })
end

function library:HideTab()
	self.selected.frame.Visible = false
	tween(self.selected.indicator.Icon, 0.25, { ImageColor3 = theme.foreground })
	tween(self.selected.indicator.text, 0.25, { TextColor3 = theme.foreground })
	self.selected = nil
end

function library:AddTab(options)
	local newtab = tab.new(options.Content, options.Icon)
	newtab.library = self
	
	newtab.frame.Parent = self.gui.main.container
	newtab.indicator.Parent = self.gui.main.left.container.holder
	self.tabs[options.Content] = newtab

	if self.selected == nil then
		self:ShowTab(options.Content)
	end

	newtab.indicator.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and self.selected ~= newtab then
			self:ShowTab(options.Content)
		end
	end)
	
	return newtab
end

function library:LoadConfig(name)
	local path = string.format("%s/%s.config", self.settings.directory, name)
	if isfile(path) then
		local succ, json = pcall(httpservice.JSONDecode, httpservice, readfile(path))
		if succ then
			for i, v in next, json do
				local item = self.Items[i]
				if item then
					if item.itemtype == "picker" then
						task.spawn(item.set, item, v.h, v.s, v.v)
						task.spawn(item.setrainbow, item, v.rainbow)
					else
						task.spawn(item.set, item, v)
					end
				end
			end
			return true
		end
	end
	return false
end

    
function library:SaveConfig(name)
	local path = self.settings.directory
	if not isfolder(path) then
		makefolder(path)
	end
	local Flags = {}
	for i, v in next, self.Flags do
		if self.Items[i] and not self.Items[i].ignore then
			Flags[i] = v
		end
	end
	writefile(string.format("%s/%s.config", path, name), httpservice:JSONEncode(Flags))
end
function library:delconfig(name)
	local path = self.settings.directory
	if not isfolder(path) then
		makefolder(path)
	end
	local Flags = {}
	for i, v in next, self.Flags do
		if self.Items[i] and not self.Items[i].ignore then
			Flags[i] = v
		end
	end
	delfile(string.format("%s/%s.config", path, name), httpservice:JSONEncode(Flags))
end




function library:Notify(options)	
    local notification = create("Frame", { 
		Theme = {
			BackgroundColor3 = "mainbackground"
		},
		AnchorPoint = Vector2.new(1, 1), 
		ClipsDescendants = true, 
		Position = UDim2.new(1, 350, 1, -35), 
		Size = UDim2.new(0, 340, 0, 77), 
		Name = options.Content, 
		Parent = self.gui.notifications
	}, {
		create("UICorner", { 
			CornerRadius = UDim.new(0, 4), 
			Name = "corner"
		}),
		create("Frame", { 
			Theme = {
				BackgroundColor3 = "titlebackground"
			},
			Size = UDim2.new(1, 0, 0, 34), 
			Name = "top"
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("Frame", { 
				Theme = {
					BackgroundColor3 = "titlebackground"
				},
				AnchorPoint = Vector2.new(0, 1), 
				BorderSizePixel = 0, 
				Position = UDim2.new(0, 0, 1, 0), 
				Size = UDim2.new(1, 0, 0, 4), 
				Name = "bottom"
			}),
			create("TextLabel", { 
				Theme = {
					TextColor3 = "foreground"
				},
				Font = Enum.Font.GothamSemibold, 
				FontSize = Enum.FontSize.Size18, 
				Text = UiName, 
				TextSize = 15, 
				TextXAlignment = Enum.TextXAlignment.Left, 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.new(1, 1, 1), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(0.5, 0, 0, 0), 
				Size = UDim2.new(1, -20, 1, 0), 
				Name = "title"
			}),
			create("ImageButton", { 
				Theme = {
					ImageColor3 = "foreground"
				},
				Image = "rbxassetid://9128696455", 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(1, -5, 0.5, 0), 
				Size = UDim2.new(0, 24, 0, 24), 
				Name = "no"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				})
			}),
			create("ImageButton", { 
				Theme = {
					ImageColor3 = "foreground"
				},
				Image = "rbxassetid://9128696588", 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(1, -34, 0.5, 0), 
				Size = UDim2.new(0, 24, 0, 24), 
				Name = "yes"
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				})
			})
		}),
		create("Frame", { 
			Theme = {
				BackgroundColor3 = "highlight"
			},
			AnchorPoint = Vector2.new(0, 1), 
			Position = UDim2.new(0, 0, 1, 0), 
			Size = UDim2.new(0, 0, 0, 8), 
			Name = "bottom"
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 3), 
				Name = "corner"
			}),
			create("Frame", { 
				Theme = {
					BackgroundColor3 = "mainbackground"
				},
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0.5, 0),
				Name = "cover"
			})
		}),
		create("TextLabel", {
			Font = Enum.Font.Gotham,
			FontSize = Enum.FontSize.Size14,
			Text = "Would you like to see me naked?",
			TextColor3 = Color3.new(0.921569, 0.921569, 0.921569),
			TextSize = 13, 
			TextWrap = true,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0, 34),
			Size = UDim2.new(1, -20, 1, -38),
			Name = "Content"
		})
	})
	
	notification.Content.Text = options.Content
	notification.Size = UDim2.new(0, 340, 0, textservice:GetTextSize(options.Content, 13, Enum.Font.Gotham, Vector2.new(notification.Content.AbsoluteSize.X, math.huge)).Y + 64)

	local closed = false

    local function closenotif(option)
        closed = true
		tween(notification, 0.2, { Position = UDim2.new(1, 310, notification.Position.Y.Scale, notification.Position.Y.Offset) }).Completed:Connect(function()
			notification:Destroy()
			self:OrderNotifications()
		end)
		if options.Callback then
			options.Callback(option)
		end
    end
	
	notification.top.yes.MouseButton1Down:Connect(function()
		closenotif(true)
	end)
	
	notification.top.no.MouseButton1Down:Connect(function()
		closenotif(false)
	end)
	
	self:OrderNotifications()
	
	tween(notification.bottom, options.Timeout or 10, { Size = UDim2.new(1, 0, 0, 8) }, Enum.EasingStyle.Linear).Completed:Connect(function()
		if closed == false then
			closenotif(false)
		end
	end)
end

function library:OrderNotifications()
	local offset, notifs = -35, self.gui.notifications:GetChildren()
	for i = #notifs, 1, -1 do
		local v = notifs[i]
		tween(v, 0.2, { Position = UDim2.new(1, -20, 1, offset) })
		offset -= v.AbsoluteSize.Y + 20
	end
end

function library:MakeDraggable(frame)
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and self.settings.dragging == false then
			self.settings.dragging = true
			local offset = Vector2.new(frame.AbsoluteSize.X * frame.AnchorPoint.X, frame.AbsoluteSize.Y * frame.AnchorPoint.Y)
			local pos = Vector2.new(mouse.X - (frame.AbsolutePosition.X + offset.X), mouse.Y - (frame.AbsolutePosition.Y + offset.Y))

            local dragconn; dragconn = mouse.Move:Connect(function()
				tween(frame, 0.125, { Position = UDim2.new(0, mouse.X - pos.X, 0, mouse.Y - pos.Y) })
			end)

			local inputconn; inputconn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
                    dragconn:Disconnect()
					inputconn:Disconnect()
					self.settings.dragging = false
				end
			end)
		end
	end)
end
function library:GetConfigs()
local configs = {}
	if isfolder(UiName.."\\Config") then 
		for i,v in pairs(listfiles(UiName.."\\Config\\"..GameName)) do
			local split = select(-1, unpack(v:split("\\")))
			if split:find(".config") then
				configs[#configs + 1] = split:gsub(".config", "")
			end
		end
	end
	return configs
end
function library:AddSettings()
	local settingstab = self:AddTab({ Content = "Settings", Icon = 9134709197 })
    local configs = settingstab:AddSection({ Content = "Configs",Open = true})
    configs:AddDropdown({ Content = "Config List", Flag = "ConfigName", Items = library:GetConfigs()})
    configs:AddTextBox({ Content = "Save File Name", Flag = "SaveFileName", ignore = true })
    configs:AddButton({ Content = "Load Config", Flag = "LoadConfig", Callback = function()
        if not self:LoadConfig(self.Flags.ConfigName) then
            self:Notify({ Content = "No valid config with the name '" .. self.Flags.ConfigName .. "' was found" })
        end
    end })
    configs:AddButton({ Content = "Create Config", Flag = "SaveConfig", Callback = function()
        self.Items.ConfigName:additem(self.Flags.SaveFileName)
    end })
    configs:AddButton({ Content = "Save Config", Flag = "SaveConfig", Callback = function()
        if self.Flags.ConfigName then
            self:SaveConfig(self.Flags.ConfigName)
            self:Notify({ Content = "Saved the config " .. self.Flags.ConfigName .. "" })
        end
    end })
    configs:AddButton({ Content = "Delete Config", Flag = "delconfig", Callback = function()
        if self.Flags.ConfigName then
            self:delconfig(self.Flags.ConfigName)
            self:Notify({ Content = "Deleted the config " .. self.Flags.ConfigName .. "" })
            self.Items.ConfigName:removeitem(self.Flags.ConfigName)
        end
    end })
    local themeItems = settingstab:AddSection({ Content = "Theme",Open = true, Right = true })
	themeItems:AddColourPicker({ Content = "Main Background", Flag = "thememainbackground", Default = theme.mainbackground, Callback = function(Colour)
		self.settings.theme.mainbackground = Colour
	end	})
	themeItems:AddColourPicker({ Content = "Title Background", Flag = "themetitlebackground", Default = theme.titlebackground, Callback = function(Colour)
		self.settings.theme.titlebackground = Colour
	end	})
	themeItems:AddColourPicker({ Content = "List Background", Flag = "themeleftbackground", Default = theme.leftbackground, Callback = function(Colour)
		self.settings.theme.leftbackground = Colour
	end	})
	themeItems:AddColourPicker({ Content = "Section Background", Flag = "themesectionbackground", Default = theme.sectionbackground, Callback = function(Colour)
		self.settings.theme.sectionbackground = Colour
	end	})
	themeItems:AddColourPicker({ Content = "Foreground", Flag = "themeforeground", Default = theme.foreground, Callback = function(Colour)
		self.settings.theme.foreground = Colour
	end	})
	themeItems:AddColourPicker({ Content = "Highlight", Flag = "themehighlight", Default = theme.highlight, Callback = function(Colour)
		self.settings.theme.highlight = Colour
	end	})
    local uioptions = settingstab:AddSection({ Content = "UI Options", Open = true , left = true })
    uioptions:AddToggle({ Content = "Anti Afk", Flag = "EnableAntiAfk", Callback = function()
	    game:GetService("Players").LocalPlayer.Idled:connect(function()
		    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		    wait(1)
		    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	    end)
    end }):set(true)
    uioptions:AddKeybind({ Content = "Toggle Key", Flag = "togglekey", Default = "RightShift", Keydown = function()
        self:Toggle()
    end })
	uioptions:AddButton({ Content = "Destroy UI", Flag = "destroyui", Callback = function()
		self:Destroy()
	end })
	local Credits = settingstab:AddSection({ Content = "Credits" , Open = true,Right = true })
    Credits:AddLabel({ Content = "Discord - xidm", Flag = "Credit1"})
    Credits:AddLabel({ Content = "Discord - vestra_shots", Flag = "Credit2"})
    Credits:AddLabel({ Content = "Discord - outhall", Flag = "Credit2"})
    self:LoadConfig("Default")
end
--[[ Return ]]--
return library
