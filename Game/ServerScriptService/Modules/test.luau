local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Axis.Axis)

local test = Axis.CreateModule {
    Name = "Test";
    Client = {};
}

function test:Foo()
    print("Hello world from test!")
end

function test:Init()
    print("Init")
end

function test:Start()
    print("Start")
    local RandomObject = Axis.Lib.Random.new()
    print(RandomObject:GenerateInteger(5, 10)) -- Generate a random number between 5 and 10
    print(RandomObject:GenerateIntegers(50, 5, 10)) -- Generate 50 random numbers between 5 and 10
    RandomObject:Destroy()
end

return test