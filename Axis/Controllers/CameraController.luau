local Axis = require(script.Parent.Parent.Axis)

--[=[
    @class CameraController
    @tag InternalController

    An internal controller that helps out with camera-related stuff

    ```lua
    CameraController = Axis.GetController("CameraController")
    ```
]=]
local CameraController = Axis.CreateController{
    Name = "CameraController";
}

local PlayerController

--[=[
    @yields
    @param Offset vector3

    Sets the player's camrea's offset.

    :::info
    Internally this sets the character's [humanoid camera offset](https://create.roblox.com/docs/reference/engine/classes/Humanoid#CameraOffset).
    :::
]=]
function CameraController:SetOffset(Offset :Vector3)
    local Character :Model = PlayerController:GetCharacter()
    local Humanoid :Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.CameraOffset = Offset
end

--[=[
    Returns the player's camera
    @return Camera
]=]
function CameraController:GetPlayerCamera()
    return workspace.CurrentCamera
end

--[=[
    @private

    Gets needed controllers:
    - Player Controller
]=]
function CameraController:Start()
    PlayerController = Axis.GetController("PlayerController")
end

return CameraController