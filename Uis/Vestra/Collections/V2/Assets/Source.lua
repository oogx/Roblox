local random = Random.new()

local unpack,a,b,c,d,e,f,g,h,i,j=table.unpack or unpack,table.concat,string.byte,string.char,string.rep,string.sub,string.format,math.floor,math.ceil,math.min,math.max;local k,l,m,n,o,p,q,r;function n(s,t)return s*2^t%4294967296 end;function o(s,t)s=s%4294967296/2^t;return s-s%1 end;function p(s,t)s=s%4294967296*2^t;local u=s%4294967296;return u+(s-u)/4294967296 end;function q(s,t)s=s%4294967296/2^t;local u=s%1;return u*4294967296+s-u end;local v={}for w=0,65535 do local s=w%256;local x=(w-s)/256;local y=0;local z=1;while s*x~=0 do local A=s%2;local B=x%2;y=y+A*B*z;s=(s-A)/2;x=(x-B)/2;z=z*2 end;v[w]=y end;local function C(s,x,D)local E=s%4294967296;local F=x%4294967296;local A=E%256;local B=F%256;local y=v[A+B*256]s=E-A;x=(F-B)/256;A=s%65536;B=x%256;y=y+v[A+B]*256;s=(s-A)/256;x=(x-B)/256;A=s%65536+x%256;y=y+v[A]*65536;y=y+v[(s+x-A)/256]*16777216;if D then y=E+F-D*y end;return y end;function k(s,x)return C(s,x)end;function l(s,x)return C(s,x,1)end;function m(s,x,G)if G then x=C(x,G,2)end;return C(s,x,2)end;function r(s)return f("%08x",s%4294967296)end;local H,I,J,K={},{},{},{}local L={[224]={},[256]=K}local M,N={[384]={},[512]=J},{[384]={},[512]=K}local O={}local function P(Q,R,S,T,U,V)for W=U,V+U-1,64 do for X=1,16 do W=W+4;local Y,Z,_,a0=b(S,W-3,W)T[X]=((Y*256+Z)*256+_)*256+a0 end;for X=17,64 do local Y,Z=T[X-15],T[X-2]T[X]=m(q(Y,7),p(Y,14),o(Y,3))+m(p(Z,15),p(Z,13),o(Z,10))+T[X-7]+T[X-16]end;local Y,Z,_,a0,a1,a2,a3,a4,G=Q[1],Q[2],Q[3],Q[4],Q[5],Q[6],Q[7],Q[8]for X=1,64 do G=m(q(a1,6),q(a1,11),p(a1,7))+k(a1,a2)+k(-1-a1,a3)+a4+R[X]+T[X]a4=a3;a3=a2;a2=a1;a1=G+a0;a0=_;_=Z;Z=Y;Y=G+k(a0,_)+k(Y,m(a0,_))+m(q(Y,2),q(Y,13),p(Y,10))end;Q[1],Q[2],Q[3],Q[4]=(Y+Q[1])%4294967296,(Z+Q[2])%4294967296,(_+Q[3])%4294967296,(a0+Q[4])%4294967296;Q[5],Q[6],Q[7],Q[8]=(a1+Q[5])%4294967296,(a2+Q[6])%4294967296,(a3+Q[7])%4294967296,(a4+Q[8])%4294967296 end end;local function a5(a6,a7,a8,a9,S,T,U,V)for W=U,V+U-1,128 do for X=1,32 do W=W+4;local Y,Z,_,a0=b(S,W-3,W)T[X]=((Y*256+Z)*256+_)*256+a0 end;local aa,ab;for ac=17*2,80*2,2 do local ad,ae,af,ag=T[ac-30],T[ac-31],T[ac-4],T[ac-5]aa=m(o(ad,1)+n(ae,31),o(ad,8)+n(ae,24),o(ad,7)+n(ae,25))+m(o(af,19)+n(ag,13),n(af,3)+o(ag,29),o(af,6)+n(ag,26))+T[ac-14]+T[ac-32]ab=aa%4294967296;T[ac-1]=m(o(ae,1)+n(ad,31),o(ae,8)+n(ad,24),o(ae,7))+m(o(ag,19)+n(af,13),n(ag,3)+o(af,29),o(ag,6))+T[ac-15]+T[ac-33]+(aa-ab)/4294967296;T[ac]=ab end;local ad,af,ah,ai,aj,ak,al,am,an=a6[1],a6[2],a6[3],a6[4],a6[5],a6[6],a6[7],a6[8]local ae,ag,ao,ap,aq,ar,as,at,au=a7[1],a7[2],a7[3],a7[4],a7[5],a7[6],a7[7],a7[8]for X=1,80 do local ac=2*X;aa=m(o(aj,14)+n(aq,18),o(aj,18)+n(aq,14),n(aj,23)+o(aq,9))+k(aj,ak)+k(-1-aj,al)+am+a8[X]+T[ac]an=aa%4294967296;au=m(o(aq,14)+n(aj,18),o(aq,18)+n(aj,14),n(aq,23)+o(aj,9))+k(aq,ar)+k(-1-aq,as)+at+a9[X]+T[ac-1]+(aa-an)/4294967296;am=al;at=as;al=ak;as=ar;ak=aj;ar=aq;aa=an+ai;aj=aa%4294967296;aq=au+ap+(aa-aj)/4294967296;ai=ah;ap=ao;ah=af;ao=ag;af=ad;ag=ae;aa=an+k(ai,ah)+k(af,m(ai,ah))+m(o(af,28)+n(ag,4),n(af,30)+o(ag,2),n(af,25)+o(ag,7))ad=aa%4294967296;ae=au+k(ap,ao)+k(ag,m(ap,ao))+m(o(ag,28)+n(af,4),n(ag,30)+o(af,2),n(ag,25)+o(af,7))+(aa-ad)/4294967296 end;aa=a6[1]+ad;ab=aa%4294967296;a6[1],a7[1]=ab,(a7[1]+ae+(aa-ab)/4294967296)%4294967296;aa=a6[2]+af;ab=aa%4294967296;a6[2],a7[2]=ab,(a7[2]+ag+(aa-ab)/4294967296)%4294967296;aa=a6[3]+ah;ab=aa%4294967296;a6[3],a7[3]=ab,(a7[3]+ao+(aa-ab)/4294967296)%4294967296;aa=a6[4]+ai;ab=aa%4294967296;a6[4],a7[4]=ab,(a7[4]+ap+(aa-ab)/4294967296)%4294967296;aa=a6[5]+aj;ab=aa%4294967296;a6[5],a7[5]=ab,(a7[5]+aq+(aa-ab)/4294967296)%4294967296;aa=a6[6]+ak;ab=aa%4294967296;a6[6],a7[6]=ab,(a7[6]+ar+(aa-ab)/4294967296)%4294967296;aa=a6[7]+al;ab=aa%4294967296;a6[7],a7[7]=ab,(a7[7]+as+(aa-ab)/4294967296)%4294967296;aa=a6[8]+am;ab=aa%4294967296;a6[8],a7[8]=ab,(a7[8]+at+(aa-ab)/4294967296)%4294967296 end end;do local function av(aw,ax,ay,az)local aA={}local aB=0;local aC=0.0;local aD=1.0;for X=1,az do local aE=0;for aF=j(1,X+1-#ax),i(X,#aw)do aE=aE+aw[aF]*ax[X+1-aF]end;aB=aB+aE*ay;local aG=aB%16777216;aA[X]=aG;aB=g(aB/16777216)aC=aC+aG*aD;aD=aD*2^24 end;return aA,aC end;local w,aH,aI,aJ=0,{4,1,2,-2,2},4,{1}local aK,aL,aM=K,J,0;repeat aI=aI+aH[aI%6]local a0=1;repeat a0=a0+aH[a0%6]if a0*a0>aI then w=w+1;local aN=aI^(1/3)local aO=av({g(aN*2^40)},aJ,1,2)local aP,aQ=av(aO,av(aO,aO,1,4),-1,4)local aR=aO[2]%65536*65536+g(aO[1]/256)local aS=aO[1]%256*16777216+g(aQ*2^-56/3*aN/aI)I[w],H[w]=aR,aS;if w<17 then aN=aI^(1/2)aO=av({g(aN*2^40)},aJ,1,2)aP,aQ=av(aO,aO,-1,2)aR=aO[2]%65536*65536+g(aO[1]/256)aS=aO[1]%256*16777216+g(aQ*2^-17/aN)L[224][w+aM]=aS;aK[w+aM],aL[w+aM]=aR,aS;if w==8 then aK,aL,aM=N[384],M[384],-8 end end;break end until aI%a0==0 until w>79 end;for aT=224,256,32 do local a6,a7={},{}for X=1,8 do a6[X]=m(J[X],0xa5a5a5a5)a7[X]=m(K[X],0xa5a5a5a5)end;a5(a6,a7,H,I,"SHA-512/"..tonumber(aT).."\128"..d("\0",115).."\88",O,0,128)M[aT]=a6;N[aT]=a7 end;local function aU(aT,aV)local Q,aW,aX={unpack(L[aT])},0,""local function aY(aZ)if aZ then if aX then aW=aW+#aZ;local U=0;if aX~=""and#aX+#aZ>=64 then U=64-#aX;P(Q,I,aX..e(aZ,1,U),O,0,64)aX=""end;local V=#aZ-U;local a_=V%64;P(Q,I,aZ,O,U,V-a_)aX=aX..e(aZ,#aZ+1-a_)return aY else error("Adding more chunks is not allowed after asking for final result",2)end else if aX then local b0={aX,"\128",d("\0",(-9-aW)%64+1)}aX=nil;aW=aW*8/256^7;for X=4,10 do aW=aW%1*256;b0[X]=c(g(aW))end;b0=a(b0)P(Q,I,b0,O,0,#b0)local b1=aT/32;for X=1,b1 do Q[X]=r(Q[X])end;Q=a(Q,"",1,b1)end;return Q end end;if aV then return aY(aV)()else return aY end end;local function b2(aT,aV)local aW,aX,a6,a7=0,"",{unpack(M[aT])},{unpack(N[aT])}local function aY(aZ)if aZ then if aX then aW=aW+#aZ;local U=0;if aX~=""and#aX+#aZ>=128 then U=128-#aX;a5(a6,a7,H,I,aX..e(aZ,1,U),O,0,128)aX=""end;local V=#aZ-U;local a_=V%128;a5(a6,a7,H,I,aZ,O,U,V-a_)aX=aX..e(aZ,#aZ+1-a_)return aY else error("Adding more chunks is not allowed after asking for final result",2)end else if aX then local b0={aX,"\128",d("\0",(-17-aW)%128+9)}aX=nil;aW=aW*8/256^7;for X=4,10 do aW=aW%1*256;b0[X]=c(g(aW))end;b0=a(b0)a5(a6,a7,H,I,b0,O,0,#b0)local b1=h(aT/64)for X=1,b1 do a6[X]=r(a7[X])..r(a6[X])end;a7=nil;a6=a(a6,"",1,b1):sub(1,aT/4)end;return a6 end end;if aV then return aY(aV)()else return aY end end;local sha={sha224=function(aV)return aU(224,aV)end,sha256=function(aV)return aU(256,aV)end,sha384=function(aV)return b2(384,aV)end,sha512=function(aV)return b2(512,aV)end,sha512_224=function(aV)return b2(224,aV)end,sha512_256=function(aV)return b2(256,aV)end}

local letters = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
}

