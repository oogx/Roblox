local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/oogx/Roblox/main/Uis/Drawing/DeadCell/Assets/Source.lua"))()
local ui_themes = {
    ["DeadCell"] = {
        ["Accent"] = Color3.fromRGB(206, 115, 136),
        ["Window Outline Background"] = Color3.fromRGB(39, 39, 47),
        ["Window Inline Background"] = Color3.fromRGB(23, 23, 30),
        ["Window Holder Background"] = Color3.fromRGB(32, 32, 38),
        ["Page Unselected"] = Color3.fromRGB(32, 32, 38),
        ["Page Selected"] = Color3.fromRGB(55, 55, 64),
        ["Section Background"] = Color3.fromRGB(27, 27, 34),
        ["Section Inner Border"] = Color3.fromRGB(50, 50, 58),
        ["Section Outer Border"] = Color3.fromRGB(19, 19, 27),
        ["Window Border"] = Color3.fromRGB(58, 58, 67),
        ["Text"] = Color3.fromRGB(245, 245, 245),
        ["Risky Text"] = Color3.fromRGB(245, 239, 120),
        ["Object Background"] = Color3.fromRGB(41, 41, 50),
    },
    ["Aimware"] = {
        ["Accent"] = Color3.fromRGB(240, 72, 78),
        ["Window Outline Background"] = Color3.fromRGB(19, 19, 19),
        ["Window Inline Background"] = Color3.fromRGB(31, 31, 31),
        ["Window Holder Background"] = Color3.fromRGB(31, 31, 31),
        ["Page Unselected"] = Color3.fromRGB(17, 19, 23),
        ["Page Selected"] = Color3.fromRGB(31, 31, 31),
        ["Section Background"] = Color3.fromRGB(24, 24, 24),
        ["Section Inner Border"] = Color3.fromRGB(52, 51, 55),
        ["Section Outer Border"] = Color3.fromRGB(0, 0, 0),
        ["Window Border"] = Color3.fromRGB(50, 50, 50),
        ["Text"] = Color3.fromRGB(255, 255, 255),
        ["Risky Text"] = Color3.fromRGB(204, 6, 6),
        ["Object Background"] = Color3.fromRGB(31, 31, 31),
    },
    ["Dark Blue"] = {
        ["Accent"] = Color3.fromRGB(82, 157, 255),
        ["Window Outline Background"] = Color3.fromRGB(15, 17, 19),
        ["Window Inline Background"] = Color3.fromRGB(23, 23, 30),
        ["Window Holder Background"] = Color3.fromRGB(17, 19, 23),
        ["Page Unselected"] = Color3.fromRGB(17, 19, 23),
        ["Page Selected"] = Color3.fromRGB(17, 19, 23),
        ["Section Background"] = Color3.fromRGB(15, 17, 19),
        ["Section Inner Border"] = Color3.fromRGB(17, 19, 23),
        ["Section Outer Border"] = Color3.fromRGB(31, 29, 29),
        ["Window Border"] = Color3.fromRGB(31, 29, 29),
        ["Text"] = Color3.fromRGB(192, 192, 192),
        ["Risky Text"] = Color3.fromRGB(204, 6, 6),
        ["Object Background"] = Color3.fromRGB(15, 17, 19),
    },
    ["Interwebz"] = {
        ["Accent"] = Color3.fromRGB(247, 123, 101),
        ["Window Outline Background"] = Color3.fromRGB(25, 18, 34),
        ["Window Inline Background"] = Color3.fromRGB(25, 18, 34),    
        ["Window Holder Background"] = Color3.fromRGB(32, 25, 43),
        ["Page Unselected"] = Color3.fromRGB(32, 25, 43),
        ["Page Selected"] = Color3.fromRGB(32, 25, 43),
        ["Section Background"] = Color3.fromRGB(25, 18, 34),
        ["Section Inner Border"] = Color3.fromRGB(48, 42, 57),
        ["Section Outer Border"] = Color3.fromRGB(26, 20, 36),
        ["Window Border"] = Color3.fromRGB(48, 42, 57),
        ["Text"] = Color3.fromRGB(245, 245, 245),
        ["Risky Text"] = Color3.fromRGB(245, 239, 120),
        ["Object Background"] = Color3.fromRGB(32, 25, 43),
    },
    ["Nebula"] = {
        ["Accent"] = Color3.fromRGB(97, 55, 206),
        ["Window Outline Background"] = Color3.fromRGB(32, 32, 32),
        ["Window Inline Background"] = Color3.fromRGB(19, 19, 19),
        ["Window Holder Background"] = Color3.fromRGB(15, 15, 15),
        ["Page Unselected"] = Color3.fromRGB(36, 36, 36),
        ["Page Selected"] = Color3.fromRGB(26, 26, 26),
        ["Section Background"] = Color3.fromRGB(22, 22, 22),
        ["Section Inner Border"] = Color3.fromRGB(0, 0, 0),
        ["Section Outer Border"] = Color3.fromRGB(37, 37, 37),
        ["Window Border"] = Color3.fromRGB(51, 51, 51),
        ["Text"] = Color3.fromRGB(223, 223, 223),
        ["Risky Text"] = Color3.fromRGB(245, 239, 120),
        ["Object Background"] = Color3.fromRGB(24, 24, 24),
    },
    ["BBOT"] = {
        ["Accent"] = Color3.fromRGB(127, 72, 163),
        ["Window Outline Background"] = Color3.fromRGB(29, 29, 29),
        ["Window Inline Background"] = Color3.fromRGB(26, 26, 26),
        ["Window Holder Background"] = Color3.fromRGB(29, 29, 29),
        ["Page Unselected"] = Color3.fromRGB(43, 43, 43),
        ["Page Selected"] = Color3.fromRGB(36, 36, 36),
        ["Section Background"] = Color3.fromRGB(27, 27, 27),
        ["Section Inner Border"] = Color3.fromRGB(0, 0, 0),
        ["Section Outer Border"] = Color3.fromRGB(48, 48, 48),
        ["Window Border"] = Color3.fromRGB(63, 63, 63),
        ["Text"] = Color3.fromRGB(223, 223, 223),
        ["Risky Text"] = Color3.fromRGB(245, 239, 120),
        ["Object Background"] = Color3.fromRGB(48, 48, 48),
    },
}
library:SetTheme(ui_themes["DeadCell"])
local default_theme = ui_themes["DeadCell"]
local window = library:new_window({size = Vector2.new(600,400)})
local combat = window:new_page({name = "Combat"})
combat:open()
local playerspage = window:new_page({name = "Players"})
local visualspage = window:new_page({name = "Visuals"})
local menu = window:new_page({name = "Settings"})
local combat_main = combat:new_section_holder({name = "aim assist", size = "Fill"}) do
    local combat_assist = combat_main:new_section({name = 'main'}) do
        combat_assist:open()
        combat_assist:new_toggle({name = "Toggle", flag = 'combat_assist'})
        combat_assist:new_button({name = "Button", callback = function()
             utility.getclipboard()
        end})
        combat_assist:new_keybind({name = "Keybind", keybind_name = "aim assist", flag = 'combat_assist_key', mode = "Hold", default = Enum.UserInputType.MouseButton2})
        combat_assist:new_slider({name = "Slider", flag = 'combat_assist_fov', min = 0, max = 1000, default = 500})
        combat_assist:new_dropdown({name = "Dropdown", flag = 'combat_assist_hitbox', options = {'Head','Chest'}, default = 'Head'})
    end
    local combat_target = combat_main:new_section({name = "targeting"}) do
        combat_target:new_dropdown({name = "checks", flag = 'combat_target_checks', options = {"Team","Visible","Invisible","Friendly","Whitelisted"}, max = 5})
        combat_target:new_seperator({name = "Seperator"})
        combat_target:new_toggle({name = "Toggle With Colour Picker", flag = 'combat_assist_fov_render',Cp = true}):new_colorpicker({flag = 'combat_assist_fov_color', default = Color3.fromRGB(255,0,0)})
        combat_target:new_toggle({name = "Toggle With Colour Picker2", flag = 'combat_assist_fov_render2',Cp = true}):new_colorpicker({flag = 'combat_assist_fov_color2', default = Color3.fromRGB(255,0,0)})
    end
