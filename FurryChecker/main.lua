--[[
Furry Detector v1

]]--
local Lixby = createapp("Lixby Furry Detector 8.1 Pro")
Lixby.ClipsDescendants = true
local LocalPlayer = GetService("Players").LocalPlayer.UserId
print("Registered " .. LocalPlayer .. " To LixbyInternet")
local Players = GetService("Players")
local TweenService = GetService("TweenService")
local TI = TweenInfo.new(2,Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
local Textbox = new("TextBox",Lixby)
local Textbutton = new("TextButton",Lixby)
local shakeIntensity = 5
-- give me credit or your liver
function HttpRequest(url, give_response,returnObject)
    -- REMOVE THIS AND I WILL KILL YOU
    if string.find(url, "LimeOS-appstore-api", 1, true) then return "no." end
    local remoteEvent = GetService("ReplicatedStorage"):WaitForChild(
                            "HttpRequest")
    local HttpService = GetService("HttpService")
    remoteEvent:FireServer(true, url, false)
    if give_response == true or give_response == nil then
        local disconnect
        local return_data
        disconnect = remoteEvent.OnClientEvent:Connect(
                         function(data, is_app, is_site)
                if is_app == false then return end
                if is_site == true then return end
                if disconnect then disconnect:Disconnect() end
                return_data = data
            end)
        while wait() do if return_data then break end end
        if returnObject then
             return HttpService:JSONDecode(return_data)
        else 
             return
        end
    else
        return true
    end
end

function updateTitle(text)
Lixby.Parent.TextLabel.Text = text
Lixby.Parent.TextLabel.Font = Enum.Font.SciFi
end

updateTitle("Lixby Furry Detector 8.1")
-- Object Configuration
Textbox.BackgroundTransparency = 1
Textbox.Font = Enum.Font.Gotham
Textbox.PlaceholderText = "Enter the username?"
Textbox.TextColor3 = Color3.new(255,255,255)
Textbox.PlaceholderColor3 = Color3.new(255,255,255)
Textbox.AnchorPoint = Vector2.new(0.5,0.5)
Textbox.Position = UDim2.new(0.5,0,0.5,0)
Textbox.Size = UDim2.new(1,0,0.1,0)
Textbox.Text = ""
Textbox.TextScaled = true
Textbutton.AnchorPoint = Vector2.new(0.5,0.5)
Textbutton.Position = UDim2.new(0.5,0,0.6,0)
Textbutton.Size = UDim2.new(0.6,0,0.1,0)
Textbutton.Font = Enum.Font.Gotham
Textbutton.BackgroundColor3= Color3.fromRGB(0,75,160)
Textbutton.TextColor3 = Color3.new(255,255,255)
Textbutton.TextScaled=  true
Textbutton.Text = "Ask Me Everything"
Textbox.ClearTextOnFocus = false
new("UICorner").Parent = Textbutton
function changeText(text)
TweenService:Create(Textbox,TI,{ ["TextTransparency"] = 1}):Play()
wait(2)
Textbox.Text = text
TweenService:Create(Textbox,TI,{ ["TextTransparency"] = 0}):Play()
wait(2)
end

Textbutton.Activated:Connect(function()
local OrgText = Textbox.Text
if OrgText == "" then
 
return
end


 TweenService:Create(Textbox,TI,{ ["Position"] = UDim2.new(0.5,0,0.3,0)}):Play()
coroutine.wrap(function()
TweenService:Create(Textbutton,TI,{ ["Position"] = UDim2.new(0.5,0,2,0)}):Play()
end)()
local pid = Players:GetUserIdFromNameAsync(Textbox.Text)
local Request = HttpRequest("https://friends.roblox.com/v1/users/" .. pid .. "/friends"
changeText("Preparing for Server..")
wait(1)
changeText("Checking Friends")
for i = 1,#Request.data do
 wait(0.1)
 Textbox.Text = #Request.data[i].name
end
changeText("UserID " .. pid)
changeText("Checking Profile....")
changeText("Checking Games...")

changeText("Checking Groups")
changeText("Complete Captcha...")

local msg = GetService("HttpServic"):UrlEncode(OrgText)
print(msg)
 TweenService:Create(Textbox,TI,{ ["Position"] = UDim2.new(0.5,0,0.5,0)}):Play()
coroutine.wrap(function()
TweenService:Create(Textbutton,TI,{ ["Position"] = UDim2.new(0.5,0,0.6,0)}):Play()
end)()



end)