function getRandomLetter()
    return letters[random:NextInteger(1, #letters)]
end

function RandomCharacters(length)
    local length = length or 10
    local str = ""
    for i = 1, length do
        local randomLetter = getRandomLetter()
        str = str .. randomLetter
    end
    return str
end

local objects = {["Background"] = {}, ["Accent"] = {}, ["LightContrast"] = {}, ["DarkContrast"] = {}, ["TextColor"] = {}, ["HighlightColor"] = {} }

local lib = {MenuToggle = false}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale,StartPosition.X.Offset + Delta.X,StartPosition.Y.Scale,StartPosition.Y.Offset + Delta.Y)
		object.Position = pos
	end

	topbarobject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end)
			end
		end)

	topbarobject.InputChanged:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end)

	UserInputService.InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end)
end

getgenv().theme = {
    Background = Color3.fromRGB(40, 40, 40),
    Accent = Color3.fromRGB(0, 0, 0), 
    LightContrast = Color3.fromRGB(35, 35, 35),
    DarkContrast = Color3.fromRGB(25, 25, 25), 
    TextColor = Color3.fromRGB(255, 255, 255),
    HighlightColor = Color3.fromRGB(0, 22, 229),
}

getgenv().White_Theme = false

if getgenv().White_Theme then

    getgenv().theme = {
        Background = Color3.fromRGB(229, 229, 229), 
        Accent = Color3.fromRGB(255, 255, 255), 
        LightContrast = Color3.fromRGB(229, 229, 229), 
        DarkContrast = Color3.fromRGB(206, 206, 206),  
        TextColor = Color3.fromRGB(0, 0, 0),
        HighlightColor = Color3.fromRGB(0, 22, 229),
    }

end

function lib:Load(Config)

    local Gui_Name = Config.Title or "Unknown"
	fs = false
    pcall(function() VestraLib:Destroy() end);

    pcall(function() for i,v in pairs(VestraLib_Con) do
    
    v:Disconnect()

    end

end);



local VestraLib = Instance.new("ScreenGui")
VestraLib.Name = "VestraLib"
VestraLib.Parent = game.CoreGui
VestraLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

getgenv()["VestraLib"] = VestraLib;

getgenv()["VestraLib_Con"] = {}

local MainFrame = Instance.new("Frame")
MainFrame.Name = RandomCharacters(math.random(15, 25));
MainFrame.Parent = VestraLib
MainFrame.BackgroundColor3 = theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.391, 0,0.351, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 322)

TweenService:Create(MainFrame, TweenInfo.new(1), {Size = UDim2.new(0, 415, 0, 322)}):Play()

wait(1)
MakeDraggable(MainFrame,MainFrame)

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = MainFrame
TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleText.BackgroundTransparency = 1.000
TitleText.Position = UDim2.new(0.0144578312, 0, 0.0186335407, 0)
TitleText.Size = UDim2.new(0, 200, 0, 25)
TitleText.Font = Enum.Font.PatrickHand
TitleText.Text = "Vestra Hub"
TitleText.TextColor3 = theme.TextColor
TitleText.TextSize = 35.000
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 4)
MainCorner.Parent = MainFrame

local LoaderText = Instance.new("TextLabel")
LoaderText.Name = "LoaderText"
LoaderText.Parent = MainFrame
LoaderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoaderText.BackgroundTransparency = 1
LoaderText.Position = UDim2.new(0.257831335, 0, 0.45962733, 0)
LoaderText.Size = UDim2.new(0, 200, 0, 25)
LoaderText.Font = Enum.Font.PatrickHand
LoaderText.Text = "Loading Ui..."
LoaderText.TextTransparency = 0
LoaderText.TextColor3 = theme.TextColor
LoaderText.TextSize = 25.000
LoaderText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

local OuterLine = Instance.new("Frame")
OuterLine.Name = "OuterLine"
OuterLine.BackgroundTransparency = 0
OuterLine.Parent = MainFrame
OuterLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
OuterLine.BorderColor3 = Color3.fromRGB(255, 255, 255)
OuterLine.BorderSizePixel = 0
OuterLine.Position = UDim2.new(0.25577879, 0, 0.556159854, 0)
OuterLine.Size = UDim2.new(0, 200, 0, 7)

