--[================================================================]--
--  ASTRA HUD - MENÚ PREMIUM NEÓN MAGENTA (HITBOX + LEGIT + ESP)
--[================================================================]--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Limpiar copias anteriores
if playerGui:FindFirstChild("Las3XRdGui") then
	playerGui.Las3XRdGui:Destroy()
end

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Las3XRdGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 2147483647
screenGui.Parent = playerGui

-- Ventana Principal (Negro elegante con bordes magenta neón)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 440, 0, 390)
mainFrame.Position = UDim2.new(0.5, -220, 0.5, -195)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(255, 0, 127) -- Magenta Neón
mainStroke.Thickness = 2.5

-- Barra Superior (Movible)
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundTransparency = 1

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.Text = "ASTRA HUD🐈"
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 127)
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Botón X (Cerrar menú)
local closeButton = Instance.new("TextButton", topBar)
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(1, -42, 0.5, -16)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 16
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

-- Botón Flotante Principal (Con el "3" en el medio - Movible)
local floatButton = Instance.new("TextButton", screenGui)
floatButton.Size = UDim2.new(0, 45, 0, 45)
floatButton.Position = UDim2.new(0.1, 0, 0.3, 0)
floatButton.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
floatButton.Text = "3"
floatButton.TextColor3 = Color3.fromRGB(255, 0, 127)
floatButton.Font = Enum.Font.FredokaOne
floatButton.TextSize = 20
floatButton.Visible = false
Instance.new("UICorner", floatButton).CornerRadius = UDim.new(1, 0)
local floatStroke = Instance.new("UIStroke", floatButton)
floatStroke.Color = Color3.fromRGB(255, 0, 127)
floatStroke.Thickness = 2

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	floatButton.Visible = true
end)

floatButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	floatButton.Visible = false
end)

-- Contenedor de Opciones
local container = Instance.new("ScrollingFrame", mainFrame)
container.Size = UDim2.new(1, -16, 1, -55)
container.Position = UDim2.new(0, 8, 0, 48)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 400)
container.ScrollBarThickness = 3

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Función auxiliar para crear botones
local function crearBoton(nombreTexto)
	local btn = Instance.new("TextButton", container)
	btn.Size = UDim2.new(1, -10, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	btn.Text = nombreTexto
	btn.TextColor3 = Color3.fromRGB(240, 240, 240)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 13
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(255, 0, 127)
	stroke.Thickness = 1.5
	return btn
end

-- 1. Elite Bot (Hitbox)
local eliteBtn = crearBoton("Elite Bot (Hitbox): OFF")

-- 1.1 Botón Click (Hitbox Invisible para Vídeos)
local clickBtn = crearBoton("Click (Hitbox Invisible): OFF")

local sizeLabel = Instance.new("TextLabel", container)
sizeLabel.Size = UDim2.new(1, -10, 0, 18)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Font = Enum.Font.SourceSansBold
sizeLabel.Text = "Tamaño Simulado: 3 (Max 20)"
sizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sizeLabel.TextSize = 12
sizeLabel.TextXAlignment = Enum.TextXAlignment.Left

local sizeHolder = Instance.new("Frame", container)
sizeHolder.Size = UDim2.new(1, -10, 0, 28)
sizeHolder.BackgroundTransparency = 1

local minusBtn = Instance.new("TextButton", sizeHolder)
minusBtn.Size = UDim2.new(0.48, 0, 1, 0)
minusBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
minusBtn.Text = "Tamaño (-)"
minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minusBtn.Font = Enum.Font.SourceSansBold
minusBtn.TextSize = 12
Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 6)
local strokeM = Instance.new("UIStroke", minusBtn)
strokeM.Color = Color3.fromRGB(255, 0, 127)
strokeM.Thickness = 1.5

local plusBtn = Instance.new("TextButton", sizeHolder)
plusBtn.Size = UDim2.new(0.48, 0, 1, 0)
plusBtn.Position = UDim2.new(0.52, 0, 0, 0)
plusBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
plusBtn.Text = "Tamaño (+)"
plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
plusBtn.Font = Enum.Font.SourceSansBold
plusBtn.TextSize = 12
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 6)
local strokeP = Instance.new("UIStroke", plusBtn)
strokeP.Color = Color3.fromRGB(255, 0, 127)
strokeP.Thickness = 1.5

-- 2. Speed Hack
local speedBtn = crearBoton("Speed: OFF (30)")

local speedHolder = Instance.new("Frame", container)
speedHolder.Size = UDim2.new(1, -10, 0, 28)
speedHolder.BackgroundTransparency = 1

local speedMinus = Instance.new("TextButton", speedHolder)
speedMinus.Size = UDim2.new(0.48, 0, 1, 0)
speedMinus.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
speedMinus.Text = "Speed (-)"
speedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedMinus.Font = Enum.Font.SourceSansBold
speedMinus.TextSize = 12
Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 6)
local strokeSM = Instance.new("UIStroke", speedMinus)
strokeSM.Color = Color3.fromRGB(255, 0, 127)
strokeSM.Thickness = 1.5

