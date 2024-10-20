local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Axis.Axis)

local Test = Axis.CreateController{
    Name = "Test"
}

function Test:Foo()
    print("Hello world from controller")
end

function Test:Init()
    print("Init")
end

function Test:Start()
    print("Start")
end

return Test