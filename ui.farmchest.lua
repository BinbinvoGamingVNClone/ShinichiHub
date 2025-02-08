local UserInputService = game:GetService("UserInputService")
 local TweenService = game:GetService("TweenService")
 local LocalPlayer = game:GetService("Players").LocalPlayer
 local Mouse = LocalPlayer:GetMouse()
 local CoreGui = LocalPlayer.PlayerGui 
 local function MakeDraggable(topbarobject, object)
     local function CustomPos(topbarobject, object)
         local Dragging = nil
         local DragInput = nil
         local DragStart = nil
         local StartPosition = nil
 
         local function UpdatePos(input)
             local Delta = input.Position - DragStart
             local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
             local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
             Tween:Play()
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
             if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                 DragInput = input
             end
         end)
 
         UserInputService.InputChanged:Connect(function(input)
             if input == DragInput and Dragging then
                 UpdatePos(input)
             end
         end)
     end
     local function CustomSize(object)
         local Dragging = false
         local DragInput = nil
         local DragStart = nil
         local StartSize = nil
         local maxSizeX = object.Size.X.Offset
         local maxSizeY = object.Size.Y.Offset
         object.Size = UDim2.new(0, maxSizeX, 0, maxSizeY)
         local changesizeobject = Instance.new("Frame");
 
         changesizeobject.AnchorPoint = Vector2.new(1, 1)
         changesizeobject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         changesizeobject.BackgroundTransparency = 0.9990000128746033
         changesizeobject.BorderColor3 = Color3.fromRGB(0, 0, 0)
         changesizeobject.BorderSizePixel = 0
         changesizeobject.Position = UDim2.new(1, 20, 1, 20)
         changesizeobject.Size = UDim2.new(0, 40, 0, 40)
         changesizeobject.Name = "changesizeobject"
         changesizeobject.Parent = object
 
         local function UpdateSize(input)
             local Delta = input.Position - DragStart
             local newWidth = StartSize.X.Offset + Delta.X
             local newHeight = StartSize.Y.Offset + Delta.Y
             newWidth = math.max(newWidth, maxSizeX)
             newHeight = math.max(newHeight, maxSizeY)
             local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Size = UDim2.new(0, newWidth, 0, newHeight)})
             Tween:Play()
         end
 
         changesizeobject.InputBegan:Connect(function(input)
             if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                 Dragging = true
                 DragStart = input.Position
                 StartSize = object.Size
                 input.Changed:Connect(function()
                     if input.UserInputState == Enum.UserInputState.End then
                         Dragging = false
                     end
                 end)
             end
         end)
 
         changesizeobject.InputChanged:Connect(function(input)
             if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                 DragInput = input
             end
         end)
 
         UserInputService.InputChanged:Connect(function(input)
             if input == DragInput and Dragging then
                 UpdateSize(input)
             end
         end)
     end
     CustomSize(object)
     CustomPos(topbarobject, object)
 end
 local Shinichi = {}
 function Shinichi:Notify(NotifyConfig)
     local NotifyConfig = NotifyConfig or {}
     NotifyConfig.Title = NotifyConfig.Title or "Alert"
     NotifyConfig.Content = NotifyConfig.Content or "Content"
     NotifyConfig.Logo = NotifyConfig.Logo or "rbxassetid://18289959127"
     NotifyConfig.Time = NotifyConfig.Time or 0.5
     NotifyConfig.Delay = NotifyConfig.Delay or 5
     local NotifyFunc = {}
     spawn(function()
         if not CoreGui:FindFirstChild("NotifyGui") then
             local NotifyGui = Instance.new("ScreenGui");
             NotifyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
             NotifyGui.Name = "NotifyGui"
             NotifyGui.Parent = CoreGui
         end
         if not CoreGui.NotifyGui:FindFirstChild("NotifyLayout") then
             local NotifyLayout = Instance.new("Frame");
             NotifyLayout.AnchorPoint = Vector2.new(1, 0)
             NotifyLayout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
             NotifyLayout.BackgroundTransparency = 0.9998999834060669
             NotifyLayout.BorderColor3 = Color3.fromRGB(0, 0, 0)
             NotifyLayout.BorderSizePixel = 0
             NotifyLayout.Position = UDim2.new(1, -10, 0, 10)
             NotifyLayout.Size = UDim2.new(0, 260, 1, -20)
             NotifyLayout.Name = "NotifyLayout"
             NotifyLayout.Parent = CoreGui.NotifyGui	
             local Count = 0
             local Count2 = 0
             CoreGui.NotifyGui.NotifyLayout.ChildRemoved:Connect(function()
                 Count = 0
                 for i, v in CoreGui.NotifyGui.NotifyLayout:GetChildren() do
                     TweenService:Create(
                         v,
                         TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                         {Position = UDim2.new(0, 0, 0, (v.Size.Y.Offset + 12)*Count)}
                     ):Play()
                     Count = Count + 1
                 end
             end)
             CoreGui.NotifyGui.NotifyLayout.ChildAdded:Connect(function(child)
                 Count2 = 1
                 for i, v in CoreGui.NotifyGui.NotifyLayout:GetChildren() do
                     if v ~= child then
                         TweenService:Create(
                             v,
                             TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                             {Position = UDim2.new(0, 0, 0, (v.Size.Y.Offset + 12)*Count2)}
                         ):Play()
                         Count2 = Count2 + 1
                     end
                 end
             end)
         end
         local NotifyFrame = Instance.new("Frame");
         local NotifyFrameReal = Instance.new("Frame");
         local UICorner = Instance.new("UICorner");
         local DropShadowHolder = Instance.new("Frame");
         local DropShadow = Instance.new("ImageLabel");
         local NotifyLogo = Instance.new("ImageLabel");
         local UICorner1 = Instance.new("UICorner");
         local NotifyTitle = Instance.new("TextLabel");
         local NotifyContent = Instance.new("TextLabel");
         local UIStroke = Instance.new("UIStroke");
         local AlertImage = Instance.new("ImageLabel");
 
         NotifyFrame.BackgroundColor3 = Color3.fromRGB(30.00000011175871, 30.00000011175871, 30.00000011175871)
         NotifyFrame.BackgroundTransparency = 0.999
         NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
         NotifyFrame.BorderSizePixel = 0
         NotifyFrame.Size = UDim2.new(1, 0, 0, 70)
         NotifyFrame.Name = "NotifyFrame"
         NotifyFrame.Parent = CoreGui.NotifyGui.NotifyLayout
         NotifyFrame.Position = UDim2.new(0, 0, 0, 0)
 
         NotifyFrameReal.BackgroundColor3 = Color3.fromRGB(30.00000011175871, 30.00000011175871, 30.00000011175871)
         NotifyFrameReal.BorderColor3 = Color3.fromRGB(0, 0, 0)
         NotifyFrameReal.BorderSizePixel = 0
         NotifyFrameReal.Position = UDim2.new(0, 270, 0, 0)
         NotifyFrameReal.Size = UDim2.new(1, 0, 1, 0)
         NotifyFrameReal.Name = "NotifyFrameReal"
         NotifyFrameReal.Parent = NotifyFrame
 
         UICorner.CornerRadius = UDim.new(0, 5)
         UICorner.Parent = NotifyFrameReal
 
         DropShadowHolder.BackgroundTransparency = 1
         DropShadowHolder.BorderSizePixel = 0
         DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
         DropShadowHolder.ZIndex = 0
         DropShadowHolder.Name = "DropShadowHolder"
         DropShadowHolder.Parent = NotifyFrameReal
 
         DropShadow.Image = "rbxassetid://6015897843"
         DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
         DropShadow.ImageTransparency = 0.5
         DropShadow.ScaleType = Enum.ScaleType.Slice
         DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
         DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
         DropShadow.BackgroundTransparency = 1
         DropShadow.BorderSizePixel = 0
         DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
         DropShadow.Size = UDim2.new(1, 47, 1, 47)
         DropShadow.ZIndex = 0
         DropShadow.Name = "DropShadow"
         DropShadow.Parent = DropShadowHolder
 
         NotifyLogo.Image = NotifyConfig.Logo
         NotifyLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         NotifyLogo.BackgroundTransparency = 0.9990000128746033
         NotifyLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
         NotifyLogo.BorderSizePixel = 0
         NotifyLogo.AnchorPoint = Vector2.new(0, 0.5)
         NotifyLogo.Position = UDim2.new(0, 12, 0.5, 0)
         NotifyLogo.Size = UDim2.new(0, 45, 0, 45)
         NotifyLogo.Name = "NotifyLogo"
         NotifyLogo.Parent = NotifyFrameReal
 
         UICorner1.CornerRadius = UDim.new(1, 0)
         UICorner1.Parent = NotifyLogo
 
         NotifyTitle.Font = Enum.Font.GothamBold
         NotifyTitle.Text = NotifyConfig.Title
         NotifyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
         NotifyTitle.TextSize = 12
         NotifyTitle.TextXAlignment = Enum.TextXAlignment.Left
         NotifyTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         NotifyTitle.BackgroundTransparency = 0.9990000128746033
         NotifyTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
         NotifyTitle.BorderSizePixel = 0
         NotifyTitle.Position = UDim2.new(0, 69, 0, 15)
         NotifyTitle.Size = UDim2.new(1, -140, 0, 14)
         NotifyTitle.Name = "NotifyTitle"
         NotifyTitle.Parent = NotifyFrameReal
 
         NotifyContent.Font = Enum.Font.Gotham
         NotifyContent.Text = NotifyConfig.Content
         NotifyContent.TextColor3 = Color3.fromRGB(80.00000283122063, 80.00000283122063, 80.00000283122063)
         NotifyContent.TextSize = 12
         NotifyContent.TextTransparency = 0.30000001192092896
         NotifyContent.TextXAlignment = Enum.TextXAlignment.Left
         NotifyContent.TextYAlignment = Enum.TextYAlignment.Top
         NotifyContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         NotifyContent.BackgroundTransparency = 0.9990000128746033
         NotifyContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
         NotifyContent.BorderSizePixel = 0
         NotifyContent.Position = UDim2.new(0, 69, 0, 29)
         NotifyContent.Size = UDim2.new(1, -140, 0, 24)
         NotifyContent.Name = "NotifyContent"
         NotifyContent.Parent = NotifyFrameReal
 
         UIStroke.Color = Color3.fromRGB(80.00000283122063, 80.00000283122063, 80.00000283122063)
         UIStroke.Thickness = 0.30000001192092896
         UIStroke.Parent = NotifyContent
 
         AlertImage.Image = "rbxassetid://18289906180"
         AlertImage.AnchorPoint = Vector2.new(1, 0.5)
         AlertImage.ImageColor3 = Color3.fromRGB(28.000000230968, 12.000000234693289, 143.00000667572021)
         AlertImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         AlertImage.BackgroundTransparency = 0.9990000128746033
         AlertImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
         AlertImage.BorderSizePixel = 0
         AlertImage.Position = UDim2.new(1, -12, 0.5, 0)
         AlertImage.Size = UDim2.new(0, 45, 0, 45)
         AlertImage.Parent = NotifyFrameReal
 
         NotifyContent.Size = UDim2.new(1, -140, 0, 12 + (12 * (NotifyContent.TextBounds.X // NotifyContent.AbsoluteSize.X)))
         NotifyContent.TextWrapped = true
         if NotifyContent.AbsoluteSize.Y < 25 then
             NotifyFrame.Size = UDim2.new(1, 0, 0, 70)
         else
             NotifyFrame.Size = UDim2.new(1, 0, 0, NotifyFrame.AbsoluteSize.Y + 17)
         end
         local waitclose = false
         function NotifyFunc:Close()
             if waitclose then
                 return false
             end
             waitclose = true
             TweenService:Create(
                 NotifyFrameReal,
                 TweenInfo.new(tonumber(NotifyConfig.Time), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                 {Position = UDim2.new(0, 270, 0, 0)}
             ):Play()
             task.wait(tonumber(NotifyConfig.Time) / 1.2)
             NotifyFrame:Destroy()
         end
         TweenService:Create(
             NotifyFrameReal,
             TweenInfo.new(tonumber(NotifyConfig.Time), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
             {Position = UDim2.new(0, 0, 0, 0)}
         ):Play()
         task.wait(tonumber(NotifyConfig.Delay))
         NotifyFunc:Close()
     end)
     return NotifyFunc
 end
 
