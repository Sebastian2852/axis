---
sidebar_position: 3
---

# Modules

Modules are server side module scripts that act like Roblox services, each module is a global singlton.

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
    -- Create objects, events, and initial setup
end

function MyModule:Start()
    -- Get any modules needed after initialization
    local SecondModule = Axis.GetModule("Second")
end

return MyModule
```

Make sure to **optimize the `Init` function** to run as quickly as possible. Anything that doesn’t need to happen before other modules can use your module should be deferred to the `Start` function. 

Since all `Init` functions need to complete before any `Start` functions are called, **avoid using blocking or yielding operations** in `Init`, as they can significantly delay the startup process.
