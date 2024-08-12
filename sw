-- Get the player character
local character = game.Players.LocalPlayer.Character

-- Get the coordinates
local coords = {
CFrame.new(-59.5290947, 76.5237885, -43.702404, 1, 0, 0, 0, 1, 0, 0, 0, 1),
CFrame.new(-77.8893661, 47.9033508, 1361.71387, 1, 0, 0, 0, 1, 0, 0, 0, 1),
CFrame.new(51.7955399, 51.4295616, 2139.85278, 0.0957754925, 0.461788416, 0.881804109, 1.68558376e-08, 0.885876536, 0.46392107, 0.995402932, 0.0444322824, 0.0848452523)
}

-- Create a tween service
local tweenService = game:GetService("TweenService")

-- Function to fly to a coordinate
local function flyToCoord(coord)
-- Create a tween info
local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

-- Create a tween
local tween = tweenService:Create(character.HumanoidRootPart, tweenInfo, {CFrame = coord})

-- Play the tween
tween:Play()

-- Wait for the tween to finish
tween.Completed:Wait()
end

-- Noclip function
local Noclip = nil
local Clip = nil

function noclip()
Clip = false
local function Nocl()
if Clip == false and game.Players.LocalPlayer.Character ~= nil then
for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
if v:IsA('BasePart') and v.CanCollide then
v.CanCollide = false
end
end
end
wait(0.21) -- basic optimization
end
Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
if Noclip then Noclip:Disconnect() end
Clip = true
end

-- Toggle noclip mode on
noclip()

-- Fly to each coordinate
for _, coord in ipairs(coords) do
flyToCoord(coord)
wait(1) -- wait for 1 second
end

-- Toggle noclip mode off
clip()