local OuterCorner = Instance.new("UICorner")
OuterCorner.CornerRadius = UDim.new(0, 20)
OuterCorner.Name = "OuterCorner"
OuterCorner.Parent = OuterLine

local InnerLine = Instance.new("Frame")
InnerLine.Name = "InnerLine"
InnerLine.BackgroundTransparency = 0
InnerLine.Parent = OuterLine
InnerLine.BackgroundColor3 = Color3.fromRGB(0, 22, 229)
InnerLine.BorderColor3 = Color3.fromRGB(255, 255, 255)
InnerLine.BorderSizePixel = 0
InnerLine.Size = UDim2.new(0, 0, 0, 7)
local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0, 20)
InnerCorner.Name = "InnerCorner"
InnerCorner.Parent = InnerLine
wait(2)
TweenService:Create(InnerLine, TweenInfo.new(1), {Size = UDim2.new(0, 200, 0, 7)}):Play()

LoaderText.Text = "Loading Ui..."
wait(2)

TitleText:Destroy()
LoaderText:Destroy()
OuterLine:Destroy()
InnerLine:Destroy()

table.insert(objects.Background, MainFrame)

local ContainerFolder = Instance.new("Folder")
ContainerFolder.Name = RandomCharacters(math.random(15, 25));
ContainerFolder.Parent = MainFrame

local TabHolder = Instance.new("Frame")
TabHolder.Name = RandomCharacters(math.random(15, 25));
TabHolder.Parent = MainFrame
TabHolder.BackgroundColor3 = theme.Background
TabHolder.BorderSizePixel = 0
TabHolder.ClipsDescendants = true
TabHolder.Position = UDim2.new(1.01337051, 0, -0.000375309348, 0)
TabHolder.Size = UDim2.new(0, 0, 0, 322)

table.insert(objects.Background, TabHolder)

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 4)
MainTabCorner.Name = RandomCharacters(math.random(15, 25));
MainTabCorner.Parent = TabHolder

local MainHolder = Instance.new("ScrollingFrame")
MainHolder.Name = RandomCharacters(math.random(15, 25));
MainHolder.Parent = TabHolder
MainHolder.Active = true
MainHolder.BackgroundColor3 = theme.Background
MainHolder.BorderSizePixel = 0
MainHolder.ClipsDescendants = false
MainHolder.Position = UDim2.new(0, 0, 0.0190088488, 0)
MainHolder.Size = UDim2.new(0, 100, 0, 308)
MainHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
MainHolder.ScrollBarThickness = 3

table.insert(objects.Background, MainHolder)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainHolder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local TabButton = Instance.new("ImageButton")
TabButton.Name = RandomCharacters(math.random(15, 25));
TabButton.Parent = MainFrame
TabButton.BackgroundTransparency = 1
TabButton.Position = UDim2.new(0.925000012, 0, 0.0189999994, 0)
TabButton.Size = UDim2.new(0, 25, 0, 25)
TabButton.Image = "rbxassetid://3926305904"
TabButton.ImageTransparency = 1
TabButton.ImageColor3 = theme.TextColor
TabButton.ImageRectOffset = Vector2.new(464, 4)
TabButton.ImageRectSize = Vector2.new(36, 36)

table.insert(objects.TextColor, TabButton)

local TitleText = Instance.new("TextLabel")
TitleText.Name = RandomCharacters(math.random(15, 25));
TitleText.Parent = MainFrame
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0.0144578312, 0, 0.0186335407, 0)
TitleText.Size = UDim2.new(0, 200, 0, 25)
TitleText.Font = Enum.Font.PatrickHand
TitleText.Text = Gui_Name
TitleText.TextTransparency = 1
TitleText.TextColor3 = theme.TextColor
TitleText.TextSize = 35.000
TitleText.TextXAlignment = Enum.TextXAlignment.Left

table.insert(objects.Accent, TabButton)

table.insert(objects.TextColor, TitleText)

wait(1)

TweenService:Create(TitleText, TweenInfo.new(1), {TextTransparency = 0}):Play()
TweenService:Create(TabButton, TweenInfo.new(1), {ImageTransparency = 0}):Play()

TabButton.MouseButton1Down:Connect(function()
    lib.MenuToggle = not lib.MenuToggle
    TweenService:Create(TabHolder, TweenInfo.new(0.70), {Size = lib.MenuToggle and UDim2.new(0, 100, 0, 322) or UDim2.new(0, 0, 0, 322)}):Play()
end)
local tabhold = {}

function tabhold:ChangeColor(What, color)
    if theme[What] then
        theme[What] = color
    
        if What == "Background" then
            for i,v in pairs(objects.Background) do
                
                if v:IsA("Frame") then
                   v.BackgroundColor3 = color 
                elseif v:IsA("ScrollingFrame") then
                   v.BackgroundColor3 = color 
                elseif v:IsA("TextButton") then
                   v.BackgroundColor3 = color 
                end
                
            end
        elseif What == "TextColor" then
            
                    for i,v in pairs(objects.TextColor) do
                
                if v:IsA("TextLabel") then
                   v.TextColor3 = color 
                elseif v:IsA("TextButton") then
                   v.TextColor3 = color 
                elseif v:IsA("TextBox") then
                   v.TextColor3 = color 
                elseif v:IsA("ImageLabel") then
                   v.ImageColor3 = color 
                end
                
                    end
            elseif What == "Accent" then
            
                    for i,v in pairs(objects.Accent) do
                
                if v:IsA("TextButton") then
                   v.BackgroundColor3 = color 
                elseif v:IsA("Frame") then
                   v.BackgroundColor3 = color 
                elseif v:IsA("TextLabel") then
                   v.BackgroundColor3 = color 
                end
                
                    end
                elseif What == "LightContrast" then
            
                    for i,v in pairs(objects.LightContrast) do
                
                if v:IsA("TextButton") then
                   v.BackgroundColor3 = color 
                elseif v:IsA("TextBox") then
                   v.BackgroundColor3 = color 
                elseif v:IsA("TextLabel") then
                   v.BackgroundColor3 = color 
                elseif v:IsA("ImageLabel") then
                   v.ImageColor3 = color 
                end
                
                    end
                    elseif What == "DarkContrast" then
            
                    for i,v in pairs(objects.DarkContrast) do
                
                if v:IsA("ImageLabel") then
                   v.ImageColor3 = color 
                end
                
                    end
                        elseif What == "HighlightColor" then
            
                    for i,v in pairs(objects.HighlightColor) do
                
                if v:IsA("ImageLabel") then
                   v.ImageColor3 = color 
                end
                
                    end
        
        end
        
    end
    
    end

