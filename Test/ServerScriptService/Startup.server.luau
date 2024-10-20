local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Axis)

local MyModule = Axis.CreateModule {
    Name = "MyModule";
    Client = {
        TestEvent = Axis.CreateSignal();
        TestProperty = Axis.CreateProperty("Hello");
    };
}

function MyModule:Init()
    self.Client.TestEvent:Connect(function(Player, Message)
        print("Got message from client event:", Player, Message)
        self.Client.TestEvent:Fire(Player, Message:lower())
    end)
end

function MyModule.Client:TestMethod(Player, Message)
    print("Test method from client:", Player, Message)
    return Message:upper()
end

Axis:Boot():andThen(function()
    print("Axis booted")
end):catch(warn)