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
    @prop Lib {}
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

if RunService:IsServer() then
    --[=[
        @within Axis
        @prop Bootstrap Bootstrap
        @server
        @private
    ]=]
    Axis.Bootstrap = require(ServerScriptService.Axis.Kernel.Bootstrapper)

    --[=[
        @within Axis
        @prop ModuleSystem ModuleSystem
        @server
        @private
        @readonly
    ]=]
    Axis.ModuleSystem = require(ServerScriptService.Axis.Core.ModuleSystem)

    --[=[
        Adds a module to Axis. This lets other modules use it awell as the client.

        ```lua
        Axis:AddModule(Somwhere.Module)
        ```

        @server
    ]=]
    function Axis:AddModule(PathToModule :ModuleScript)
        Axis.ModuleSystem:Add(PathToModule)
    end

    --[=[
        Adds the modules within the parent.

        @param Parent Folder

        :::caution
        This only adds children, use AddModulesDeep to add descendants
        :::
    ]=]
    function Axis:AddModules(Parent :Folder)
        for _, Child :ModuleScript? in pairs(Parent:GetChildren()) do
            if not Child:IsA("ModuleScript") then continue end
            Axis.ModuleSystem:Add(Child)
        end
    end

    --[=[
        Adds any modules within the parent folder, this includes in sub-folders

        @param Parent Folder
    ]=]
    function Axis:AddModulesDeep(Parent :Folder)
        for _, Child :ModuleScript? in pairs(Parent:GetDescendants()) do
            if not Child:IsA("ModuleScript") then continue end
            Axis.ModuleSystem:Add(Child)
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
        return Axis.ModuleSystem.Create(ModuleDef)
    end
end

--[=[
Start core systems and initialize all core modules

@return boolean -- Was boot successful
]=]
function Axis:Boot()
    return Axis.Promise.new(function(Resolve, Reject)
        local Success = Axis.Bootstrap:BootSequence()
        if not Success then
            Reject("Failed to boot")
        end

        Axis.ModuleSystem:Start()
        Resolve()
    end)
end

return Axis