end
local combat_mods = combat:new_section({name = "Test 1", side = "right", size = 140}) do
    combat_mods:new_toggle({name = "Risky", flag = 'mods_wallbang', risky = true}):new_colorpicker({flag = 'aaaaaaa', default = Color3.fromRGB(255,0,0)})
end
local combat_hitsounds = combat:new_section_holder({name = "hitsounds", side = "right", size = 140}) do
    local hitsounds_hitmarker = combat_hitsounds:new_section({name = "hitmarker"}) do
        hitsounds_hitmarker:open()
        hitsounds_hitmarker:new_toggle({name = "Toggle", flag = 'hitmarker_toggle'}):new_colorpicker({flag = 'ttttttt', default = Color3.fromRGB(255,0,0)})
    end
    local hitsounds_headshot = combat_hitsounds:new_section({name = "headshot"}) do
        hitsounds_headshot:new_toggle({name = "Toggle", flag = 'hitmarker_toggle'})
    end
    local hitsounds_kill = combat_hitsounds:new_section({name = "kill"}) do
        hitsounds_kill:new_toggle({name = "Toggle", flag = 'hitmarker_toggle2'})
    end
end
local informationsection = playerspage:new_section({name = "Information", side = "right", size = "Fill"})
    local displaytext = informationsection:new_label({text = "Display Name: "})
    local usernametext = informationsection:new_label({text = "Username: "})
    local useridtext = informationsection:new_label({text = "UserId: "})
    local teamtext = informationsection:new_label({text = "Team: "})
    local healthtext = informationsection:new_label({text = "Health: "})
    informationsection:new_button({name = "Refresh Player List", callback = function()
        library.initialised = false
        updateplayers()
        library.initialised = true
    end})
