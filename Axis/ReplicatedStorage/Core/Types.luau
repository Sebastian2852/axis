--[=[
    @within PlayerConfig
    @type PlayerConfigTable {DefaultWalkSpeed: number, LockFirstPerson: boolean}
]=]
export type PlayerConfigTable = {
    DefaultWalkSpeed :number;
    LockFirstPerson :boolean;
}

--[=[
    What a .CreateModule returns

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
    .[any] any
    ]=]
export type Module = {
    Name :string;
    Client :{any};
    [any] :any;
}

return nil