--[[

	Library


]]--

<library> library.new(<table> options)
	<string> options.Name -- the title, shown in the top left of the gui
	<string> options.Game -- the game, shown in the top right of the gui

<void> library:Toggle() 											-- shows/hides the gui

<void> library:Destroy() 											-- deletes the gui

<tab> library:AddTab(<table> options) 								-- adds a new tab to the gui. If it's the first tab, it will automatically be shown
	<number> options.Icon 											-- the id of the image representing this tab, shown in the left list
	<string> options.Content 										-- the title of this tab, shown in the left list just below the icon
	
<void> library:ShowTab(<string> name) 								-- shows a specific tab, the name should be what you passed as options.Content in library:addtab

<void> library:HideTab(<string> name) 								-- hides a specific tab, the name should be what you passed as options.Content in library:addtab

<void> library:AddSettings()										-- Generates a settings tab with configs, themes, and ui options built in

<void> library:SaveConfig(<string> name) 							-- saves the current state of the gui to a file, located at {Exploit Directory} > Workspace > VestraV5 > {options.Content passed in library.new} > {name}.cfg

<void> library:LoadConfig(<string> name) 							-- loads every option in the gui from a file, located at {Exploit Directory} > Workspace > VestraV5 > {options.Content passed in library.new} > {name}.cfg

<void> library:Notify(<table> options)								-- Sends a notification that pops up on the bottom right
	<string> options.Content										-- The text to be displayed on the notification
	<number/nil> options.Timeout									-- Decides how long the notification takes to go away. Default is 10
	<function(<bool> yes)> options.Callback							-- Fires when the notification is closed. The bool is true if the person clicks the tick. If it times out or they click the X, it's false

<void> library:OrderNotifications()									-- You shouldn't need to use this, it's only used internally to position concurrent notifications on the screen

<void> library:MakeDraggable(<Frame> frame)							-- You shouldn't need to use this, it's only used internally to make the gui draggable using custom tweening

--[[


	Tab


]]--

<section> tab:AddSection(<table> options)							-- adds a section to this tab in the gui
	<string> options.Content						 				-- the title, shown at the top of the section
	<boolean/nil> options.Right 									-- if true, the section will be in the right column.
	<boolean/nil> options.Left 									    -- if true, the section will be in the left column.