local profilesection = playerspage:new_section({name = "Profiles", size = "Fill"})
local playerlist = profilesection:new_dropdown({name = "Player:",list = true, size = "Fill", flag = 'selected_player',scrollable = true,callback = function(option) 
    if library.initialised then
        local SelPlayer = library.flags.selected_player
        local Ped = game.Players:FindFirstChild(SelPlayer)
        local team
        if Ped.Team == nil then team = "Not Found" else team = Ped.team end
        displaytext:update("Display Name: "..Ped.DisplayName.."")
        usernametext:update("Username: "..SelPlayer.."")
        useridtext:update("UserId: "..Ped.UserId.."")
        teamtext:update("Team: "..team.."")
        local Hum = workspace[SelPlayer].Humanoid
        local CurrentHealth = Hum.Health
        local MaxHealth = Hum.MaxHealth
        healthtext:update("Health: "..CurrentHealth.."/"..MaxHealth.."")
    end
end})
function updateplayers()
    local playertable = {}
    for i,v in pairs(game.Players:GetPlayers()) do
        table.insert(playertable, v.Name)
    end
    playerlist:refresh(playertable)
end
updateplayers()
local visualpage = visualspage:new_section({name = "Visualisation", side = "left", size = "Fill"}) 
    local vis = visualpage:new_visualisation()
