---
sidebar_position: 2
---

# Getting Started

## Installing

### Wally
Axis is available on Wally (not very stable atm) [here](https://wally.run/package/sebastian2852/axis).

## Using

### Booting
Booting up axis is as simple as 1 line of code. Keep in mind that axis does need to be booted from the client and the server. Firstly lets boot axis on the server:
```lua
-- Startup.server.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Packages.Axis)

Axis:Boot():andThen(function()
    print("Axis booted")
end):catch(warn)
```
Pressing play should result with "Axis booted" being printed in the output.

Great we have booted axis from the server, now the client. The process is identical:
```lua
-- Startup.client.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Axis = require(ReplicatedStorage.Packages.Axis)

Axis:Boot():andThen(function()
    print("Axis booted")
end):catch(warn)
```

Having both these scripts should result in "Axis booted" being printed from the server and then the client in the output.

### Notes
- Axis is designed to work only in modules scripts. These 2 "Startup" scripts should be the only normal scripts in your game.
- Adding anything (like modules or controllers) to axis must come before booting!!!