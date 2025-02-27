local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo hiệu ứng Blur
local Blur = Instance.new("BlurEffect")
Blur.Size = 30
Blur.Parent = game.Lighting
Blur.Enabled = true

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui

-- Tạo ImageLabel (Logo)
local Logo = Instance.new("ImageLabel")
Logo.Parent = ScreenGui
Logo.Size = UDim2.new(0, 150, 0, 150) -- Kích thước logo
Logo.Position = UDim2.new(0.5, -75, 0.4, -75) -- Ở giữa màn hình
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://78774998900413" -- Thay YOUR_LOGO_ID bằng ID ảnh logo

-- Bo tròn logo
local UICorner = Instance.new("UICorner", Logo)
UICorner.CornerRadius = UDim.new(1, 0) -- Bo tròn 100%

-- Tạo TextLabel (Chữ Welcome)
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Parent = ScreenGui
WelcomeText.Size = UDim2.new(0, 300, 0, 50)
WelcomeText.Position = UDim2.new(0.5, -150, 0.55, 0) -- Ngay dưới logo
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = "Welcome To Shinichi Hub"
WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeText.TextScaled = true
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextTransparency = 1 -- Ẩn hoàn toàn

-- Xoay logo 1 vòng trong 0.8 giây
local TweenService = game:GetService("TweenService")
local RotateInfo = TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local RotateGoal = {Rotation = 360}
local RotateTween = TweenService:Create(Logo, RotateInfo, RotateGoal)

RotateTween:Play()
RotateTween.Completed:Wait() -- Đợi xoay xong

-- Hiện chữ từ từ ngay dưới logo
local TextTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TextGoal = {TextTransparency = 0} -- Dần hiện rõ
local TextTween = TweenService:Create(WelcomeText, TextTweenInfo, TextGoal)
TextTween:Play()
wait(1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
wait(0.1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
wait(0.1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
wait(0.1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
wait(0.1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
wait(0.1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
wait(0.1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
wait(0.1)
WelcomeText.Text = "Loading."
wait(0.1)
WelcomeText.Text = "Loading.."
wait(0.1)
WelcomeText.Text = "Loading..."
Blur.Enabled = false
WelcomeText.Visible = false
Logo.Visible = false
if getgenv().UserID == "" then
    game.Players.LocalPlayer:Kick("Pls Input Your ID Discord User! ")
elseif not getgenv().UserID then
        game.Players.LocalPlayer:Kick("Can Not Find User Discord ID!")
elseif getgenv().BloxFruitsMode == "Find Fruits" then
            _G.AutoStoreFruit, _G.MaxStoreAttempts = true, 5  
            local c = 0  
            function S() if c < _G.MaxStoreAttempts then  
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit") c = c + 1  
            end end  
            if _G.AutoStoreFruit then for i = 1, _G.MaxStoreAttempts do task.wait(1) S() end end  
        loadstring(game:HttpGet("https://raw.githubusercontent.com/shinichidz/EzFruit/refs/heads/main/ShinichiHub"))()
        elseif getgenv().BloxFruitsMode == "Main" then
            loadstring(game:HttpGet("https://shinichihub.vercel.app/main.bloxfruits.lua",true))()
        elseif getgenv().BloxFruitsMode == "" then
            game.Players.LocalPlayer:Kick("Pls Select Blox Fruits Mode!")
        end