local speedPlus = Instance.new("TextButton", speedHolder)
speedPlus.Size = UDim2.new(0.48, 0, 1, 0)
speedPlus.Position = UDim2.new(0.52, 0, 0, 0)
speedPlus.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
speedPlus.Text = "Speed (+)"
speedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedPlus.Font = Enum.Font.SourceSansBold
speedPlus.TextSize = 12
Instance.new("UICorner", speedPlus).CornerRadius = UDim.new(0, 6)
local strokeSP = Instance.new("UIStroke", speedPlus)
strokeSP.Color = Color3.fromRGB(255, 0, 127)
strokeSP.Thickness = 1.5

-- 3. ESP Jugadores
local espBtn = crearBoton("ESP Jugadores: OFF")

-- Controles de Arrastre Menú Principal
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true; dragStart = input.Position; startPos = mainFrame.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

-- Arrastre Botón Flotante "3"
local fDrag, fMoved, fStart, fStartPos
floatButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		fDrag = true; fMoved = false; fStart = input.Position; fStartPos = floatButton.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if fDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - fStart
		if delta.Magnitude > 6 then
			fMoved = true
			floatButton.Position = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y)
		end
	end
end)
floatButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if fDrag and not fMoved then mainFrame.Visible = true; floatButton.Visible = false end
		fDrag = false
	end
end)

-- Variables de Control del Sistema
local eliteActive = false
local clickLegitActive = false
local headSizeVal = 3
local speedActive = false
local speedVal = 30
local espActive = false
local espCache = {}
local ghostHitboxes = {}

local function removeEsp(p)
	if espCache[p] then
		if espCache[p].hl then espCache[p].hl:Destroy() end
		if espCache[p].bb then espCache[p].bb:Destroy() end
		espCache[p] = nil
	end
end

local function limpiarGhost(obj)
	if ghostHitboxes[obj] then
		ghostHitboxes[obj]:Destroy()
		ghostHitboxes[obj] = nil
	end
end

Players.PlayerRemoving:Connect(function(p)
	removeEsp(p)
end)

-- Bucle Principal (Hitbox + Click Legit + Speed + ESP)
RunService.RenderStepped:Connect(function()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		if speedActive then
			player.Character.Humanoid.WalkSpeed = speedVal
		elseif player.Character.Humanoid.WalkSpeed == speedVal then
			player.Character.Humanoid.WalkSpeed = 16
		end
	end

	-- Bucle para Jugadores
	for _, otherPlr in ipairs(Players:GetPlayers()) do
		if otherPlr ~= player then
			local char = otherPlr.Character
			if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("Head") then
				local hum = char.Humanoid
				local head = char.Head

				if eliteActive and hum.Health > 0 then
					if clickLegitActive then
						-- Mantiene la cabeza visualmente normal pero crea un Hitbox fantasma invisible ampliado
						head.Size = Vector3.new(1.2, 1, 1)
						head.Massless = false
						
						local ghost = ghostHitboxes[char]
						if not ghost or not ghost.Parent then
							ghost = Instance.new("Part")
							ghost.Name = "Head"
							ghost.Size = Vector3.new(headSizeVal, headSizeVal, headSizeVal)
							ghost.Transparency = 1
							ghost.CanCollide = true
							ghost.Massless = true
							ghost.Parent = char
							ghostHitboxes[char] = ghost
						end
						ghost.Size = Vector3.new(headSizeVal, headSizeVal, headSizeVal)
						ghost.CFrame = head.CFrame
					else
						limpiarGhost(char)
						head.Size = Vector3.new(headSizeVal, headSizeVal, headSizeVal)
						head.CanCollide = true
						head.Massless = true
					end
				else
					limpiarGhost(char)
					head.Size = Vector3.new(1.2, 1, 1)
					head.Massless = false
				end

				-- ESP
				if espActive and hum.Health > 0 then
					if not espCache[otherPlr] then
						local hl = Instance.new("Highlight", char)
						hl.Adornee = char
						hl.FillColor = Color3.fromRGB(18, 18, 22)
						hl.OutlineColor = Color3.fromRGB(255, 0, 127)
						hl.FillTransparency = 0.5

						local bb = Instance.new("BillboardGui", char)
						bb.Size = UDim2.new(0, 100, 0, 30)
						bb.StudsOffset = Vector3.new(0, 3, 0)
						bb.AlwaysOnTop = true
						bb.Adornee = head

						local txt = Instance.new("TextLabel", bb)
						txt.Size = UDim2.new(1, 0, 1, 0)
						txt.BackgroundTransparency = 1
						txt.Font = Enum.Font.SourceSansBold
						txt.Text = otherPlr.Name
						txt.TextColor3 = Color3.fromRGB(255, 255, 255)
						txt.TextSize = 13

						espCache[otherPlr] = {hl = hl, bb = bb}
					end
				else
					removeEsp(otherPlr)
				end
			else
				removeEsp(otherPlr)
				limpiarGhost(char)
			end
		end
	end

	-- Bucle para Bots / NPCs
	for _, obj in ipairs(Workspace:GetChildren()) do
		if obj:IsA("Model") and obj ~= player.Character then
			local hum = obj:FindFirstChildOfClass("Humanoid")
			local head = obj:FindFirstChild("Head")
			local isPlayerModel = Players:GetPlayerFromCharacter(obj)

			if hum and head and not isPlayerModel then
				if eliteActive and hum.Health > 0 then
					if clickLegitActive then
						head.Size = Vector3.new(1.2, 1, 1)
						local ghost = ghostHitboxes[obj]
						if not ghost or not ghost.Parent then
							ghost = Instance.new("Part")
							ghost.Name = "Head"
							ghost.Size = Vector3.new(headSizeVal, headSizeVal, headSizeVal)
							ghost.Transparency = 1
							ghost.CanCollide = true
							ghost.Massless = true
							ghost.Parent = obj
							ghostHitboxes[obj] = ghost
						end
						ghost.Size = Vector3.new(headSizeVal, headSizeVal, headSizeVal)
						ghost.CFrame = head.CFrame
					else
						limpiarGhost(obj)
						head.Size = Vector3.new(headSizeVal, headSizeVal, headSizeVal)
						head.CanCollide = true
						head.Massless = true
					end
				else
					limpiarGhost(obj)
					head.Size = Vector3.new(1.2, 1, 1)
				end
			end
		end
	end
end)

