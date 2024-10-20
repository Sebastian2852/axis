local ReplicatedStorage = game:GetService("ReplicatedStorage")
--[=[
    @class ModuleSystem
    @server
    Internal module only to be used by Axis itself
]=]
local ModuleSystem = {}

local Types = require(ReplicatedStorage.Axis.Core.Types)
local Promise = require(ReplicatedStorage.Packages.Promise)
local Comm = require(ReplicatedStorage.Packages.Comm)


local SIGNAL_MARKER = newproxy(true)
local UNRELIABLE_SIGNAL_MARKER  = newproxy(true)
local PROPERTY_MARKER = newproxy(true)

ModuleSystem.SIGNAL_MARKER = SIGNAL_MARKER
ModuleSystem.UNRELIABLE_SIGNAL_MARKER = UNRELIABLE_SIGNAL_MARKER
ModuleSystem.PROPERTY_MARKER = PROPERTY_MARKER

--[=[
    @within ModuleSystem
    @readonly
    @prop Modules {[string] :any}}
]=]
ModuleSystem.Modules = {}

--[=[
    Add a module to the module list
    @param ModuleScript ModuleScript
]=]
function ModuleSystem:Add(ModuleScript :ModuleScript)
    require(ModuleScript)
end

--[=[
    Checks wether a module exists by name
    @param Name string
    @return boolean
]=]
function ModuleSystem:Exists(Name :string) :boolean
    if ModuleSystem.Modules[Name] then
        return true
    end

    return false
end

--[=[
    Create a module

    @param ModuleDef ModuleDefinition

    @return Module
]=]
function ModuleSystem.Create(ModuleDef :Types.ModuleDefinition) :Types.Module
    assert(not ModuleSystem:Exists(ModuleDef.Name), "Module already exists")

    local Module :Types.Module = ModuleDef
    Module.AxisNetworking = Comm.ServerComm.new(ReplicatedStorage.Axis.Storage.Modules, ModuleDef.Name)

    if type(Module.Client) ~= "table" then
        Module.Client = { Server = Module }
    else
        if Module.Client.Server ~= Module then
            Module.Client.Server = Module
        end
    end

    ModuleSystem.Modules[ModuleDef.Name] = Module
    return Module
end

--[=[
    Initializes and starts all added modules
    @private
    @return Promise
]=]
function ModuleSystem:Start()
    return Promise.new(function(Resolve)
        for _, Module :Types.Module in ModuleSystem.Modules do
            for Key, Value in Module.Client do
                if type(Value) == "function" then
                    Module.AxisNetworking:WrapMethod(Module.Client, Key, nil, nil)
                elseif Value == SIGNAL_MARKER then
                    Module.Client[Key] = Module.AxisNetworking:CreateSignal(Key, false, nil, nil)
                elseif Value == UNRELIABLE_SIGNAL_MARKER then
                    Module.Client[Key] = Module.AxisNetworking:CreateSignal(Key, true, nil, nil)
                elseif type(Value) == "table" and Value[1] == PROPERTY_MARKER then
                    Module.Client[Key] = Module.AxisNetworking:CreateProperty(Key, Value[2], nil, nil)
                end
            end
        end

        local ModuleInitPromises = {}
        for _, Module in ModuleSystem.Modules do
            if type(Module.Init) == "function" then
                table.insert(ModuleInitPromises, Promise.new(function(R)
                    debug.setmemorycategory("AXIS_MODULEINIT_"..Module.Name)
                    Module:Init()
                    R()
                end))
            end
        end
        Resolve(Promise.all(ModuleInitPromises))
    end):andThen(function()
        for _, Module in ModuleSystem.Modules do
            if type(Module.Start) == "function" then
                task.spawn(function()
                    debug.setmemorycategory("AXIS_MODULESTART_"..Module.Name)
                    Module:Start()
                end)
            end
        end
    end)
end

--[=[
    Returns the module with that name

    @return Module

    @error "Name must be a string" -- The passed name is not a string
    @error "Could not find module ..." -- A module does not exist with the passed name
]=]
function ModuleSystem.GetModule(Name :string) :Types.Module
    assert(type(Name) == "string", "Name must be a string")
    return assert(ModuleSystem.Modules[Name], `Could not find module "{Name}"`) :: Types.Module
end

return ModuleSystem