function tabhold:Notification(title,desc,buttontitle)
    desc = desc or "none"
    buttontitle = buttontitle or "Close"

    local NotificationBase = Instance.new("TextButton")
    NotificationBase.Name = RandomCharacters(math.random(15, 25));
    NotificationBase.Parent = MainFrame
    NotificationBase.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NotificationBase.BackgroundTransparency = 0.550
    NotificationBase.BorderColor3 = Color3.fromRGB(255, 255, 255)
    NotificationBase.BorderSizePixel = 0
    NotificationBase.Size = UDim2.new(0, 415, 0, 322)
    NotificationBase.Font = Enum.Font.SourceSans
    NotificationBase.Text = ""
    NotificationBase.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotificationBase.TextSize = 1.000
    NotificationBase.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    NotificationBase.AutoButtonColor = false

    MakeDraggable(NotificationBase,MainFrame)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = NotificationBase
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Name = RandomCharacters(math.random(15, 25));
    NotificationFrame.Parent = NotificationBase
    NotificationFrame.BackgroundColor3 = theme.Background
    NotificationFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.ClipsDescendants = true
    NotificationFrame.Position = UDim2.new(0.257831335, 0, 0.16770187, 0)
    NotificationFrame.Size = UDim2.new(0, 200,0, 0)

    table.insert(objects.Background, NotificationFrame)

    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 4)
    UICorner_2.Parent = NotificationFrame
    
    local NotificationTitle = Instance.new("TextLabel")
    NotificationTitle.Name = RandomCharacters(math.random(15, 25));
    NotificationTitle.Parent = NotificationFrame
    NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotificationTitle.BackgroundTransparency = 1
    NotificationTitle.Position = UDim2.new(-0.0021686554, 0, 0.0398792624, 0)
    NotificationTitle.Size = UDim2.new(0, 200, 0, 25)
    NotificationTitle.Font = Enum.Font.PatrickHand
    NotificationTitle.Text = title
    NotificationTitle.TextColor3 = theme.TextColor
    NotificationTitle.TextSize = 35.000
    
    table.insert(objects.TextColor, NotificationTitle)

    local NotificationDesc = Instance.new("TextLabel")
    NotificationDesc.Name = RandomCharacters(math.random(15, 25));
    NotificationDesc.Parent = NotificationTitle
    NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotificationDesc.BackgroundTransparency = 1
    NotificationDesc.Position = UDim2.new(0.00283142086, 0, 1.4095211, 0)
    NotificationDesc.Size = UDim2.new(0, 200, 0, 100)
    NotificationDesc.Font = Enum.Font.PatrickHand
    NotificationDesc.Text = desc
    NotificationDesc.TextColor3 = theme.TextColor
    NotificationDesc.TextSize = 25.000
    NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top
    
    table.insert(objects.TextColor, NotificationDesc)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = RandomCharacters(math.random(15, 25));
    CloseButton.Parent = NotificationTitle
    CloseButton.BackgroundColor3 = theme.LightContrast
    CloseButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0, 0, 6.32635498, 0)
    CloseButton.Size = UDim2.new(0, 200, 0, 50)
    CloseButton.Font = Enum.Font.PatrickHand
    CloseButton.Text = buttontitle
    CloseButton.TextColor3 = theme.TextColor
    CloseButton.TextSize = 35.000
    CloseButton.AutoButtonColor = false
    
    table.insert(objects.LightContrast, CloseButton)
    
    table.insert(objects.TextColor, CloseButton)

    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.CornerRadius = UDim.new(0, 4)
    UICorner_3.Parent = CloseButton

    TweenService:Create(NotificationFrame, TweenInfo.new(1), {Size = UDim2.new(0, 200, 0, 214)}):Play()

    CloseButton.MouseButton1Click:Connect(function()

        TweenService:Create(NotificationFrame, TweenInfo.new(1), {Size = UDim2.new(0, 200, 0, 0)}):Play()

        TweenService:Create(NotificationBase, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()

wait(1)

NotificationBase:Destroy()

    end)

end

function tabhold:Tab(Config)
    local Tab_Name = Config.Title or "Unknown"
    
    local MainTabButton = Instance.new("TextButton")
    MainTabButton.Name = RandomCharacters(math.random(15, 25));
    MainTabButton.Parent = MainHolder
    MainTabButton.BackgroundColor3 = theme.Accent
    MainTabButton.BorderSizePixel = 0
    MainTabButton.Position = UDim2.new(0.0850000009, 0, 0.0186335407, 0)
    MainTabButton.Size = UDim2.new(0, 83, 0, 26)
    MainTabButton.Font = Enum.Font.SourceSans
    MainTabButton.Text = ""
    MainTabButton.TextColor3 = theme.TextColor
    MainTabButton.TextSize = 14.000
    
    table.insert(objects.Accent, MainTabButton)

    table.insert(objects.TextColor, MainTabButton)

    local TabCorner = Instance.new("UICorner")
    TabCorner.Name = RandomCharacters(math.random(15, 25));
    TabCorner.Parent = MainTabButton
    
    local TabTitle = Instance.new("TextLabel")
    TabTitle.Name = RandomCharacters(math.random(15, 25));
    TabTitle.Parent = MainTabButton
    TabTitle.BackgroundTransparency = 1
    TabTitle.Position = UDim2.new(0.168674693, 0, 0, 0)
    TabTitle.Size = UDim2.new(0, 55, 0, 26)
    TabTitle.Font = Enum.Font.PatrickHand
    TabTitle.Text = Tab_Name
    TabTitle.TextColor3 = theme.TextColor
    TabTitle.TextSize = 20.000
   
    table.insert(objects.TextColor, TabTitle)

    local Container = Instance.new("ScrollingFrame")
    Container.Name = RandomCharacters(math.random(15, 25));
    Container.Parent = ContainerFolder
    Container.Active = true
    Container.BackgroundColor3 = theme.Background
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Position = UDim2.new(0, 0, 0.129999995, 0)
    Container.Size = UDim2.new(0, 415, 0, 275)
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 3
    Container.Visible = false

    table.insert(objects.Background, Container)

    local ContainerListLayout = Instance.new("UIListLayout")
    ContainerListLayout.Parent = Container
    ContainerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ContainerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContainerListLayout.Padding = UDim.new(0, 5)

    if fs == false then
        fs = true
        Container.Visible = true
    end

    MainTabButton.MouseButton1Click:Connect(function()
        for i, v in next, ContainerFolder:GetChildren() do
            if v.Visible == true then
                v.Visible = false
            end
            Container.Visible = true
        end
        TweenService:Create(TabHolder, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size =UDim2.new(0, 0, 0, 322)}):Play()
    end)


    MainHolder.CanvasSize = UDim2.new(0, 0, 0, MainHolder.UIListLayout.AbsoluteContentSize.Y)

    local tabcontent = {}

    function tabcontent:Button(text, callback)
        text = text or "None"
        callback = callback or function() end

        local Button = Instance.new("TextButton")
        Button.Name = RandomCharacters(math.random(15, 25));
        Button.Parent = Container
        Button.BackgroundColor3 = theme.Accent
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(0, 390, 0, 26)
        Button.Font = Enum.Font.SourceSans
        Button.Text = ""
        Button.TextColor3 = theme.TextColor
        Button.TextSize = 14.000

        table.insert(objects.Accent, Button)

        table.insert(objects.TextColor, Button)

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.Name = RandomCharacters(math.random(15, 25));
        ButtonCorner.Parent = Button

        local ButtonTitle = Instance.new("TextLabel")
        ButtonTitle.Name = RandomCharacters(math.random(15, 25));
        ButtonTitle.Parent = Button
        ButtonTitle.BackgroundTransparency = 1
        ButtonTitle.Position = UDim2.new(0.0153846154, 0, 0, 0)
        ButtonTitle.Size = UDim2.new(0, 194, 0, 26)
        ButtonTitle.Font = Enum.Font.PatrickHand
        ButtonTitle.Text = text
        ButtonTitle.TextColor3 = theme.TextColor
        ButtonTitle.TextSize = 20.000
        ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
    
        table.insert(objects.TextColor, ButtonTitle)

        Button.MouseButton1Click:Connect(function()
           pcall(callback())
        end)

        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
    end

    function tabcontent:TextBox(text,default, callback)
        text = text or "None"
        default = default or "Text"
        callback = callback or function() end
       
        local TextBox = Instance.new("TextButton")
        TextBox.Name = "TextBox"
        TextBox.Parent = Container
        TextBox.BackgroundColor3 = theme.Accent
        TextBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.BorderSizePixel = 0
        TextBox.ClipsDescendants = true
        TextBox.Position = UDim2.new(0.0301204827, 0, 0.672727168, 0)
        TextBox.Size = UDim2.new(0, 390, 0, 26)
        TextBox.AutoButtonColor = false
        TextBox.Font = Enum.Font.SourceSans
        TextBox.Text = ""
        TextBox.TextColor3 = theme.TextColor
        TextBox.TextSize = 14.000
     
        table.insert(objects.Accent, TextBox)

        table.insert(objects.TextColor, TextBox)

        local TextboxTxt = Instance.new("TextBox")
        TextboxTxt.Name = "TextboxTxt"
        TextboxTxt.Parent = TextBox
        TextboxTxt.BackgroundColor3 = theme.LightContrast
        TextboxTxt.BorderSizePixel = 0
        TextboxTxt.Position = UDim2.new(0.746153951, 0, 0.0799999982, 0)
        TextboxTxt.Size = UDim2.new(0, 80, 0, 20)
        TextboxTxt.Font = Enum.Font.PatrickHand
        TextboxTxt.PlaceholderColor3 = theme.TextColor
        TextboxTxt.PlaceholderText = default
        TextboxTxt.Text = ""
        TextboxTxt.TextColor3 = theme.TextColor
        TextboxTxt.TextSize = 20.000
     
        table.insert(objects.LightContrast, TextboxTxt)

        table.insert(objects.TextColor, TextboxTxt)

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.Name = "ToggleCorner"
        ToggleCorner.Parent = TextboxTxt
     
        local BoxText = Instance.new("TextLabel")
        BoxText.Name = "BoxText"
        BoxText.Parent = TextBox
        BoxText.BackgroundTransparency = 1
        BoxText.Position = UDim2.new(0.0153846154, 0, 0, 0)
        BoxText.Size = UDim2.new(0, 194, 0, 25)
        BoxText.Font = Enum.Font.PatrickHand
        BoxText.Text = text
        BoxText.TextColor3 = theme.TextColor
        BoxText.TextSize = 20.000
        BoxText.TextXAlignment = Enum.TextXAlignment.Left
     
        table.insert(objects.TextColor, BoxText)

        local TextBoxCorner = Instance.new("UICorner")
        TextBoxCorner.Name = "TextBoxCorner"
        TextBoxCorner.Parent = TextBox

		TextBox.MouseButton1Click:Connect(function()
			TextboxTxt:CaptureFocus()
		end)
		
		TextboxTxt:GetPropertyChangedSignal("Text"):Connect(function()
			
pcall(callback, TextboxTxt.Text)
		end)
		
		TextboxTxt.FocusLost:Connect(function()
			
            pcall(callback, TextboxTxt.Text)

		end)


        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
    end

    function tabcontent:KeyBind(text,default, callback)
        text = text or "None"
        local Key = default.Name or Enum.KeyCode.RightControl
        callback = callback or function() end
        local binding = false

        local KeyBind = Instance.new("TextButton")
        KeyBind.Name = "KeyBind"
        KeyBind.Parent = Container
        KeyBind.BackgroundColor3 = theme.Accent
        KeyBind.BorderSizePixel = 0
        KeyBind.Size = UDim2.new(0, 390, 0, 26)
        KeyBind.AutoButtonColor = false
        KeyBind.Font = Enum.Font.SourceSans
        KeyBind.Text = ""
        KeyBind.TextColor3 = theme.TextColor
        KeyBind.TextSize = 14.000
    
        table.insert(objects.Accent, KeyBind)

        table.insert(objects.TextColor, KeyBind)

        local KeyBindCorner = Instance.new("UICorner")
        KeyBindCorner.Name = "KeyBindCorner"
        KeyBindCorner.Parent = KeyBind
      
        local KeyBindTitle = Instance.new("TextLabel")
        KeyBindTitle.Name = "KeyBindTitle"
        KeyBindTitle.Parent = KeyBind
        KeyBindTitle.BackgroundTransparency = 1
        KeyBindTitle.Position = UDim2.new(0.0153846154, 0, 0, 0)
        KeyBindTitle.Size = UDim2.new(0, 194, 0, 26)
        KeyBindTitle.Font = Enum.Font.PatrickHand
        KeyBindTitle.Text = text
        KeyBindTitle.TextColor3 = theme.TextColor
        KeyBindTitle.TextSize = 20.000
        KeyBindTitle.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(objects.TextColor, KeyBindTitle)

        local ThingHolder = Instance.new("TextLabel")
        ThingHolder.Name = "ThingHolder"
        ThingHolder.Parent = KeyBind
        ThingHolder.BackgroundTransparency = 1
        ThingHolder.BorderSizePixel = 0
        ThingHolder.Position = UDim2.new(0.904999971, 0, 0, 0)
        ThingHolder.Size = UDim2.new(0, 30, 0, 25)
        ThingHolder.Font = Enum.Font.PatrickHand
        ThingHolder.Text = Key
        ThingHolder.TextColor3 = theme.TextColor
        ThingHolder.TextSize = 20.000

        table.insert(objects.TextColor, ThingHolder)

        KeyBind.MouseButton1Click:Connect(function()
            ThingHolder.Text = "..."
            binding = true
            local inputwait = game:GetService("UserInputService").InputBegan:wait()
            if inputwait.KeyCode.Name ~= "Unknown" then
                ThingHolder.Text = inputwait .KeyCode.Name
                Key = inputwait.KeyCode.Name
                binding = false
            else
                binding = false
            end
        end)
        
        local ahahha = game:GetService("UserInputService").InputBegan:connect(function(current, pressed)
            if not pressed then
                if current.KeyCode.Name == Key and binding == false then
                    pcall(callback)
                end
            end
        end)

