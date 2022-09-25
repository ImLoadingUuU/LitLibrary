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
local sus = 0
results = {}
function genareteData()
 local p = new("Frame",Lixby)
 local t = new("TextLabel",p)
 t.Size = UDim2.new(1,0,0.08,0)
 t.Text = "Suspicious List"
 t.Font = Enum.Font.GothamBlack
 t.TextScaled = true
 t.TextColor3 = Color3.new(255,255,255)
 t.BackgroundTransparency = 1
 p.Size = UDim2.new(0.8,0,0.8,0)
 p.AnchorPoint = Vector2.new(0.5,0.5)
 p.Position = UDim2.new(0.5,0,0.6,0)
 p.ZIndex = 99
 p.BackgroundColor3 = Color3.fromRGB(88,101,242)
 local sf = new("ScrollingFrame",p)
 sf.Parent = p
sf.AnchorPoint = Vector2.new(0.5,0.5)
 sf.Position = UDim2.new(0.5,0,0.6,0)
 sf.Size = UDim2.new(1,0,1,0)
 sf.BackgroundTransparency = 1
 new("UIListLayout").Parent = sf
  local function createTemplate(category,text)
    local template = new("Frame",sf)
 template.Size = UDim2.new(1,0,0.1,0)
 template.BackgroundColor3 = Color3.new(0,0,0)
 template.BackgroundTransparency = 0.1
 local templatetext = new("TextLabel",template)
 templatetext.Text = "( " .. category .. " ) " .. text 
 templatetext.Font = Enum.Font.GothamBlack
 templatetext.TextColor3 = Color3.new(255,255,255)
 templatetext.BackgroundTransparency = 1
 templatetext.Size = UDim2.new(1,0,0.5,0) 
 templatetext.TextScaled = true
 
  end
 new("UICorner").Parent = template
 new("UICorner").Parent = p
 for _,v in pairs(results) do
    createTemplate(v.type,v.name)
 end
 return p
end

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
        print("Done")
        if returnObject then
             return HttpService:JSONDecode(return_data)
        else 
             return return_data
        end
    else
        return true
    end
end

function updateTitle(text)
Lixby.Parent.TextLabel.Text = text
Lixby.Parent.TextLabel.Font = Enum.Font.SciFi
end
function iterPageItems(pages)
    return coroutine.wrap(function()
        local pagenum = 1
        while true do
            for _, item in ipairs(pages:GetCurrentPage()) do
                coroutine.yield(item, pagenum)
            end
            if pages.IsFinished then
                break
            end

            pages:AdvanceToNextPageAsync()
            pagenum = pagenum + 1
        end
    end)
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
print(pid)
local fr = Players:GetFriendsAsync(pid)
if Textbox.Text:lower():find("furry") then
 sus = sus + 1
 print("Username Include Furrys")
  updateTitle("Lixby Furry Detector 8.1 (Furrys:" .. sus .. ")")
  table.insert(results,{
         ["type"] = "username",
         ["name"] = Textbox.Text
       })
end

changeText("Preparing for Server..")

changeText("Checking Friends")

for i,v in iterPageItems(fr) do
  local uname = string.lower(i.Username)
   Textbox.Text = i.Username
   if uname:find("furry") or uname:find("fox") or uname:find("kaiju") then
       table.insert(results,{
         ["type"] = "friends",
         ["name"] = uname
       })
       sus = sus + 1
       updateTitle("Lixby Furry Detector 8.1 (Furrys:" .. sus .. ")")
   end
   wait(0.01)
end
print(#results)
changeText("UserID " .. pid)
changeText("Checking Profile....")
changeText("Checking Games...")

changeText("Checking Groups")
changeText("Complete Captcha...")
if sus == 0 then
 changeText("This user is not Furry!")
elseif sus == 1 then
 changeText("This user little bit chance is Furry!")
elseif sus >= 5 then
 changeText("This user maybe is Furry!")
elseif sus <= 4 then
 changeText("This user proably is Furry!")
elseif sus >= 10 then
 changeText("This user is Furry!")
end
local frame = genareteData()
frame.Position = UDim2.new(0.5,0,2,0)
coroutine.wrap(function()
TweenService:Create(frame,TI,{ ["Position"] = UDim2.new(0.5,0,0.6,0)}):Play()
end)()
wait(10)
  coroutine.wrap(function()
TweenService:Create(frame,TI,{ ["Position"] = UDim2.new(0.5,0,2,0)}):Play()
end)()
frame:Destroy()
results = {}
sus = 0
--
 TweenService:Create(Textbox,TI,{ ["Position"] = UDim2.new(0.5,0,0.5,0)}):Play()
coroutine.wrap(function()
TweenService:Create(Textbutton,TI,{ ["Position"] = UDim2.new(0.5,0,0.6,0)}):Play()
end)()



end)
