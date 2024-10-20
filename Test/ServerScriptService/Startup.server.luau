local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Axis.Axis)

Axis:AddModulesDeep(script.Parent.Modules)

Axis:Boot():andThen(function()
    print("Axis booted")

    local Test = Axis.ModuleSystem.GetModule("Test")
    Test:Foo()
end):catch(warn)