table.insert(VestraLib_Con, ahahha)

        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
    end

    function tabcontent:Toggle(text, callback)
        text = text or "None"
        callback = callback or function() end
        local Toggled = false

        local Toggle = Instance.new("TextButton")
        Toggle.Name = RandomCharacters(math.random(15, 25));
        Toggle.Parent = Container
        Toggle.BackgroundColor3 = theme.Accent
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(0, 390, 0, 26)
        Toggle.AutoButtonColor = false
        Toggle.Font = Enum.Font.SourceSans
        Toggle.Text = ""
        Toggle.TextColor3 = theme.TextColor
        Toggle.TextSize = 14.000

        table.insert(objects.Accent, Toggle)

        table.insert(objects.TextColor, Toggle)

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.Name = RandomCharacters(math.random(15, 25));
        ToggleCorner.Parent = Toggle

        local ToggleTitle = Instance.new("TextLabel")
        ToggleTitle.Name = RandomCharacters(math.random(15, 25));
        ToggleTitle.Parent = Toggle
        ToggleTitle.BackgroundTransparency = 1
        ToggleTitle.Position = UDim2.new(0.0153846154, 0, 0, 0)
        ToggleTitle.Size = UDim2.new(0, 194, 0, 26)
        ToggleTitle.Font = Enum.Font.PatrickHand
        ToggleTitle.Text = text
        ToggleTitle.TextColor3 = theme.TextColor
        ToggleTitle.TextSize = 20.000
        ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(objects.TextColor, ToggleTitle)

        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Name = RandomCharacters(math.random(15, 25));
        ToggleFrame.Parent = ToggleTitle
        ToggleFrame.BackgroundColor3 = theme.Background
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Position = UDim2.new(1.715, 0,0.11, 0)
        ToggleFrame.Size = UDim2.new(0, 40, 0, 20)

        table.insert(objects.Background, ToggleFrame)

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = ToggleFrame

        local ToggleBall = Instance.new("Frame")
        ToggleBall.Name = RandomCharacters(math.random(15, 25));
        ToggleBall.Parent = ToggleFrame
        ToggleBall.BackgroundColor3 = theme.Accent
        ToggleBall.BorderSizePixel = 0
        ToggleBall.Position = UDim2.new(0.1, 0,0.1, 0)
        ToggleBall.Size = UDim2.new(0, 16, 0, 16)
    
        table.insert(objects.Accent, ToggleBall)

        local UICorner_2 = Instance.new("UICorner")
        UICorner_2.CornerRadius = UDim.new(0, 10)
        UICorner_2.Parent = ToggleBall


        Toggle.MouseButton1Click:Connect(function()
            Toggled = not Toggled
            if Toggled == false then
                TweenService:Create(
                    ToggleFrame,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = theme.Background}
                ):Play()

                TweenService:Create(ToggleBall, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.1, 0,0.1, 0)}):Play()
            else
                TweenService:Create(
                    ToggleFrame,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = theme.HighlightColor}
                ):Play()

                TweenService:Create(ToggleBall, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.50, 0,0.1, 0)}):Play()
            end
            pcall(callback, Toggled)
        end)

        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
    end

    function tabcontent:Slider(text, min, max ,start ,callback)
        text = text or "None"
        min = min or 0
        max = max or 100
        start = start or min
        callback = callback or function() end
        value = start or min

        local dragging, last
      
        local Slider = Instance.new("TextButton")
        Slider.Name = RandomCharacters(math.random(15, 25));
        Slider.Parent = Container
        Slider.BackgroundColor3 = theme.Accent
        Slider.BorderSizePixel = 0
        Slider.Size = UDim2.new(0, 390, 0, 26)
        Slider.AutoButtonColor = false
        Slider.Font = Enum.Font.SourceSans
        Slider.Text = ""
        Slider.TextColor3 = theme.TextColor
        Slider.TextSize = 14.000

        table.insert(objects.Accent, Slider)

        table.insert(objects.TextColor, Slider)

        local SliderCorner = Instance.new("UICorner")
        SliderCorner.Name = RandomCharacters(math.random(15, 25));
        SliderCorner.Parent = Slider
      
        local SliderTitle = Instance.new("TextLabel")
        SliderTitle.Name = RandomCharacters(math.random(15, 25));
        SliderTitle.Parent = Slider
        SliderTitle.BackgroundTransparency = 1
        SliderTitle.Position = UDim2.new(0.0153846154, 0, 0, 0)
        SliderTitle.Size = UDim2.new(0, 135, 0, 26)
        SliderTitle.Font = Enum.Font.PatrickHand
        SliderTitle.Text = text
        SliderTitle.TextColor3 = theme.TextColor
        SliderTitle.TextSize = 20.000
        SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
     
        table.insert(objects.TextColor, SliderTitle)

        local SliderMain = Instance.new("ImageLabel")
        SliderMain.Name = RandomCharacters(math.random(15, 25));
        SliderMain.Parent = SliderTitle
        SliderMain.AnchorPoint = Vector2.new(0, 0.5)
        SliderMain.BackgroundTransparency = 1
        SliderMain.BorderSizePixel = 0
        SliderMain.Position = UDim2.new(1.56940746, 0, 0.476923078, 0)
        SliderMain.Size = UDim2.new(0, 160, 0, 5)
        SliderMain.ZIndex = 3
        SliderMain.Image = "rbxassetid://3570695787"
        SliderMain.ImageColor3 = theme.LightContrast
        SliderMain.ScaleType = Enum.ScaleType.Slice
        SliderMain.SliceCenter = Rect.new(100, 100, 100, 100)

        table.insert(objects.LightContrast, SliderMain)

        local SliderFill = Instance.new("ImageLabel")
        SliderFill.Name = RandomCharacters(math.random(15, 25));
        SliderFill.Parent = SliderMain
        SliderFill.BackgroundColor3 = Color3.fromRGB(42, 0, 255)
        SliderFill.BackgroundTransparency = 1
        SliderFill.BorderSizePixel = 0
        SliderFill.Size = UDim2.new(0, 0, 0, 5)
        SliderFill.ZIndex = 3
        SliderFill.Active = false
        SliderFill.Image = "rbxassetid://3570695787"
        SliderFill.ImageColor3 = theme.HighlightColor
        SliderFill.ScaleType = Enum.ScaleType.Slice
        SliderFill.SliceCenter = Rect.new(100, 100, 100, 100)
   
        table.insert(objects.HighlightColor, SliderFill)

        local SliderBall = Instance.new("ImageLabel")
        SliderBall.Name = RandomCharacters(math.random(15, 25));
        SliderBall.Parent = SliderFill
        SliderBall.AnchorPoint = Vector2.new(0.5, 0.5)
        SliderBall.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        SliderBall.BackgroundTransparency = 1
        SliderBall.BorderSizePixel = 0
        SliderBall.Position = UDim2.new(1, 0, 0.449999988, 0)
        SliderBall.Size = UDim2.new(0, 14, 0, 14)
        SliderBall.ZIndex = 3
        SliderBall.Image = "rbxassetid://3570695787"
        SliderBall.ImageColor3 = theme.DarkContrast
        SliderBall.ScaleType = Enum.ScaleType.Slice
        SliderBall.SliceCenter = Rect.new(100, 100, 100, 100)
      
        table.insert(objects.DarkContrast, SliderBall)

        local SliderValue = Instance.new("TextLabel")
        SliderValue.Name = RandomCharacters(math.random(15, 25));
        SliderValue.Parent = Slider
        SliderValue.BackgroundTransparency = 1
        SliderValue.Position = UDim2.new(0.36153847, 0, 0, 0)
        SliderValue.Size = UDim2.new(0, 59, 0, 26)
        SliderValue.Font = Enum.Font.PatrickHand
        SliderValue.Text = min .. "/" .. max
        SliderValue.TextColor3 = theme.TextColor
        SliderValue.TextSize = 20.000

        table.insert(objects.TextColor, SliderValue)

        Slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        Slider.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        local function move(input)
            local pos = UDim2.new(math.clamp((input.Position.X - SliderMain.AbsolutePosition.X) / SliderMain.AbsoluteSize.X, 0, 1),0, 1, 0)
            local pos1 = UDim2.new(math.clamp((input.Position.X - SliderMain.AbsolutePosition.X) / SliderMain.AbsoluteSize.X, 0, 1),0, 1, 0)
            SliderFill:TweenSize(pos1, "Out", "Sine", 0.1, true)
            local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
            SliderValue.Text = tostring(value) .. "/" .. max
            pcall(callback, value)
            end

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
     
