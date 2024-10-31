-- Variáveis principais
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local initialPosition = humanoidRootPart.CFrame  -- Posição inicial do jogador
local SafeZoneActive = false  -- Controla o modo Safe Zone
local AutoCollect = false  -- Controla a coleta automática
local isMinimized = false  -- Estado do hub (minimizado ou expandido)

-- Lista de nomes das frutas
local fruitNames = {
    "Gum Fruit",
    "Bomb Fruit",
    "Chop Fruit",
    "Spike Fruit",
    "Sand Fruit",
    "Smoke Fruit",
    "Ice Fruit",
    "Light Fruit",
    "Flame Fruit",
    "Dark Fruit",
    "Gravity Fruit",
    "Phoenix Fruit",
    "Quake Fruit",
    "Magma Fruit",
    "Rumble Fruit",
    "Buddha Fruit",
    "Control Fruit",
    "Barrier Fruit",
    "Dragon Fruit",
    "Dough Fruit",
    "Soul Fruit",
    "Venom Fruit",
    "Shadow Fruit",
    "Spirit Fruit",
    "Leopard Fruit",
    "Christmas Fruit",
    "Halloween Fruit",
    "New Year Fruit",
    "Valentine Fruit",
    "Easter Fruit",
    "Thanksgiving Fruit",
    "Obsidian Fruit",
}

-- Função para ativar/desativar Safe Zone
local function toggleSafeZone()
    SafeZoneActive = not SafeZoneActive
    if SafeZoneActive then
        -- Esconde o nome do jogador
        player.DisplayName = " "  -- Deixa o nome em branco ou disfarçado
        player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    else
        -- Restaura a visibilidade do nome
        player.DisplayName = player.Name
        player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
    end
end

-- Função para coletar frutas e retornar ao ponto de partida
local function collectFruits()
    if not AutoCollect then return end  -- Executa apenas se a coleta automática está ativa
    
    for _, item in pairs(workspace:GetChildren()) do
        if item:IsA("Part") and table.find(fruitNames, item.Name) then  -- Verifica se o nome da fruta está na lista
            humanoidRootPart.CFrame = item.CFrame
            wait(math.random(0.5, 1))  -- Delay aleatório para emular comportamento humano
            
            -- Código para coletar a fruta, se necessário
            
            humanoidRootPart.CFrame = initialPosition
            wait(math.random(0.5, 1))  -- Delay antes de iniciar a próxima coleta
        end
    end
end

-- Interface do usuário
local ScreenGui = Instance.new("ScreenGui")
local HubFrame = Instance.new("Frame")
local SafeZoneButton = Instance.new("TextButton")
local CollectButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local MessageLabel = Instance.new("TextLabel")

-- Configurações da interface principal
ScreenGui.Name = "AutoCollectHub"
ScreenGui.Parent = game.CoreGui

-- Configurações do quadro principal do hub
HubFrame.Name = "HubFrame"
HubFrame.Parent = ScreenGui
HubFrame.Size = UDim2.new(0, 200, 0, 150)
HubFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
HubFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
HubFrame.BorderSizePixel = 0

-- Configuração do botão Safe Zone
SafeZoneButton.Name = "SafeZoneButton"
SafeZoneButton.Parent = HubFrame
SafeZoneButton.Size = UDim2.new(0, 180, 0, 40)
SafeZoneButton.Position = UDim2.new(0, 10, 0, 50)
SafeZoneButton.Text = "Ativar Safe Zone"
SafeZoneButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
SafeZoneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SafeZoneButton.Font = Enum.Font.SourceSansBold
SafeZoneButton.TextSize = 18

-- Configuração do botão Coleta Automática
CollectButton.Name = "CollectButton"
CollectButton.Parent = HubFrame
CollectButton.Size = UDim2.new(0, 180, 0, 40)
CollectButton.Position = UDim2.new(0, 10, 0, 100)
CollectButton.Text = "Iniciar Coleta Automática"
CollectButton.BackgroundColor3 = Color3.fromRGB(255, 85, 127)
CollectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectButton.Font = Enum.Font.SourceSansBold
CollectButton.TextSize = 18

-- Configuração do botão de minimizar
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = HubFrame
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 18

-- Configuração da mensagem
MessageLabel.Name = "MessageLabel"
MessageLabel.Parent = HubFrame
MessageLabel.Size = UDim2.new(0, 180, 0, 30)
MessageLabel.Position = UDim2.new(0, 10, 0, 10)
MessageLabel.Text = ""
MessageLabel.BackgroundTransparency = 1
MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MessageLabel.Font = Enum.Font.SourceSansBold
MessageLabel.TextSize = 18

-- Função para exibir mensagem e escondê-la após um tempo
local function showMessage(message, duration)
    MessageLabel.Text = message
    wait(duration)
    MessageLabel.Text = ""
end

-- Função para alternar o modo Safe Zone
SafeZoneButton.MouseButton1Click:Connect(function()
    toggleSafeZone()
    SafeZoneButton.Text = SafeZoneActive and "Desativar Safe Zone" or "Ativar Safe Zone"
    showMessage("Script ativado", 3)  -- Exibe a mensagem por 3 segundos
end)

-- Função para iniciar/parar a coleta automática
CollectButton.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    CollectButton.Text = AutoCollect and "Parar Coleta Automática" or "Iniciar Coleta Automática"
    
    if AutoCollect then
        showMessage("Script ativado", 3)  -- Exibe a mensagem por 3 segundos
    end

    while AutoCollect do
        collectFruits()
        wait(math.random(3, 5))  -- Intervalo de verificação aleatório
    end
end)

-- Função para minimizar o hub
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        -- Minimiza o hub
        SafeZoneButton.Visible = false
        CollectButton.Visible = false
        MinimizeButton.Text = "+"
        HubFrame.Size = UDim2.new(0, 200, 0, 40)
    else
        -- Expande o hub
        SafeZoneButton.Visible = true
        CollectButton.Visible = true
        MinimizeButton.Text = "-"
        HubFrame.Size = UDim2.new(0, 200, 0, 150)
    end
end)
