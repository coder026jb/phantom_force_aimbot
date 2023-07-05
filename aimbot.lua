FOV = 180
HIT_PART = "Head"
loadstring(game:HttpGet("https://raw.githubusercontent.com/Spoorloos/scripts/main/silent_aim_no_actor_bypass.lua"))() --thx spoorloos for the silent aim
getgenv().thing = true;
	
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
