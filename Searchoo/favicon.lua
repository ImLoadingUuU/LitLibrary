--[[
Searchoo Favicon Renderer Beta
==========================
Original:
https://github.com/isLenk/Roblox-Image-Loader/
]]--
local callFormat = "ServerURL Here "
local HttpService = GetService("HttpRequest")
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
--[[
_G.pixelLength = 3
_G.forceQuit = false
_G.dimensions = {250, 250}
]]

_G.dimensionLimit = 200 * 200
function convertHexToRGB(hexString)
	-- Remove the hashtag
	hexString = hexString:sub(2)

	local r = tonumber('0x' .. hexString:sub(1, 2))
	local g = tonumber('0x' .. hexString:sub(3, 4))
	local b = tonumber('0x' .. hexString:sub(5, 6))
	
	return Color3.fromRGB(r, g, b)
end

function draw(imageData, width, height,GuiPoint) 
	
	local lastUI = GuiPoint
	
	if lastUI then
		lastUI:Destroy()
	end
	
	
	local drawUI = GuiPoint
	
	local slowMode = (tonumber(width*height) > _G.dimensionLimit)
	
	local imageSize = Instance.new("Frame")
	imageSize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageSize.BorderSizePixel = 0
	imageSize.Position = UDim2.new(0, 0, 0, 0)
	imageSize.Size = UDim2.new(0,_G.pixelLength * width,0,_G.pixelLength * height)
	imageSize.Parent = drawUI
	
	for column = 1, width do
		
		spawn(function()
			local cellData = {}
			local rowBackground = Instance.new("Frame")
			rowBackground.BackgroundColor3 = Color3.fromRGB(150,150,150)
			rowBackground.BorderSizePixel = 0
			rowBackground.Position = UDim2.new(0, 0, 0, _G.pixelLength * (column-1))
			rowBackground.Size = UDim2.new(0,_G.pixelLength,0,_G.pixelLength)
			rowBackground.Parent = drawUI
			local rawRowImageData = imageData:sub(1, 7*width)
			imageData = imageData:sub(7*width + 1)
			for row = 1, height do
				--local cellEndIndex = column * row * 7
				--local cellStartIndex = cellEndIndex - 6
				--local hexColorString = imageData:sub(cellStartIndex, cellEndIndex)
				local hexColorString = rawRowImageData:sub(1, 7)
				rawRowImageData = rawRowImageData:sub(8)
				local frame = Instance.new("Frame")
				frame.BorderSizePixel = 0
				frame.Size = UDim2.new(0, _G.pixelLength, 0, _G.pixelLength)
				frame.Position = UDim2.new(0, _G.pixelLength * column, 0, _G.pixelLength * row)
				frame.BackgroundColor3 = convertHexToRGB(hexColorString)
				frame.ZIndex = 2
				table.insert(cellData, frame)
				
				rowBackground.Size = UDim2.new(0, _G.pixelLength * row, 0, _G.pixelLength)
				
				if slowMode then
					wait()
				end
				
				if (drawUI.Parent ~= game.StarterGui) then
					print("Parent is nil. Quitting...")
					print("Ended on " .. row)
					return
				end
			end
			
			print(("Column #%s complete"):format(column))
			
			for _, cell in pairs(cellData) do
				cell.Parent = drawUI
			end
		end)
		
	end
end

function request(imageURL, imageWidth, imageHeight)
	--local encodedURL = game.HttpService:UrlEncode(callFormat:format(imageURL, imageWidth, imageHeight))
	print("Sending Request...")
	local returnData
	
	if not (pcall(function()
				returnData = HttpRequest(callFormat:format(imageURL, imageWidth, imageHeight))
	end)) then
		error("Could not connect to API. Check if the python file is running.")
	end
			
		
	print("Response Received...")
	local decoded = HttpService:JSONDecode(returnData):gsub("\n", "")
	print("Beginning Draw...")
	draw(decoded, imageWidth, imageHeight)
end


request(
	_G.imageUrl,
	_G.dimensions[1], _G.dimensions[2])

