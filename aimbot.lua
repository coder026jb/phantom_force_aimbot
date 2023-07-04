-- Silent aim and ESP settings
local FOV = 200
local HIT_PARTS = { "Head" }
local HIT_PART = "Head"

-- Rapid Fire settings
local FIRE_DELAY = 0.1 -- Adjust this value to set the delay between shots

-- Variables
local camera = workspace.CurrentCamera
local players = workspace:WaitForChild("Players")
local localPlayer = game:GetService("Players").LocalPlayer

-- Functions
local function getFirearm()
    for _, child in camera:GetChildren() do
        if child:FindFirstChild("Trigger") then
            return child
        end
    end
end

local function getEnemyTeam()
    for _, team in pairs(players:GetChildren()) do
        if team.Name ~= localPlayer.TeamColor.Name then
            return team
        end
    end
end

local function getClosest()
    local _hitPart
    local _angle = math.rad(FOV * 0.5)
    for _, character in pairs(getEnemyTeam():GetChildren()) do
        local hitPart = character:FindFirstChild(HIT_PARTS[math.random(1, #HIT_PARTS)])
        if not hitPart then
            continue
        end

        local vector = (hitPart.Position - camera.CFrame.Position).Unit
        local angle = math.acos(camera.CFrame.LookVector:Dot(vector))
        if angle < _angle then
            _hitPart = hitPart
            _angle = angle
        end
    end
    return _hitPart
end

-- Silent aim
game:GetService("RunService").Stepped:Connect(function()
    local firearm = getFirearm()
    local hitPart = firearm and getClosest()
    if not hitPart then
        return
    end

    for _, part in pairs(firearm:GetChildren()) do
        local isAimPart = part.Name == "Flame" or string.find(part.Name, "SightMark")
        local weld = isAimPart and part:GetJoints()[1]
        if weld then
            weld.C0 = weld.Part0.CFrame:ToObjectSpace(
                CFrame.lookAt(weld.Part1.Position, hitPart.Position)
            )
        end
    end
end)

-- ESP
while true do
    wait(1)

    for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "Box" then
            v:Destroy()
        end
    end

    for _, team in pairs(game:GetService("Workspace").Players:GetChildren()) do
        for _, v in pairs(team:GetChildren()) do
            if v:FindFirstChild("Torso") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "Box"
                box.Adornee = v.Torso
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = v.Torso.Size * Vector3.new(1.6, 3, 1.6)
                box.Transparency = 0.5
                box.Color = BrickColor.new(team.Name)
                box.Parent = game:GetService("CoreGui")
            end
        end
    end
end

-- Rapid Fire
local function rapidFire()
    local firearm = getFirearm()
    if not firearm then
        return
    end

    local remote = firearm:FindFirstChildOfClass("RemoteEvent")
    if not remote then
        return
    end

    while true do
        remote:FireServer()
        wait(FIRE_DELAY)
    end
end

spawn(rapidFire)

-- Button "Made by coder026jb"
local gui = game:GetService("CoreGui")
local button = Instance.new("TextButton")
button.Name = "MadeByCoder026jbButton"
button.Text = "Made by coder026jb"
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Parent = gui

wait(60)
button:Destroy()
