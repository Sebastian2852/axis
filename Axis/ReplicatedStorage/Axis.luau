local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
--[=[
    @class Axis
    The global axis module, contains everthing axis has to offer.
]=]
local Axis = {}

local Types = require(ReplicatedStorage.Axis.Core.Types)

--[=[
    Contains all the custom libraries axis provides
    @within Axis
    @prop Lib {Random: RandomLib}
    @readonly
]=]
Axis.Lib = {}

Axis.Lib.Random = require(script.Parent.Libraries.Random)

--[=[
    @within Axis
    @prop EventSystem EventSystem
    @readonly
]=]
Axis.EventSystem = require(script.Parent.Core.EventSystem)

--[=[
    External promise library

    @within Axis
    @prop Promise Promise
    @readonly
]=]
Axis.Promise = require(ReplicatedStorage.Packages.Promise)

--[=[
    @within Axis
    @prop Bootstrap Bootstrap
    @private
]=]
Axis._Bootstrap = require(ReplicatedStorage.Axis.Core.Bootstrapper)

if RunService:IsServer() then

    --[=[
        @within Axis
        @prop ModuleSystem ModuleSystem
        @server
        @private
        @readonly
    ]=]
    Axis._ModuleSystem = require(ServerScriptService.Axis.Core.ModuleSystem)

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
        Wrapper function for module system
        @server
    ]=]
    function Axis.GetModule(Name :string) :Types.Controller
        return Axis._ModuleSystem.GetModule(Name)
    end
end

if RunService:IsClient() then
    --[=[
        @within Axis
        @prop ControllerSystem ControllerSystem
        @client
        @private
        @readonly
    ]=]
    Axis._ControllerSystem = require(ReplicatedStorage.Axis.Core.ControllerSystem)

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