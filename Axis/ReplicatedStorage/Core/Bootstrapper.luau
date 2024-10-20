local RunService = game:GetService("RunService")

if RunService:IsServer() then
    return require(script.Parent.Bootstrap.Server)
else
    return require(script.Parent.Bootstrap.Client)
end