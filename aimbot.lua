
local a=Drawing.new("Text")
a.Visible=true
a.Text="Made By code026jb discord = jb026 wait 5 seconds and the silent aim + esp will loads"
a.Transparency=1
a.Font=0
a.Size=25
a.Color=Color3.new(255,0,0)
game:GetService("RunService").RenderStepped:Connect(function()a.Position=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2-100
,workspace.CurrentCamera.ViewportSize.Y/2)end)

wait(5)
a:Remove()

FOV = 180
HIT_PART = "Head"
loadstring(game:HttpGet("https://raw.githubusercontent.com/Spoorloos/scripts/main/silent_aim_no_actor_bypass.lua"))()
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
