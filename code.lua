local s = createapp("Searchoo V1")
local t = new("TextBox")
local l = new("TextLabel")
local b = new("TextButton")
local k = new("TextBox")
local Http = GetService("HttpService")
function HttpRequest(url, give_response)
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
        return return_data
    else 
        return true
    end
end
function RequestSearch(args)
 local Window = createapp("Searchoo - New Search | " .. args .. " | Searchoo Season ID: " .. math.random(1,100000))
 local Title = new("TextLabel")
 local Description = new("TextLabel")
 local TextBox = new("TextBox")
 Title.Size = UDim2.new(1,0,0.1,0) 
 Title.TextScaled = true
 Title.Parent = Window
 Title.Position = UDim2.new(0.5,0,0.5,0) 
 Title.AnchorPoint = Vector2.new(0.5,0.5)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(255,255,255)
 Title.Text = "Connecting..."
 local template = "https://www.googleapis.com/customsearch/v1?cx=006414095369450443889:m2aush7jofk&key=%s&q=%s" 
 local url = string.format(template,k.Text,Http:UrlEncode(args))
 print("[Searchoo] [Reqeust] [GET] Sending request to " .. url)
 local res = HttpRequest(url)
 print("Decoding")
 local decode = Http:JSONDecode(res)
 print("Proccess")
 Title.Text = decode["items"][1]["title"]
 print("Getting Description")
 Description.Size = UDim2.new(1,0,0.3,0)
 Description.Position = UDim2.new(0.5,0,0.7,0)
 Description.AnchorPoint = Vector2.new(0.5,0.5)
 Description.BackgroundTransparency = 1
 Description.TextColor3 = Color3.new(255,255,255)
 Description.Parent = Window
 Description.Text = decode["items"][1]["snippet"]
 Description.TextScaled = true
 TextBox.AnchorPoint = Vector2.new(0.5,0.5)
 TextBox.Size = UDim2.new(1,0,0.1,0)
 TextBox.Position = UDim2.new(0.5,0,0.1,0)
 TextBox.Text =  decode["items"][1]["link"]
 TextBox.Parent = Window
 TextBox.TextScaled = true
 TextBox.ClearTextOnFocus = false
end
t.Parent = s
t.PlaceholderText = "Searchoo,Search everything in world." 
t.Text = ""
t.AnchorPoint = Vector2.new(0.5,0.5)
t.Position = UDim2.new(0.5,0,0.5,0) 
t.Size = UDim2.new(0.9,0,0.1,0)
t.TextScaled = true
t.PlaceholderColor3 = Color3.new(0,0,0)
--[[Searchoo Logo Render]]--
l.Text = "Searchoo!"
l.Parent = s
l.AnchorPoint = Vector2.new(0.5,0.5)
l.Position = UDim2.new(0.5,0,0.35,0)
l.Size = UDim2.new(0.9,0,0.2,0)
l.BackgroundTransparency = 1
l.TextScaled = true
l.TextColor3 = Color3.new(255,255,255)
--[[Searchoo Button]]--
b.Text = "Bing it"
b.Parent = s
b.AnchorPoint = Vector2.new(0.5,0.5)
b.Position = UDim2.new(0.5,0,0.65,0)
b.Size = UDim2.new(0.7,0,0.1,0)
b.BackgroundTransparency = 0
b.TextScaled = true
b.TextColor3 = Color3.new(0,0,0)
b.Activated:Connect(function()
print("Connecting to Searchoo")
RequestSearch(t.Text)
end)
--[[API Key Selection]]--
k.Size = UDim2.new(1,0,0.05,0)
k.PlaceholderText = "Custom Search API Key"
k.Text = ""
k.PlaceholderColor3 = Color3.new(0,0,0)
k.Parent = s
k.TextScaled = true
--[[Font Config]]--
t.Font = Enum.Font.SourceSans
k.Font = Enum.Font.SourceSans
l.Font = Enum.Font.SourceSans
