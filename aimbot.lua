FOV = FOV or 180;
HIT_PARTS = HIT_PARTS or { "Head" };

-- variables
local camera = workspace.CurrentCamera;
local players = workspace:WaitForChild("Players");
local localPlayer = game:GetService("Players").LocalPlayer;

-- functions
local function getFirearm()
    for _, child in camera:GetChildren() do
        if child:FindFirstChild("Trigger") then
            return child;
        end
    end
end

local function getEnemyTeam()
    for _, team in players:GetChildren() do
        if team.Name ~= localPlayer.TeamColor.Name then
            return team;
        end
    end
end

local function getClosest()
    local bestAngle, bestPart = math.rad(FOV * 0.5);
    local partName = HIT_PARTS[math.random(1, #HIT_PARTS)];
    for _, character in getEnemyTeam():GetChildren() do
        local hitPart = character:FindFirstChild(partName);
        if not hitPart then
            continue;
        end

        local vector = (hitPart.Position - camera.CFrame.Position).Unit;
        local angle = math.acos(camera.CFrame.LookVector:Dot(vector));
        if angle < bestAngle then
            bestAngle = angle;
            bestPart = hitPart;
        end
    end
    return bestPart;
end

-- connections
game:GetService("RunService").Stepped:Connect(function()
    local firearm = getFirearm();
    local hitPart = firearm and getClosest();
    if not hitPart then
        return;
    end

    for _, part in firearm:GetChildren() do
        local isAimPart = part.Name == "Flame" or string.find(part.Name, "SightMark");
        local weld = isAimPart and part:GetJoints()[1];
        if weld then
            weld.C0 = weld.Part0.CFrame:ToObjectSpace(
                CFrame.lookAt(weld.Part1.Position, hitPart.Position)
            );
        end
    end
end);
	
while getgenv().thing do wait(1)

	for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
		if(v.Name == "Box") then
			v:Destroy();
		end
	end

	for _, team in pairs(game:GetService("Workspace").Players:GetChildren()) do
		for _, v in pairs(team:GetChildren()) do
			
			if(v:FindFirstChild("Torso")) then
				local box = Instance.new("BoxHandleAdornment");
				box.Name = "Box";
				box.Adornee = v.Torso;
				box.AlwaysOnTop = true;
				box.ZIndex = 10;
				box.Size = v.Torso.Size * Vector3.new(1.6, 3, 1.6);
				box.Transparency = 0.5;
				box.Color = BrickColor.new(team.Name)
				box.Parent = game:GetService("CoreGui");
			end
			
		end
	end

end

wait(60)
button:Destroy()
