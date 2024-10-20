local ReplicatedStorage = game:GetService("ReplicatedStorage")
--[=[
    @class ClientBootstrap
    @client

    Internal bootstrap module only to be used by Axis itself
]=]
local ClientBootstrap = {}

local ControllerSystem = require(script.Parent.Parent.ControllerSystem)

--[=[
    Start up all client-related parts of Axis
    @return boolean
]=]
function ClientBootstrap:BootSequence() :boolean
    for _, Module in pairs(script.Parent.Parent.Parent.Controllers:GetDescendants()) do
        if not Module:IsA("ModuleScript") then continue end
        ControllerSystem:Add(Module)
    end

    ControllerSystem:Start()
    return true
end

return ClientBootstrap