move(input)

        end
    end)



        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
    end

    function tabcontent:Dropdown(text, list ,callback)
        text = text or "None"
        list = list or {}
        callback = callback or function() end
      
        local droptog = false
        local framesize = 0
        local itemcount = 0


        local Dropdown = Instance.new("TextButton")
        Dropdown.Name = RandomCharacters(math.random(15, 25));
        Dropdown.Parent = Container
        Dropdown.BackgroundColor3 = theme.Accent
        Dropdown.BorderSizePixel = 0
        Dropdown.ClipsDescendants = true
        Dropdown.Position = UDim2.new(0.0301204827, 0, 0.672727287, 0)
        Dropdown.Size = UDim2.new(0, 390, 0, 26)
        Dropdown.AutoButtonColor = false
        Dropdown.Font = Enum.Font.SourceSans
        Dropdown.Text = ""
        Dropdown.TextColor3 = theme.TextColor
        Dropdown.TextSize = 14.000
      
        table.insert(objects.Accent, Dropdown)

        table.insert(objects.TextColor, Dropdown)

        local DropdownCorner = Instance.new("UICorner")
        DropdownCorner.Name = RandomCharacters(math.random(15, 25));
        DropdownCorner.Parent = Dropdown
      
        local DropdownTitle = Instance.new("TextLabel")
        DropdownTitle.Name = RandomCharacters(math.random(15, 25));
        DropdownTitle.Parent = Dropdown
        DropdownTitle.BackgroundColor3 = theme.Accent
        DropdownTitle.BackgroundTransparency = 1
        DropdownTitle.Position = UDim2.new(0.0153846154, 0, 0, 0)
        DropdownTitle.Size = UDim2.new(0, 194, 0, 26)
        DropdownTitle.Font = Enum.Font.PatrickHand
        DropdownTitle.Text = text
        DropdownTitle.TextColor3 = theme.TextColor
        DropdownTitle.TextSize = 20.000
        DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
      
        table.insert(objects.Accent, DropdownTitle)

        table.insert(objects.TextColor, DropdownTitle)

        local ItemHolder = Instance.new("ScrollingFrame")
        ItemHolder.Name = RandomCharacters(math.random(15, 25));
        ItemHolder.Parent = DropdownTitle
        ItemHolder.Active = true
        ItemHolder.BackgroundColor3 = theme.Accent
        ItemHolder.BorderSizePixel = 0
        ItemHolder.ClipsDescendants = true
        ItemHolder.Position = UDim2.new(0.00257731951, 0, 1.36923218, 0)
        ItemHolder.Size = UDim2.new(0, 375, 0, 77)
        ItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
        ItemHolder.ScrollBarThickness = 3

        table.insert(objects.Accent, ItemHolder)

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = ItemHolder
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)
        
        local Arrow = Instance.new("ImageLabel")
        Arrow.Name = RandomCharacters(math.random(15, 25));
        Arrow.Parent = DropdownTitle
        Arrow.BackgroundColor3 = theme.TextColor
        Arrow.BackgroundTransparency = 1
        Arrow.Position = UDim2.new(1.80711079, 0, 0.0800000876, 0)
        Arrow.Size = UDim2.new(0, 20, 0, 20)
        Arrow.Image = "rbxassetid://6034818375"
        Arrow.ImageColor3 = theme.TextColor

        table.insert(objects.TextColor, Arrow)

        Dropdown.MouseButton1Click:Connect(function()
         
            if Dropdown.Size == UDim2.new(0, 390, 0, 26) then
               
                TweenService:Create(
                    Dropdown,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 390, 0, 120)}
                ):Play()

                TweenService:Create(
                    Arrow,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Rotation = 270}
                ):Play()
                wait(.2)
                Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
            else
                TweenService:Create(
                    Dropdown,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 390, 0, 26)}
                ):Play()

                TweenService:Create(
                    Arrow,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Rotation = 0}
                ):Play()
                wait(.2)
                Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
            end

        end)

        for i,v in pairs(list) do

