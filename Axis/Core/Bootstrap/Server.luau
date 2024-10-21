local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
--[=[
    @class ServerBootstrap
    @server

    Internal module only to be used by Axis itself
]=]
local ServerBootstrap = {}

local PlayerConfig = require(script.Parent.Parent.Parent.Configs.PlayerConfig)
local ModuleSystem = require(script.Parent.Parent.ModuleSystem)

--[=[
    Applies the current player config to the given player

    @param Player Player
]=]
function ServerBootstrap:ApplyPlayerConfig(Player :Player)
    local CurrentConfig = PlayerConfig:GetConfig()

    if CurrentConfig.LockFirstPerson then
        Player.CameraMode = Enum.CameraMode.LockFirstPerson
    else
        Player.CameraMode = Enum.CameraMode.Classic
    end
end

--[=[
    Applies the current player config to the given player's character

    @yields
    @param Player Player

    @error "Player currently doesn't have a character" -- Error happens when the function is called but the player's character does not yet exist
]=]
function ServerBootstrap:ApplyCharacterConfig(Player :Player)
    local CurrentConfig = PlayerConfig:GetConfig()
    local Character = Player.Character
    if not Character then
        error("Player currently doesn't have a character")
        return
    end

    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
    Humanoid.WalkSpeed = CurrentConfig.DefaultWalkSpeed
end

--[=[
Executes all the phases in order

@return bool
]=]
function ServerBootstrap:BootSequence() :boolean
    game.Players.PlayerAdded:Connect(function(Player)
        ServerBootstrap:ApplyPlayerConfig(Player)
        Player.CharacterAdded:Connect(function()
            ServerBootstrap:ApplyCharacterConfig(Player)
        end)
    end)

    for _, Module in pairs(script.Parent.Parent.Parent.Modules:GetDescendants()) do
        if not Module:IsA("ModuleScript") then continue end
        ModuleSystem:Add(Module)
    end

    ModuleSystem:Start()
    return true
end

return ServerBootstrap