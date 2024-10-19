local ReplicatedStorage = game:GetService("ReplicatedStorage")
--[=[
    @class Bootstrap

    Internal module only to be used by Axis itself
]=]
local Bootstrap = {}

local EventSystem = require(ReplicatedStorage.Axis.Core.EventSystem)
local PlayerConfig = require(ReplicatedStorage.Axis.Configs.PlayerConfig)

--[=[
    All Axis core objects like events are created, this sets all roblox related properties and setups up anthing roblox-wise

    @return bool -- Was the phase successful
]=]
function Bootstrap:PhaseOne() :boolean
    EventSystem.NewEvent("BootFinished")
    EventSystem.NewEvent("BootPhaseTwo")
    return true
end

--[=[
    Any roblox functions/events are connected with functions.

    @return bool -- Was the phase successful
]=]
function Bootstrap:PhaseTwo() :boolean
    game.Players.PlayerAdded:Connect(function(Player)
        Bootstrap:ApplyPlayerConfig(Player)
        Player.CharacterAdded:Connect(function()
            Bootstrap:ApplyCharacterConfig(Player)
        end)
    end)

    EventSystem:FireEvent("BootPhaseTwo")
    return true
end

--[=[
    Initializes and Starts all modules added to by the developer

    @return bool -- Was the phase successful
]=]
function Bootstrap:PhaseThree() :boolean
    game.Players.PlayerAdded:Connect(function(Player)
        Bootstrap:ApplyPlayerConfig(Player)
        Player.CharacterAdded:Connect(function()
            Bootstrap:ApplyCharacterConfig(Player)
        end)
    end)

    EventSystem:FireEvent("BootPhaseTwo")
    return true
end

--[=[
    Applies the current player config to the given player

    @param Player Player
]=]
function Bootstrap:ApplyPlayerConfig(Player :Player)
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
function Bootstrap:ApplyCharacterConfig(Player :Player)
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
function Bootstrap:BootSequence() :boolean
    local PhaseOne = Bootstrap:PhaseOne()
    local PhaseTwo = Bootstrap:PhaseTwo()
    local PhaseThree = Bootstrap:PhaseThree()
    return PhaseOne and PhaseTwo and PhaseThree
end

return Bootstrap