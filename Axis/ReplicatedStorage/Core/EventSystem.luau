local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
--[=[
    @class EventSystem
    @tag Unfinished

    A cross realm event system.
]=]
local EventSystem = {}

--[=[
    Convert the name into a usable one
    @private
    @within EventSystem
]=]
local function ConvertName(Name :string) :string
    return Name:lower()
end

--[=[
    Creates a new event
    @param EventName string
]=]
function EventSystem.NewEvent(EventName :string)
    EventName = ConvertName(EventName)
    local Holder = Instance.new("Folder")
    Holder.Name = EventName
    Holder.Parent = ReplicatedStorage.Axis.Storage.Events

    local RemoteEvent = Instance.new("RemoteEvent")
    RemoteEvent.Name = "RE"
    RemoteEvent.Parent = Holder

    local BindableEvent = Instance.new("BindableEvent")
    BindableEvent.Name = "BE"
    BindableEvent.Parent = Holder
end

--[=[
    Get the `on event` script connection for the event.

    @param EventName string
    @return RBXScriptSignal

    @error "Invalid name; no holder" -- The passed event name is incorrect and doesn't exist.
    @error "Client unsupported" -- Client `OnEvent` functions are not yet supported.
    @error "Cannot find events" -- The event name was valid but the actual event objects cannot be found
]=]
function EventSystem:OnEvent(EventName :string) :RBXScriptSignal
    EventName = ConvertName(EventName)
    local HolderFolder = ReplicatedStorage.Axis.Storage.Events:FindFirstChild(EventName)
    if not HolderFolder then
        error("Invalid name; no holder")
        return
    end

    local RemoteEvent = HolderFolder:FindFirstChildWhichIsA("RemoteEvent")
    local BindableEvent = HolderFolder:FindFirstChildWhichIsA("BindableEvent")

    if not RemoteEvent or not BindableEvent then
        error("Cannot find events")
        return
    end

    if RunService:IsServer() then
        return BindableEvent.Event
    else
        error("Client unsupported")
    end
end

--[=[
    Fires the event for both the server and the client

    @param EventName string
    @param ... any -- Arguments to be passed to the events

    @error "Invalid name; no holder" -- The passed event name is incorrect and doesn't exist.
    @error "Cannot find events" -- The event name was valid but the actual event objects cannot be found
]=]
function EventSystem:FireEvent(EventName :string, ... :any)
    EventName = ConvertName(EventName)

    local HolderFolder = ReplicatedStorage.Axis.Storage.Events:FindFirstChild(EventName)
    if not HolderFolder then
        error("Invalid name; no holder")
        return
    end

    local RemoteEvent = HolderFolder:FindFirstChildWhichIsA("RemoteEvent")
    local BindableEvent = HolderFolder:FindFirstChildWhichIsA("BindableEvent")

    if not RemoteEvent or not BindableEvent then
        error("Cannot find events")
        return
    end

    if RunService:IsClient() then
        RemoteEvent:FireServer(...)
    else
        RemoteEvent:FireAllClients(...)
    end

    BindableEvent:Fire(...)
end

return EventSystem