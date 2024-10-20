--[=[
    @within PlayerConfig
    @type PlayerConfigTable {DefaultWalkSpeed: number, LockFirstPerson: boolean}
]=]
export type PlayerConfigTable = {
    DefaultWalkSpeed :number;
    LockFirstPerson :boolean;
}

--[=[
    @within ModuleSystem
    @interface ModuleDefinition
    .Name string
    .Client table?
    .[any] any
]=]
export type ModuleDefinition = {
    Name :string;
    Client :{[string] :any}?;
    [any] :any;
}

--[=[
    @within ModuleSystem
    @interface Module
    .Name string
    .Client table?
    .AxisNetworking any
    .[any] any
    ]=]
export type Module = {
    Name :string;
    Client :{any};
    AxisNetworking :any;
    [any] :any;
}

--[=[
    @within ControllerSystem
    @interface ControllerDefinition
    .Name string
    .[any] any
]=]
export type ControllerDefinition = {
    Name :string;
    [any] :any;
}

--[=[
    @within ControllerSystem
    @interface Controller
    .Name string
    .[any] any
]=]
export type Controller = {
    Name :string;
    [any] :any;
}

return nil