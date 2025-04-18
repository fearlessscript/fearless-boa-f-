-- LocalScript (StarterPlayer > StarterPlayerScripts)

local Players = game:GetService("Players") local RunService = game:GetService("RunService") local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer local camera = Workspace.CurrentCamera local mouse = localPlayer:GetMouse()

-- CONFIG local aimRadius = 110 local smoothing = 0.15 local targetPart = "Head"

-- GUI FOV local screenGui = Instance.new("ScreenGui") screenGui.Name = "AimAssistGui" screenGui.ResetOnSpawn = false screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

local circleFrame = Instance.new("Frame") circleFrame.Name = "FOVCircle" circleFrame.AnchorPoint = Vector2.new(0.5, 0.5) circleFrame.Size = UDim2.new(0, aimRadius * 2, 0, aimRadius * 2) circleFrame.Position = UDim2.new(0.5, 0, 0.5, 0) circleFrame.BackgroundTransparency = 0.8 circleFrame.BackgroundColor3 = Color3.fromRGB(0, 170, 255) circleFrame.BorderSizePixel = 0 circleFrame.Parent = screenGui

local uicorner = Instance.new("UICorner") uicorner.CornerRadius = UDim.new(1, 0) uicorner.Parent = circleFrame

-- INTRO TEXTO local introGui = Instance.new("ScreenGui") introGui.Name = "IntroText" introGui.ResetOnSpawn = false introGui.Parent = localPlayer:WaitForChild("PlayerGui")

local introLabel = Instance.new("TextLabel") introLabel.Size = UDim2.new(1, 0, 0.1, 0) introLabel.Position = UDim2.new(0.5, 0, 0.4, 0) introLabel.AnchorPoint = Vector2.new(0.5, 0.5) introLabel.BackgroundTransparency = 1 introLabel.TextScaled = true introLabel.Font = Enum.Font.GothamBlack introLabel.Text = "by: fearless boa fé" introLabel.TextColor3 = Color3.fromRGB(255, 255, 255) introLabel.TextStrokeTransparency = 0.5 introLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) introLabel.TextTransparency = 1 introLabel.TextStrokeTransparency = 1 introLabel.Parent = introGui

-- ANIMAÇÃO DE INTRODUÇÃO task.spawn(function() for i = 1, 20 do introLabel.TextTransparency = 1 - i * 0.05 introLabel.TextStrokeTransparency = 1 - i * 0.05 task.wait(0.03) end task.wait(2.5) for i = 1, 20 do introLabel.TextTransparency = i * 0.05 introLabel.TextStrokeTransparency = i * 0.05 task.wait(0.03) end introGui:Destroy() end)

-- FUNÇÃO DE DETECÇÃO DE INIMIGO local function getClosestEnemy() local closest = nil local shortest = math.huge

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= localPlayer and player.Character and player.Character:FindFirstChild(targetPart) then
		local part = player.Character[targetPart]
		local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
		if onScreen then
			local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
			if dist < aimRadius and dist < shortest then
				local direction = (part.Position - camera.CFrame.Position).Unit
				local rayParams = RaycastParams.new()
				rayParams.FilterDescendantsInstances = {localPlayer.Character}
				rayParams.FilterType = Enum.RaycastFilterType.Blacklist
				local result = Workspace:Raycast(camera.CFrame.Position, direction * 1000, rayParams)
				if result and result.Instance and result.Instance:IsDescendantOf(player.Character) then
					closest = part
					shortest = dist
				end
			end
		end
	end
end
return closest

end

-- FUNÇÃO DE MIRA local function aimAtTarget(target) if not target then return end local targetPos = target.Position + Vector3.new(0, 0.1, 0) local direction = (targetPos - camera.CFrame.Position).Unit local lookCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction) camera.CFrame = camera.CFrame:Lerp(lookCFrame, smoothing) end

-- LOOP DO AIMBOT RunService.RenderStepped:Connect(function() circleFrame.Position = UDim2.new(0.5, 0, 0.5, 0) local target = getClosestEnemy() aimAtTarget(target) end)

