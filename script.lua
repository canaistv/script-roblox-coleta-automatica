-- Variáveis principais
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local initialPosition = character.HumanoidRootPart.CFrame  -- Posição inicial
local SafeZoneActive = false  -- Controla o modo Safe Zone
local AutoCollect = false  -- Controla a coleta automática

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
    
    for _, fruit in pairs(workspace:GetChildren()) do
        if fruit:IsA("Part") and fruit.Name == "Fruit" then  -- Substitua 'Fruit' pelo nome real
            character.HumanoidRootPart.CFrame = fruit.CFrame
            wait(math.random(0.5, 1))  -- Delay aleatório para emular comportamento humano
            
            -- Código para coletar a fruta, se necessário
            
            wait(math.random(0.5, 1))  -- Outro delay para a volta
            character.HumanoidRootPart.CFrame = initialPosition
        end
    end
end

-- Função para iniciar o hub
local ScreenGui = Instance.new("ScreenGui")
local SafeZoneButton = Instance.new("TextButton")
local CollectButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

-- Configurações do botão Safe Zone
SafeZoneButton.Parent = ScreenGui
SafeZoneButton.Size = UDim2.new(0, 150, 0, 50)
SafeZoneButton.Position = UDim2.new(0.5, -175, 0.5, -25)
SafeZoneButton.Text = "Ativar Safe Zone"

-- Configurações do botão Coleta Automática
CollectButton.Parent = ScreenGui
CollectButton.Size = UDim2.new(0, 150, 0, 50)
CollectButton.Position = UDim2.new(0.5, 25, 0.5, -25)
CollectButton.Text = "Iniciar Coleta Automática"

-- Função para alternar o modo Safe Zone
SafeZoneButton.MouseButton1Click:Connect(function()
    toggleSafeZone()
    SafeZoneButton.Text = SafeZoneActive and "Desativar Safe Zone" or "Ativar Safe Zone"
end)

-- Função para iniciar/parar a coleta automática
CollectButton.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    CollectButton.Text = AutoCollect and "Parar Coleta Automática" or "Iniciar Coleta Automática"
    
    while AutoCollect do
        collectFruits()
        wait(math.random(3, 5))  -- Intervalo de verificação aleatório
    end
end)
