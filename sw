-- Get the player character
local character = game.Players.LocalPlayer.Character

-- Get the coordinates
local coords = {
CFrame.new(-59.5290947, 76.5237885, -43.702404, 1, 0, 0, 0, 1, 0, 0, 0, 1),
CFrame.new(-77.8893661, 47.9033508, 1361.71387, 1, 0, 0, 0, 1, 0, 0, 0, 1),
CFrame.new(-37.6384048, 63.0563698, 2134.92798, 1, 0, 0, 0, 1, 0, 0, 0, 1),
CFrame.new(-58.9824028, 63.9899483, 2909.11938, 1, 0, 0, 0, 1, 0, 0, 0, 1)
}

-- Create a tween service
local tweenService = game:GetService("TweenService")

-- Function to fly to a coordinate
local function flyToCoord(coord)
print("Flying to coordinate:", coord)
-- Create a tween info
local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

-- Get the current position
local startPos = character.HumanoidRootPart.Position

-- Calculate the direction to the coordinate
local direction = (coord.p - startPos).unit

-- Set the character's velocity
character.HumanoidRootPart.Velocity = direction * 50

-- Create a tween
local tween = tweenService:Create(character.HumanoidRootPart, tweenInfo, {
CFrame = coord
})

-- Play the tween
tween:Play()

-- Wait for the tween to finish
wait(5) -- wait for 5 seconds
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
end

-- Toggle noclip mode off
clip()