--[[


	Section

	Note: every :add command also has <boolean/nil> ignore
	If set true, this will make configs ignore this flag when saving (it won't be included in the cfg file)

]]--

<void> section:Open() 												-- extends the section down so every item inside it is visible

<void> section:Close() 												-- minimises the section

<label> section:AddLabel(<table> options) 							-- adds a label to the section
	<string> options.Content 										-- what's shown on the label
	<string> options.Flag 											-- what the label is stored under in library.items

<statuslabel> section:AddStatus(<table> options) 				    -- adds a status label to the section
	<string> options.Content 										-- what's shown on the left side of the status label
	<string> options.Flag 											-- what the status label is stored under in library.items
	<string/nil> options.Status 									-- what's shown on the right side of the status label
	<Color3/nil> options.Colour 									-- the colour of options.status

<button> section:AddButton(<table> options) 						-- adds a button to the section
	<string> options.Content 										-- what's shown on the button
	<string> options.Flag 											-- what the button is stored under in library.items
	<function()> options.Callback 									-- the function to be called when the button is pressed

<toggle> section:AddToggle(<table> options) 						-- adds a toggle to the section
	<string> options.Content										-- what's shown on the toggle
	<string> options.Flag											-- what the toggle is stored under in library.items and what the toggle's state is stored under in library.Flags
	<function(<string> state)> options.Callback						-- the function to be called when the toggle is switched or set
	<boolean/nil> options.Default 									-- the initial state of the toggle

<bind> section:AddKeybind(<table> options) 							-- adds a bind to the section
	<string> options.Content 										-- what's shown on the bind
	<string> options.Flag 											-- what the bind is stored under in library.items and what the bind's key is stored under in library.Flags
	<function> options.Keydown 										-- the function to be called when the bind's chosen key is pressed
	<function> options.Keyup 										-- the function to be called when the bind's chosen key is released
	<function(<string> old, <string> new)> options.KeyChanged 		-- the function to be called when the bind's chosen key is changed by the user
	<string/nil> options.Default 									-- the initial key for the bind

<slider> section:AddSlider(<table> options) 						-- adds a slider to the section
	<string> options.Content										-- what's shown on the slider
	<string> options.Flag											-- what the slider is stored under in library.items and what the slider's value is stored under in library.Flags
	<number/nil> options.Min										-- the minimum value of the slider. Default is 0
	<number/nil> options.Max										-- the maximum value of the slider. Default is 100
	<number/nil> options.Float										-- the nearest number the slider will round it's values to. Default is 1
	<string/nil> options.Prefix										-- displayed before the value on the gui (example: "$100")
	<string/nil> options.Suffix										-- displayed after the value on the gui (example: "50%")
	<function(<number> value)> options.Callback						-- the function to be called when the slider's value is changed
	<number/nil> options.Default 									-- the initial value of the slider

<box> section:AddTextBox(<table> options) 							-- adds a box to the section
	<string> options.Content										-- what's shown on the box
	<string> options.Flag											-- what the toggle is stored under in library.items and what the box's value is stored under in library.Flags
	<boolean/nil> options.NumberOnly							    -- If true, the box will only accept numerical values
	<function(<string> value)> options.Callback						-- the function to be called when the box's value is changed
	<boolean/nil> options.Default 									-- the initial value of the box

<picker> section:AddColourPicker(<table> options) 					-- adds a colour picker to the section
	<string> options.Content										-- what's shown on the colour picker
	<string> options.Flag											-- what the colour picker is stored under in library.items and what the colour picker's data is stored under in library.Flags
	<boolean/nil> options.Rainbow									-- If true, the colour picker will start with the rainbow option toggled
	<function(<Color3> colour)> options.Callback					-- the function to be called when the picker's colour is changed
	<Color3/nil> options.Default 									-- the initial colour of the picker

<dropdown> section:AddDropdown(<table> options) 					-- adds a dropdown to the section
	<string> options.Content										-- what's shown on the dropdown
	<string> options.Flag											-- what the dropdown is stored under in library.items and what the dropdown's selected value is stored under in library.Flags
	<table> options.Items											-- an array of every item to appear in the dropdown menu
	<function(<string> value)> options.Callback						-- the function to be called when the dropdown's selected value is changed
	<string/nil> options.Default 									-- the initial value of the dropdown

--[[


	Label


]]--

<void> label:update(<string> content)								-- Changes the text shown on the label

--[[


	Status Label


]]--

<void> label:update(<string> content, <Color3/nil> colour)			-- Changes the text and text colour shown on the right of the status label. If no colour is provided, it will remain as it's current colour

--[[


	Button


]]--

<void> button:fire(<Tuple> ...)										-- Fires the button's callback function. If you wish to pass arguments through, you can

--[[


	Toggle


]]--

<void> toggle:set(<boolean> state)									-- Changes the state of the toggle

<void> toggle:switch()												-- Inverts the state of the toggle

--[[


	Bind


]]--

<void> bind:set(<string> key)										-- Changes the bind's selected key

--[[


	Slider


]]--

<void> slider:set(<number> value)									-- Sets the value of the slider

--[[


	Box


]]--

<void> box:set(<string> value)										-- Sets the value of the box

<void> box:resize()													-- You shouldn't need to use this, it's just fired internally whenever the text is changed

--[[


	Colour Picker


]]--

<void> picker:open() 												-- extends the picker down so the entirety of it is visible

<void> picker:close() 												-- minimises the picker

<void> picker:set(<number> hue, <number> sat, <number> val)			-- Sets the colour of the picker. The arguments can be done shorthand by just doing picker:set(Color3:ToHSV())

<void> picker:setrainbow(<boolean> state)							-- Changes the state of the picker's rainbow option

--[[


	Dropdown


]]--

<void> dropdown:open() 												-- extends the dropdown down so the entirety of it is visible. A maxmium of 4 items will show, the rest can be scrolled to view

<void> dropdown:close() 											-- minimises the dropdown

<void> dropdown:set(<string> value)									-- Sets the selected value of the dropdown. The item must be in the dropdown to be selected

<void> dropdown:additem(<any> item)									-- Adds an item to the dropdown. The value shown will simply be tostring(item), and it will be passed through dropdown.Callback in its original form

<void> dropdown:removeitem(<string> name)			   			     -- Removes an item to the dropdown. It will be checked against the displayed names, not the original item passed

--[[


		Theme


]]--

To change any part of the theme, just do:
library.settings.theme[propertyname] = Color3

Property list:

- mainbackground
- titlebackground
- leftbackground
- sectionbackground
- foreground
- highlight