local ItemButton = Instance.new("TextButton")
ItemButton.Name = RandomCharacters(math.random(15, 25));
ItemButton.Parent = ItemHolder
ItemButton.BackgroundColor3 = theme.Background
ItemButton.BorderSizePixel = 0
ItemButton.Position = UDim2.new(0.0333333351, 0, 0, 0)
ItemButton.Size = UDim2.new(0, 350, 0, 23)
ItemButton.AutoButtonColor = false
ItemButton.Font = Enum.Font.SourceSans
ItemButton.Text = ""
ItemButton.TextColor3 = theme.TextColor
ItemButton.TextSize = 14.000

table.insert(objects.TextColor, ItemButton)

local ItemCorner = Instance.new("UICorner")
ItemCorner.Name = RandomCharacters(math.random(15, 25));
ItemCorner.Parent = ItemButton

local ItemTitle = Instance.new("TextLabel")
ItemTitle.Name = RandomCharacters(math.random(15, 25));
ItemTitle.Parent = ItemButton
ItemTitle.BackgroundColor3 = theme.Background
ItemTitle.BackgroundTransparency = 1
ItemTitle.Position = UDim2.new(0.425012738, 0, 0, 0)
ItemTitle.Size = UDim2.new(0, 55, 0, 23)
ItemTitle.Font = Enum.Font.PatrickHand
ItemTitle.Text = v
ItemTitle.TextColor3 = theme.TextColor
ItemTitle.TextSize = 20.000

table.insert(objects.TextColor, ItemTitle)

table.insert(objects.Background, ItemTitle)

ItemButton.MouseButton1Click:Connect(function()
    DropdownTitle.Text = text .. " - " .. v
    pcall(callback, v)
    TweenService:Create(
        Dropdown,
        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 390, 0, 26)}
    ):Play()

    TweenService:Create(
        Arrow,
        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Rotation = 0}
    ):Play()
    wait(.2)
    Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
