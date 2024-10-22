local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
--[=[
    @class Axis
    The global axis module, contains everthing axis has to offer.
]=]
local Axis = {}

local Types = require(script.Parent.Core.Types)

--[=[
    External promise library

    @within Axis
    @prop Promise Promise
    @readonly
]=]
Axis.Promise = require(script.Parent.Parent.Promise)

--[=[
    @within Axis
    @prop Bootstrap Bootstrap
    @private
]=]
Axis._Bootstrap = require(script.Parent.Core.Bootstrapper)

--[=[
    Returns the module with that name
    @return Module
]=]
function Axis.GetModule(Name :string) :Types.Module
    if RunService:IsServer() then
        return Axis._ModuleSystem.GetModule(Name)
    else
        return Axis._ControllerSystem.GetModule(Name)
    end
end

if RunService:IsServer() then

    --[=[
        Contains all the configs
        @within Axis
        @prop ServerConfigs {PlayerConfig: PlayerConfig}
        @readonly
        @server
    ]=]
    Axis.ServerConfigs = {}
    Axis.ServerConfigs.PlayerConfig = require(script.Parent.Configs.PlayerConfig)

    --[=[
        @within Axis
        @prop ModuleSystem ModuleSystem
        @server
        @private
        @readonly
    ]=]
    Axis._ModuleSystem = require(script.Parent.Core.ModuleSystem)

    local SIGNAL_MARKER = Axis._ModuleSystem.SIGNAL_MARKER
    local PROPERTY_MARKER = Axis._ModuleSystem.PROPERTY_MARKER
    local UNRELIABLE_SIGNAL_MARKER = Axis._ModuleSystem.UNRELIABLE_SIGNAL_MARKER

    --[=[
        Wrapper function for module system function

        @server
    ]=]
    function Axis:AddModule(PathToModule :ModuleScript)
        Axis._ModuleSystem:Add(PathToModule)
    end

    --[=[
        Adds the modules within the parent.

        @param Parent Folder
        @server

        :::caution
        This only adds children, use AddModulesDeep to add descendants
        :::
    ]=]
    function Axis:AddModules(Parent :Folder)
        for _, Child :ModuleScript? in pairs(Parent:GetChildren()) do
            if not Child:IsA("ModuleScript") then continue end
            Axis._ModuleSystem:Add(Child)
        end
    end

    --[=[
        Adds any modules within the parent folder, this includes in sub-folders

        @param Parent Folder
        @server
    ]=]
    function Axis:AddModulesDeep(Parent :Folder)
        for _, Child :ModuleScript? in pairs(Parent:GetDescendants()) do
            if not Child:IsA("ModuleScript") then continue end
            Axis._ModuleSystem:Add(Child)
        end
    end

    --[=[
        Returns a table to use for the module. This table contains some axis-related stuff

        ```lua
        local MyModule = Axis.CreateModule {
            Name = "MyModule";
            Client = {};
        }

        function MyModule:Init()
            print("Init")
        end

        function MyModule:Start()
            print("Start")
        end

        return MyModule
        ```

        @param ModuleDef ModuleDefinition

        @server
        @return Module
    ]=]
    function Axis.CreateModule(ModuleDef :Types.ModuleDefinition) :Types.Module
        return Axis._ModuleSystem.Create(ModuleDef)
    end

    --[=[
        @return SIGNAL_MARKER

        Creates a marker that will turn the key into a remote signal once Axis
        is booted

        ```lua
        local MyModule = Axis.CreateModule {
            Name = "MyModule";
            Client = {
                -- Create the signal marker, which will turn into a
                -- RemoteSignal when Axis:Boot() is called:
                MySignal = Axis.CreateSignal();
            };
        }
        ```
    ]=]
    function Axis.CreateSignal()
        return SIGNAL_MARKER
    end

    --[=[
        @return UNRELIABLE_SIGNAL_MARKER

        Creates a marker that will turn the key into a unreliable remote signal
        once Axis is booted.

        :::warning Unreliable Events
        Internally, this uses UnreliableRemoteEvents, which allows for
        network communication that is unreliable and unordered. This is
        useful for events that are not crucial for gameplay, since the
        delivery of the events may occur out of order or not at all.

        See  the documentation for [UnreliableRemoteEvents](https://create.roblox.com/docs/reference/engine/classes/UnreliableRemoteEvent)
        for more info.
        :::
    ]=]
    function Axis.CreateUnreliableSignal()
        return UNRELIABLE_SIGNAL_MARKER
    end

    --[=[
        @return PROPERTY_MARKER
        Returns a marker that will turn the key into a remote property
        one Axis is booted. An initial value can be passed.

        RemoteProperties are great for replicating data to all of
        the clients. Different data can also be set per client.

        ```lua
        local MyModule = Axis.CreateModule {
            Name = "MyModule",
            Client = {
                -- Create the property marker, which will turn into a
                -- RemoteProperty when Axis:Boot() is called:
                MyProperty = Axis.CreateProperty("HelloWorld");
            },
        }
        ```
    ]=]
    function Axis.CreateProperty(InitialValue :any)
        return {PROPERTY_MARKER, InitialValue}
    end
end

if RunService:IsClient() then
    --[=[
        @within Axis
        @prop Player Player
        @client
        @readonly
    ]=]
    Axis.Player = Players.LocalPlayer

    --[=[
        @within Axis
        @prop ControllerSystem ControllerSystem
        @client
        @private
        @readonly
    ]=]
    Axis._ControllerSystem = require(script.Parent.Core.ControllerSystem)

    --[=[
        Wrapper function for controller system function
        @client
    ]=]
    function Axis:AddController(ControllerScript :ModuleScript)
        return Axis._ControllerSystem:Add(ControllerScript)
    end

    --[=[
        Adds the controllers within the parent.

        @param Parent Folder
        @client

        :::caution
        This only adds children, use AddControllersDeep to add descendants
        :::
    ]=]
    function Axis:AddControllers(Parent :Folder)
        for _, Child :ModuleScript? in pairs(Parent:GetChildren()) do
            if not Child:IsA("ModuleScript") then continue end
            Axis._ControllerSystem:Add(Child)
        end
    end

    --[=[
        Adds any controllers within the parent folder, this includes in sub-folders

        @param Parent Folder
        @client
    ]=]
    function Axis:AddControllersDeep(Parent :Folder)
        for _, Child :ModuleScript? in pairs(Parent:GetDescendants()) do
            if not Child:IsA("ModuleScript") then continue end
            Axis._ControllerSystem:Add(Child)
        end
    end

    --[=[
        Wrapper function for controller system function
        @client
        @return Controller

        ```lua
        local MyController = Axis.CreateController {
            Name = "MyController";
        }

        function MyController:Init()
            print("Init")
        end

        function MyController:Start()
            print("Start")
        end

        return MyController
        ```
    ]=]
    function Axis.CreateController(ControllerDef :Types.ControllerDefinition) :Types.Controller
        return Axis._ControllerSystem.CreateController(ControllerDef)
    end

    --[=[
        Wrapper function for controller system
        @client
        @return Controller
    ]=]
    function Axis.GetController(Name :string) :Types.Controller
        return Axis._ControllerSystem.GetController(Name)
    end
end

--[=[
    Start core systems and initialize all core modules
    @return boolean -- Was boot successful
]=]
function Axis:Boot()
    return Axis.Promise.new(function(Resolve, Reject)
        local Success = Axis._Bootstrap:BootSequence()
        if not Success then
            Reject("Failed to boot")
        end

        Resolve()
    end)
end

return Axis