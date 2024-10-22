---
sidebar_position: 4
---

# Controllers

Controllers are client side module scripts.

## Writing Controllers

Like modules controllers also have the `Init` and `Start` functions.  

Example:
```lua
local MyController = Axis.CreateController {
    Name = "MyController";
}

function MyController:Init()
    print("Init")
end

function MyController:Start()
    print("Start")
end

return MyController
```

Make sure to **optimize the `Init` function** to run as quickly as possible. Anything that doesn’t need to happen before other modules can use your module should be deferred to the `Start` function. 

Since all `Init` functions need to complete before any `Start` functions are called, **avoid using blocking or yielding operations** in `Init`, as they can significantly delay the startup process.

:::danger 
The Controller's :Start() and :Init() functions are "removed" once Axis is booted. So calling the `Start` or `Init` functions will error!
:::

## Adding controllers to Axis

Like with modules you should have your controllers in a single folder to easily add it to Axis. Just like modules they need to be added before you call `Axis:Boot()`.
```lua
Axis:AddControllersDeep(script.Parent.Controllers) -- Axis:AddControllersDeep(Path to controllers folder)
```
For other options of adding controllers to Axis see the API [here](../api/Axis#AddController).