---
sidebar_position: 3
---

# Modules

Modules are server side module scripts that act like Roblox services, each module is a global singleton.

## Writing Modules

Modules have two key functions that are automatically called by Axis: **`Init`** and **`Start`**. This separation ensures that dependencies between modules are handled correctly.

- **`Init`**: This is where you initialize objects and set up any necessary preconditions. For example, if your module relies on certain events being created before other modules can use its functionality, those events should be created here.

- **`Start`**: This is where you retrieve and interact with other modules or perform any actions that depend on all modules being initialized.

Example:

```lua
local MyModule = Axis.CreateModule {
    Name = "MyModule";
    Client = {};
}

function MyModule:Init()
    print("My module Init")
end

function MyModule:Start()
    print("My module Start")
end

return MyModule
```

Make sure to **optimize the `Init` function** to run as quickly as possible. Anything that doesn’t need to happen before other modules can use your module should be deferred to the `Start` function. 

Since all `Init` functions need to complete before any `Start` functions are called, **avoid using blocking or yielding operations** in `Init`, as they can significantly delay the startup process.

## Adding modules to Axis

Now that we have a simple test module we can add it to Axis. Ideally you should have 1 folder next to your startup script containing all the Module module scripts. Once this is true you can add this above the `Axis:Boot` function call:
```lua
Axis:AddModulesDeep(script.Parent.Modules) -- Axis:AddModulesDeep(Path to modules folder)
```
For other options of adding modules to Axis see the API [here](../api/Axis#AddModule).

## Client-Server Communication
Axis handles client / server communications in the same way as Knit. I recommend reading [Knit's documentation](https://sleitnick.github.io/Knit/docs/services#client-communication) to learn about client / server communication.