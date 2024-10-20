local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[=[
    @class ControllerSystem
    @client
    Internal system for handling controllers
]=]
local ControllerSystem = {}

local Types = require(ReplicatedStorage.Axis.Core.Types)
local Promise = require(ReplicatedStorage.Packages.Promise)

ControllerSystem.Controllers = {}

--[=[
    Add a controller
    @param ControllerScript ModuleScript
]=]
function ControllerSystem:Add(ControllerScript :ModuleScript)
    require(ControllerScript)
end

--[=[
    Create a controller

    @param ControllerDef ControllerDefinition
    @return Controller
]=]
function ControllerSystem.CreateController(ControllerDef :Types.ControllerDefinition) :Types.Controller
    assert(type(ControllerDef) == "table", "Controller def must be a table")
    assert(not ControllerSystem:Exists(ControllerDef.Name), "Controller already exists")

    local Controller = ControllerDef
    ControllerSystem.Controllers[ControllerDef.Name] = Controller
    return Controller
end

--[=[
    Check if a controller with the given name exists

    @param Name string
    @return boolean
]=]
function ControllerSystem:Exists(Name :string) :boolean
    assert(type(Name) == "string", "Name must be a string")
    return ControllerSystem.Controllers[Name]
end

--[=[
    Init and Start all controllers

    @return Promise

    @private
]=]
function ControllerSystem:Start()
    return Promise.new(function(Resolve)
        local ModuleInitPromises = {}
        for _, Module in ControllerSystem.Controllers do
            if type(Module.Init) == "function" then
                table.insert(ModuleInitPromises, Promise.new(function(R)
                    debug.setmemorycategory("AXIS_CONTROLLERINIT_"..Module.Name)
                    Module:Init()
                    R()
                end))
            end
        end
        Resolve(Promise.all(ModuleInitPromises))
    end):andThen(function()
        for _, Module in ControllerSystem.Controllers do
            if type(Module.Start) == "function" then
                task.spawn(function()
                    debug.setmemorycategory("AXIS_CONTROLLERSTART_"..Module.Name)
                    Module:Start()
                end)
            end
        end
    end)
end

--[=[
    Get a controller with the given name
    @param Name string
    @return Controller
]=]
function ControllerSystem.GetController(Name :string) :Types.Controller
    assert(type(Name) == "string", "Name must be a string")
    return assert(ControllerSystem.Controllers[Name], `Could not find controller "{Name}"`) :: Types.Controller
end

return ControllerSystem