local visualpage = visualspage:new_section({name = "Settings", side = "right", size = "Fill"}) do
    local chamtoggle = visualpage:new_toggle({name = "Cham", flag = 'ChamEsp',state = true,callback = function(state)
        vis:updatesetting({Part = "Chams",show = state})
    end})
    chamtoggle:new_colorpicker({flag = 'ChamOutlineColour', default = Color3.fromRGB(0,0,0),callback = function(colour) 
        vis:updatecolour({Part = "ChamsOutline",colour = colour})
    end})
    chamtoggle:new_colorpicker({flag = 'ChamInlineColour', default = Color3.fromRGB(83,25,111),callback = function(colour) 
        vis:updatecolour({Part = "ChamsInline",colour = colour})
    end})
    local boxtoggle = visualpage:new_toggle({name = "Box", flag = 'BoxEsp',state = true,callback = function(state)
        vis:updatesetting({Part = "Box",show = state})
    end})
    boxtoggle:new_colorpicker({flag = 'BoxOutlineColour', default = Color3.fromRGB(0,0,0),callback = function(colour) 
        vis:updatecolour({Part = "BoxOutline",colour = colour})
    end})
    boxtoggle:new_colorpicker({flag = 'BoxInlineColour', default = Color3.fromRGB(83,25,111),callback = function(colour) 
        vis:updatecolour({Part = "BoxInline",colour = colour})
    end})
    local healthbartoggle = visualpage:new_toggle({name = "Healthbar", flag = 'HealthbarEsp',state = true,callback = function(state)
        vis:updatesetting({Part = "Healthbar",show = state})
    end})
    healthbartoggle:new_colorpicker({flag = 'HealthbarOutlineColour', default = Color3.fromRGB(0,0,0),callback = function(colour) 
        vis:updatecolour({Part = "HealthbarOutline",colour = colour})
    end})
    healthbartoggle:new_colorpicker({flag = 'HealthbarInlineColour', default = Color3.fromRGB(0,255,0),callback = function(colour) 
        vis:updatecolour({Part = "HealthbarInline",colour = colour})
    end})
    local nametoggle = visualpage:new_toggle({name = "Name", flag = 'NameEsp',state = true,callback = function(state)
        vis:updatesetting({Part = "Name",show = state})
    end})
    nametoggle:new_colorpicker({flag = 'NameOutlineColour', default = Color3.fromRGB(0,0,0),callback = function(colour) 
        vis:updatecolour({Part = "NameOutline",colour = colour})
    end})
    nametoggle:new_colorpicker({flag = 'NameInlineColour', default = Color3.fromRGB(255,255,255),callback = function(colour) 
        vis:updatecolour({Part = "NameInline",colour = colour})
    end})
end
local themesection = menu:new_section_holder({name = "Themes",side = "left", size = "Fill"})
local CustomTheme = themesection:new_section({name = "Editor"})
CustomTheme:open()
local ThemeSettings = themesection:new_section({name = "Settings"}) 
local theme_pickers = {}
theme_pickers["Accent"] = CustomTheme:new_colorpicker({name = "accent",flag = 'theme_accent', default = default_theme["Accent"], callback = function(state) library:ChangeThemeOption("Accent", state) end})
theme_pickers["Window Outline Background"] = CustomTheme:new_colorpicker({name = "window outline",flag = 'theme_outline', default = default_theme["Window Outline Background"], callback = function(state) library:ChangeThemeOption("Window Outline Background", state) end})
theme_pickers["Window Inline Background"] = CustomTheme:new_colorpicker({name = "window inline",flag = 'theme_inline', default = default_theme["Window Inline Background"], callback = function(state) library:ChangeThemeOption("Window Inline Background", state) end})
theme_pickers["Window Holder Background"] = CustomTheme:new_colorpicker({name = "window holder",flag = 'theme_holder', default = default_theme["Window Holder Background"], callback = function(state) library:ChangeThemeOption("Window Holder Background", state) end})
theme_pickers["Window Border"] = CustomTheme:new_colorpicker({name = "window border",flag = 'theme_border', default = default_theme["Window Border"], callback = function(state) library:ChangeThemeOption("Window Border", state) end})
theme_pickers["Page Selected"] = CustomTheme:new_colorpicker({name = "page selected",flag = 'theme_selected', default = default_theme["Page Selected"], callback = function(state) library:ChangeThemeOption("Page Selected", state) end})
theme_pickers["Page Unselected"] = CustomTheme:new_colorpicker({name = "page unselected",flag = 'theme_unselected', default = default_theme["Page Unselected"], callback = function(state) library:ChangeThemeOption("Page Unselected", state) end})
theme_pickers["Section Inner Border"] = CustomTheme:new_colorpicker({name = "border 1",flag = 'theme_border1', default = default_theme["Section Inner Border"], callback = function(state) library:ChangeThemeOption("Section Inner Border", state) end})
theme_pickers["Section Outer Border"] = CustomTheme:new_colorpicker({name = "border 2",flag = 'theme_border2', default = default_theme["Section Outer Border"], callback = function(state) library:ChangeThemeOption("Section Outer Border", state) end})
theme_pickers["Section Background"] = CustomTheme:new_colorpicker({name = "section background",flag = 'theme_section', default = default_theme["Section Background"], callback = function(state) library:ChangeThemeOption("Section Background", state) end})
theme_pickers["Text"] = CustomTheme:new_colorpicker({name = "text",flag = 'theme_text', default = default_theme["Text"], callback = function(state) library:ChangeThemeOption("Text", state) end})
theme_pickers["Risky Text"] = CustomTheme:new_colorpicker({name = "risky text",flag = 'theme_risky', default = default_theme["Risky Text"], callback = function(state) library:ChangeThemeOption("Risky Text", state) end})
theme_pickers["Object Background"] = CustomTheme:new_colorpicker({name = "element background",flag = 'theme_element', default = default_theme["Object Background"], callback = function(state) library:ChangeThemeOption("Object Background", state) end})
local theme_tbl = {}
for theme,v in pairs(ui_themes) do
    table.insert(theme_tbl, theme)
