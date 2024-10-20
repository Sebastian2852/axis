local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
--[=[
    @class ServerBootstrap
    @server

    Internal module only to be used by Axis itself
]=]
local ServerBootstrap = {}

local EventSystem = require(script.Parent.Parent.EventSystem)
local PlayerConfig = require(script.Parent.Parent.Parent.Configs.PlayerConfig)
local ModuleSystem = require(script.Parent.Parent.ModuleSystem)

--[=[
    All Axis core objects like events are created, this sets all roblox related properties and setups up anthing roblox-wise

    @return bool -- Was the phase successful
]=]
function ServerBootstrap:PhaseOne() :boolean
    EventSystem.NewEvent("BootFinished")
    EventSystem.NewEvent("BootPhaseTwo")
    return true
end

--[=[
    Any roblox functions/events are connected with functions.

    @return bool -- Was the phase successful
]=]
function ServerBootstrap:PhaseTwo() :boolean
    game.Players.PlayerAdded:Connect(function(Player)
        ServerBootstrap:ApplyPlayerConfig(Player)
        Player.CharacterAdded:Connect(function()
            ServerBootstrap:ApplyCharacterConfig(Player)
        end)
    end)

    EventSystem:FireEvent("BootPhaseTwo")
    return true
end

--[=[
    Applies the current player config to the given player

    @param Player Player
]=]
function ServerBootstrap:ApplyPlayerConfig(Player :Player)
    local CurrentConfig = PlayerConfig:ReturnAsTable()

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
    local CurrentConfig = PlayerConfig:ReturnAsTable()
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
    local PhaseOne = ServerBootstrap:PhaseOne()
    local PhaseTwo = ServerBootstrap:PhaseTwo()
    ModuleSystem:Start()
    return PhaseOne and PhaseTwo
end

return ServerBootstrap