end)



        end

        ItemHolder.CanvasSize = UDim2.new(0, 0, 0, ItemHolder.UIListLayout.AbsoluteContentSize.Y)


        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
    end

    local function GetXY(GuiObject)
        local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
        local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
        return Px/Max, Py/May
    end

    function tabcontent:ColorPicker(text,Default, callback)
        text = text or "None"
        Default = Default or theme.Accent
        callback = callback or function() end
   
        local H, S, V = Instance.new("NumberValue"), Instance.new("NumberValue"), Instance.new("NumberValue")

        H.Value, S.Value, V.Value = Color3.toHSV(Default)

        local r,g,b = 255,255,255

        local Colorpicker = Instance.new("TextButton")
        Colorpicker.Name = RandomCharacters(math.random(15, 25));
        Colorpicker.Parent = Container
        Colorpicker.BackgroundColor3 = theme.Accent
        Colorpicker.BorderSizePixel = 0
        Colorpicker.ClipsDescendants = true
        Colorpicker.Position = UDim2.new(0.0301204827, 0, 0.672727287, 0)
        Colorpicker.Size = UDim2.new(0, 390, 0, 26)
        Colorpicker.AutoButtonColor = false
        Colorpicker.Font = Enum.Font.SourceSans
        Colorpicker.Text = ""
        Colorpicker.TextColor3 = theme.TextColor
        Colorpicker.TextSize = 14.000
        
        table.insert(objects.Accent, Colorpicker)

        table.insert(objects.TextColor, Colorpicker)

        Colorpicker.MouseButton1Click:Connect(function()
         
            if Colorpicker.Size == UDim2.new(0, 390, 0, 26) then
               
                TweenService:Create(
                    Colorpicker,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 390, 0, 120)}
                ):Play()

                wait(.2)
                Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
            else
                TweenService:Create(
                    Colorpicker,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 390, 0, 26)}
                ):Play()

                wait(.2)
                Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
            end

        end)

        local ColorpickerCorner = Instance.new("UICorner")
        ColorpickerCorner.Name = RandomCharacters(math.random(15, 25));
        ColorpickerCorner.Parent = Colorpicker
        
        local ColorpickerTitle = Instance.new("TextLabel")
        ColorpickerTitle.Name = RandomCharacters(math.random(15, 25));
        ColorpickerTitle.Parent = Colorpicker
        ColorpickerTitle.BackgroundTransparency = 1
        ColorpickerTitle.Position = UDim2.new(0.0153846154, 0, 0, 0)
        ColorpickerTitle.Size = UDim2.new(0, 135, 0, 26)
        ColorpickerTitle.Font = Enum.Font.PatrickHand
        ColorpickerTitle.Text = text
        ColorpickerTitle.TextColor3 = theme.TextColor
        ColorpickerTitle.TextSize = 20.000
        ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        table.insert(objects.TextColor, ColorpickerTitle)

        local ColorThing = Instance.new("Frame")
        ColorThing.Name = RandomCharacters(math.random(15, 25));
        ColorThing.Parent = ColorpickerTitle
        ColorThing.BackgroundColor3 = Default
        ColorThing.BorderSizePixel = 0
        ColorThing.Position = UDim2.new(2.49159265, 0, 0.100000001, 0)
        ColorThing.Size = UDim2.new(0, 35, 0, 20)
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = ColorThing
        
        local RainbowGradient = Instance.new("ImageButton")
        RainbowGradient.Name = RandomCharacters(math.random(15, 25));
        RainbowGradient.Parent = ColorpickerTitle
        RainbowGradient.BackgroundTransparency = 1
        RainbowGradient.Position = UDim2.new(0.239999995, 0, 1.31900001, 0)
        RainbowGradient.Size = UDim2.new(0.889999986, 220, 0, 20)
        RainbowGradient.Image = "rbxassetid://5554237731"
        RainbowGradient.ImageRectOffset = Vector2.new(464, 4)
        RainbowGradient.ImageRectSize = Vector2.new(36, 36)
        RainbowGradient.ScaleType = Enum.ScaleType.Slice
      
        local UIGradient = Instance.new("UIGradient")
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.32, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.49, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.82, Color3.fromRGB(149, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
        UIGradient.Parent = RainbowGradient

        local OWOGradient = Instance.new("ImageButton")
        OWOGradient.Name = RandomCharacters(math.random(15, 25));
        OWOGradient.Parent = ColorpickerTitle
        OWOGradient.BackgroundTransparency = 1
        OWOGradient.Position = UDim2.new(0.239999995, 0, 2.30200005, 0)
        OWOGradient.Size = UDim2.new(0.889999986, 220, 0, 20)
        OWOGradient.Image = "rbxassetid://5554237731"
        OWOGradient.ImageRectOffset = Vector2.new(464, 4)
        OWOGradient.ImageRectSize = Vector2.new(36, 36)
        OWOGradient.ScaleType = Enum.ScaleType.Slice
        
        local UIGradient_2 = Instance.new("UIGradient")
        UIGradient_2.Color = ColorSequence.new(
            Color3.fromHSV(H.Value,1,V.Value),
            Color3.new(0,0,0):Lerp(Color3.fromRGB(255,255,255), V.Value)
        )
        UIGradient_2.Parent = OWOGradient
        

        local HueTitle = Instance.new("TextLabel")
        HueTitle.Name = RandomCharacters(math.random(15, 25));
        HueTitle.Parent = ColorpickerTitle
        HueTitle.BackgroundColor3 = theme.LightContrast
        HueTitle.Position = UDim2.new(0.00370370364, 0, 1.31916296, 0)
        HueTitle.Size = UDim2.new(0, 25, 0, 20)
        HueTitle.Font = Enum.Font.PatrickHand
        HueTitle.Text = "H"
        HueTitle.TextColor3 = theme.TextColor
        HueTitle.TextSize = 25.000
        HueTitle.TextWrapped = true

        table.insert(objects.LightContrast, HueTitle)

        table.insert(objects.TextColor, HueTitle)
        
        local UICorner_4 = Instance.new("UICorner")
        UICorner_4.CornerRadius = UDim.new(0, 4)
        UICorner_4.Parent = HueTitle
        
        local SusTitle = Instance.new("TextLabel")
        SusTitle.Name = RandomCharacters(math.random(15, 25));
        SusTitle.Parent = ColorpickerTitle
        SusTitle.BackgroundColor3 = theme.LightContrast
        SusTitle.Position = UDim2.new(0.00370370364, 0, 2.31916285, 0)
        SusTitle.Size = UDim2.new(0, 25, 0, 20)
        SusTitle.Font = Enum.Font.PatrickHand
        SusTitle.Text = "S"
        SusTitle.TextColor3 = theme.TextColor
        SusTitle.TextSize = 25.000
        SusTitle.TextWrapped = true

        table.insert(objects.LightContrast, SusTitle)


        table.insert(objects.TextColor, SusTitle)
        
        local UICorner_5 = Instance.new("UICorner")
        UICorner_5.CornerRadius = UDim.new(0, 4)
        UICorner_5.Parent = SusTitle
        
        local BlackWhiteGradient = Instance.new("ImageButton")
        BlackWhiteGradient.Name = RandomCharacters(math.random(15, 25));
        BlackWhiteGradient.Parent = ColorpickerTitle
        BlackWhiteGradient.BackgroundTransparency = 1
        BlackWhiteGradient.Position = UDim2.new(0.239999995, 0, 3.31900001, 0)
        BlackWhiteGradient.Size = UDim2.new(0.889999986, 220, 0, 20)
        BlackWhiteGradient.Image = "rbxassetid://5554237731"
        BlackWhiteGradient.ImageRectOffset = Vector2.new(464, 4)
        BlackWhiteGradient.ImageRectSize = Vector2.new(36, 36)
        BlackWhiteGradient.ScaleType = Enum.ScaleType.Slice
        
        local UIGradient_3 = Instance.new("UIGradient")
        UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(1,1,1))}
        UIGradient_3.Parent = BlackWhiteGradient
        

        local VerTitle = Instance.new("TextLabel")
        VerTitle.Name = RandomCharacters(math.random(15, 25));
        VerTitle.Parent = ColorpickerTitle
        VerTitle.BackgroundColor3 = theme.LightContrast
        VerTitle.Position = UDim2.new(0.00370370364, 0, 3.28070116, 0)
        VerTitle.Size = UDim2.new(0, 25, 0, 20)
        VerTitle.Font = Enum.Font.PatrickHand
        VerTitle.Text = "V"
        VerTitle.TextColor3 = theme.TextColor
        VerTitle.TextSize = 25.000
        VerTitle.TextWrapped = true
        
        table.insert(objects.LightContrast, VerTitle)


        table.insert(objects.TextColor, VerTitle)

        local UICorner_7 = Instance.new("UICorner")
        UICorner_7.CornerRadius = UDim.new(0, 4)
        UICorner_7.Parent = VerTitle

        H:GetPropertyChangedSignal("Value"):Connect(function()
            ColorThing.BackgroundColor3 = Color3.fromHSV(H.Value,S.Value,V.Value)
            UIGradient_2.Color = ColorSequence.new(
                Color3.fromHSV(H.Value,1,V.Value), 
                Color3.fromRGB(0,0,0):Lerp(Color3.fromRGB(255,255,255),V.Value)
            )
            local color = Color3.fromHSV(H.Value,S.Value,V.Value)

            local r,g,b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)

            callback(color)
        end)

        S:GetPropertyChangedSignal("Value"):Connect(function()
            ColorThing.BackgroundColor3 = Color3.fromHSV(H.Value,S.Value,V.Value)
            UIGradient_2.Color = ColorSequence.new(
                Color3.fromHSV(H.Value,1,V.Value), 
                Color3.fromRGB(0,0,0):Lerp(Color3.fromRGB(255,255,255),V.Value)
            )
            local color = Color3.fromHSV(H.Value,S.Value,V.Value)

            local r,g,b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)

            callback(color)
        end)

        V:GetPropertyChangedSignal("Value"):Connect(function()
            ColorThing.BackgroundColor3 = Color3.fromHSV(H.Value,S.Value,V.Value)
            UIGradient_2.Color = ColorSequence.new(
                Color3.fromHSV(H.Value,1,V.Value), 
                Color3.fromRGB(0,0,0):Lerp(Color3.fromRGB(255,255,255),V.Value)
            )
            local color = Color3.fromHSV(H.Value,S.Value,V.Value)

            local r,g,b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)

            callback(color)
        end)

        RainbowGradient.MouseButton1Down:Connect(function()
            H.Value = 1 - GetXY(RainbowGradient)
            local MouseMove, MouseKill
            MouseMove = Mouse.Move:Connect(function()
                H.Value = 1 - GetXY(RainbowGradient)
            end)
            MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
                if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    MouseMove:Disconnect()
                    MouseKill:Disconnect()
                end
            end)
        end)

        BlackWhiteGradient.MouseButton1Down:Connect(function()
            V.Value = 1 - GetXY(RainbowGradient)
            local MouseMove, MouseKill
            MouseMove = Mouse.Move:Connect(function()
                V.Value = 1 - GetXY(RainbowGradient)
            end)
            MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
                if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    MouseMove:Disconnect()
                    MouseKill:Disconnect()
                end
            end)
        end)

        OWOGradient.MouseButton1Down:Connect(function()
            S.Value = 1 - GetXY(RainbowGradient)
            local MouseMove, MouseKill
            MouseMove = Mouse.Move:Connect(function()
                S.Value = 1 - GetXY(RainbowGradient)
            end)
            MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
                if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    MouseMove:Disconnect()
                    MouseKill:Disconnect()
                end
            end)
        end)



        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y)
    end

    function ScrambleNames(A)
        for i,v in pairs(A:GetDescendants()) do
            v.Name = RandomCharacters(math.random(15, 25));
        end
    end
    
    --ScrambleNames(VestraLib)

return tabcontent

    end

    return tabhold
end
return lib