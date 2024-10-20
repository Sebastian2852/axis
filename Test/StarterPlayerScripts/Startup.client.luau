local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Packages.Axis)

local MyController = Axis.CreateController {
    Name = "MyController";
}

function MyController:Init()
    local MyModule = Axis.GetModule("MyModule")
    MyModule.TestEvent:Connect(function(Message)
        print("Got message from server:", Message)
    end)

    MyModule.TestEvent:Fire("Hello")

    MyModule:TestMethod("Hello world from client"):andThen(function(Result)
        print("Result from server:", Result)
    end)

    MyModule.TestProperty:Observe(function(Value)
        print("TestProperty value:", Value)
    end)
end

Axis:Boot():andThen(function()
    print("Axis booted")
end):catch(warn)