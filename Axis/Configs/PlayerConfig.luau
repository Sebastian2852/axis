--[=[
    @class PlayerConfig
    @tag Config
    @server
    All config relating to player's and their characters
]=]
local PlayerConfig = {}

local Types = require(script.Parent.Parent.Core.Types)

--[=[
    @within PlayerConfig
    @prop DefaultWalkSpeed number
    @readonly
    What the player's walkspeed should be set to when their character spawns
]=]
PlayerConfig.DefaultWalkSpeed = 16

--[=[
    @within PlayerConfig
    @prop LockFirstPerson boolean
    @readonly
    Should the player be locked in first person mode
]=]
PlayerConfig.LockFirstPerson = false

--[=[
    Returns the player config as a table
    @return PlayerConfigTable
]=]
function PlayerConfig:GetConfig() :Types.PlayerConfigTable
    local Config = {}
    for Key, Value in pairs(PlayerConfig) do
       if type(Value) == "function" then continue end
       Config[Key] = Value
    end
    return Config
end

--[=[
    Apply a new config
    @param NewConfig PlayerConfigTable

    ```lua
    -- AxisBoot.server.luau
    local Config = Axis.ServerConfigs.PlayerConfig:GetConfig()
    Config.DefaultWalkSpeed = 3
    Axis.ServerConfigs.PlayerConfig:ApplyConfig(Config)
    ```
]=]
function PlayerConfig:ApplyConfig(NewConfig :Types.PlayerConfigTable)
    for Key, Value in pairs(NewConfig) do
        PlayerConfig[Key] = Value
    end
end

return PlayerConfig