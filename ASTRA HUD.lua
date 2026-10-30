-- ==========================================================
-- SCRIPT ÚNICO: ASTRA HUD - ESTILO CROSSSHOT / iDEPHUB
-- Ubicación del archivo: GitHub (ASTRA HUD.lua)
-- ==========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Variables de Estado
local aimbotActivo = false
local hitboxesExpandidas = false
local robuxFalsos = 0
local unlocksActivo = false

-- ----------------------------------------------------------
-- 1. CREACIÓN DE INTERFAZ ESTILO ESCUADRA (DARK/GREEN)
-- ----------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "iDepAstraHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Botón Flotante para Minimizar (Estilo Esquina)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 130, 0, 40)
ToggleButton.Position = UDim2.new(0.02, 0, 0.05, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
ToggleButton.Text = "Ocultar Panel"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 130) -- Verde Neón CrossShot
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 13
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

-- Contenedor Principal (Marco Oscuro con Bordes Suaves)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 480)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Título Principal del Script Hub
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1
Header.Text = "CrossShot - [ ASTRA HUD ]"
Header.TextColor3 = Color3.fromRGB(0, 255, 130)
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 16
Header.Parent = MainFrame

-- Contador de Robux Falsos en la Esquina del Panel
local RobuxDisplay = Instance.new("TextLabel")
RobuxDisplay.Size = UDim2.new(0, 150, 0, 30)
RobuxDisplay.Position = UDim2.new(1, -160, 0, 10)
RobuxDisplay.BackgroundTransparency = 1
RobuxDisplay.Text = "💵 Robux: 0"
RobuxDisplay.TextColor3 = Color3.fromRGB(0, 200, 255)
RobuxDisplay.Font = Enum.Font.GothamBold
RobuxDisplay.TextSize = 13
RobuxDisplay.TextXAlignment = Enum.TextXAlignment.Right
RobuxDisplay.Parent = MainFrame

-- Lista de Scroll Interna
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -65)
ScrollFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 550)
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = ScrollFrame

-- CREADOR DINÁMICO DE BOTONES SWITCH (TOGGLES)
local function crearToggle(texto)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    frame.Parent = ScrollFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(0.7, 0, 1, 0)
    txt.Position = UDim2.new(0, 15, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Text = texto
    txt.TextColor3 = Color3.fromRGB(200, 200, 200)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 13
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = frame
    
    local indicator = Instance.new("TextButton")
    indicator.Size = UDim2.new(0, 60, 0, 28)
    indicator.Position = UDim2.new(1, -75, 0.5, -14)
    indicator.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    indicator.Text = "OFF"
    indicator.TextColor3 = Color3.fromRGB(255, 100, 100)
    indicator.Font = Enum.Font.GothamBold
    indicator.TextSize = 12
    indicator.Parent = frame
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(0, 4)
    indCorner.Parent = indicator
    
    return indicator
end

-- Botones de acción directa
local function crearBotonAccion(texto, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 300, 0, 45)
    btn.BackgroundColor3 = color
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = ScrollFrame
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    return btn
end

-- Instanciar elementos solicitados en el menú
local ToggleAim = crearToggle("Asistencia de Apuntado (Aimbot)")
local ToggleHitbox = crearToggle("Expandir Hitboxes (Enemigos)")
local ToggleUnlocks = crearToggle("Desbloquear Todo (Skins/Gamepasses)")

local BtnAddRobux = crearBotonAccion("💰 Generar +500,000 Robux Falsos", Color3.fromRGB(0, 180, 100))
local BtnAnim = crearBotonAccion("🎬 Ejecutar Animación (Baile Troll)", Color3.fromRGB(140, 80, 255))

-- ----------------------------------------------------------
-- 2. SISTEMA DE OCULTAR / MOSTRAR CON ANIMACIÓN
-- ----------------------------------------------------------
local menuAbierto = true
ToggleButton.MouseButton1Click:Connect(function()
    menuAbierto = not menuAbierto
    local endPos = menuAbierto and UDim2.new(0.5, -170, 0.5, -230) or UDim2.new(0.5, -170, 1, 60)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = endPos}):Play()
    ToggleButton.Text = menuAbierto and "Ocultar Panel" or "Mostrar Panel"
end)

local function actualizarVisualToggle(btn, estado)
    if estado then
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(0, 15, 0)
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 130)
    else
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 100, 100)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    end
end

-- ----------------------------------------------------------
-- 3. FUNCIONALIDADES DEL PANEL
-- ----------------------------------------------------------

-- Aimbot Fluyente (Busca el objetivo más cercano a la cámara)
ToggleAim.MouseButton1Click:Connect(function()
    aimbotActivo = not aimbotActivo
    actualizarVisualToggle(ToggleAim, aimbotActivo)
end)

local function buscarObjetivo()
    local distanciaLimite = 400
    local target = nil
    for _, j in ipairs(Players:GetPlayers()) do
        if j ~= LocalPlayer and j.Character and j.Character:FindFirstChild("HumanoidRootPart") then
            local miHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if miHrp then
                local d = (miHrp.Position - j.Character.HumanoidRootPart.Position).Magnitude
                if d < distanciaLimite then
                    distanciaLimite = d
                    target = j.Character.HumanoidRootPart
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if aimbotActivo then
        local target = buscarObjetivo()
        if target then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- Expansor de Hitbox (Agranda al enemigo localmente)
ToggleHitbox.MouseButton1Click:Connect(function()
    hitboxesExpandidas = not hitboxesExpandidas
    actualizarVisualToggle(ToggleHitbox, hitboxesExpandidas)
    
    for _, j in ipairs(Players:GetPlayers()) do
        if j ~= LocalPlayer and j.Character then
            local hrp = j.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if hitboxesExpandidas then
                    hrp.Size = Vector3.new(12, 12, 12)
                    hrp.Transparency = 0.6
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
end)

-- Desbloquear Todo (Simulación de Gamepasses y Skins locales)
ToggleUnlocks.MouseButton1Click:Connect(function()
    unlocksActivo = not unlocksActivo
    actualizarVisualToggle(ToggleUnlocks, unlocksActivo)
    
    -- Busca carpetas comunes del juego vinculadas al perfil local
    local deSp = LocalPlayer:FindFirstChild("StarterGear") or LocalPlayer:FindFirstChild("Backpack")
    if unlocksActivo and deSp then
        print("[ASTRA HUD] Desbloqueando herramientas del servidor de forma local...")
        -- Agrega aquí herramientas de prueba si el juego lo permite
    end
end)

-- Robux Falsos con Destello Visual
BtnAddRobux.MouseButton1Click:Connect(function()
    robuxFalsos = robuxFalsos + 500000
    RobuxDisplay.Text = "💵 Robux: " .. string.format("%.0f", robuxFalsos)
    RobuxDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
    task.wait(0.2)
    RobuxDisplay.TextColor3 = Color3.fromRGB(0, 200, 255)
end)

-- Animación Rara (Emote de Baile)
BtnAnim.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://3333499508" -- ID universal de baile
        local track = humanoid:LoadAnimation(anim)
        track:Play()
    end
end)
