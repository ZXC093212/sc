-- Get the player character
local character = game.Players.LocalPlayer.Character

-- Get the coordinates
local coords1 = CFrame.new(-59.5290947, 76.5237885, -43.702404, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local coords2 = CFrame.new(-77.8893661, 47.9033508, 1361.71387, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local coords3 = CFrame.new(51.7955399, 51.4295616, 2139.85278, 0.0957754925, 0.461788416, 0.881804109, 1.68558376e-08, 0.885876536, 0.46392107, 0.995402932, 0.0444322824, 0.0848452523)

-- Function to fly to a coordinate
local function flyToCoord(coord)
-- Toggle noclip mode on
noclip()

-- Create a BodyPosition object
local bodyPosition = Instance.new("BodyPosition")
bodyPosition.Parent = character.HumanoidRootPart

-- Create a BodyGyro object
local bodyGryo = Instance.new("BodyGyro")
bodyGryo.Parent = character.HumanoidRootPart

-- Set the BodyPosition's position to the coordinate's position
bodyPosition.Position = coord.Position

-- Set the BodyGryo's maxTorque to a high value
bodyGryo.MaxTorque = Vector3.new(1000, 1000, 1000)

-- Smoothly move to the coordinate
local distance = (character.HumanoidRootPart.Position - coord.Position).magnitude
local speed = 50
local time = distance / speed
local startTime = tick()
while tick() - startTime < time do
-- Calculate the position of the character
local position = character.HumanoidRootPart.Position:Lerp(coord.Position, (tick() - startTime) / time)
character.HumanoidRootPart.CFrame = CFrame.new(position)
wait(0.01)
end

-- Braking mechanism
local brakingDistance = 5
while (character.HumanoidRootPart.Position - coord.Position).magnitude > brakingDistance do
-- Calculate the position of the character
local position = character.HumanoidRootPart.Position:Lerp(coord.Position, (character.HumanoidRootPart.Position - coord.Position).magnitude / brakingDistance)
character.HumanoidRootPart.CFrame = CFrame.new(position)
wait(0.01)
end

-- Wait for 1 second
wait(1)

-- Remove the BodyPosition and BodyGryo objects
bodyPosition:Destroy()

bodyGryo:Destroy()
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

-- Fly to the first coordinate
flyToCoord(coords1)

-- Fly to the second coordinate
flyToCoord(coords2)

-- Fly to the third coordinate
flyToCoord(coords3)
