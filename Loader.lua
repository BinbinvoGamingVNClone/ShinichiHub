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
