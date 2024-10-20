local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Axis.Axis)

Axis:AddControllersDeep(script.Parent.Controllers)

Axis:Boot():andThen(function()
    print("Axis booted")

    local Test = Axis.ControllerSystem.GetController("Test")
    Test:Foo()
end):catch(warn)