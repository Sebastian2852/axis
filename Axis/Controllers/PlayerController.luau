local StarterGui = game:GetService("StarterGui")
local Axis = require(script.Parent.Parent.Axis)

--[=[
    @class PlayerController
    @tag InternalController

    An internal controller that helps with controlling/manipulating the player.

    ```lua
    PlayerController = Axis.GetController("PlayerController")
    ```
]=]
local PlayerController = Axis.CreateController{
    Name = "PlayerController"
}

--[=[
    Returns the player's PlayerModule
    @yields
    @param ReturnAsModule boolean -- Should it be returned as the actual module
    @return ModuleScript | { [any]: any }
]=]
function PlayerController:GetPlayerModule(ReturnAsModule :boolean) :ModuleScript | {}
    local Module = Axis.Player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
    if ReturnAsModule then
        return Module
    end

    return require(Module)
end

--[=[
    Disable the player's controls

    @yields
]=]
function PlayerController:DisableControls()
    local Controls = self:GetPlayerModule(false):GetControls()
    Controls:Disable()
end

--[=[
    Enable the player's controls

    @yields
]=]
function PlayerController:EnableControls()
    local Controls = self:GetPlayerModule(false):GetControls()
    Controls:Enable()
end

--[=[
    Returns the player's cahracter

    @yields
    @return Model
]=]
function PlayerController:GetCharacter() :Model
    return Axis.Player.Character or Axis.Player.CharacterAdded:Wait()
end

return PlayerController