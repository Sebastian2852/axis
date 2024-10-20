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
end

function test.Client:TestClientComm()
    print("CLIENT COMM :O")
end

return test