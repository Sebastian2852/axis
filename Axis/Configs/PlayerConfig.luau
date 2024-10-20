--[=[
    @class PlayerConfig
    @tag Config
    All config relating to player's and their characters
]=]
local PlayerConfig = {}

local Types = require(script.Parent.Parent.Core.Types)

--[=[
    @within PlayerConfig
    @prop DefaultWalkSpeed number
    What the player's walkspeed should be set to when their character spawns
]=]
PlayerConfig.DefaultWalkSpeed = 3

--[=[
    @within PlayerConfig
    @prop LockFirstPerson boolean
    Should the player be locked in first person mode
]=]
PlayerConfig.LockFirstPerson = false

--[=[
    Returns the player config as a table
    @return PlayerConfigTable
]=]
function PlayerConfig:ReturnAsTable() :Types.PlayerConfigTable
    return {
        DefaultWalkSpeed = PlayerConfig.DefaultWalkSpeed;
        LockFirstPerson = PlayerConfig.LockFirstPerson;
    }
end

return PlayerConfig