-- Conexiones de Botones del Menú
eliteBtn.MouseButton1Click:Connect(function()
	eliteActive = not eliteActive
	eliteBtn.Text = eliteActive and "Elite Bot (Hitbox): ON" or "Elite Bot (Hitbox): OFF"
	eliteBtn.BackgroundColor3 = eliteActive and Color3.fromRGB(255, 0, 127) or Color3.fromRGB(18, 18, 22)
	
	if not eliteActive then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
				p.Character.Head.Size = Vector3.new(1.2, 1, 1)
				limpiarGhost(p.Character)
			end
		end
		for _, obj in ipairs(Workspace:GetChildren()) do
			if obj:IsA("Model") then
				local head = obj:FindFirstChild("Head")
				if head and not Players:GetPlayerFromCharacter(obj) then
					head.Size = Vector3.new(1.2, 1, 1)
					limpiarGhost(obj)
				end
			end
		end
	end
end)

clickBtn.MouseButton1Click:Connect(function()
	clickLegitActive = not clickLegitActive
	clickBtn.Text = clickLegitActive and "Click (Hitbox Invisible): ON" or "Click (Hitbox Invisible): OFF"
	clickBtn.BackgroundColor3 = clickLegitActive and Color3.fromRGB(255, 0, 127) or Color3.fromRGB(18, 18, 22)
end)

plusBtn.MouseButton1Click:Connect(function()
	headSizeVal = math.clamp(headSizeVal + 1, 2, 20)
	sizeLabel.Text = string.format("Tamaño Simulado: %d (Max 20)", headSizeVal)
end)

minusBtn.MouseButton1Click:Connect(function()
	headSizeVal = math.clamp(headSizeVal - 1, 2, 20)
	sizeLabel.Text = string.format("Tamaño Simulado: %d (Max 20)", headSizeVal)
end)

speedBtn.MouseButton1Click:Connect(function()
	speedActive = not speedActive
	speedBtn.Text = speedActive and ("Speed: ON ("..speedVal..")") or ("Speed: OFF ("..speedVal..")")
	speedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(255, 0, 127) or Color3.fromRGB(18, 18, 22)
end)

speedPlus.MouseButton1Click:Connect(function()
	speedVal = math.clamp(speedVal + 5, 16, 100)
	speedBtn.Text = (speedActive and "Speed: ON (" or "Speed: OFF (")..speedVal..")"
end)

speedMinus.MouseButton1Click:Connect(function()
	speedVal = math.clamp(speedVal - 5, 16, 100)
	speedBtn.Text = (speedActive and "Speed: ON (" or "Speed: OFF (")..speedVal..")"
end)

espBtn.MouseButton1Click:Connect(function()
	espActive = not espActive
	espBtn.Text = espActive and "ESP Jugadores: ON" or "ESP Jugadores: OFF"
	espBtn.BackgroundColor3 = espActive and Color3.fromRGB(255, 0, 127) or Color3.fromRGB(18, 18, 22)
	if not espActive then for _, p in ipairs(Players:GetPlayers()) do removeEsp(p) end end
end)
