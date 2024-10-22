local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[=[
    @class ControllerSystem
    @client
    Internal system for handling controllers
]=]
local ControllerSystem = {}

local Types = require(script.Parent.Types)
local Promise = require(script.Parent.Parent.Parent.Promise)
local Comm = require(script.Parent.Parent.Parent.Comm)

local ModulesFolder = nil

ControllerSystem.Modules = {}
ControllerSystem.Controllers = {}

--[=[
    @within ControllerSystem
    @prop Started boolean
    @readonly
]=]
ControllerSystem.Started = false

local function GetModulesFolder()
    if not ModulesFolder then
        ModulesFolder = script.Parent.Parent.Storage.Modules :: Folder
    end

    return ModulesFolder
end

local function BuildModule(Name :string)
    local Folder = GetModulesFolder()
    local ClientComm = Comm.ClientComm.new(Folder, true, Name)
    local Module = ClientComm:BuildObject(nil, nil)

    ControllerSystem.Modules[Name] = Module
    return Module
end

--[=[
    Add a controller
    @param ControllerScript ModuleScript
]=]
function ControllerSystem:Add(ControllerScript :ModuleScript)
    assert(not ControllerSystem.Started, "Cannot create Controllers after ControllerSystem start")
    require(ControllerScript)
end

--[=[
    Create a controller

    @param ControllerDef ControllerDefinition
    @return Controller
]=]
function ControllerSystem.CreateController(ControllerDef :Types.ControllerDefinition) :Types.Controller
    assert(not ControllerSystem.Started, "Cannot create Controllers after ControllerSystem start")
    assert(type(ControllerDef) == "table", "Controller def must be a table")
    assert(type(ControllerDef.Name) == "string", `Controller name must be a string; got {type(ControllerDef.Name)}`)
    assert(#ControllerDef.Name > 0, "Controller name must be a non-empty string")
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
    ControllerSystem.Started = true

    return Promise.new(function(Resolve)
        -- Init all controllers
        local ControllerInitPromises = {}
        for _, Controller in ControllerSystem.Controllers do
            if type(Controller.Init) == "function" then
                table.insert(ControllerInitPromises, Promise.new(function(R)
                    debug.setmemorycategory("AXIS_CONTROLLERINIT_"..Controller.Name)
                    Controller:Init()
                    R()
                end))
            end
        end
        Resolve(Promise.all(ControllerInitPromises))
    end):andThen(function()
        -- Start all controllers
        for _, Controller in ControllerSystem.Controllers do
            if type(Controller.Start) == "function" then
                task.spawn(function()
                    debug.setmemorycategory("AXIS_CONTROLLERSTART_"..Controller.Name)
                    Controller:Start()
                end)
            end
        end
    end):andThen(function()
        -- Remove start and init functions
        for _, Controller in ControllerSystem.Controllers do
            for Key, _ in Controller do
                if Key == "Init" then
                    Controller[Key] = function()
                        error("Controller:Init() can only be called by Axis!")
                    end
                    continue
                end

                if Key == "Start" then
                    Controller[Key] = function()
                        error("Controller:Start() can only be called by Axis!")
                    end
                    continue
                end
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

--[=[
    Get a Module with the given name
    @param Name string
    @return Module
]=]
function ControllerSystem.GetModule(Name :string) :Types.Module
    local Module = ControllerSystem.Modules[Name]
    if Module then
        return Module
    end

    return BuildModule(Name)
end

return ControllerSystem