end
ThemeSettings:new_dropdown({name = "Selecton:", flag = 'theme_list', options = theme_tbl,default = "DeadCell"})
ThemeSettings:new_button({name = "Load", callback = function()
    library:SetTheme(ui_themes[library.flags.theme_list])
    for option,picker in pairs(theme_pickers) do
        picker:set(ui_themes[library.flags.theme_list][option])
    end
end})
ThemeSettings:new_seperator({name = "Effects"})
ThemeSettings:new_dropdown({flag = "settings/menu/effects", name = "Selection:", options = {"None", "Rainbow", "Shift", "Reverse Shift"}, default = "None"})
ThemeSettings:new_slider({flag = "settings/menu/effect_speed", name = "Speed", min = 0.1, max = 2, default = 1, float = 0.1})
game:GetService("RunService").Heartbeat:Connect(function()
    local AccentEffect = library.flags["settings/menu/effects"]
    local EffectSpeed = library.flags["settings/menu/effect_speed"]
    if AccentEffect == "Rainbow" then
        local Clock = os.clock() * EffectSpeed
        local Color = Color3.fromHSV(math.abs(math.sin(Clock)), 1, 1)
        library:ChangeThemeOption("Accent", Color)
    end
    if AccentEffect == "Shift" then
        local ShiftOffset = 0
        local Clock = os.clock() * EffectSpeed + ShiftOffset
        ShiftOffset = ShiftOffset + 0.01
        local Color = Color3.fromHSV(math.abs(math.sin(Clock)), 1, 1)
        library.flags["theme_accent"] = Color
        library:ChangeThemeOption("Accent", Color)
    end
    if AccentEffect == "Reverse Shift" then
        local ShiftOffset = 0
        local Clock = os.clock() * EffectSpeed + ShiftOffset
        ShiftOffset = ShiftOffset - 0.01
        local Color = Color3.fromHSV(math.abs(math.sin(Clock)), 1, 1)
        library.flags["theme_accent"] = Color
        library:ChangeThemeOption("Accent", Color)
    end
end)
local menu_other = menu:new_section({name = "Options", size = "Fill", side = "right"})
menu_other:new_seperator({name = "Ui Option"})
menu_other:new_keybind({name = "Toggle Key", flag = 'menu_toggle', default = Enum.KeyCode.RightControl, mode = "Toggle", ignore = true, callback = function() library:Close() end})
menu_other:new_toggle({name = "Performance Drag", flag = 'PerformanceDragFlag', callback = function(state) library.performancedrag = state end})
menu_other:new_seperator({name = "Lists"})
menu_other:new_toggle({name = "Watermark", flag = 'watermarklist', callback = function(state) window:set_watermark_visibility(state) end})
menu_other:new_toggle({name = "Keybind", flag = 'keybind_list', callback = function(state) window:set_keybind_list_visibility(state) end})
menu_other:new_seperator({name = "Server"})
menu_other:new_button({name = "rejoin", confirm = true, callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end})
menu_other:new_button({name = "copy join script", callback = function() setclipboard(([[game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s")]]):format(game.PlaceId, game.JobId)) end})
menu_other:new_button({name = "Notify", callback = function() library.notify({message = "this is a test notif lol", time = 5}) end})
library:Init()
window:pos()