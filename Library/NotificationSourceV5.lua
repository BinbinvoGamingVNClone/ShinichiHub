local LibraryName = "Notification Library"
local NotificationLibrary = {}
local TweenService = game:GetService("TweenService")
local CoreGui = cloneref(game:GetService("CoreGui"))
local library
local templateFolder
local canvas

function NotificationLibrary:Load()
    library = game:GetObjects("rbxassetid://15133757123")[1]
    templateFolder = library.Templates
    canvas = library.list
    library.Name = LibraryName
    library.Parent = CoreGui
end

function NotificationLibrary:SendNotification(Mode, Text, Duration)
    local libaryCore = CoreGui:FindFirstChild(LibraryName)
    if not libaryCore then
        NotificationLibrary:Load()
    else
        library = libaryCore
        templateFolder = library.Templates
        canvas = library.list
    end

    if string.find(Mode, "rbxassetid://") then
        task.spawn(function()
            local success, err = pcall(function()
                local Notification = Instance.new("Frame")
                Notification.Size = UDim2.new(0, 0, 0.1, 0)
                Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Notification.Parent = canvas

                local ImageLabel = Instance.new("ImageLabel")
                ImageLabel.Size = UDim2.new(1, 0, 1, 0)
                ImageLabel.Image = Mode
                ImageLabel.Parent = Notification

                local T1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local T2 = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local T3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                
                TweenService:Create(Notification, T1, {Size = UDim2.new(1, 0, 0.1, 0)}):Play()
                task.wait(Duration)
                TweenService:Create(Notification, T3, {Size = UDim2.new(0, 0, 0.1, 0)}):Play()
                task.wait(0.3)
                Notification:Destroy()
            end)
            if not success then
                warn("Error while creating image notification!")
                warn(err)
            end
        end)
    elseif templateFolder:FindFirstChild(Mode) then
        task.spawn(function()
            local success, err = pcall(function()
                local Notification = templateFolder:WaitForChild(Mode):Clone()
                local filler = Notification.Filler
                local bar = Notification.bar
                Notification.Header.Text = Text
                
                Notification.Visible = true
                Notification.Parent = canvas
    
                Notification.Size = UDim2.new(0, 0, 0.087, 0)
                filler.Size = UDim2.new(1, 0, 1, 0)
        
                local T1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local T2 = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local T3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            
                TweenService:Create(Notification, T1, {Size = UDim2.new(1, 0, 0.087, 0)}):Play()
                task.wait(0.2)
                TweenService:Create(filler, T3, {Size = UDim2.new(0.011, 0, 1, 0)}):Play()
            
                TweenService:Create(bar, T2, {Size = UDim2.new(1, 0, 0.05, 0)}):Play()
            
                task.wait(Duration)
            
                TweenService:Create(filler, T1, {Size = UDim2.new(1, 0, 1, 0)}):Play()
                task.wait(0.25)
                TweenService:Create(Notification, T3, {Size = UDim2.new(0, 0, 0.087, 0)}):Play()
                task.wait(0.25)
                Notification:Destroy()
            end)
            if not success then
                warn("There was an error while trying to create a notification!")
                warn(err)
            end
        end)
    else
        warn("Invalid theme applied")
    end
end

return NotificationLibrary
