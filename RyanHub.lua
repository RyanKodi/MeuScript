-- Variáveis principais
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()
local currentLevel = player:WaitForChild("Data"):WaitForChild("Level").Value -- Pega o nível atual do jogador
local islands = {
    {name = "Starter Island", level = 1},
    {name = "Jungle", level = 10},
    {name = "Pirate Village", level = 20},
    {name = "Desert", level = 60},
    {name = "Frozen Village", level = 90},
    {name = "Skypiea Island", level = 150},
    {name = "Marine Fortress", level = 120},
    {name = "Prison", level = 190}
}

-- Função para encontrar a ilha do jogador
function getIslandForLevel(level)
    for _, island in pairs(islands) do
        if level >= island.level then
            return island.name
        end
    end
    return nil
end

-- Função para farmar na ilha
function farmOnIsland(islandName)
    local island = workspace:FindFirstChild(islandName)
    if island then
        local enemies = island:GetChildren()
        for _, enemy in pairs(enemies) do
            if enemy:FindFirstChild("Humanoid") then
                -- Movimenta o personagem para atacar o inimigo
                humanoid:MoveTo(enemy.HumanoidRootPart.Position)
                wait(1)  -- Aguarda para realizar o ataque
                -- Você pode adicionar a lógica de ataque aqui com suas habilidades
            end
        end
    end
end

-- Função para procurar frutas no chão
function findAndPickFruit()
    local fruits = workspace:FindPartsInRegion3(character.HumanoidRootPart.Position - Vector3.new(50, 50, 50), character.HumanoidRootPart.Position + Vector3.new(50, 50, 50), nil)
    for _, part in pairs(fruits) do
        if part.Name == "Fruit" then
            -- Encontra a fruta e pega ela
            fireclickdetector(part:FindFirstChild("ClickDetector"))
            print("Fruta encontrada e pega!")
            break
        end
    end
end

-- Função principal de farmar
function startFarming()
    local islandName = getIslandForLevel(currentLevel)
    if islandName then
        print("Farming na ilha: " .. islandName)
        farmOnIsland(islandName)
        findAndPickFruit()
    else
        print("Não há ilha adequada para o seu nível.")
    end
end

-- Inicia o farm a cada 10 segundos
while true do
    startFarming()
    wait(10)  -- Aguarda 10 segundos antes de tentar novamente
end
