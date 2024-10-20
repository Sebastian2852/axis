local ReplicatedStorage = game:GetService("ReplicatedStorage")
--[=[
    @class ClientBootstrap
    @client

    Internal bootstrap module only to be used by Axis itself
]=]
local ClientBootstrap = {}

local ControllerSystem = require(ReplicatedStorage.Axis.Core.ControllerSystem)

--[=[
    Start up all client-related parts of Axis
    @return boolean
]=]
function ClientBootstrap:BootSequence() :boolean
    ControllerSystem:Start()
    return true
end

return ClientBootstrap