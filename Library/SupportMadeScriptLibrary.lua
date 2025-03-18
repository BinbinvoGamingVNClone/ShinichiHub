local ShinichiMadeScriptLibrary = {}

function ShinichiMadeScriptLibrary:Kick(Content)
    game.Players.LocalPlayer:Kick(Content)
end

function ShinichiMadeScriptLibrary:Notification(type, message, Time)
    local NotificationLibrary = loadstring(game:HttpGet("https://shinichihub.vercel.app/Library/NotificationLibraryV5.lua",true))()
    NotificationLibrary:SendNotification(type, message, Time)
end

function ShinichiMadeScriptLibrary:CopyCFrame()
    setclipboard(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position))
end

function ShinichiMadeScriptLibrary:SetClipBoard(Content)
    setclipboard(Content)
end
