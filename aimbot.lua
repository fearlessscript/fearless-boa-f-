-- Exibe o texto "fearless boa fé!" na tela ao iniciar

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "IntroText"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0.1, 0)
label.Position = UDim2.new(0.5, 0, 0.4, 0)
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.GothamBlack
label.Text = "fearless boa fé!"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextStrokeTransparency = 0.5
label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
label.Parent = gui

-- Animação suave de entrada e saída
label.TextTransparency = 1
label.TextStrokeTransparency = 1

for i = 1, 20 do
	label.TextTransparency = 1 - i * 0.05
	label.TextStrokeTransparency = 1 - i * 0.05
	wait(0.03)
end

wait(2.5) -- Tempo visível na tela

for i = 1, 20 do
	label.TextTransparency = i * 0.05
	label.TextStrokeTransparency = i * 0.05
	wait(0.03)
end

gui:Destroy()
